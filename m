From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Sep 2016 23:23:56 +0800
Subject: [PATCH v2 4/4] ARM: dts: gr8: Add support for the GR8 evaluation
 board
In-Reply-To: <20160907145400.27192-5-maxime.ripard@free-electrons.com>
References: <20160907145400.27192-1-maxime.ripard@free-electrons.com>
 <20160907145400.27192-5-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66Ed1u5NaC9ev=ohywCbssy6BnkPcThY2D9O=_eNK1pdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 10:54 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> From: Myl?ne Josserand <mylene.josserand@free-electrons.com>
>
> The GR8-EVB is a small board with an NextThing GR8, an Hynix MLC NAND,
> an AXP209 PMIC, USB host and OTG, an SPDIF output and a connectors for CSI,
> I2S and LCD.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile        |   1 +
>  arch/arm/boot/dts/ntc-gr8-evb.dts | 342 ++++++++++++++++++++++++++++++++++++++

Acked-by: Chen-Yu Tsai <wens@csie.org>

>  arch/arm/boot/dts/ntc-gr8.dtsi    |  14 +-
>  3 files changed, 350 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/boot/dts/ntc-gr8-evb.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bb906f23d161..b2814271b397 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -719,6 +719,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
>         sun4i-a10-pcduino2.dtb \
>         sun4i-a10-pov-protab2-ips9.dtb
>  dtb-$(CONFIG_MACH_SUN5I) += \
> +       ntc-gr8-evb.dtb \
>         sun5i-a10s-auxtek-t003.dtb \
>         sun5i-a10s-auxtek-t004.dtb \
>         sun5i-a10s-mk802.dtb \
> diff --git a/arch/arm/boot/dts/ntc-gr8-evb.dts b/arch/arm/boot/dts/ntc-gr8-evb.dts
> new file mode 100644
> index 000000000000..7da1afddcab5
> --- /dev/null
> +++ b/arch/arm/boot/dts/ntc-gr8-evb.dts

[...]

> +&i2c1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c1_pins_a>;
> +       status = "okay";
> +
> +       pcf8563: rtc at 51 {
> +               compatible = "phg,pcf8563";
> +               reg = <0x51>;
> +       };
> +
> +       wm8978: codec at 1a {
> +               #sound-dai-cells = <0>;
> +               compatible = "wlf,wm8978";
> +               reg = <0x1a>;
> +       };

Seems like I2S support will happen soon? :)

> +};

[...]

> diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
> index d21cfa3f3c14..cdb7a12946c4 100644
> --- a/arch/arm/boot/dts/ntc-gr8.dtsi
> +++ b/arch/arm/boot/dts/ntc-gr8.dtsi

This looks like the wrong patch. Nevertheless...

> @@ -228,7 +228,7 @@
>
>                 axi_gates: clk at 01c2005c {
>                         #clock-cells = <1>;
> -                       compatible = "allwinner,sun4i-a10-axi-gates-clk";
> +                       compatible = "allwinner,sun4i-a10-gates-clk";
>                         reg = <0x01c2005c 0x4>;
>                         clocks = <&axi>;
>                         clock-indices = <0>;
> @@ -244,7 +244,7 @@
>                                         <2>, <5>, <6>,
>                                         <7>, <8>, <9>,
>                                         <10>, <13>,
> -                                       <14>, <20>,
> +                                       <14>, <17>, <20>,
>                                         <21>, <22>,
>                                         <28>, <32>, <34>,
>                                         <36>, <40>, <44>,
> @@ -254,7 +254,7 @@
>                                              "ahb_ohci", "ahb_ss", "ahb_dma",
>                                              "ahb_bist", "ahb_mmc0", "ahb_mmc1",
>                                              "ahb_mmc2", "ahb_nand",
> -                                            "ahb_sdram", "ahb_spi0",
> +                                            "ahb_sdram", "ahb_sdram", "ahb_spi0",

I don't think this will work. Copy/paste error?

Regards
ChenYu

>                                              "ahb_spi1", "ahb_spi2",
>                                              "ahb_stimer", "ahb_ve", "ahb_tve",
>                                              "ahb_lcd", "ahb_csi", "ahb_de_be",
> @@ -264,7 +264,7 @@
>
>                 apb0_gates: clk at 01c20068 {
>                         #clock-cells = <1>;
> -                       compatible = "allwinner,sun5i-a13-apb0-gates-clk";
> +                       compatible = "allwinner,sun4i-a10-gates-clk";
>                         reg = <0x01c20068 0x4>;
>                         clocks = <&apb0>;
>                         clock-indices = <0>, <3>,
> @@ -275,15 +275,15 @@
>
>                 apb1_gates: clk at 01c2006c {
>                         #clock-cells = <1>;
> -                       compatible = "allwinner,sun5i-a13-apb1-gates-clk";
> +                       compatible = "allwinner,sun4i-a10-gates-clk";
>                         reg = <0x01c2006c 0x4>;
>                         clocks = <&apb1>;
>                         clock-indices = <0>, <1>,
>                                         <2>, <17>,
> -                                       <18>;
> +                                       <18>, <19>;
>                         clock-output-names = "apb1_i2c0", "apb1_i2c1",
>                                              "apb1_i2c2", "apb1_uart1",
> -                                            "apb1_uart2";
> +                                            "apb1_uart2", "apb1_uart3";
>                 };
>
>                 nand_clk: clk at 01c20080 {
> --
> 2.9.3
>
