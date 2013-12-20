From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Dec 2013 10:28:26 +0800
Subject: [PATCH V2] ARM: dts: imx6qdl-sabresd: Add power key support
In-Reply-To: <1387487244-2749-1-git-send-email-b20788@freescale.com>
References: <1387487244-2749-1-git-send-email-b20788@freescale.com>
Message-ID: <20131220022821.GJ7172@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 04:07:24PM -0500, Anson Huang wrote:
> This patch adds support for imx6qdl-sabresd board's power
> key, the key is named "SW1" on board, press it can wake up
> system from suspend.
> 
> Add a new pinctrl entry for gpio keys and move all gpio
> keys pin to this entry.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

There are a couple of minor things below.  Nothing major, so I just
fixed them up and applied the patch.

> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index e75e11b..b545895 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -10,6 +10,7 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
>  
> +#include <dt-bindings/input/input.h>

Have a blank line here.

>  / {
>  	memory {
>  		reg = <0x10000000 0x40000000>;
> @@ -46,19 +47,28 @@
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		power {
> +			label = "Power Button";
> +			gpios = <&gpio3 29 0>;
> +			gpio-key,wakeup;
> +			linux,code = <KEY_POWER>;
> +		};
>  
>  		volume-up {
>  			label = "Volume Up";
>  			gpios = <&gpio1 4 0>;
>  			gpio-key,wakeup;
> -			linux,code = <115>; /* KEY_VOLUMEUP */
> +			linux,code = <KEY_VOLUMEUP>;
>  		};
>  
>  		volume-down {
>  			label = "Volume Down";
>  			gpios = <&gpio1 5 0>;
>  			gpio-key,wakeup;
> -			linux,code = <114>; /* KEY_VOLUMEDOWN */
> +			linux,code = <KEY_VOLUMEDOWN>;
>  		};
>  	};
>  
> @@ -171,8 +181,6 @@
>  	hog {
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
> -				MX6QDL_PAD_GPIO_4__GPIO1_IO04   0x80000000
> -				MX6QDL_PAD_GPIO_5__GPIO1_IO05   0x80000000
>  				MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x80000000
>  				MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x80000000
>  				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
> @@ -185,6 +193,16 @@
>  			>;
>  		};
>  	};
> +
> +	gpio-keys {

We now use one pinctrl container 'imx6qdl-sabresd' for all pinctrl
groups, so we can move pinctrl_gpio_keys into above and save this
gpio-keys container.

Shawn

> +		pinctrl_gpio_keys: gpio_keysgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x80000000
> +				MX6QDL_PAD_GPIO_4__GPIO1_IO04   0x80000000
> +				MX6QDL_PAD_GPIO_5__GPIO1_IO05   0x80000000
> +			>;
> +		};
> +	};
>  };
>  
>  &ldb {
> -- 
> 1.7.9.5
> 
> 
