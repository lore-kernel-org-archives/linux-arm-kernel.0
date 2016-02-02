From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 2 Feb 2016 15:02:53 +0100
Subject: [PATCH] ARM: dts: imx51: add support for Ka-Ro electronics TX51
 modules
In-Reply-To: <20160202061842.GB8307@tiger>
References: <1453292619-3560-1-git-send-email-LW@KARO-electronics.de>
 <20160202061842.GB8307@tiger>
Message-ID: <20160202150253.340d8e86@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2 Feb 2016 14:18:42 +0800 Shawn Guo wrote:
> On Wed, Jan 20, 2016 at 01:23:39PM +0100, Lothar Wa?mann wrote:
> > The TX51-8xxx module series is a System On Module manufactured by
> >   Ka-Ro electronics GmbH with the following characteristics:
> >   Processor    Freescale i.MX515
> >                  up to 800 MHz (commercial)
> >                  up to 600 MHz (industrial)
> >   RAM          128/256MB mobile DDR-SDRAM
> >   ROM          128MB NAND Flash
> >   RTC          DS1339 Real Time Clock
> >   Power supply Single 3.1V to 5.5V
> >   Size         26mm SO-DIMM
> >   Temp. Range  0?C..70?C (-40?C..85?C)
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  arch/arm/boot/dts/Makefile       |   3 +-
> >  arch/arm/boot/dts/imx51-tx51.dts | 749 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 751 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/boot/dts/imx51-tx51.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index a4a6d70..ea70f34 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -277,7 +277,8 @@ dtb-$(CONFIG_SOC_IMX51) += \
> >  	imx51-babbage.dtb \
> >  	imx51-digi-connectcore-jsk.dtb \
> >  	imx51-eukrea-mbimxsd51-baseboard.dtb \
> > -	imx51-ts4800.dtb
> > +	imx51-ts4800.dtb \
> > +	imx51-tx51.dtb
> >  dtb-$(CONFIG_SOC_IMX53) += \
> >  	imx53-ard.dtb \
> >  	imx53-m53evk.dtb \
> > diff --git a/arch/arm/boot/dts/imx51-tx51.dts b/arch/arm/boot/dts/imx51-tx51.dts
> > new file mode 100644
> > index 0000000..80c5d60
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx51-tx51.dts
> > @@ -0,0 +1,749 @@
> > +/*
> > + * Copyright 2012-2014 Lothar Wa?mann <LW@KARO-electronics.de>
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> 
> We generally suggest GPL/X11 dual license for new dts to consider
> non-Linux device tree users.
> 
OK.

> > +
> > +/dts-v1/;
> > +#include "imx51.dtsi"
> > +#include <dt-bindings/pwm/pwm.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +	model = "Ka-Ro electronics TX51 module";
> > +	compatible = "karo,tx51", "fsl,imx51";
> > +
> > +	aliases {
> > +		backlight = &backlight;
> > +		display = &display;
> > +		i2c1 = &i2c_gpio;
> > +		usbotg = &usbotg;
> > +		wlan0 = &wlan0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = &uart1;
> > +	};
> > +
> > +	backlight: pwm-backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
> > +		power-supply = <&reg_3v3>;
> > +		brightness-levels = <
> > +			  0  1  2  3  4  5  6  7  8  9
> > +			 10 11 12 13 14 15 16 17 18 19
> > +			 20 21 22 23 24 25 26 27 28 29
> > +			 30 31 32 33 34 35 36 37 38 39
> > +			 40 41 42 43 44 45 46 47 48 49
> > +			 50 51 52 53 54 55 56 57 58 59
> > +			 60 61 62 63 64 65 66 67 68 69
> > +			 70 71 72 73 74 75 76 77 78 79
> > +			 80 81 82 83 84 85 86 87 88 89
> > +			 90 91 92 93 94 95 96 97 98 99
> > +			100
> > +		>;
> > +		default-brightness-level = <50>;
> > +	};
> > +
> > +	clocks {
> > +		ckih1 {
> > +			clock-frequency = <0>;
> > +		};
> > +
> > +		mclk: clock at 0 {
> 
> I would like to see these fixed rate clocks are named in a consistent
> way, maybe just drop 'reg' property and use a unique clock name to align
> with what imx51.dtsi does.
> 
OK.

> > +			compatible = "fixed-clock";
> > +			reg = <0>;
> > +			#clock-cells = <0>;
> > +			clock-output-names = "mclk";
> > +			clock-frequency = <26000000>;
> > +		};
> > +
> > +		clk_26M: clock at 1 {
> > +			compatible = "fixed-clock";
> > +			reg = <1>;
> > +			#clock-cells = <0>;
> > +			clock-output-names = "clk_26M";
> > +			clock-frequency = <26000000>;
> > +			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> > +		};
> > +
> > +		wlan_ref_clk: wlan-ref-clk {
> > +			compatible = "ti,wilink-clock";
> 
> I do not see this compatible string is documented anywhere.  And how is
> this compatible string used by kernel?
> 
This is a relic from a Test of a TI Wifi adapter.
Will be removed.

[...]
> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		reg_2v5: regulator at 0 {
> 
> Device tree maintainers do not like the fake simple-bus container node.
> We are asked to put these fixed regulators directly under root node,
> with a unique node name like:
> 
> 	reg_xxx: regulator-xxx {
> 		...
> 	};
> 
OK.

> > +	usbphy {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "simple-bus";
> > +
> > +		usbh1phy: usbphy at 0 {
> > +			compatible = "usb-nop-xceiv";
> > +			reg = <0>;
> > +			clocks = <&clk_26M>;
> > +			clock-names = "main_clk";
> > +		};
> 
> This should probably go with the same way as fixed regulators.
> 
This is modeled exactly after the code in imx51.dtsi:
|	usbphy {
|		#address-cells = <1>;
|		#size-cells = <0>;
|		compatible = "simple-bus";
|
|		usbphy0: usbphy at 0 {
|			compatible = "usb-nop-xceiv";
|			reg = <0>;
|			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
|			clock-names = "main_clk";
|		};
|	};

> > +	};
> > +
> > +	wlan0: tiwi-ble {
> > +		compatible = "ti,wilink6";
> 
> Undocumented compatible string.
>
See above.
 
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_wlan0>;
> > +		clocks = <&wlan_ref_clk>;
> > +		clock-names = "refclock";
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +};
> > +
> > +&audmux {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ssi1>;
> > +	status = "okay";
> > +};
> > +
> > +&ecspi1 {
> > +	fsl,spi-num-chipselects = <2>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi1>;
> > +	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>,
> > +		   <&gpio4 25 GPIO_ACTIVE_LOW>;
> > +	status = "okay";
> > +
> > +	spidev0: spi at 0 {
> > +		compatible = "spidev";
> > +		reg = <0>;
> > +		spi-max-frequency = <54000000>;
> > +	};
> > +
> > +	spidev1: spi at 1 {
> > +		compatible = "spidev";
> > +		reg = <1>;
> > +		spi-max-frequency = <54000000>;
> > +	};
> > +};
> > +
> > +&esdhc1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_esdhc1>;
> > +	cd-gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
> > +	fsl,wp-controller;
> > +	status = "okay";
> > +};
> > +
> > +&esdhc2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_esdhc2 &pinctrl_wlan0>;
> > +	vmmc-supply = <&reg_wlan0>;
> > +	bus-width = <4>;
> > +	no-1-8-v;
> > +	fsl,wp-controller;
> > +	cap-sdio-irq;
> > +	non-removable;
> > +	//cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
> 
> Drop it.
> 
This also stems from the Wifi adapter test...

> > +	status = "okay";
> > +};
> > +
> > +&fec {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_fec>;
> > +	phy-mode = "mii";
> > +//	phy-handle = <&phy0>;
> > +	local-mac-address = [000000000000]; /* will be set by U-Boot */
> > +	status = "okay";
> > +
> > +	phy0: ethernet-phy at 0 {
> > +		interrupt-parent = <&gpio3>;
> > +		interrupts = <18 0>;
> > +		device_type = "ethernet-phy";
> > +	};
> 
> This probably works, but I think we should follow the more standard
> bindings to put it like the following?
> 
> 
> 	phy-handle = <&phy0>;
> 
> 	mdio {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		phy0: ethernet-phy at 0 {
> 			interrupt-parent = <&gpio3>;
> 			interrupts = <18 0>;
> 			device_type = "ethernet-phy";
> 		};
> 	};
> 
OK.
 
> > +};
> > +
> > +&ipu {
> > +	status = "okay";
> > +};
> > +
> > +&i2c2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c2>;
> > +	status = "okay";
> > +
> > +	sgtl5000: sgtl5000 at 0a {
> 
> Use generic name like 'codec' for node might comply to DT convention
> better.
> 
OK.

> > +		compatible = "fsl,sgtl5000";
> > +		reg = <0x0a>;
> > +		clocks = <&mclk>;
> > +		VDDA-supply = <&reg_2v5>;
> > +		VDDIO-supply = <&reg_3v3>;
> > +	};
> > +
> > +	polytouch: edt-ft5x06 at 38 {
> > +		compatible = "edt,edt-ft5x06";
> > +		reg = <0x38>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_edt_ft5x06>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <5 0>;
> > +		reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
> > +		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	touchscreen: tsc2007 at 48 {
> 
> 	tsc2007: touchscreen at 48 {
> 
> > +		compatible = "ti,tsc2007";
> > +		reg = <0x48>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_tsc2007>;
> > +		interrupt-parent = <&gpio3>;
> > +		interrupts = <3 0>;
> > +		gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
> > +		ti,x-plate-ohms = <660>;
> > +		linux,wakeup;
> 
> Use the new standard 'wakeup-source' please.
> 
> https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt&id=1c49ad21c2cae607193da4495489c751d7147df2
> 
OK.

> > +	};
> > +};
> > +
> > +&iomuxc {
> 
> Please move the node to the bottom of the file to make the reset a bit
> easier for reading.
> 
> > +	imx51-tx51 {
> 
> Since commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without
> function nodes), this additional function container node can be saved.
> 
OK.

> > +		pinctrl_hog: hoggrp {
> > +			fsl,pins = <
> > +				MX51_PAD_GPIO1_7__GPIO1_7		0x20e0	/* 26MHz osc enable */
> > +			>;
> > +		};
> > +
> > +		pinctrl_ecspi1: ecspi1grp {
> > +			fsl,pins = <
> > +				MX51_PAD_CSPI1_SS0__ECSPI1_SS0		0x4
> > +				MX51_PAD_CSPI1_SS1__ECSPI1_SS1		0x4
> > +				MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK	0x5
> > +				MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI	0x85
> > +				MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
> > +				MX51_PAD_CSPI1_RDY__ECSPI1_RDY		0x84
> > +			>;
> > +		};
> > +
> > +		pinctrl_edt_ft5x06: edt-ft5x056grp {
> 
> I would suggest to not use any hyphen in pinctrl group node name to make
> the naming looks more consistent.
> 
OK.

[...]
> > +
> > +		pinctrl_kpp: kppgrp-1 {
> 
> The '-1' suffix means nothing and can just be dropped.
> 
OK.

[...]
> > +&ssi1 {
> > +	fsl,mode = "i2s-slave";
> 
> The "i2s-slave" of fsl,mode is deprecated and can be dropped.
> 
OK.


Lothar Wa?mann
