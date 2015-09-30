From: aalonso@freescale.com (Alonso Adrian)
Date: Wed, 30 Sep 2015 16:14:45 +0000
Subject: [PATCH v7 7/7] pinctrl: freescale: imx: imx7d iomuxc-lpsr
 devicetree bindings
In-Reply-To: <20150930020347.GD15771@tiger>
References: <1443477401-17238-1-git-send-email-aalonso@freescale.com>
 <1443477401-17238-7-git-send-email-aalonso@freescale.com>
 <20150930020347.GD15771@tiger>
Message-ID: <BN3PR03MB150968E32E95154CFDE7BBF9A84D0@BN3PR03MB1509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Tuesday, September 29, 2015 9:04 PM
> To: Alonso Lazcano Adrian-B38018 <aalonso@freescale.com>
> Cc: linux-arm-kernel at lists.infradead.org; shawn.guo at linaro.org;
> linus.walleij at linaro.org; lznuaa at gmail.com; linux-gpio at vger.kernel.org;
> devicetree at vger.kernel.org; kernel at pengutronix.de; robh+dt at kernel.org;
> Huang Yongcai-B20788 <Anson.Huang@freescale.com>; Li Frank-B20596
> <Frank.Li@freescale.com>; Gong Yibin-B38343 <yibin.gong@freescale.com>;
> Garg Nitin-B37173 <nitin.garg@freescale.com>
> Subject: Re: [PATCH v7 7/7] pinctrl: freescale: imx: imx7d iomuxc-lpsr
> devicetree bindings
> 
> On Mon, Sep 28, 2015 at 04:56:41PM -0500, Adrian Alonso wrote:
> > Add iomuxc-lpsr devicetree bindings documentation Provide
> > documentation context as well an example on pheriperals that could use
> > pad from either iomuxc controller supported by iMX7D SoC
> >
> > Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> > ---
> > Changes for V2: New patch on imx7d iomuxc-lpsr patch series Changes
> > for V3: Add shared input select register notes Changes for V4: Resend
> > Changes for V5:
> > - Fix spell error
> > - Remove references of SHARE_INPUT_SELECT_REG flag Changes for V6:
> > Resend Changes for v7: Resend
> >
> >  .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         | 63 +++++++++++++++++++++-
> >  1 file changed, 62 insertions(+), 1 deletion(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> > b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> > index 8bbf25d..aae069f 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> > +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> > @@ -1,16 +1,42 @@
> >  * Freescale i.MX7 Dual IOMUX Controller
> >
> > +iMX7D supports two iomuxc controllers, fsl,imx7d-iomuxc controller is
> > +similar as previous iMX SoC generation and fsl,imx7d-iomuxc-lpsr
> > +which provides low power state retention capabilities on gpios that
> > +are part of iomuxc-lpsr (GPIO1_IO7..GPIO1_IO0). While iomuxc-lpsr
> > +provides its own set of registers for mux and pad control settings,
> > +it shares the input select register from main iomuxc controller for
> > +daisy chain settings, the fsl,input-sel property extends fsl,imx-pinctrl driver
> to support iomuxc-lpsr controller.
> > +
> > +iomuxc_lpsr: iomuxc-lpsr at 302c0000 {
> > +	compatible = "fsl,imx7d-iomuxc-lpsr";
> > +	reg = <0x302c0000 0x10000>;
> > +	fsl,input-sel = <&iomuxc>;
> > +};
> > +
> > +iomuxc: iomuxc at 30330000 {
> > +	compatible = "fsl,imx7d-iomuxc";
> > +	reg = <0x30330000 0x10000>;
> > +};
> > +
> > +Pheriparials using pads from iomuxc-lpsr support low state retention
> > +power state, under LPSR mode GPIO's state of pads are retain.
> > +
> >  Please refer to fsl,imx-pinctrl.txt in this directory for common
> > binding part  and usage.
> >
> >  Required properties:
> > -- compatible: "fsl,imx7d-iomuxc"
> > +- compatible: "fsl,imx7d-iomuxc" for main IOMUXC controller, or
> > +  "fsl,imx7d-iomuxc-lpsr" for Low Power State Retention IOMUXC controller.
> >  - fsl,pins: each entry consists of 6 integers and represents the mux and config
> >    setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg
> mux_val
> >    input_val> are specified using a PIN_FUNC_ID macro, which can be found in
> >    imx7d-pinfunc.h under device tree source folder.  The last integer CONFIG
> is
> >    the pad setting value like pull-up on this pin.  Please refer to i.MX7 Dual
> >    Reference Manual for detailed CONFIG settings.
> > +- fsl,input-sel: required property for iomuxc-lpsr controller, this
> > +property is
> > +  a phandle for main iomuxc controller which shares the input select
> > +register for
> > +  daisy chain settings.
> >
> >  CONFIG bits definition:
> >  PAD_CTL_PUS_100K_DOWN           (0 << 5)
> > @@ -25,3 +51,38 @@ PAD_CTL_DSE_X1                  (0 << 0)
> >  PAD_CTL_DSE_X2                  (1 << 0)
> >  PAD_CTL_DSE_X3                  (2 << 0)
> >  PAD_CTL_DSE_X4                  (3 << 0)
> > +
> > +Examples:
> > +While iomuxc-lpsr is intended to be used by dedicated peripherals to
> > +take advantages of LPSR power mode, is also possible that an IP to
> > +use pads from any of the iomux controllers. For example the I2C1 IP
> > +can use SCL pad from iomuxc-lpsr controller and SDA pad from iomuxc
> controller as:
> > +
> > +i2c1: i2c at 30a20000 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c1_1 &pinctrl_i2c1_2>;
> > +	status = "okay";
> > +};
> > +
> > +iomuxc-lpsr at 302c0000 {
> > +	compatible = "fsl,imx7d-iomuxc-lpsr";
> > +	reg = <0x302c0000 0x10000>;
> > +	fsl,input-sel = <&iomuxc>;
> > +
> > +	pinctrl_i2c1_1: i2c1grp-1 {
> > +		fsl,pins = <
> > +			MX7D_PAD_GPIO1_IO04__I2C1_SCL 0x4000007f
> > +		>;
> > +	};
> > +};
> > +
> > +iomuxc at 30330000 {
> > +	compatible = "fsl,imx7d-iomuxc";
> > +	reg = <0x30330000 0x10000>;
> > +
> > +	pinctrl_i2c1_2: i2c1grp-2 {
> > +		fsl,pins = <
> > +			MX7D_PAD_I2C1_SCL__I2C1_SCL 0x4000007f
> 
> I'm not sure how many times I should repeat: you should set up a I2C1_SDA
> instead of two I2C1_SCL in this example.
> 
> Shawn
[Adrian] Sorry about that, fixed in new patch series, thanks :)
> 
> > +		>;
> > +	};
> > +};
> > --
> > 2.1.4
> >
