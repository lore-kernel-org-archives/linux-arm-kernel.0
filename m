From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 12 Dec 2017 10:44:53 +0100
Subject: [PATCH 2/3] arm64: dts: renesas: r8a7796: move nodes which have
 no reg property out of bus
In-Reply-To: <20171212082436.12210-3-horms+renesas@verge.net.au>
References: <20171212082436.12210-1-horms+renesas@verge.net.au>
 <20171212082436.12210-3-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVx-cEHwV+mBcZfM903DrkxjyNqOiT6KQvm5fNUpcW2Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Dec 12, 2017 at 9:24 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Move pmu_a5[73], timer and thermal-zones nodes from soc node to root node.
> The nodes that have been moved do not have any register properties and thus
> shouldn't be placed on the bus.

[...]

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
but a few minor comments below...

> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -154,6 +154,26 @@
>                 clock-frequency = <0>;
>         };
>
> +       pmu_a57 {
> +               compatible = "arm,cortex-a57-pmu";
> +               interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-affinity = <&a57_0>,
> +                                    <&a57_1>;
> +       };
> +
> +       pmu_a53 {
> +               compatible = "arm,cortex-a53-pmu";
> +               interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <&gic GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <&gic GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-affinity = <&a53_0>,
> +                                    <&a53_1>,
> +                                    <&a53_2>,
> +                                    <&a53_3>;

Merge these 4 into a single line?

> @@ -2027,4 +1971,64 @@
>                         resets = <&cpg 822>;
>                 };
>         };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts-extended = <&gic GIC_PPI 13
> +                                      (GIC_CPU_MASK_SIMPLE(6) |
> +                                       IRQ_TYPE_LEVEL_LOW)>,
> +                                     <&gic GIC_PPI 14
> +                                      (GIC_CPU_MASK_SIMPLE(6) |
> +                                       IRQ_TYPE_LEVEL_LOW)>,
> +                                     <&gic GIC_PPI 11
> +                                      (GIC_CPU_MASK_SIMPLE(6) |
> +                                       IRQ_TYPE_LEVEL_LOW)>,
> +                                     <&gic GIC_PPI 10
> +                                      (GIC_CPU_MASK_SIMPLE(6) |
> +                                       IRQ_TYPE_LEVEL_LOW)>;

I think you can do a better job here, by trying not to break entries across
multiple lines ;-)

(Oops, we already have it this way in r8a7795.dtsi)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
