From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Feb 2014 10:23:09 +0800
Subject: [PATCH v3 1/4] Phytec phyFLEX-i.MX6 : Added USB_OTG Support
In-Reply-To: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
References: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
Message-ID: <20140219022307.GL15716@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 07:16:22PM +0530, Ashutosh singh wrote:
> This patch adds support for USB_OTG on Phytec phyFLEX-i.MX6 Quad module.
> 
> Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>

Please have the prefix of patch subject be 'ARM: dts: imx6q-phytec: ...'

> ---
>  arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |    4 ++++
>  arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
> index 7d37ec6..87c3702 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
> @@ -25,6 +25,10 @@
>  	status = "okay";
>  };
>  
> +&usbotg {
> +	status = "okay";
> +};
> +
>  &usdhc2 {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> index 1a3b50d..e025ad2 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> @@ -18,6 +18,14 @@
>  	memory {
>  		reg = <0x10000000 0x80000000>;
>  	};
> +
> +	reg_usb_otg_vbus: regulator at 0 {

You do not have a 'reg' property in the node, so you shouldn't have
'@num' in node name.  You may want to name it 'regulator-0'.

> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio4 15 0>;
> +	};
>  };
>  
>  &ecspi3 {
> @@ -134,6 +142,7 @@
>  				MX6QDL_PAD_EIM_D23__GPIO3_IO23 0x80000000
>  				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
>  				MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000 /* PMIC interrupt */
> +				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x80000000 /* USB_OTG_PWR_EN */

Don't add it into hog group.  Define a pinctrl state in above regulator
node for it.

>  			>;
>  		};
>  	};
> @@ -162,6 +171,14 @@
>  	status = "disabled";
>  };
>  
> +&usbotg {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg_1>;

pinctrl_usbotg_1 is gone.  Please generate the patch against my for-next
branch below.

 git://git.linaro.org/people/shawnguo/linux-2.6.git for-next

Shawn

> +	disable-over-current;
> +	status = "disabled";
> +};
> +
>  &usdhc2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc2_2>;
> -- 
> 1.7.9.5
> 
