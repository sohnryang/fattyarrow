export VIRTUAL_ENV_DISABLE_PROMPT=yes

function time_indicator {
    psvar[1]=' time: '`date +"%T"`
}
add-zsh-hook precmd time_indicator

function root_indicator {
    if [[ $UID -eq 0 ]] then
        psvar[2]=' root'
    else
        psvar[2]=''
    fi
}
add-zsh-hook precmd root_indicator

function last_cmd_indicator {
    if [[ $? -eq 0 ]] then
        psvar[3]=''
    else
        psvar[3]=' exit: '`echo $?`
    fi
}
add-zsh-hook precmd last_cmd_indicator

function git_indicator {
    git rev-parse >& /dev/null
    if [[ $? -eq 0 ]] then
        if [[ -n "$(git status --porcelain)" ]] then
            psvar[4]=' git: '`git rev-parse --abbrev-ref HEAD 2> /dev/null`'*'
        else
            psvar[4]=' git: '`git rev-parse --abbrev-ref HEAD 2> /dev/null`
        fi
    else
        psvar[4]=''
    fi
}
add-zsh-hook precmd git_indicator

function virtenv_indicator {
    if [[ -z $VIRTUAL_ENV ]] then
        psvar[5]=''
    else
        psvar[5]=' virtualenv: '${VIRTUAL_ENV##*/}
    fi
}
add-zsh-hook precmd virtenv_indicator

PROMPT="
%{$fg[blue]%}%~%{$reset_color%}%{$fg[magenta]%}%(1V.%1v.)%{$fg[red]%}%(2V.%2v.)%(3V.%3v.)%{$fg[cyan]%}%(4V.%4v.)%{$fg[yellow]%}%(5V.%5v.)
%{$fg[yellow]%}=> %{$reset_color%}"

