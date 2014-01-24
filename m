From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 24 Jan 2014 23:04:52 +0100
Subject: [PATCH] ARM-i.MX6Q-dts : Added USB_OTG Support
In-Reply-To: <1390555724-9779-1-git-send-email-ashutosh.s@phytec.in>
References: <1390555724-9779-1-git-send-email-ashutosh.s@phytec.in>
Message-ID: <20140124220452.GL16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please add Phytec phyFLEX-i.MX6 to the subject. I assumed some SoC
specific changes here.

Sascha

On Fri, Jan 24, 2014 at 02:58:44PM +0530, Ashutosh singh wrote:
> This patch adds support for USB_OTG on Phytec phyFLEX-i.MX6 Quad module.
> 
> Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>
> ---
>  arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |    4 ++++
>  arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
> index 7d37ec6..39e69bd 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
> @@ -32,3 +32,7 @@
>  &usdhc3 {
>  	status = "okay";
>  };
> +
> +&usbotg {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> index 1a3b50d..dcb1d59 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> @@ -18,6 +18,19 @@
>  	memory {
>  		reg = <0x10000000 0x80000000>;
>  	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_usb_otg_vbus: usb_otg_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio4 15 0>;
> +			enable-active-low;
> +		};
> +	};
>  };
>  
>  &ecspi3 {
> @@ -134,6 +147,7 @@
>  				MX6QDL_PAD_EIM_D23__GPIO3_IO23 0x80000000
>  				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
>  				MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000 /* PMIC interrupt */
> +				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x80000000 /* USB_OTG_PWR_EN */
>  			>;
>  		};
>  	};
> @@ -178,3 +192,11 @@
>          wp-gpios = <&gpio1 29 0>;
>          status = "disabled";
>  };
> +
> +&usbotg {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg_1>;
> +	disable-over-current;
> +	status = "disabled";
> +};
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
