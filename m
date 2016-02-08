From: chauveau.julien@gmail.com (Julien Chauveau)
Date: Mon, 8 Feb 2016 17:26:04 +0100
Subject: [PATCH v2 07/10] ARM64: dts: rockchip: Add power key to GeekBox
In-Reply-To: <1454897859-7601-8-git-send-email-afaerber@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
 <1454897859-7601-8-git-send-email-afaerber@suse.de>
Message-ID: <99011D31-E0AE-4F02-B769-E10617EA4F01@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

> Le 8 f?vr. 2016 ? 03:17, Andreas F?rber <afaerber@suse.de> a ?crit :
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
> v2: New
> 
> arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> index e84383fd6f10..fe5aa785cfda 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> @@ -70,6 +70,22 @@
> 		pinctrl-0 = <&ir_int>;
> 	};
> 
> +	keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwr_key>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;

I think #address-cells and #size-cells are not necessary.

> +
> +		button at 0 {
> +			reg = <0>;

reg can be removed too.

> +			gpio-key,wakeup = <1>;

You should use the new "wakeup-source ? property.

> +			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
> +			label = "GPIO Power";
> +			linux,code = <116>;

#include <dt-bindings/input/input.h>
and use KEY_POWER instead of 116

> +		};
> +	};
> +
> 	leds: gpio-leds {
> 		compatible = "gpio-leds";
> 
> @@ -265,6 +281,12 @@
> 		};
> 	};
> 
> +	keys {
> +		pwr_key: pwr-key {
> +			rockchip,pins = <0 2 RK_FUNC_GPIO &pcfg_pull_up>;

Is there a reason you want to enable the internal pull-up resistor on this pin?

The schematic shows there's already an external pull-up resistor so the internal one should not be needed.


> +		};
> +	};
> +
> 	pmic {
> 		pmic_sleep: pmic-sleep {
> 			rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
