From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Jan 2013 16:17:57 -0800
Subject: [PATCH v6 2/8] ARM: dts: support pinctrl single in pxa910
In-Reply-To: <1356083118-18857-3-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
 <1356083118-18857-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130104001756.GO25633@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Haojian Zhuang <haojian.zhuang@linaro.org> [121221 01:48]:
> Add pinctrl-single support with device tree in pxa910 dkb platform.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/boot/dts/pxa910-dkb.dts |  204 +++++++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/pxa910.dtsi    |   68 +++++++++++++
>  2 files changed, 271 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
> index 595492a..76e9c8d 100644
> --- a/arch/arm/boot/dts/pxa910-dkb.dts
> +++ b/arch/arm/boot/dts/pxa910-dkb.dts
> @@ -24,10 +24,212 @@
>  
>  	soc {
>  		apb at d4000000 {
> -			uart1: uart at d4017000 {
> +			pmx: pinmux at d401e000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&board_pins>;

Looking at this maybe we should allow specifying the pinconf values at
the controller level too if the apply to all the registers:

				pinctrl-single,power-source = <enableval disableval regmask>;
				pinctrl-single,bias = <enableval disableval regmask>;
				pinctrl-single,input-schmitt = <enableval disableval regmask>;

> +
> +				board_pins: pinmux_board_pins {
> +					/* pins not owned by device driver */
> +					/* w1 */
> +					pinctrl-single,pins = <
> +						0x0cc 0x2	/* CLK_REQ_W1 */
> +					>;
> +					pinctrl-single,power-source = <0x1000 0x1800>;
> +					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
> +					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;

And then you could leave them out from here for your case, while I still need
to specify them at the register level.

> +				};
> +				uart1_pins: pinmux_uart1_pins {
> +					pinctrl-single,pins = <
> +						0x198 0x6	/* GPIO47_UART1_RXD */
> +						0x19c 0x6	/* GPIO48_UART1_TXD */
> +					>;
> +					/* power source, mask */
> +					pinctrl-single,power-source = <0x1000 0x1800>;
> +					/* bias, mask, disable, pull down, pull up */
> +					pinctrl-single,bias = <0xc000 0xe000 0 0xa000 0xc000>;
> +					/* input schmitt, mask, disable */
> +					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;

Regards,

Tony
