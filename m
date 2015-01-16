From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 16 Jan 2015 14:22:46 +0800
Subject: [PATCH] AT91, DT, usb gadget: disable pull-up on vbus-gpio (PB16)
 to reduce power consumption
In-Reply-To: <1421337643-24074-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421337643-24074-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <54B8AE36.6090904@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain Rochet,

On 01/16/2015 12:00 AM, Sylvain Rochet wrote:
> There is an external resistor divider on PB16, acting like a pull-down,
> the pull-up increase power consumption and prevent the vbus detect pin
> to reach Vss voltage, ~1.5V mesured on my board, it might no even work
> if the pull-up is stronger than usual.
>
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

Thanks for your patch.

Acked-by: Bo Shen <voice.shen@atmel.com>

> ---
>   arch/arm/boot/dts/at91sam9x5ek.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> index 3a9f6fa..f622f96 100644
> --- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> @@ -53,6 +53,8 @@
>   			};
>
>   			usb2: gadget at f803c000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_board_usb2>;
>   				atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
>   				status = "okay";
>   			};
> @@ -80,6 +82,13 @@
>   							<AT91_PIOD 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;	/* PD14 gpio CD pin pull up and deglitch */
>   					};
>   				};
> +
> +				usb2 {
> +					pinctrl_board_usb2: usb2-board {
> +						atmel,pins =
> +							<AT91_PIOB 16 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;		/* PB16, no pull up and deglitch */

Nitpick:
I think comments as "PB16 gpio vbus sense, deglitch" will be better. Or 
else change "pinctrl_board_usb2" to "pinctrl_usb2_vbus_sense". These 
will be help the user easily to understand the function of this pin.

> +					};
> +				};
>   			};
>
>   			spi0: spi at f0000000 {
>

Best Regards,
Bo Shen
