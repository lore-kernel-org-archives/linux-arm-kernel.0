From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 10 Dec 2014 14:28:39 +0100
Subject: [PATCH] [RFC] ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
In-Reply-To: <1417617454-14533-1-git-send-email-geert+renesas@glider.be>
References: <1417617454-14533-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdX5i8qXdVUYMi+BLEe7Ah+_hJOEputW7jw5xvQ6UqH3EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 3, 2014 at 3:37 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add a node for the Private Timer and Watchdog, as found in the Cortex-A9
> MPCore.
>
> Without this, there's no clocksource available during early kernel
> initialization, before cmt1 is initialized, leading to a lock-up if
> CONFIG_CPU_IDLE=y.
>
> FIXME The clock should be the PERIPH clock, but the sh73a0 CPG driver
>       doesn't have support for that clock yet. Hence we use the ZG
>       clock, which runs at the same frequency.

It looks like we do have the clock in sh73a0.dtsi, but it's called "twd_clk".
Ulrich, is that correct?

Note that the frequency is off by a factor of 2, just like for its parent "z".
(that is, without your (~private) patch to take into account ZSEL).

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Unlike "arm,armv7-timer" (used on R-Car Gen2), "arm,cortex-a9-twd-time"
> does require a clock, which is not documented in its bindings?
> ---
>  arch/arm/boot/dts/sh73a0.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> index cca22ec59a2edd63..c53b19f40ae0977f 100644
> --- a/arch/arm/boot/dts/sh73a0.dtsi
> +++ b/arch/arm/boot/dts/sh73a0.dtsi
> @@ -11,6 +11,7 @@
>  /include/ "skeleton.dtsi"
>
>  #include <dt-bindings/clock/sh73a0-clock.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>
>  / {
> @@ -43,6 +44,13 @@
>                       <0xf0000100 0x100>;
>         };
>
> +       timer at f0000600 {
> +               compatible = "arm,cortex-a9-twd-timer";
> +               reg = <0xf0000600 0x20>;
> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +               clocks = <&cpg_clocks SH73A0_CLK_ZG>;   // FIXME CLK_PERIPH
> +       };
> +
>         pmu {
>                 compatible = "arm,cortex-a9-pmu";
>                 interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>,
> --
> 1.9.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
