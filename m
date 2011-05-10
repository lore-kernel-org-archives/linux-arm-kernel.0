From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 10 May 2011 17:26:18 -0500
Subject: [PATCH] [wip] ARM: imx: register "leds-gpio" device using new
	helper function
In-Reply-To: <1305017456-10910-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110510073152.GF29089@pengutronix.de>
	<1305017456-10910-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1305017456-10910-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <0D753D10438DA54287A00B027084269764D2C3CCBE@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 10, 2011 1:51 AM, Uwe Kleine-K?nig wrote:
> This converts eukrea_mbimx27-baseboard to the new helper function.
>
> bloat-o-meter reports for this change:
>
>	add/remove: 1/1 grow/shrink: 0/1 up/down: 128/-220 (-92)
>	function                                     old     new   delta
>	gpio_led_register_device                       -     128    +128
>	platform_devices                              28      24      -4
>	leds_gpio                                    216       -    -216
>
> Additionally gpio_led_info (12 bytes) and gpio_leds (32 Bytes) are
> initdata now as is gpio_led_register_device.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> This is just an example and probably doesn't apply to the imx tree as
> is. I will convert all imx machines when there's an agreement for the
> patch providing the helper function.
>
>  arch/arm/mach-imx/Kconfig                    |    1 +
>  arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |   18 +++---------------
>  2 files changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 56b930a..ef16471 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -222,6 +222,7 @@ choice
> 
>  config MACH_EUKREA_MBIMX27_BASEBOARD
>  	bool "Eukrea MBIMX27 development board"
> +	select LEDS_GPIO_REGISTER
>  	select IMX_HAVE_PLATFORM_IMX_FB
>  	select IMX_HAVE_PLATFORM_IMX_KEYPAD
>  	select IMX_HAVE_PLATFORM_IMX_SSI
> diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> index fa5288018..3479f66 100644
> --- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> +++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> @@ -113,7 +113,7 @@ eukrea_mbimx27_keymap_data __initconst = {
>  	.keymap_size    = ARRAY_SIZE(eukrea_mbimx27_keymap),
>  };
>  
> -static struct gpio_led gpio_leds[] = {
> +static const struct gpio_led gpio_leds[] __initconst = {
>  	{
>  		.name			= "led1",
>  		.default_trigger	= "heartbeat",
> @@ -128,19 +128,11 @@ static struct gpio_led gpio_leds[] = {
>  	},
>  };
>  
> -static struct gpio_led_platform_data gpio_led_info = {
> +static const struct gpio_led_platform_data gpio_led_info __initconst = {
>  	.leds		= gpio_leds,
>  	.num_leds	= ARRAY_SIZE(gpio_leds),
>  };

Uwe,

Just a note that the 'const' you added to struct gpio_led above will be
discarded in struct gpio_led_platform_data.  You will get something like:

arch/arm/mach-imx/eukrea_mbimx27-baseboard.c:132: warning: initialization discards qualifiers from pointer target type

Regards,
Hartley
