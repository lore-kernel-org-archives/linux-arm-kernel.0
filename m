From: mgr@pengutronix.de (Michael Grzeschik)
Date: Sun, 8 Mar 2015 17:00:22 +0100
Subject: [PATCH 2/2] ARM: dts: imx6: add support for technexion toucan
 board
In-Reply-To: <20150303010530.GA20455@dragon>
References: <1424457195-8796-1-git-send-email-m.grzeschik@pengutronix.de>
 <1424457195-8796-2-git-send-email-m.grzeschik@pengutronix.de>
 <20150303010530.GA20455@dragon>
Message-ID: <20150308160022.GA29524@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 09:05:32AM +0800, Shawn Guo wrote:
> On Fri, Feb 20, 2015 at 07:33:15PM +0100, Michael Grzeschik wrote:
> > This patch adds the second user of the edm1 module.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/Makefile          |   1 +
> >  arch/arm/boot/dts/imx6dl-toucan.dts | 203 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 204 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6dl-toucan.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 91bd5bd..bea96c8 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -234,6 +234,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
> >  	imx6dl-tx6dl-comtft.dtb \
> >  	imx6dl-tx6u-801x.dtb \
> >  	imx6dl-tx6u-811x.dtb \
> > +	imx6dl-toucan.dtb \
> 
> 'o' goes before 'x' in alphabet table.

Will be fixed in v2.

> 
> >  	imx6dl-wandboard.dtb \
> >  	imx6dl-wandboard-revb1.dtb \
> >  	imx6q-arm2.dtb \
> > diff --git a/arch/arm/boot/dts/imx6dl-toucan.dts b/arch/arm/boot/dts/imx6dl-toucan.dts
> > new file mode 100644
> > index 0000000..c801774
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6dl-toucan.dts
> > @@ -0,0 +1,203 @@
> > +/*
> > + * Copyright 2015 Michael Grzeschik <mgr@pengutronix.de>, Pengutronix
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +/dts-v1/;
> > +
> > +#include "imx6dl.dtsi"
> > +#include "imx6qdl-edm1.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +/ {
> > +	model = "Technexion Toucan";
> > +	compatible = "technexion,toucan", "fsl,imx6dl";
> > +
> > +	memory {
> > +		reg = <0x10000000 0x40000000>;
> > +	};
> > +
> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		reg_usbotg_vbus: regulator at 0 {
> > +			compatible = "regulator-fixed";
> > +			reg = <7>;
> 
> 'reg' value should match @unit-address.

Will be fixed in v2.

> 
> > +			regulator-name = "usbotg_vbus";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			pinctrl-names = "default";
> > +			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> > +			enable-active-high;
> > +		};
> > +
> > +		reg_2p5v: regulator at 1 {
> > +			compatible = "regulator-fixed";
> > +			reg = <0>;
> > +			regulator-name = "2P5V";
> > +			regulator-min-microvolt = <2500000>;
> > +			regulator-max-microvolt = <2500000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		reg_3p3v: regulator at 2 {
> > +			compatible = "regulator-fixed";
> > +			reg = <1>;
> > +			regulator-name = "3P3V";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-always-on;
> > +		};
> > +	};
> > +
> > +	sound {
> > +		compatible = "fsl,imx6-toucan-sgtl5000",
> > +			     "fsl,imx-audio-sgtl5000";
> > +		model = "imx6-toucan-sgtl5000";
> > +		ssi-controller = <&ssi1>;
> > +		audio-codec = <&codec>;
> > +		audio-routing =
> > +			"MIC_IN", "Mic Jack",
> > +			"Mic Jack", "Mic Bias",
> > +			"Headphone Jack", "HP_OUT";
> > +		mux-int-port = <1>;
> > +		mux-ext-port = <3>;
> > +	};
> 
> Can generic simple-audio-card be used instead?

I don't know. Is it common to use simple-audio-card for sgtl5000?
The Wandboard is using the same nodes. It probably makes sense to keep
it as it is tested. So I will leave this as is for v2.

> 
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_hog>;
> > +
> > +	imx6qdl-toucan {
> > +		pinctrl_hog: hoggrp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_CSI0_DAT19__GPIO6_IO05	0x0b0b0
> > +				MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02	0x0b0b0
> > +				MX6QDL_PAD_CSI0_DAT18__GPIO6_IO04	0x0b0b0
> > +				MX6QDL_PAD_EIM_D27__GPIO3_IO27		0x0b0b0
> > +				MX6QDL_PAD_EIM_D26__GPIO3_IO26		0x0b0b0
> > +				MX6QDL_PAD_EIM_BCLK__GPIO6_IO31		0x0b0b0
> > +				MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03	0x0b0b0
> > +				MX6QDL_PAD_ENET_RX_ER__GPIO1_IO24	0x0b0b0
> > +				MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x0b0b0
> > +				MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x0b0b0
> > +				MX6QDL_PAD_SD4_DAT0__GPIO2_IO08         0x17059
> > +			>;
> > +		};
> > +	};
> > +};
> > +
> > +&fec {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_enet>;
> > +	phy-mode = "rgmii";
> > +	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
> > +	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
> > +			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> > +	status = "okay";
> > +};
> > +
> > +&audmux {
> 
> Please sort these nodes alphabetically in label name.

Will change it in v2.


Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
