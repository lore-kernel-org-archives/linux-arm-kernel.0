From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 10 Nov 2013 00:59:08 +0100
Subject: [PATCH] ARM: mvebu: Add RN104 SATA LEDs driven via NXP PCA9554
 I2C to GPIO muxer
In-Reply-To: <877gchmggw.fsf@natisbad.org>
References: <877gchmggw.fsf@natisbad.org>
Message-ID: <527ECC4C.8080207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2013 10:07 PM, Arnaud Ebalard wrote:
> NETGEAR ReadyNAS 104 has a NXP PCA9554 I2C to GPIO chip. Among the 8 GPIO
> lines the chip makes available, four are used on the device to control
> the SATA LEDs (the four remaining ones are used for SATA disk presence).
> This patch adds DT entries for NXP PCA9554 and the four SATA GPIO LEDs.
>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
[...]
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> index b0b32f5..1efc871 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> @@ -123,6 +123,13 @@
>   					fan_startv = <1>;
>   					pwm_polarity = <0>;
>   				};
> +
> +				pca9554: pca9554 at 23 {
> +					compatible = "nxp,pca9554";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					reg = <0x23>;
> +				};
>   			};
>   		};
>   	};
> @@ -154,6 +161,30 @@
>   			gpios = <&gpio2 0 1>;    /* GPIO 64 Active Low */
>   			linux,default-trigger = "keep";
>   		};
> +
> +		sata1_led {
> +			label = "rn104:blue:sata1";
> +			gpios = <&pca9554 0 1>;  /* Active Low */

Same comment as for ReadyNAS 2120 patch:

#include <dt-bindings/gpio/gpio.h> and use GPIO_ACTIVE_HIGH/LOW.

Sebastian

> +			default-state = "off";
> +		};
> +
> +		sata2_led {
> +			label = "rn104:blue:sata2";
> +			gpios = <&pca9554 1 1>;  /* Active Low */
> +			default-state = "off";
> +		};
> +
> +		sata3_led {
> +			label = "rn104:blue:sata3";
> +			gpios = <&pca9554 2 1>;  /* Active Low */
> +			default-state = "off";
> +		};
> +
> +		sata4_led {
> +			label = "rn104:blue:sata4";
> +			gpios = <&pca9554 3 1>;  /* Active Low */
> +			default-state = "off";
> +		};
>   	};
>
>   	gpio_keys {
>
