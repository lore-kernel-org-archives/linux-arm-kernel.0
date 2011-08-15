From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 15 Aug 2011 13:19:17 +0200
Subject: [PATCH 17/18] mach-sa1100: retire custom LED code
In-Reply-To: <1312977952-2272-18-git-send-email-bryan.wu@canonical.com>
References: <1312977952-2272-1-git-send-email-bryan.wu@canonical.com>
	<1312977952-2272-18-git-send-email-bryan.wu@canonical.com>
Message-ID: <4E4900B5.8000708@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

> diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
> index b4311b0..2e370c6c 100644
> --- a/arch/arm/mach-sa1100/badge4.c
> +++ b/arch/arm/mach-sa1100/badge4.c
> @@ -22,6 +22,8 @@
>   #include<linux/mtd/mtd.h>
>   #include<linux/mtd/partitions.h>
>   #include<linux/errno.h>
> +#include<linux/gpio.h>
> +#include<linux/leds.h>
>
>   #include<mach/hardware.h>
>   #include<asm/mach-types.h>
> @@ -69,8 +71,36 @@ static struct platform_device sa1111_device = {
>   	.resource	= sa1111_resources,
>   };
>
> +/* LEDs */
> +struct gpio_led badge4_gpio_leds[] = {
> +	{
> +		.name			= "badge4:red",
> +		.default_trigger	= "heartbeat",
> +		.gpio			= 7,
> +	},
> +	{
> +		.name			= "badge4:green",
> +		.default_trigger	= "cpu0",
> +		.gpio			= 9,
> +	},
> +};
> +
> +static struct gpio_led_platform_data badge4_gpio_led_info = {
> +	.leds		= badge4_gpio_leds,
> +	.num_leds	= ARRAY_SIZE(badge4_gpio_leds),
> +};
> +
> +static struct platform_device badge4_leds = {
> +	.name	= "leds-gpio",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	=&badge4_gpio_led_info,
> +	}
> +};
> +
>   static struct platform_device *devices[] __initdata = {
>   	&sa1111_device,
> +	&badge4_leds;

Typo. This should be &badge4_leds,

>   };
>
>   static int __init badge4_sa1111_init(void)

Thanks,
Jochen
