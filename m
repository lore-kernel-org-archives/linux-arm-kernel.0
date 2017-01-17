From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 17 Jan 2017 10:47:16 -0300
Subject: [PATCH 2/2] arm64: dts: exynos: Add regulators for Vbus and
 Vbus-Boost
In-Reply-To: <1484649143-19423-3-git-send-email-pankaj.dubey@samsung.com>
References: <1484649143-19423-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170117102941epcas1p3a33a312bedd013edb0997b16786dede6@epcas1p3.samsung.com>
 <1484649143-19423-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <0266f79b-d667-d8f0-89f5-fd604a721a39@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pankaj,

On 01/17/2017 07:32 AM, Pankaj Dubey wrote:
> Adding fixed voltage regulators for Vbus and Vbus-boost required
> by USB 3.0 DRD controller on Exynos7-espresso board.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Vivek Gautam <gautamvivek1987@gmail.com>

Same comment than 1/2 here.

> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index 9cf73cf..68f3a51 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -33,6 +33,29 @@
>  		device_type = "memory";
>  		reg = <0x0 0x40000000 0x0 0xC0000000>;
>  	};
> +
> +	usb30_vbus_reg: regulator-usb30 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VBUS_5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gph1 1 0>;

Please use the GPIO_ACTIVE_HIGH instead for the GPIO polarity.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb30_vbus_en>;
> +		enable-active-high;
> +	};
> +
> +	usb3drd_boost_5v: regulator-usb3drd-boost {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VUSB_VBUS_5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpf4 1 0>;

Same here.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb3drd_boost_en>;
> +		enable-active-high;
> +	};
> +
>  };
>  
>  &fin_pll {
> @@ -366,3 +389,24 @@
>  	vqmmc-supply = <&ldo2_reg>;
>  	disable-wp;
>  };
> +
> +&usbdrd_phy {
> +	vbus-supply = <&usb30_vbus_reg>;
> +	vbus-boost-supply = <&usb3drd_boost_5v>;
> +};
> +
> +&pinctrl_bus1 {
> +	usb30_vbus_en: usb30-vbus-en {
> +		samsung,pins = "gph1-1";
> +		samsung,pin-function = <1>;

EXYNOS_PIN_FUNC_OUTPUT

> +		samsung,pin-pud = <0>;

EXYNOS_PIN_PULL_NONE

> +		samsung,pin-drv = <0>;

I see that there are no Exynos7 drive strengths values for 
Exynos7 in include/dt-bindings/pinctrl/samsung.h. It would
be good to add those (on a different series of course).

The patch looks good to me, so after the minor nits:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
