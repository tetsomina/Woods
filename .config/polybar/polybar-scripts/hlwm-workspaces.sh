#!/usr/bin/env bash

herbstclient --idle "tag_*" 2>/dev/null | {

    while true; do
        # Read tags into $tags as array
        IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status)"
        {
            for f in "${tags[@]}" ; do
                status+=( ${f:0:1} )
            done

				    for i in "${!tags[@]}"; do
                if [[ ${tags[$i]} == *"1"* ]]; then
   				          tags[$i]=${status[$i]}
					      elif [[ ${tags[$i]} == *"2"* ]]; then
					          tags[$i]=${status[$i]}
			          elif [[ ${tags[$i]} == *"3"* ]]; then
			              tags[$i]=${status[$i]}
			          elif [[ ${tags[$i]} == *"4"* ]]; then
			              tags[$i]=${status[$i]}
			          elif [[ ${tags[$i]} == *"5"* ]]; then
			              tags[$i]=${status[$i]}
   	            elif [[ ${tags[$i]} == *"6"* ]]; then
			              tags[$i]=${status[$i]}
			          elif [[ ${tags[$i]} == *"7"* ]]; then
			              tags[$i]=${status[$i]}
			          elif [[ ${tags[$i]} == *"8"* ]]; then
			              tags[$i]=${status[$i]}
			          elif [[ ${tags[$i]} == *"9"* ]]; then
			              tags[$i]=${status[$i]}
			          elif [[ ${tags[$i]} == *"0"* ]]; then
			              tags[$i]=${status[$i]}
			          else
			              break && notify-send "Hlwm polybar status broke"
			          fi
			      done
            count=1
            for i in "${tags[@]}" ; do
                # Read the prefix from each tag and render them according to that prefix
                case ${i:0:1} in
                    '#')
                        # the tag is viewed on the focused monitor
                        # TODO Add your formatting tags for focused workspaces
												echo "%{F#a7c080}"
                        ;;
                    ':')
                        # : the tag is not empty
                        # TODO Add your formatting tags for occupied workspaces
												echo "%{F#d8caac}"
                        ;;
                    '!')
                        # ! the tag contains an urgent window
                        # TODO Add your formatting tags for workspaces with the urgent hint
												echo "%{F#e68183}"
                        ;;
                    '-')
                        # - the tag is viewed on a monitor that is not focused
                        # TODO Add your formatting tags for visible but not focused workspaces
												echo "%{F#87c095}"
                        ;;
                    *)
                        # . the tag is empty
                        # There are also other possible prefixes but they won't appear here
                        echo "%{F#868d80}" # Add your formatting tags for empty workspaces
                        ;;
                esac
                
                if [ $count -eq 10 ]; then
                    count=0
                fi

                echo "%{A1:herbstclient use $count:} ${i:1} %{A -u -o F- B-}"
                count=$(( count + 1 ))
            done

            echo "%{F-}%{B-}"
        } | tr -d "\n"

    echo

    # wait for next event from herbstclient --idle
    read -r || break
done
} 2>/dev/null
