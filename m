From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 May 2014 21:16:42 +0200
Subject: [PATCH] clk: shmobile: Add R8A7740-specific clock support
In-Reply-To: <1400156437-19694-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1400156437-19694-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <CAMuHMdWDwgugY6jzj3UuvweyrRqj6sey3smLHQ1fgw_0mAJsKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulrich,

On Thu, May 15, 2014 at 2:20 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
> @@ -0,0 +1,39 @@
> +* Renesas R8A7740  Clock Pulse Generator (CPG)
> +
> +The CPG generates core clocks for the R8A7740 SoC. It includes three PLLs
> +and several fixed ratio and variable ratio dividers.
> +
> +Required Properties:
> +
> +  - compatible: Must be "renesas,r8a7740-cpg-clocks"
> +
> +  - reg: Base address and length of the memory resource used by the CPG
> +
> +  - clocks: Reference to the two parent clocks

Aren't there 3 parent clocks (extal1, extal2, extalr)?

> +Example
> +-------
> +
> +cpg_clocks: cpg_clocks at e6150000 {
> +        compatible = "renesas,r8a7740-cpg-clocks";
> +        reg = <0xe6150000 0x10000>;
> +        clocks = <&extal1_clk>, <&extalr_clk>;

Hence missing "<&extal2_clk>" (see below)?

> --- /dev/null
> +++ b/drivers/clk/shmobile/clk-r8a7740.c

> +static struct div4_clk div4_clks[] = {
> +       { "i", CPG_FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT },
> +       { "zg", CPG_FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT },
> +       { "b", CPG_FRQCRA,  8, 0x6fff, CLK_ENABLE_ON_INIT },
> +       { "m1", CPG_FRQCRA,  4, 0x6fff, CLK_ENABLE_ON_INIT },
> +       { "hp", CPG_FRQCRB,  4, 0x6fff, 0 },
> +       { "hpp", CPG_FRQCRC, 20, 0x6fff, 0 },
> +       { "usbp", CPG_FRQCRC, 16, 0x6fff, 0 },
> +       { "s", CPG_FRQCRC, 12, 0x6fff, 0 },
> +       { "zb", CPG_FRQCRC,  8, 0x6fff, 0 },
> +       { "m3", CPG_FRQCRC,  4, 0x6fff, 0 },
> +       { "cp", CPG_FRQCRC,  0, 0x6fff, 0 },

I assume the identical mask values (0x6fff) are not the final values, and will
be updated when the field becomes used?

> +       { NULL, 0, 0, 0, 0 },
> +};

> +static struct clk * __init
> +r8a7740_cpg_register_clock(struct device_node *np, struct r8a7740_cpg *cpg,
> +                            const char *name)
> +{

> +       } else if (!strcmp(name, "usb24s")) {
> +               u32 value = clk_readl(cpg->reg + CPG_USBCKCR);
> +               if (value & BIT(7))
> +                       parent_name = "extal2";

This one references extal2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
