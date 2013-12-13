From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 13 Dec 2013 10:54:17 +0100
Subject: [PATCH] ARM: dts: imx53: add support for Ka-Ro TX53 modules
In-Reply-To: <20131213081744.GR18380@S2101-09.ap.freescale.net>
References: <1386852128-32220-1-git-send-email-LW@KARO-electronics.de>
 <20131213081744.GR18380@S2101-09.ap.freescale.net>
Message-ID: <20131213105417.71a42133@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo wrote:
> On Thu, Dec 12, 2013 at 01:42:08PM +0100, Lothar Wa?mann wrote:
> > This patch adds support for the Ka-Ro electronics GmbH TX53 modules.
> > There are two distinct module types. One with an LVDS display
> > interface and SATA support, the other with a parallel LCD
> > interface and no SATA interface.
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  arch/arm/boot/dts/Makefile            |    2 +
> >  arch/arm/boot/dts/imx53-tx53-x03x.dts |  269 ++++++++++++
> >  arch/arm/boot/dts/imx53-tx53-x13x.dts |  283 ++++++++++++
> >  arch/arm/boot/dts/imx53-tx53.dtsi     |  420 ++++++++++++++++--
> >  5 files changed, 1701 insertions(+), 45 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/imx53-tx53-x03x.dts
> >  create mode 100644 arch/arm/boot/dts/imx53-tx53-x13x.dts
[...]
> > +	backlight0: pwm-backlight at 0 {
> 
> s/pwm-backlight/backlight
> 
> And nodename at num only makes sense when there is a property reg = <0xnum>
> for the node.  Otherwise, we do not add @num into the node name. 
> 
OK.

> Also, I do not see the point of having label backlight0 here.
> 
> > +		compatible = "pwm-backlight";
> > +		pwms = <&pwm2 0 500000>;
> > +		power-supply = <&reg_3v3>;
> > +		brightness-levels = <
> > +			100 99 98 97 96 95 94 93 92 91
> > +			 90 89 88 87 86 85 84 83 82 81
> > +			 80 79 78 77 76 75 74 73 72 71
> > +			 70 69 68 67 66 65 64 63 62 61
> > +			 60 59 58 57 56 55 54 53 52 51
> > +			 50 49 48 47 46 45 44 43 42 41
> > +			 40 39 38 37 36 35 34 33 32 31
> > +			 30 29 28 27 26 25 24 23 22 21
> > +			 20 19 18 17 16 15 14 13 12 11
> > +			 10  9  8  7  6  5  4  3  2  1
> > +			  0
> 
> Why is it so unique to start with 100 and end with 0?  Does it even
> work?  Here is what I read from bindings doc.
> 
Yes, it works. The backlight control of the displays we typically use
is active low. This is a poor man's way to get an inverted PWM output!
(And one in which the number written to the sysfs file corresponds to
the actual duty cycle of the PWM output)

> > +		>;
> > +		default-brightness-level = <50>;
> > +	};
> > +
> > +	regulators {
> > +		compatible = "simple-bus";
> 
> This property can be dropped, since it's already defined in
> imx53-tx53.dtsi?
> 
Yes.

> > +
> > +		reg_lcd_pwr: regulator at 5 {
> 
> The DT convention is that you need to have a property 'reg = <num>' if
> the node name is xxx at num.
> 
OK.

> > +			compatible = "regulator-fixed";
> > +			regulator-name = "LVDS0 POWER";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
> > +			enable-active-high;
> > +			regulator-boot-on;
> > +		};
> > +
> > +		reg_lcd_reset: regulator at 6 {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "LVDS1 POWER";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
> > +			enable-active-high;
> > +			regulator-boot-on;
> > +		};
> > +	};
> > +};
> > +
> > +&i2c3 {
> > +	status = "okay";
> > +
> 
> We generally put 'status' at the bottom of the property list.  So please
> drop the blank line and move 'status' after 'pinctrl-0'.
> 
OK.

> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c3>;
> > +
> > +	sgtl5000: codec at 0a {
> > +		compatible = "fsl,sgtl5000";
> > +		reg = <0x0a>;
> > +		VDDA-supply = <&reg_2v5>;
> > +		VDDIO-supply = <&reg_3v3>;
> > +		clocks = <&mclk>;
> > +	};
> > +
> > +	touchscreen: tsc2007 at 48 {
> > +		compatible = "ti,tsc2007";
> > +		reg = <0x48>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_tsc2007>;
> > +		interrupt-parent = <&gpio3>;
> > +		interrupts = <26 0>;
> > +		gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
> > +		ti,x-plate-ohms = <660>;
> > +		linux,wakeup;
> > +	};
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl-names = "default";
> 
> It does not make any sense to have a 'pinctrl-names' property when there
> is no 'pinctrl-0' accompanied.  So, please drop it.
> 
leftover after removing the hog pins I had there previously...

> > +
> > +	kpp {
> 
> It's not so helpful to create a container node for each device, after we
> move to board specific pingrp definition.  You can have only one
> container of all these pinctrl nodes just like all other IMX board dts
> files do.
> 
OK.

> > +		pinctrl_kpp: kppgrp {
> > +			fsl,pins = <
> > +				MX53_PAD_GPIO_9__KPP_COL_6 0x80000000
> > +				MX53_PAD_GPIO_4__KPP_COL_7 0x80000000
> > +				MX53_PAD_KEY_COL2__KPP_COL_2 0x80000000
> > +				MX53_PAD_KEY_COL3__KPP_COL_3 0x80000000
> > +
> 
> Nit: drop the blank line.
> 
> > +				MX53_PAD_GPIO_2__KPP_ROW_6 0x80000000
> > +				MX53_PAD_GPIO_5__KPP_ROW_7 0x80000000
> > +				MX53_PAD_KEY_ROW2__KPP_ROW_2 0x80000000
> > +				MX53_PAD_KEY_ROW3__KPP_ROW_3 0x80000000
> > +			>;
> > +		};
> > +	};
> > +
> > +	touchpanel {
> > +		pinctrl_tsc2007: tsc2007grp-1 {
> 
> Will there be anything like tsc2007grp-2?  Otherwise, tsc2007grp is good
> enough.
> 
I'll drop the '-1'.

> > +			fsl,pins = <
> > +				MX53_PAD_EIM_D26__GPIO3_26 0xe0 /* Interrupt */
> > +			>;
> > +		};
> > +	};
> > +};
> > +
> > +&kpp {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_kpp>;
> > +	status = "okay";
> > +
> > +	/* sample keymap */
> > +	/* row/col 0,1 are mapped to KPP row/col 6,7 */
> > +	linux,keymap = <
> > +		0x06060074 /* row 6, col 6, KEY_POWER */
> 
> With the help of include/dt-bindings/input/input.h, you can write it
> MATRIX_KEY(6, 6, KEY_POWER), right?
> 
Yes, that looks much better.

[...]
> > +&i2c3 {
> > +	status = "okay";
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c3>;
> > +
> > +	sgtl5000: codec at 0a {
> > +		compatible = "fsl,sgtl5000";
> > +		reg = <0x0a>;
> > +		VDDA-supply = <&reg_2v5>;
> > +		VDDIO-supply = <&reg_3v3>;
> > +		clocks = <&mclk>;
> > +	};
> 
> Can this be put into imx53-tx53.dtsi to save the duplication in both dts
> files?
> 
I prefer to keep all I2C clients of each bus together in one place to
have a better overview what devices are connected to the bus.

> > +
> > +	touchscreen1: eeti at 04 {
> > +		compatible = "eeti,egalax_ts";
> > +		reg = <0x04>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_eeti_1>;
> > +		interrupt-parent = <&gpio3>;
> > +		interrupts = <22 0>;
> > +		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> > +		linux,wakeup;
> > +	};
> > +};
[...]
> > +	pwm {
> > +		pinctrl_pwm1: pwm1grp {
> > +			fsl,pins = <MX53_PAD_GPIO_9__PWM1_PWMO 0x80000000>;
> > +		};
> > +	};
> > +
> > +	touchpanel {
> > +		pinctrl_eeti_1: eetigrp-1 {
> 
> pinctrl_eeti1: eeti1grp
> 
OK.

> > +			fsl,pins = <
> > +				MX53_PAD_EIM_D22__GPIO3_22 0xe0 /* Interrupt */
> > +			>;
> > +		};
> > +
> > +		pinctrl_eeti_2: eetigrp-2 {
> 
> pinctrl_eeti2: eeti2grp
> 
OK.

> > +			fsl,pins = <
> > +				MX53_PAD_EIM_D23__GPIO3_23 0xe0 /* Interrupt */
> > +			>;
> > +		};
> > +	};
> > +};
> > +
> > +&kpp {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_kpp>;
> > +	status = "okay";
> > +
> > +	/* sample keymap */
> > +	/* row/col 0,1 are mapped to KPP row/col 6,7
> > +	 * row/col 3 are used for I2C2 (second touch controller on hsd100pxn1)
> > +	 */
> > +	linux,keymap = <
> > +		0x06060074 /* row 6, col 6, KEY_POWER */
> > +		0x06070052 /* row 6, col 7, KEY_KP0 */
> > +		0x0602004f /* row 6, col 2, KEY_KP1 */
> > +		0x07060050 /* row 7, col 6, KEY_KP2 */
> > +		0x07070051 /* row 7, col 7, KEY_KP3 */
> > +		0x0702004b /* row 7, col 2, KEY_KP4 */
> > +		0x0206004c /* row 2, col 6, KEY_KP5 */
> > +		0x0207004d /* row 2, col 7, KEY_KP6 */
> > +		0x02020047 /* row 2, col 2, KEY_KP7 */
> > +	>;
> > +};
> > +
> > +&ldb {
> > +	status = "okay";
> > +//	fsl,dual-channel;
> 
> Drop it.
> 
debugging remnant...

[...]
> > diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
> > index db4255c..63bfa97 100644
> > --- a/arch/arm/boot/dts/imx53-tx53.dtsi
> > +++ b/arch/arm/boot/dts/imx53-tx53.dtsi
> > @@ -1,125 +1,455 @@
> >  /*
> > - * Copyright 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > + * Copyright 2012 <LW@KARO-electronics.de>
> > + * based on imx53-qsb.dts
> > + *   Copyright 2011 Freescale Semiconductor, Inc.
> > + *   Copyright 2011 Linaro Ltd.
> >   *
> >   * The code contained herein is licensed under the GNU General Public
> >   * License. You may obtain a copy of the GNU General Public License
> > - * Version 2 or later at the following locations:
> > + * Version 2 at the following locations:
> >   *
> >   * http://www.opensource.org/licenses/gpl-license.html
> >   * http://www.gnu.org/copyleft/gpl.html
> >   */
> >  
> > -/include/ "imx53.dtsi"
> > +#include "imx53.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> >  
> >  / {
> > -	model = "Ka-Ro TX53";
> > +	model = "Ka-Ro electronics TX53 module";
> >  	compatible = "karo,tx53", "fsl,imx53";
> >  
> > -	memory {
> > -		reg = <0x70000000 0x40000000>; /* Up to 1GiB */
> > +	aliases {
> > +		can0 = &can1;
> > +		can1 = &can2;
> > +		ipu = &ipu;
> > +		reg_can_xcvr = &reg_can_xcvr;
> > +		usbh1 = &usbh1;
> > +		usbotg = &usbotg;
> > +	};
> > +
> > +	clocks {
> > +		ckih1 {
> > +			clock-frequency = <0>;
> > +		};
> > +
> > +		mclk: codec_clock {
> 
> s/codec_clock/clock at 0
> 
OK.

[...]
> >  	regulators {
> >  		compatible = "simple-bus";
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> 
> Keep these.  They are the specification of 'reg' property for the child
> nodes.
> 
OK.

> >  
> > -		reg_3p3v: regulator at 0 {
> > +		reg_2v5: regulator at 0 {
> >  			compatible = "regulator-fixed";
> > -			reg = <0>;
> 
> Keep this.
> 
OK.

> > -			regulator-name = "3P3V";
> > +			regulator-name = "2V5";
> > +			regulator-min-microvolt = <2500000>;
> > +			regulator-max-microvolt = <2500000>;
> > +		};
> > +
> > +		reg_3v3: regulator at 1 {
> > +			compatible = "regulator-fixed";
> 
> Add 'reg' property as well as the following regulator nodes.
> 
OK.

[...]
> >  &can1 {
> >  	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_can1_2>;
> > -	status = "disabled";
> > +	pinctrl-0 = <&pinctrl_can1>;
> > +	xceiver-supply = <&reg_can_xcvr>;
> > +
> 
> Drop this blank line.
> 
OK.

> > +	status = "okay";
> >  };
> >  
> >  &can2 {
> >  	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_can2_1>;
> > -	status = "disabled";
> > +	pinctrl-0 = <&pinctrl_can2>;
> > +	xceiver-supply = <&reg_can_xcvr>;
> > +
> 
> Ditto
> 
> > +	status = "okay";
> >  };
> >  
> >  &ecspi1 {
> > +	status = "okay";
> > +
> 
> Drop the blank line and move the property to end of property list.
> 
> >  	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_ecspi1_2>;
> > -	status = "disabled";
> > +	pinctrl-0 = <&pinctrl_ecspi1>;
> > +
> 
> Drop this blank line.
> 
> > +	fsl,spi-num-chipselects = <2>;
> 
> Have a blank line between node and property.
> 
OK.

> > +	cs-gpios = <
> > +		&gpio2 30 GPIO_ACTIVE_HIGH
> > +		&gpio3 19 GPIO_ACTIVE_HIGH
> > +	>;
> > +
> > +	spidev0: spi at 0 {
> > +		compatible = "spidev";
> > +		reg = <0>;
> > +		spi-max-frequency = <54000000>;
> > +	};
> >  };
> >  
> >  &esdhc1 {
> > +	status = "okay";
> 
> Move it to end.
> 
> > +	cd-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
> > +	fsl,wp-controller;
> >  	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_esdhc1_2>;
> > -	status = "disabled";
> > +	pinctrl-0 = <&pinctrl_esdhc1>;
> >  };
> >  
> >  &esdhc2 {
> > +	status = "okay";
> 
> Ditto
> 
> > +	cd-gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>;
> > +	fsl,wp-controller;
> >  	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_esdhc2_1>;
> > -	status = "disabled";
> > +	pinctrl-0 = <&pinctrl_esdhc2>;
> >  };
> >  
> >  &fec {
> > +	status = "okay";
> > +
> 
> Ditto
> 
> >  	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_fec_1>;
> > +	pinctrl-0 = <&pinctrl_fec>;
> > +
> 
> Drop the line.
> 
> >  	phy-mode = "rmii";
> > -	status = "disabled";
> > +	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
> > +	phy-handle = <&phy0>;
> > +	mac-address = [000000000000]; /* placeholder; will be overwritten by bootloader */
> > +
> > +	phy0: ethernet-phy at 0 {
> > +		interrupt-parent = <&gpio2>;
> > +		interrupts = <4>;
> > +		device_type = "ethernet-phy";
> > +	};
> >  };
> >  
> > -&i2c3 {
> > +&i2c1 {
> >  	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_i2c3_2>;
> > -	status = "disabled";
> > +	pinctrl-0 = <&pinctrl_i2c1>;
> > +	clock-frequency = <400000>;
> > +	status = "okay";
> > +
> > +	rtc1: ds1339 at 68 {
> > +		compatible = "dallas,ds1339";
> > +		reg = <0x68>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_ds1339>;
> > +		interrupt-parent = <&gpio4>;
> > +		interrupts = <20 0>;
> > +	};
> > +
> > +	pmic: lt3589 at 48 {
> > +		compatible = "lt,lt3589";
> > +		reg = <0x48>;
> > +	};
> >  };
> >  
> > -&owire {
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_owire_1>;
> > -	status = "disabled";
> > +&iomuxc {
> > +	display {
> 
> One container node, please.
> 
OK.

[...]
> >  &ssi2 {
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_audmux_2>;
> >  	status = "disabled";
> >  };
> 
> Then you can drop the node completely.
> 
The SSI interface is accessible on the module but not used by default.
Thus I would like to keep it so that it is easier to find the place
where to enable this interface.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
