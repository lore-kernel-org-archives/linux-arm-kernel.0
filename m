From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 21:16:05 +0100
Subject: [PATCH 4/6] ARM: dts: sun9i: Add GPIO LEDs for A80 Optimus board
In-Reply-To: <1414489843-2680-5-git-send-email-wens@csie.org>
References: <1414489843-2680-1-git-send-email-wens@csie.org>
 <1414489843-2680-5-git-send-email-wens@csie.org>
Message-ID: <20141028201605.GA9255@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Tue, Oct 28, 2014 at 05:50:41PM +0800, Chen-Yu Tsai wrote:
> The A80 Optimus board has 3 usable LEDs that are controlled via GPIO.
> 
> This patch adds support for 2 of them which are driver by GPIOs in the
> main pin controller. The remaining one uses GPIO from the R_PIO
> controller, which we don't support yet.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80-optimus.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
> index 25fe775..91eda76 100644
> --- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
> +++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
> @@ -64,6 +64,13 @@
>  				/* Enable internal pull-up */
>  				allwinner,pull = <1>;
>  			};
> +
> +			led_pins_optimus: led_pins at 0 {
> +				allwinner,pins = "PH0", "PH1";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
>  		};
>  
>  		uart0: serial at 07000000 {
> @@ -78,4 +85,22 @@
>  			status = "okay";
>  		};
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_optimus>;
> +
> +		led2 {
> +			label = "a80_optimus:led2:usr";

We're usually using a dash instead of an underscore as a separator.

> +			gpios = <&pio 7 0 0>;
> +		};
> +
> +		/* led3 is on PM15, in R_PIO */

You were saying that there is three LEDs, why start the numbering at
2?

> +
> +		led4 {
> +			label = "a80_optimus:led4:usr";
> +			gpios = <&pio 7 1 0>;
> +		};
> +	};
>  };

The rest of your patchset is fine for me, we just need to get the
pinctrl driver merged first :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/a985b3b6/attachment.sig>
