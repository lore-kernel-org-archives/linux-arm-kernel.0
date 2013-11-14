From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Nov 2013 14:22:06 +0900
Subject: [PATCH] ARM: shmobile: Enable DSW2 with gpio-keys on KZM9D
In-Reply-To: <20131113230345.21482.36997.sendpatchset@w520>
References: <20131113230345.21482.36997.sendpatchset@w520>
Message-ID: <20131114052204.GD22870@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 08:03:45AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Use the gpio-keys driver to support the 4 pins on the
> dip switch DSW2 which is mounted on the KZM9D board.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Hi Magnus,

I have tried enabling the following on a config produced
using the kzm9d_defconfig:

CONFIG_INPUT_KEYBOARD
CONFIG_INPUT_EVDEV
CONFIG_KEYBOARD_GPIO

But all I see so far in dmsg is:

# dmesg | grep gpio 
platform gpio_keys.3: Driver gpio-keys requests probe deferral

I was expecting something more along the lines of:
input: gpio-keys as /devices/platform/gpio-keys/input/input0

Could you give me some guidance on how to test this?

> ---
> 
>  arch/arm/boot/dts/emev2-kzm9d.dts |   39 ++++++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/emev2.dtsi      |    2 -
>  2 files changed, 39 insertions(+), 2 deletions(-)
> 
> --- 0001/arch/arm/boot/dts/emev2-kzm9d.dts
> +++ work/arch/arm/boot/dts/emev2-kzm9d.dts	2013-11-13 20:21:27.000000000 +0900
> @@ -9,7 +9,9 @@
>   */
>  /dts-v1/;
>  
> -/include/ "emev2.dtsi"
> +#include "emev2.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  
>  / {
>  	model = "EMEV2 KZM9D Board";
> @@ -54,4 +56,39 @@
>  		vddvario-supply = <&reg_1p8v>;
>  		vdd33a-supply = <&reg_3p3v>;
>  	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		button at 1 {
> +			debounce_interval = <50>;
> +			wakeup = <1>;
> +			label = "DSW2-1";
> +			linux,code = <KEY_1>;
> +			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
> +		};
> +		button at 2 {
> +			debounce_interval = <50>;
> +			wakeup = <1>;
> +			label = "DSW2-2";
> +			linux,code = <KEY_2>;
> +			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +		};
> +		button at 3 {
> +			debounce_interval = <50>;
> +			wakeup = <1>;
> +			label = "DSW2-3";
> +			linux,code = <KEY_3>;
> +			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +		};
> +		button at 4 {
> +			debounce_interval = <50>;
> +			wakeup = <1>;
> +			label = "DSW2-4";
> +			linux,code = <KEY_4>;
> +			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
>  };
> --- 0001/arch/arm/boot/dts/emev2.dtsi
> +++ work/arch/arm/boot/dts/emev2.dtsi	2013-11-13 20:20:03.000000000 +0900
> @@ -8,7 +8,7 @@
>   * kind, whether express or implied.
>   */
>  
> -/include/ "skeleton.dtsi"
> +#include "skeleton.dtsi"
>  
>  / {
>  	compatible = "renesas,emev2";
> 
