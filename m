From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 13 May 2013 17:25:50 +0400
Subject: [PATCH 3/3] ARM: mach-shmobile: lager: support GPIO switches
In-Reply-To: <1368435233-8587-4-git-send-email-horms+renesas@verge.net.au>
References: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
 <1368435233-8587-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <5190E9DE.6000502@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-05-2013 12:53, Simon Horman wrote:

> The lager board has pins 1 - 4 of SW2 wired up to GPIO pins.
> This patch allows access to those pins as KEYS 1 - 4 using
> gpio-keys.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[...]

> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index 6a1ba38..4d1b42b 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
[...]
> @@ -52,6 +55,22 @@ static struct gpio_led_platform_data lager_leds_pdata = {
>   	.num_leds	= ARRAY_SIZE(lager_leds),
>   };
>
> +/* GPIO KEY */
> +#define GPIO_KEY(c, g, d, ...) \
> +	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
> +
> +static struct gpio_keys_button gpio_buttons[] = {
> +	GPIO_KEY(KEY_4,		RCAR_GP_PIN(1, 28),	"SW2-pin4"),
> +	GPIO_KEY(KEY_3,		RCAR_GP_PIN(1, 26),	"SW2-pin3"),
> +	GPIO_KEY(KEY_2,		RCAR_GP_PIN(1, 24),	"SW2-pin2"),
> +	GPIO_KEY(KEY_1,		RCAR_GP_PIN(1, 14),	"SW2-pin1"),
> +};
> +
> +static struct gpio_keys_platform_data lager_keys_pdata = {

    You forgot to annotate this with __initdata.

> +	.buttons	= gpio_buttons,
> +	.nbuttons	= ARRAY_SIZE(gpio_buttons),
> +};
> +
>   static const struct pinctrl_map lager_pinctrl_map[] = {
>   	/* SCIF0 (CN19: DEBUG SERIAL0) */
>   	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
> @@ -73,6 +92,9 @@ static void __init lager_add_standard_devices(void)
>   	platform_device_register_data(&platform_bus, "leds-gpio", -1,
>   				      &lager_leds_pdata,
>   				      sizeof(lager_leds_pdata));
> +	platform_device_register_data(&platform_bus, "gpio-keys", -1,
> +				      &lager_keys_pdata,
> +				      sizeof(lager_keys_pdata));
>   }

WBR, Sergei
