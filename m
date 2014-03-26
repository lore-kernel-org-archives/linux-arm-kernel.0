From: Peter.Chen@freescale.com (Peter Chen)
Date: Wed, 26 Mar 2014 02:00:49 +0000
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Add USB Host1 support
In-Reply-To: <1395750922-3244-1-git-send-email-festevam@gmail.com>
References: <1395750922-3244-1-git-send-email-festevam@gmail.com>
Message-ID: <07405bf6fc4841d5b0d22c07c582acb9@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts
> b/arch/arm/boot/dts/imx51-babbage.dts
> index 121dadd..0a4301f 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -119,6 +119,23 @@
>  			gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_usb_vbus: regulator at 0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "usb_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio2 5 0>;
> +			enable-active-high;
> +		};
> +	};
> +
>  };
> 
>  &esdhc1 {
> @@ -461,6 +478,23 @@
>  				MX51_PAD_EIM_D24__UART3_CTS		0x1c5
>  			>;
>  		};
> +
> +		pinctrl_usbh1: usbh1grp {
> +			fsl,pins = <
> +				MX51_PAD_USBH1_CLK__USBH1_CLK		0x80000000
> +				MX51_PAD_USBH1_DIR__USBH1_DIR		0x80000000
> +				MX51_PAD_USBH1_NXT__USBH1_NXT		0x80000000
> +				MX51_PAD_USBH1_DATA0__USBH1_DATA0	0x80000000
> +				MX51_PAD_USBH1_DATA1__USBH1_DATA1	0x80000000
> +				MX51_PAD_USBH1_DATA2__USBH1_DATA2	0x80000000
> +				MX51_PAD_USBH1_DATA3__USBH1_DATA3	0x80000000
> +				MX51_PAD_USBH1_DATA4__USBH1_DATA4	0x80000000
> +				MX51_PAD_USBH1_DATA5__USBH1_DATA5	0x80000000
> +				MX51_PAD_USBH1_DATA6__USBH1_DATA6	0x80000000
> +				MX51_PAD_USBH1_DATA7__USBH1_DATA7	0x80000000
> +				MX51_PAD_EIM_D21__GPIO2_5		0x80000000
> +			>;
> +		};
>  	};
>  };
> 
> @@ -529,3 +563,11 @@
>  		>;
>  	status = "okay";
>  };
> +
> +&usbh1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbh1>;
> +	vbus-supply = <&reg_usb_vbus>;
> +	phy_type = "ulpi";
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index e508e6f..917b6ed 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -100,6 +100,13 @@
>  			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
>  			clock-names = "main_clk";
>  		};
> +
> +		usbphy1: usbphy at 1 {
> +			compatible = "usb-nop-xceiv";
> +			reg = <1>;
> +			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> +			clock-names = "main_clk";
> +		};
>  	};
> 

You are using usb nop phy driver (phy-generic.c) for ulpi phy,
Are you sure your phy doesn't need any configurations from viewport?

Peter

>  	soc {
> @@ -239,6 +246,7 @@
>  				interrupts = <14>;
>  				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
>  				fsl,usbmisc = <&usbmisc 1>;
> +				fsl,usbphy = <&usbphy1>;
>  				status = "disabled";
>  			};
> 
> --
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
