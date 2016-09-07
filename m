From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 8 Sep 2016 00:32:48 +0800
Subject: [PATCH v2 3/4] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <20160907145400.27192-4-maxime.ripard@free-electrons.com>
References: <20160907145400.27192-1-maxime.ripard@free-electrons.com>
 <20160907145400.27192-4-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67WLn6Sv9ie9CrA52zHf0xbwVd7YrJ_2pF3UW8LmxVvRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 10:53 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> From: Myl?ne Josserand <mylene.josserand@free-electrons.com>
>
> The GR8 is an SoC made by Nextthing loosely based on the sun5i family.
>
> Since it's not clear yet what we can factor out and merge with the A10s and
> A13 support, let's keep it out of the sun5i.dtsi include tree. We will
> figure out what can be shared when things settle down.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/ntc-gr8.dtsi | 1080 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1080 insertions(+)
>  create mode 100644 arch/arm/boot/dts/ntc-gr8.dtsi
>
> diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
> new file mode 100644
> index 000000000000..d21cfa3f3c14
> --- /dev/null
> +++ b/arch/arm/boot/dts/ntc-gr8.dtsi
> @@ -0,0 +1,1080 @@

[...]

> +               pll3x2: pll3x2_clk {
> +                       compatible = "fixed-factor-clock";

I think you want "allwinner,sun4i-a10-pll3-2x-clk"?

> +                       #clock-cells = <0>;
> +                       clock-div = <1>;
> +                       clock-mult = <2>;
> +                       clocks = <&pll3>;
> +                       clock-output-names = "pll3-2x";
> +               };

[...]

> +               pll7x2: pll7x2_clk {
> +                       compatible = "fixed-factor-clock";

Same here.

> +                       #clock-cells = <0>;
> +                       clock-div = <1>;
> +                       clock-mult = <2>;
> +                       clocks = <&pll7>;
> +                       clock-output-names = "pll7-2x";
> +               };
> +

[...]

> +               ahb_gates: clk at 01c20060 {
> +                       #clock-cells = <1>;
> +                       compatible = "allwinner,sun5i-a13-ahb-gates-clk";
> +                       reg = <0x01c20060 0x8>;
> +                       clocks = <&ahb>;
> +                       clock-indices = <0>, <1>,
> +                                       <2>, <5>, <6>,
> +                                       <7>, <8>, <9>,
> +                                       <10>, <13>,
> +                                       <14>, <20>,
> +                                       <21>, <22>,
> +                                       <28>, <32>, <34>,
> +                                       <36>, <40>, <44>,
> +                                       <46>, <51>,
> +                                       <52>;
> +                       clock-output-names = "ahb_usbotg", "ahb_ehci",
> +                                            "ahb_ohci", "ahb_ss", "ahb_dma",
> +                                            "ahb_bist", "ahb_mmc0", "ahb_mmc1",
> +                                            "ahb_mmc2", "ahb_nand",
> +                                            "ahb_sdram", "ahb_spi0",
> +                                            "ahb_spi1", "ahb_spi2",
> +                                            "ahb_stimer", "ahb_ve", "ahb_tve",

                                               "ahb_hstimer"?

> +                                            "ahb_lcd", "ahb_csi", "ahb_de_be",
> +                                            "ahb_de_fe", "ahb_iep",
> +                                            "ahb_mali400";
> +               };

[...]

> +               tcon_ch1_clk: clk at 01c2012c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
> +                       reg = <0x01c2012c 0x4>;
> +                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> +                       clock-output-names = "tcon-ch1-sclk";
> +               };

Nit: Is there a ve_clk we could add?

[...]

> +               pio: pinctrl at 01c20800 {
> +                       compatible = "nextthing,gr8-pinctrl";
> +                       reg = <0x01c20800 0x400>;
> +                       interrupts = <28>;
> +                       clocks = <&apb0_gates 5>;
> +                       gpio-controller;
> +                       interrupt-controller;
> +                       #interrupt-cells = <3>;
> +                       #gpio-cells = <3>;
> +
> +                       i2c0_pins_a: i2c0 at 0 {
> +                               allwinner,pins = "PB0", "PB1";
> +                               allwinner,function = "i2c0";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       i2c1_pins_a: i2c1 at 0 {
> +                               allwinner,pins = "PB15", "PB16";
> +                               allwinner,function = "i2c1";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       i2c2_pins_a: i2c2 at 0 {
> +                               allwinner,pins = "PB17", "PB18";
> +                               allwinner,function = "i2c2";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       i2s0_pins_a: i2s0 at 0 {
> +                               allwinner,pins = "PB5", "PB6", "PB7", "PB8", "PB9";
> +                               allwinner,function = "i2s0";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };

You may want to split out the MCLK pin. Some codecs don't need it, and the
pin can be allocated for other uses.

> +
> +                       ir0_rx_pins_a: ir0 at 0 {
> +                               allwinner,pins = "PB4";
> +                               allwinner,function = "ir0";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       lcd_rgb666_pins: lcd_rgb666 at 0 {
> +                               allwinner,pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
> +                                                "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
> +                                                "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
> +                                                "PD24", "PD25", "PD26", "PD27";
> +                               allwinner,function = "lcd0";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       mmc0_pins_a: mmc0 at 0 {
> +                               allwinner,pins = "PF0", "PF1", "PF2", "PF3",
> +                                                "PF4", "PF5";
> +                               allwinner,function = "mmc0";
> +                               allwinner,drive = <SUN4I_PINCTRL_30_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       nand_pins_a: nand_base0 at 0 {
> +                               allwinner,pins = "PC0", "PC1", "PC2",
> +                                               "PC5", "PC8", "PC9", "PC10",
> +                                               "PC11", "PC12", "PC13", "PC14",
> +                                               "PC15";
> +                               allwinner,function = "nand0";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;

Macros for the nand pins?

> +                       };
> +
> +                       nand_cs0_pins_a: nand_cs at 0 {
> +                               allwinner,pins = "PC4";
> +                               allwinner,function = "nand0";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };
> +
> +                       nand_rb0_pins_a: nand_rb at 0 {
> +                               allwinner,pins = "PC6";
> +                               allwinner,function = "nand0";
> +                               allwinner,drive = <0>;
> +                               allwinner,pull = <0>;
> +                       };

[...]

The rest looks good.


Regards
ChenYu
