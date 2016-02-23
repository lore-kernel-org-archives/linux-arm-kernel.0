From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 23 Feb 2016 17:21:14 +0900
Subject: [PATCH] ARM: dts: add support for gpio buttons for
 exynos5422-odroidxu3
In-Reply-To: <1456214467-3344-1-git-send-email-linux.amoon@gmail.com>
References: <1456214467-3344-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <56CC167A.8040303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.02.2016 17:01, Anand Moon wrote:
> Add support for gpio-based button on Odroid-XU3 boards
> for reboot/poweroff feature.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> changes rebase based on linux next-20160222.
> 
> Tested on Odroid-XU4
> 
> dmesg output.
> [    3.286068] of_get_named_gpiod_flags: parsed 'gpios' property of node '/gpio_keys/power_key[0]' - status (0)
> [    3.286206] gpio-11 (power key): gpiod_set_debounce: missing set() or set_debounce() operations
> [    3.286600] input: gpio_keys as /devices/platform/gpio_keys/input/input0
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index 1bd507b..db9770b 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -11,6 +11,7 @@
>  */
>  
>  #include <dt-bindings/clock/samsung,s2mps11.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/sound/samsung-i2s.h>
> @@ -54,6 +55,22 @@
>  		#cooling-cells = <2>;
>  		cooling-levels = <0 130 170 230>;
>  	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_power_key>;
> +
> +		power_key {
> +			interrupt-parent = <&gpx0>;
> +			interrupts = <3 IRQ_TYPE_NONE>;

Hmmm.... why you specify the interrupts?

> +			gpios = <&gpx0 3 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_POWER>;
> +			label = "power key";

Just "power".

> +			debounce-interval = <10>;
> +			wakeup-source;
> +		};
> +	};
>  };
>  
>  &clock_audss {
> @@ -362,6 +379,11 @@
>  };
>  
>  &pinctrl_0 {
> +	gpio_power_key: power_key {

The naming is mixed... Everything is GPIO here so don't add such prefix.
Underscores only in label, not in name of node.

	power_key_irq: power-key-irq {

> +		samsung,pins = "gpx0-3";
> +		samsung,pin-pud = <0>;

Don't you want to set specific pin function? And what about drive strength?

Best regards,
Krzysztof

> +	};
> +
>  	hdmi_hpd_irq: hdmi-hpd-irq {
>  		samsung,pins = "gpx3-7";
>  		samsung,pin-function = <0>;
> 
