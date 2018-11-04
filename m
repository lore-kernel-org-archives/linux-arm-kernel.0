From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 4 Nov 2018 15:27:38 +0800
Subject: [PATCH v2 1/1] ARM: dts: imx6sx-sdb: Add flexcan support
In-Reply-To: <20181020023318.21663-1-qiangqing.zhang@nxp.com>
References: <20181020023318.21663-1-qiangqing.zhang@nxp.com>
Message-ID: <20181104072734.GA26016@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2018 at 02:35:36AM +0000, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> CAN transceiver is different on RevA and RevB board.
> It's active high on RevA while active low on Rev B.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb-reva.dts | 12 ++++++++
>  arch/arm/boot/dts/imx6sx-sdb.dts      |  5 ++++
>  arch/arm/boot/dts/imx6sx-sdb.dtsi     | 42 +++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> index 9cc6ff206aea..d98dcf00b9c4 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> @@ -10,6 +10,18 @@
>  
>  / {
>  	model = "Freescale i.MX6 SoloX SDB RevA Board";
> +
> +	/* Transceiver EN/STBY is active high on RevA board */
> +	reg_can_en: regulator-can-en {
> +		gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};

Please use label node to make it easier for both yourself and readers.

&reg_can_en {
	...
};

Shawn

> +
> +	reg_can_stby: regulator-can-stby {
> +		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_can_en>;
> +	};
>  };
>  
>  &i2c1 {
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 6dd9bebfe027..092b8de142a8 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -10,6 +10,11 @@
>  
>  / {
>  	model = "Freescale i.MX6 SoloX SDB RevB Board";
> +
> +	/* Transceiver EN/STBY is active low on RevB board */
> +	reg_can_stby: regulator-can-stby {
> +		gpio = <&gpio4 27 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &i2c1 {
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> index f8f31872fa14..e37ec4b396a2 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> @@ -136,6 +136,20 @@
>  		regulator-max-microvolt = <5000000>;
>  	};
>  
> +	reg_can_en: regulator-can-en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "can-en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	reg_can_stby: regulator-can-stby {
> +		compatible = "regulator-fixed";
> +		regulator-name = "can-stby";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
>  	sound {
>  		compatible = "fsl,imx6sx-sdb-wm8962", "fsl,imx-audio-wm8962";
>  		model = "wm8962-audio";
> @@ -202,6 +216,20 @@
>  	status = "okay";
>  };
>  
> +&flexcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&reg_can_stby>;
> +	status = "okay";
> +};
> +
> +&flexcan2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	xceiver-supply = <&reg_can_stby>;
> +	status = "okay";
> +};
> +
>  &i2c3 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -397,6 +425,20 @@
>  			>;
>  		};
>  
> +		pinctrl_flexcan1: flexcan1grp {
> +			fsl,pins = <
> +				MX6SX_PAD_QSPI1B_DQS__CAN1_TX		0x1b020
> +				MX6SX_PAD_QSPI1A_SS1_B__CAN1_RX		0x1b020
> +			>;
> +		};
> +
> +		pinctrl_flexcan2: flexcan2grp {
> +			fsl,pins = <
> +				MX6SX_PAD_QSPI1B_SS1_B__CAN2_RX		0x1b020
> +				MX6SX_PAD_QSPI1A_DQS__CAN2_TX		0x1b020
> +			>;
> +		};
> +
>  		pinctrl_gpio_keys: gpio_keysgrp {
>  			fsl,pins = <
>  				MX6SX_PAD_CSI_DATA04__GPIO1_IO_18 0x17059
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
