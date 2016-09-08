From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 09:41:55 +0200
Subject: [PATCH v2 3/4] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <CAGb2v67WLn6Sv9ie9CrA52zHf0xbwVd7YrJ_2pF3UW8LmxVvRQ@mail.gmail.com>
References: <20160907145400.27192-1-maxime.ripard@free-electrons.com>
 <20160907145400.27192-4-maxime.ripard@free-electrons.com>
 <CAGb2v67WLn6Sv9ie9CrA52zHf0xbwVd7YrJ_2pF3UW8LmxVvRQ@mail.gmail.com>
Message-ID: <20160908074155.GH8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 12:32:48AM +0800, Chen-Yu Tsai wrote:
> On Wed, Sep 7, 2016 at 10:53 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > From: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> >
> > The GR8 is an SoC made by Nextthing loosely based on the sun5i family.
> >
> > Since it's not clear yet what we can factor out and merge with the A10s and
> > A13 support, let's keep it out of the sun5i.dtsi include tree. We will
> > figure out what can be shared when things settle down.
> >
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/ntc-gr8.dtsi | 1080 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 1080 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/ntc-gr8.dtsi
> >
> > diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
> > new file mode 100644
> > index 000000000000..d21cfa3f3c14
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/ntc-gr8.dtsi
> > @@ -0,0 +1,1080 @@
> 
> [...]
> 
> > +               pll3x2: pll3x2_clk {
> > +                       compatible = "fixed-factor-clock";
> 
> I think you want "allwinner,sun4i-a10-pll3-2x-clk"?

Indeed.

> > +               tcon_ch1_clk: clk at 01c2012c {
> > +                       #clock-cells = <0>;
> > +                       compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
> > +                       reg = <0x01c2012c 0x4>;
> > +                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> > +                       clock-output-names = "tcon-ch1-sclk";
> > +               };
> 
> Nit: Is there a ve_clk we could add?

I don't know. No one uses it, and the next item on my todo list is to
move the sun5i SoCs to sunxi-ng, so it seems a bit useless to add that
one.

> 
> [...]
> 
> > +               pio: pinctrl at 01c20800 {
> > +                       compatible = "nextthing,gr8-pinctrl";
> > +                       reg = <0x01c20800 0x400>;
> > +                       interrupts = <28>;
> > +                       clocks = <&apb0_gates 5>;
> > +                       gpio-controller;
> > +                       interrupt-controller;
> > +                       #interrupt-cells = <3>;
> > +                       #gpio-cells = <3>;
> > +
> > +                       i2c0_pins_a: i2c0 at 0 {
> > +                               allwinner,pins = "PB0", "PB1";
> > +                               allwinner,function = "i2c0";
> > +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> > +
> > +                       i2c1_pins_a: i2c1 at 0 {
> > +                               allwinner,pins = "PB15", "PB16";
> > +                               allwinner,function = "i2c1";
> > +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> > +
> > +                       i2c2_pins_a: i2c2 at 0 {
> > +                               allwinner,pins = "PB17", "PB18";
> > +                               allwinner,function = "i2c2";
> > +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> > +
> > +                       i2s0_pins_a: i2s0 at 0 {
> > +                               allwinner,pins = "PB5", "PB6", "PB7", "PB8", "PB9";
> > +                               allwinner,function = "i2s0";
> > +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> 
> You may want to split out the MCLK pin. Some codecs don't need it, and the
> pin can be allocated for other uses.

ACK.

> 
> > +
> > +                       ir0_rx_pins_a: ir0 at 0 {
> > +                               allwinner,pins = "PB4";
> > +                               allwinner,function = "ir0";
> > +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> > +
> > +                       lcd_rgb666_pins: lcd_rgb666 at 0 {
> > +                               allwinner,pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
> > +                                                "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
> > +                                                "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
> > +                                                "PD24", "PD25", "PD26", "PD27";
> > +                               allwinner,function = "lcd0";
> > +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> > +
> > +                       mmc0_pins_a: mmc0 at 0 {
> > +                               allwinner,pins = "PF0", "PF1", "PF2", "PF3",
> > +                                                "PF4", "PF5";
> > +                               allwinner,function = "mmc0";
> > +                               allwinner,drive = <SUN4I_PINCTRL_30_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> > +
> > +                       nand_pins_a: nand_base0 at 0 {
> > +                               allwinner,pins = "PC0", "PC1", "PC2",
> > +                                               "PC5", "PC8", "PC9", "PC10",
> > +                                               "PC11", "PC12", "PC13", "PC14",
> > +                                               "PC15";
> > +                               allwinner,function = "nand0";
> > +                               allwinner,drive = <0>;
> > +                               allwinner,pull = <0>;
> 
> Macros for the nand pins?

Indeed.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/678c08b7/attachment.sig>
