From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Jan 2015 10:41:14 +0100
Subject: [PATCH] ARM: shmobile: r8a7794: Correct SDHI clock node names
In-Reply-To: <1420418648-7815-1-git-send-email-horms+renesas@verge.net.au>
References: <1420418648-7815-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVX196P9u8zHyjWR_-6Pj7kqtOzR4pW2_qGigsSw-2BVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 5, 2015 at 1:44 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> index 8f78da5..9856e9c 100644
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -294,14 +294,14 @@
>                                              "lb", "qspi", "sdh", "sd0", "z";
>                 };
>                 /* Variable factor clocks */
> -               sd1_clk: sd2_clk at e6150078 {
> +               sd1_clk: sd1_clk at e6150078 {
>                         compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
>                         reg = <0 0xe6150078 0 4>;
>                         clocks = <&pll1_div2_clk>;
>                         #clock-cells = <0>;
>                         clock-output-names = "sd1";
>                 };
> -               sd2_clk: sd3_clk at e615007c {
> +               sd2_clk: sd2_clk at e615007c {
>                         compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
>                         reg = <0 0xe615007c 0 4>;
>                         clocks = <&pll1_div2_clk>;

According to the documentation, SDCKCR is 0xe6150074, not ..78,
SD2CKCR is 0xe6150078, not ..7c.
For reference SD3CKCR is 0xe615026c.

Note that r8a7791.dtsi also has the mismatches between the labels and node
names.

The discrepancy is caused by the different number of SDHI modules in the
different SoCs of the R-Car Gen2 family.

  - r8a7790 has hardware modules SDHI0, SDHI1, SDHI2, and SDHI3.
  - r8a7791 and r8a7794 have hardware modules SDHI0, SDHI2, and SDHI3,
    but call the last two instances SDHI1 and SDHI2, while the clock registers
    are not renumbered.
    So instance SDHI1 uses SD2CKCR, and instance SDHI2 uses SD3CKCR, right?

That means the node names are actually correct. But the register value and
unit address for the second clock are still wrong, they should be (0x)e615007c,
cfr. in r8a7791.dtsi.

Note that IMHO the clock-output-names are wrong, for both r8a7791 and r8a7794,
as the hardware documentation calls these "sd2" and "sd3", not "sd1" and "sd2".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
