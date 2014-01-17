From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 17 Jan 2014 10:08:35 +0100
Subject: [PATCH] ARM: dts: imx6: Add DFI FS700-M60 board support
In-Reply-To: <20140117063929.GF1565@shlinux1.ap.freescale.net>
References: <1389876354-24341-1-git-send-email-s.hauer@pengutronix.de>
 <20140117063929.GF1565@shlinux1.ap.freescale.net>
Message-ID: <20140117090835.GA16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 02:39:31PM +0800, Shawn Guo wrote:
> On Thu, Jan 16, 2014 at 01:45:54PM +0100, Sascha Hauer wrote:
> > diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
> > new file mode 100644
> > index 0000000..ca3c748
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
> > @@ -0,0 +1,145 @@
> > +/ {
> > +	regulators {
> > +		compatible = "simple-bus";
> > +
> > +		dummy_reg: fixed at 0 {
> 
> regulator at 0
> 
> > +			compatible = "regulator-fixed";
> 
> reg = <0>;
> 
> > +			regulator-name = "dummy-supply";
> > +		};
> > +
> > +		reg_usb_otg_vbus: usb_otg_vbus {
> 
> regulator at 1
> 
> > +			compatible = "regulator-fixed";
> 
> reg = <1>;
> 
> > +			regulator-name = "usb_otg_vbus";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			gpio = <&gpio3 22 0>;
> > +			enable-active-high;
> > +		};
> > +	};
> > +
> > +	chosen {
> > +		linux,stdout-path = &uart1;
> > +	};
> > +};
> > +
> > +&ecspi3 {
> > +	fsl,spi-num-chipselects = <1>;
> > +	cs-gpios = <&gpio4 24 0>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi3>;
> > +	status = "okay";
> > +
> > +	flash: m25p80 at 0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "sst,sst25vf040b", "m25p80";
> > +		spi-max-frequency = <20000000>;
> > +		reg = <0>;
> > +	};
> > +};
> > +
> > +&fec {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_enet>;
> > +	status = "okay";
> > +	phy-mode = "rgmii";
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_hog>;
> > +
> > +	imx6qdl-dfi-fs700-m60 {
> > +		pinctrl_hog: hoggrp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
> > +				MX6QDL_PAD_GPIO_18__GPIO7_IO13 0x80000000 /* PMIC irq */
> > +				MX6QDL_PAD_EIM_D26__GPIO3_IO26 0x80000000 /* MAX11801 irq */
> > +				MX6QDL_PAD_NANDF_D5__GPIO2_IO05 0x000030b0 /* Backlight enable */
> > +				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000 /* SD2 card detect */
> 
> Can we minimize the pins in hog group by moving the client device's pins
> into device's pin entry, just like what you do for
> MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24?
> 
> > +			>;
> > +		};
> > +
> > +		pinctrl_enet: enetgrp {
> > +			fsl,pins = <MX6QDL_ENET_PINGRP1>;
> > +		};
> > +
> > +		pinctrl_i2c2: i2c2grp {
> > +			fsl,pins = <MX6QDL_I2C2_PINGRP1>;
> > +		};
> > +
> > +		pinctrl_uart1: uart1grp {
> > +			fsl,pins = <MX6QDL_UART1_PINGRP1>;
> > +		};
> > +
> > +		pinctrl_usbotg: usbotggrp {
> > +			fsl,pins = <MX6QDL_USBOTG_PINGRP2>;
> > +		};
> > +
> > +		pinctrl_usdhc2: usdhc2grp {
> > +			fsl,pins = <MX6QDL_USDHC2_PINGRP_D4>;
> > +		};
> > +
> > +		pinctrl_usdhc3: usdhc3grp {
> > +			fsl,pins = <MX6QDL_USDHC3_PINGRP_D4>;
> > +		};
> > +
> > +		pinctrl_usdhc4: usdhc4grp {
> > +			fsl,pins = <MX6QDL_USDHC4_PINGRP_D8>;
> > +		};
> > +	};
> > +
> > +	ecspi3 {
> > +		pinctrl_ecspi3: ecspi3_csgrp {
> 
> s/ecspi3_csgrp/ecspi3grp
> 
> And just move the node into imx6qdl-dfi-fs700-m60?

Makes sense. Addressed all comments in v2.

Thanks for reviewing.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
