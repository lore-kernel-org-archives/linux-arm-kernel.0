From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 29 May 2017 21:11:00 +0800
Subject: [PATCH v3 06/10] pinctrl: sunxi: add support of R40 to A10
 pinctrl driver
In-Reply-To: <20170527102308.1988-7-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-7-icenowy@aosc.io>
Message-ID: <20170529131100.a56rv3e5z3kpcxuo@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 06:23:04PM +0800, Icenowy Zheng wrote:
> R40 is said to be an upgrade of A20, and its pin configuration is also
> similar to A20 (and thus similar to A10).
> 
> Add support for R40 to the A10 pinctrl driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/pinctrl/sunxi/Kconfig             |   2 +-
>  drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 272 +++++++++++++++++++++---------
>  2 files changed, 197 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index 624d84e6c936..9d01da3b90bd 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -7,7 +7,7 @@ config PINCTRL_SUNXI
>  	select GPIOLIB
>  
>  config PINCTRL_SUN4I_A10
> -	def_bool MACH_SUN4I || MACH_SUN7I
> +	def_bool MACH_SUN4I || MACH_SUN7I || MACH_SUN8I
>  	select PINCTRL_SUNXI
>  
>  config PINCTRL_SUN5I
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> index 159580c04b14..0f6ca8391ea7 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c

[...]

> @@ -162,14 +183,19 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>  		  SUNXI_FUNCTION(0x3, "can"),		/* RX */
>  		  SUNXI_FUNCTION(0x4, "uart1"),		/* RING */
>  		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ETXERR */
> -					 PINCTRL_SUN7I_A20),
> +					 PINCTRL_SUN7I_A20 |
> +					 PINCTRL_SUN8I_R40),
>  		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* DI */
> -					 PINCTRL_SUN7I_A20)),
> +					 PINCTRL_SUN7I_A20 |
> +					 PINCTRL_SUN8I_R40)),
>  	/* Hole */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
> -		  SUNXI_FUNCTION(0x2, "i2c0")),		/* SCK */
> +		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION_VARIANT(0x3,
> +					 "pll-lock-dbg",

Can you stick to underscores to be consistent?

> +					 PINCTRL_SUN8I_R40)),
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
> @@ -177,11 +203,19 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
> -		  SUNXI_FUNCTION(0x2, "pwm")),		/* PWM0 */
> +		  SUNXI_FUNCTION_VARIANT(0x2, "pwm",	/* PWM0 */
> +					 PINCTRL_SUN4I_A10 |
> +					 PINCTRL_SUN7I_A20),
> +		  SUNXI_FUNCTION_VARIANT(0x3, "pwm",	/* PWM0 */
> +					 PINCTRL_SUN8I_R40)),
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
> -		  SUNXI_FUNCTION(0x2, "ir0"),		/* TX */
> +		  SUNXI_FUNCTION_VARIANT(0x2, "ir0",	/* TX */
> +					 PINCTRL_SUN4I_A10 |
> +					 PINCTRL_SUN7I_A20),
> +		  SUNXI_FUNCTION_VARIANT(0x3, "pwm0",	/* PWM1 */

The numbering is wrong. Just drop the number altogether, like all the
other instances.

> +					 PINCTRL_SUN8I_R40),
>  		/*
>  		 * The SPDIF block is not referenced at all in the A10 user
>  		 * manual. However it is described in the code leaked and the
> @@ -205,7 +239,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* MCLK */
>  					 PINCTRL_SUN4I_A10),
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* MCLK */
> -					 PINCTRL_SUN7I_A20),
> +					 PINCTRL_SUN7I_A20 |
> +					 PINCTRL_SUN8I_R40),

Maybe we could use "i2s" instead, like on the A10. I don't know where
i2s1 is used, but it certainly isn't routed outside the SoC, and i2s2
looks like it's for dw-hdmi's audio path.

>  		  SUNXI_FUNCTION(0x3, "ac97")),		/* MCLK */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),

[...]

> @@ -237,31 +275,41 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO1 */
>  					 PINCTRL_SUN4I_A10),
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO1 */
> -					 PINCTRL_SUN7I_A20)),
> +					 PINCTRL_SUN7I_A20 |
> +					 PINCTRL_SUN8I_R40),
> +		  SUNXI_FUNCTION_VARIANT(0x4, "pwm",	/* PWM6 */
> +					 PINCTRL_SUN8I_R40)),
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 10),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO2 */
>  					 PINCTRL_SUN4I_A10),
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO2 */
> -					 PINCTRL_SUN7I_A20)),
> +					 PINCTRL_SUN7I_A20 |
> +					 PINCTRL_SUN8I_R40),
> +		  SUNXI_FUNCTION_VARIANT(0x4, "pwm",	/* PWM7 */
> +					 PINCTRL_SUN8I_R40)),
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 11),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO3 */
>  					 PINCTRL_SUN4I_A10),
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO3 */
> -					 PINCTRL_SUN7I_A20)),
> +					 PINCTRL_SUN7I_A20 |
> +					 PINCTRL_SUN8I_R40)),
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 12),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DI */
>  					 PINCTRL_SUN4I_A10),
>  		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DI */
> -					 PINCTRL_SUN7I_A20),
> +					 PINCTRL_SUN7I_A20 |
> +					 PINCTRL_SUN8I_R40),
>  		  SUNXI_FUNCTION(0x3, "ac97"),		/* DI */
>  		/* Undocumented mux function on A10 - See SPDIF MCLK above */
> -		  SUNXI_FUNCTION(0x4, "spdif")),        /* SPDIF IN */
> +		  SUNXI_FUNCTION_VARIANT(0x4, "spdif",	/* SPDIF IN */
> +					 PINCTRL_SUN4I_A10 |
> +					 PINCTRL_SUN7I_A20)),
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
> @@ -308,7 +356,9 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {

You missed PWM4 and PWM5 on pins PB20 and PB21.

>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
> -		  SUNXI_FUNCTION(0x3, "ir1")),		/* TX */
> +		  SUNXI_FUNCTION_VARIANT(0x3, "ir1",	/* TX */
> +					 PINCTRL_SUN4I_A10 |
> +					 PINCTRL_SUN7I_A20)),
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 23),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),

[...]

> @@ -916,7 +1000,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>  		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD12 */
>  					 PINCTRL_SUN4I_A10),
>  		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD1 */
> -					 PINCTRL_SUN7I_A20),
> +					 PINCTRL_SUN7I_A20 |
> +					 PINCTRL_SUN8I_R40),
> +		  SUNXI_FUNCTION_VARIANT(0x5, "sim",	/* DET */
> +					 PINCTRL_SUN8I_R40),

This is available on all 3 variants.

Should we consider sending a fix for this first? The hardware backing
this pin is not supported, but it would be less confusing to fix it
first instead of introducing a function for all variants in a patch
supposedly for just the R40.

>  		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN6 */
>  		  SUNXI_FUNCTION_IRQ(0x6, 16),		/* EINT16 */
>  		  SUNXI_FUNCTION(0x7, "csi1")),		/* D16 */

[...]

Looks good otherwise.


Regards
ChenYu
