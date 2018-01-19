From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 19 Jan 2018 10:41:17 +0100
Subject: [PATCH v2 0/16] ARM: r8a7790: add soc node
In-Reply-To: <20180117161717.14589-1-horms+renesas@verge.net.au>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWGZ-kN1Kb-w9KAWD+0c8ccF7B5WE0gLhv4PNi41B6XWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Jan 17, 2018 at 5:17 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> this patchset adds an soc node, moves all nodes for IP blocks with an
> address on the bus to be sub nodes of the soc node, and sorts subnodes of
> the root and soc nodes.
>
> The use of an soc node is consistent with handling of R-Car Gen3, RZ/G1,
> and R-Car V2H (R8A77920) SoCs upstream. This patch-set adds it for all
> other R-Car Gen2 SoCs: r8a7790 (H2), r8a7791 (M2-W), r8a7793 (M2-N),
> r8a7794 (E2).
>
> Sorting of nodes is also done for the R-Car V2H (R8A77920), making it
> consistent across all R-Car Gen2 SoCs and thus allowing easier comparison
> of DTs of different R-Car Gen2 SoCs.
>
> The patchset also fixes some minor whitespace problems.

Thank you, this is a great cleanup!

Now the structure of the DTSes is the same for all SoCs, they can be
compared more easily using my soc-dts-diff script (which BTW also works
for e.g. driver source files using the <soc>-<module>.c pattern).

$ cat $(type -p soc-dts-diff)
#!/bin/bash

set -e

function usage()
{
        cat <<END

Usage: $(basename $0) [options...] <dts1> <dts2>

END
        exit -1
}

for i in $*; do
        case $i in
        -*)
                options="$options $i"
                ;;

        *)
                if [ "$dts1" == "" ]; then
                        dts1=$i
                elif [ "$dts2" == "" ]; then
                        dts2=$i
                else
                        usage
                fi
                ;;
        esac
done

if [ "$dts1" == "" -o "$dts2" == "" ]; then
        usage
fi

soc1=$(basename $dts1)
soc2=$(basename $dts2)
soc1=${soc1%%[-.]*}
soc2=${soc2%%[-.]*}

colordiff -u $options \
        --label $dts1 <(sed -e "s/$soc1/<SOC>/gi" $dts1) \
        --label $dts2 <(sed -e "s/$soc2/<SOC>/gi" $dts2)
$

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
