From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 23 May 2016 11:03:11 +0200
Subject: [PATCH 1/2] ARM: dts: imx6q: extend support for the cm-fx6
In-Reply-To: <709d6b3d522f4fcb8112830e0426dbb3@rwthex-s1-b.rwth-ad.de>
References: <709d6b3d522f4fcb8112830e0426dbb3@rwthex-s1-b.rwth-ad.de>
Message-ID: <1463994191.2370.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 23.05.2016, 00:47 +0200 schrieb
christopher.spinrath at rwth-aachen.de:
> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> 
> The cm-fx6 module has an on-board spi-flash chip for its firmware, an
> eeprom (containing e.g. the mac address of the on-board Ethernet),
> a sata port, a pcie controller, an USB hub, and an USB otg port.
> Enable support for them. In addition, enable syscon poweroff support.
> 
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> ---
>  arch/arm/boot/dts/imx6q-cm-fx6.dts | 136 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> index 99b46f8..f4fc22e 100644
> --- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
> +++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> @@ -31,6 +31,61 @@
>  			linux,default-trigger = "heartbeat";
>  		};
>  	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +

Please remove this regulator pseudo-bus. It doesn't exist in hardware.
The regulators are direct children of the module.

> +		reg_usb_otg_vbus: usb_otg_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio3 22 0>;
> +			enable-active-high;
> +		};
> +
> +		reg_usb_h1_vbus: usb_h1_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb_h1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio7 8 0>;
> +			enable-active-high;
> +		};
> +	};
> +};
> +
> +&ecspi1 {
> +	fsl,spi-num-chipselects = <2>;
> +	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	status = "okay";
> +
> +	flash: m25p80 at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "st,m25p", "jedec,spi-nor";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +
> +		partition at 0 {
> +			label = "uboot";
> +			reg = <0x0 0xc0000>;
> +		};
> +
> +		partition at c0000 {
> +			label = "uboot environment";
> +			reg = <0xc0000 0x40000>;
> +		};
> +
> +		partition at 100000 {
> +			label = "reserved";
> +			reg = <0x100000 0x100000>;
> +		};

Partition layouts don't belong in the upstream DT, as it a device
configuration thing. Please kep them in the bootloader/firmware and make
this one pass the partition layout to the kernel.

> +	};
>  };
>  
>  &fec {
> @@ -46,8 +101,31 @@
>  	status = "okay";
>  };
>  
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	eeprom at 50 {
> +		compatible = "at24,24c02";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +};
> +
>  &iomuxc {
>  	imx6q-cm-fx6 {
> +		pinctrl_ecspi1: ecspi1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		 0x100b1
> +				MX6QDL_PAD_EIM_D17__ECSPI1_MISO		 0x100b1
> +				MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		 0x100b1
> +				MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x100b1
> +				MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x100b1
> +			>;
> +		};
> +
>  		pinctrl_enet: enetgrp {
>  			fsl,pins = <
>  				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
> @@ -91,17 +169,75 @@
>  			>;
>  		};
>  
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_3__I2C3_SCL 0x4001b8b1
> +				MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_pcie: pciegrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x80000000
> +				MX6QDL_PAD_EIM_CS1__GPIO2_IO24 0x80000000
> +			>;
> +		};
> +
>  		pinctrl_uart4: uart4grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
>  				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
>  			>;
>  		};
> +
> +		pinctrl_usbh1: usbh1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_RST__GPIO7_IO08 0x80000000
> +			>;
> +		};
> +
> +		pinctrl_usbotg: usbotggrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
> +				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x80000000
> +			>;
> +		};
>  	};
>  };
>  
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	reset-gpio = <&gpio1 26 0>;
> +	power-on-gpio = <&gpio2 24 0>;

There is no power-on-gpio in the upstream binding.

> +	status = "okay";
> +};
> +
> +&sata {
> +	status = "okay";
> +};
> +
> +&snvs_poweroff {
> +	status = "okay";
> +};
> +
>  &uart4 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart4>;
>  	status = "okay";
>  };
> +
> +&usbotg {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	vbus-supply = <&reg_usb_h1_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbh1>;
> +	status = "okay";
> +};
