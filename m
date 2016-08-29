From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Aug 2016 09:53:23 +0200
Subject: [PATCH 1/4] ARM: dts: shmobile: remove label property from led
In-Reply-To: <1472219382-22789-1-git-send-email-horms+renesas@verge.net.au>
References: <1472219382-22789-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdW7=XB_-7YvMwBw-7WLaEj8A4=znsvRkTbdf5SCYe00rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

The patch index in the subject should have been 0/4. You're breaking my
script to extract patch series from email threads ;-)

On Fri, Aug 26, 2016 at 3:49 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Remove label property from led nodes. This seems to have little
> value and is used inconsistently amongst Renesas SoCs.
>
> Based on renesas-devel-20160824-v4.8-rc3
>
> Simon Horman (4):
>   ARM: dts: armadillo800eva: remove label property from led nodes
>   ARM: dts: koelsch: remove label property from led nodes
>   ARM: dts: gose: remove label property from led nodes
>   ARM: dts: kzm9g: remove label property from led nodes

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I assume you are aware this is a user-visible change?
The LED name is exposed under /sys/class/leds/.
Fortunately my LED init script is agnostic to the actual names ;-)

if [ -d /sys/class/leds ]; then
        echo -n Enabling LEDs:
        i=-1
        for led in /sys/class/leds/*; do
                case $i in
                -1)
                        echo -n " heartbeat"
                        echo heartbeat > $led/trigger
                        ;;
                *)
                        if grep -qP "^processor.*: $i$" /proc/cpuinfo; then
                                echo -n " cpu$i"
                                echo cpu$i > $led/trigger
                        fi
                        ;;
                esac
                i=$(($i + 1))
        done
        echo
fi

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
