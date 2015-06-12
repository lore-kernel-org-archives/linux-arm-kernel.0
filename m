From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 12 Jun 2015 19:13:53 +0200
Subject: [PATCH v3 2/2] arm64: dts: mt8173: Add I2C device node
In-Reply-To: <CAGS+omB1UadXeKZLmMdhSamsPpipQLmoH_PhbUPvszrYTq68fA@mail.gmail.com>
References: <1434101229-32695-1-git-send-email-eddie.huang@mediatek.com>
 <1434101229-32695-3-git-send-email-eddie.huang@mediatek.com>
 <CAGS+omB1UadXeKZLmMdhSamsPpipQLmoH_PhbUPvszrYTq68fA@mail.gmail.com>
Message-ID: <1863259.t4daGE7nbQ@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 12, 2015 08:28:51 PM Daniel Kurtz wrote:
> Hi Eddie,
> 
> On Fri, Jun 12, 2015 at 5:27 PM, Eddie Huang <eddie.huang@mediatek.com> 
wrote:
> > Add MT8173 I2C device nodes, include I2C controllers and pins.
> > MT8173 has six I2C controllers, from i2c0 to i2c6, exclude i2c5.
> > The 6th I2C controller register base doesn't next to 5th I2C,
> > and there is a hardware between 5th and 6th I2C controller. So
> > SoC designer name 6th controller as "i2c6", not "i2c5".
> 
> This is slightly misleading.  There are in fact 7 I2C controllers, but
> "i2c5" is dedicated for use by HDMI for ddc & hdcp.
> Is there a reason why the HDMI I2C port cannot be controlled by the
> generic i2c driver?
> 
> Of course the hdmiddc / i2c5 node can always be added in a later
> patch, so this is no reason to hold up this patch.
> 
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> > 
> >  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 50 ++++++++++++++++++++
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 72
> >  +++++++++++++++++++++++++++++ 2 files changed, 122 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts index 43d5401..2e01988
> > 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > @@ -33,6 +33,56 @@
> > 
> >         chosen { };
> >  
> >  };
> > 
> > +&pio {
> 
> I don't think we needed to move these i2c pinmux descriptions from
> mt8173.dtsi to the board .dts file.
> 
> AFAICT, the "i2cN_pins_a" nodes defined here are the pinctl
> configuration that the corresponding enabled i2c nodes would choose.
> Thus, they are generic to the MT8173 SoC, not specific to any board.
> By themselves, these nodes do not actually select a pin configuration.
> 
> It is the nodes that *enable* the individual i2c nodes, and hence
> activate those pin settings, which is board specific.
> 
> Hence, if your intent is to have the evb enable all i2c nodes, it
> would have a set of nodes like this:
> 
> 
> &i2c0 {
>   pinctrl-names = "default";
>   pinctrl-0 = <&i2c0_pins_a>;
>   status = "okay";
> };
> 
> &i2c1 {
>  pinctrl-names = "default";
>  pinctrl-0 = <&i2c1_pins_a>;
>  status = "okay";
> };
> 
> ...
> 
> > +       i2c0_pins_a: i2c0 at 0 {
> 
> Do these nodes need the "@0"?
> 
> > +               pins1 {
> > +                       pinmux = <MT8173_PIN_45_SDA0__FUNC_SDA0>,
> > +                                <MT8173_PIN_46_SCL0__FUNC_SCL0>;
> > +                       bias-disable;
> > +               };
> > +       };
> > +
> > +       i2c1_pins_a: i2c1 at 0 {
> > +               pins1 {
> > +                       pinmux = <MT8173_PIN_125_SDA1__FUNC_SDA1>,
> > +                                <MT8173_PIN_126_SCL1__FUNC_SCL1>;
> > +                       bias-disable;
> > +               };
> > +       };
> > +
> > +       i2c2_pins_a: i2c2 at 0 {
> > +               pins1 {
> > +                       pinmux = <MT8173_PIN_43_SDA2__FUNC_SDA2>,
> > +                                <MT8173_PIN_44_SCL2__FUNC_SCL2>;
> > +                       bias-disable;
> > +               };
> > +       };
> > +
> > +       i2c3_pins_a: i2c3 at 0 {
> > +               pins1 {
> > +                       pinmux = <MT8173_PIN_106_SDA3__FUNC_SDA3>,
> > +                                <MT8173_PIN_107_SCL3__FUNC_SCL3>;
> > +                       bias-disable;
> > +               };
> > +       };
> > +
> > +       i2c4_pins_a: i2c4 at 0 {
> > +               pins1 {
> > +                       pinmux = <MT8173_PIN_133_SDA4__FUNC_SDA4>,
> > +                                <MT8173_PIN_134_SCL4__FUNC_SCL4>;
> > +                       bias-disable;
> > +               };
> > +       };
> > +
> > +       i2c6_pins_a: i2c6 at 0 {
> > +               pins1 {
> > +                       pinmux = <MT8173_PIN_100_MSDC2_DAT0__FUNC_SDA5>,
> > +                                <MT8173_PIN_101_MSDC2_DAT1__FUNC_SCL5>;
> 
> These are the SDA/SCL pins for i2c port 6, so they should really be
> _SDA6 / _SCL6.
> However... I checked, and these settings are labeled "SDA5 & SCL5" in
> the datasheet.
> I recommend marking them correctly as 6 here and fixing the datasheet :-).
> 
> > +                       bias-disable;
> > +               };
> > +       };
> > +};
> > +
> > 
> >  &uart0 {
> >  
> >         status = "okay";
> >  
> >  };
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8173.dtsi index b52ec43..6d3dbbdd 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -229,6 +229,78 @@
> > 
> >                         clocks = <&uart_clk>;
> >                         status = "disabled";
> >                 
> >                 };
> > 
> > +
> > +               i2c0: i2c at 11007000 {
> > +                       compatible = "mediatek,mt8173-i2c";
> > +                       reg = <0 0x11007000 0 0x70>,
> > +                             <0 0x11000100 0 0x80>;
> > +                       interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
> > +                       clock-div = <16>;
> > +                       clocks = <&pericfg CLK_PERI_I2C0>,
> > +                                <&pericfg CLK_PERI_AP_DMA>;
> > +                       clock-names = "main", "dma";
> 
> The following fields must also be selected by the i2c nodes when they
> are enabled:
> 
> clock-frequency = <100000>;
> pinctrl-names = "default";
> pinctrl-0 = <&i2c0_pins_a>;
> #address-cells = <1>;
> #size-cells = <0>;
> 
> So, is there any reason not to also include them here in mt8173.dtsi
> so we can use them as defaults?
> This would simplify the i2c nodes in the board specific .dts files.
> The only field that might be board specific would be clock-frequency,
> but that is trivial to override on a port-by-port basis in board files
> as necessary.

The problem is, that most of the pins have several modes (up to eight).
In the future when all the device drivers are implemented, this gets you a 
really huge dtsi. AFAIK this can cause a somewhat long parsing time of the dtb 
when booting the system.
Sascha, please correct me, if I'm wrong.

Thanks,
Matthias
