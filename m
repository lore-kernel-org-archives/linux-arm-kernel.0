From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Sep 2017 16:05:47 +0200
Subject: [PATCH 07/11] arm64: dts: renesas: r8a77970: add [H]SCIF support
In-Reply-To: <20170912210531.451036685@cogentembedded.com>
References: <20170912210531.451036685@cogentembedded.com>
Message-ID: <CAMuHMdWY8Ad0XDqqwUrCv4uJf0Nem99WyTPQCYV+On-6RKWifA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Sep 12, 2017 at 10:37 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe [H]SCIF ports in the R8A77970 device tree.
>
> Based on the original (and large) patch by Daisuke Matsushita
> <daisuke.matsushita.ns@hitachi.com>.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi

> @@ -170,5 +177,139 @@
>                         #dma-cells = <1>;
>                         dma-channels = <8>;
>                 };
> +
> +               hscif0: serial at e6540000 {
> +                       compatible = "renesas,hscif-r8a77970",
> +                                    "renesas,rcar-gen3-hscif",
> +                                    "renesas,hscif";
> +                       reg = <0 0xe6540000 0 96>;
> +                       interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 520>,
> +                                <&cpg CPG_CORE 9>,
> +                                <&scif_clk>;
> +                       clock-names = "fck", "brg_int", "scif_clk";
> +                       dmas = <&dmac1 0x31>, <&dmac1 0x30>;
> +                       dma-names = "tx", "rx";

The DMA channel numbers in Table 17.5 in the datasheet are a bit messed up
(it doesn't take into account that each V3M DMAC has only 8 channels,
while they have
16 on H3 and M3-W), but it looks like HSCIF[0-3] and SCIF[0134] can use both
dmac1 and dmac2.
So please add these (preferably after verifying the above is true).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
