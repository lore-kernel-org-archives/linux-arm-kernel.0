From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 9 Aug 2013 15:46:11 +0200
Subject: [PATCH 4/7] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <20130805061204.GD24629@S2101-09.ap.freescale.net>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
 <1375439907-10462-5-git-send-email-mpa@pengutronix.de>
 <20130805061204.GD24629@S2101-09.ap.freescale.net>
Message-ID: <20130809134611.GF13664@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 02:12:06PM +0800, Shawn Guo wrote:
> On Fri, Aug 02, 2013 at 12:38:24PM +0200, Markus Pargmann wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  .../bindings/pinctrl/fsl,imx27-pinctrl.txt         |  53 +++
> >  drivers/pinctrl/Kconfig                            |   8 +
> >  drivers/pinctrl/Makefile                           |   1 +
> >  drivers/pinctrl/pinctrl-imx27.c                    | 477 +++++++++++++++++++++
> >  4 files changed, 539 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
> >  create mode 100644 drivers/pinctrl/pinctrl-imx27.c
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
> > new file mode 100644
> > index 0000000..3352d94
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
> > @@ -0,0 +1,53 @@
> > +* Freescale IMX27 IOMUX Controller
> > +
> > +Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
> > +and usage.
> > +
> > +The iomuxc driver node can have pin configuration and gpio subnodes. gpio
> > +nodes defined as childs will share the registers with the iomuxc driver.
> > +Please have a look into
> > +Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt for information about
> > +the gpio properties.
> > +
> > +Required properties:
> > +- compatible: "fsl,imx27-iomuxc"
> > +
> > +Required properties for pin configuration node:
> > +- fsl,pins: three integers array, represents a group of pins mux and config
> > +  setting. The format is fsl,pins = <PIN MUX_ID CONFIG>. PIN and MUX_ID are
> 
> Neither here nor imx27-pinfunc.h is PIN documented clearly.  Also,
> imx27-pinfunc.h names MUX_CONFIG for what we name MUX_ID here.

I added PIN documentation in imx27-pinfunc.h and the bindings
docs. Fixed MUX_ID/MUX_CONFIG.

Thanks,

Markus

> 
> Shawn
> 
> > +  defined as macros in arch/arm/boot/dts/imx27-pinfunc.h. CONFIG can be 0 or
> > +  1, meaning Pullup disable/enable.
> > +
> > +Example:
> > +
> > +iomuxc: iomuxc at 10015000 {
> > +	compatible = "fsl,imx27-iomuxc";
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	reg = <0x10015000 0x600>;
> > +
> > +	gpio1: gpio at 10015000 {
> > +		compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> > +		reg = <0x10015000>;
> > +		interrupts = <8>;
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +	};
> > +
> > +	...
> > +
> > +	uart {
> > +		pinctrl_uart1: uart-1 {
> > +			fsl,pins = <
> > +				MX27_PAD_UART1_TXD__UART1_TXD 0x0
> > +				MX27_PAD_UART1_RXD__UART1_RXD 0x0
> > +				MX27_PAD_UART1_CTS__UART1_CTS 0x0
> > +				MX27_PAD_UART1_RTS__UART1_RTS 0x0
> > +			>;
> > +		};
> > +
> > +		...
> > +	};
> > +};
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
