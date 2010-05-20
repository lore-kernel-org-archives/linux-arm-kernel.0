From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 May 2010 08:33:17 +0200
Subject: [PATCH 02/13] eukrea_mbimx27-baseboard: add generic-bl and
	platform-lcd controls
In-Reply-To: <1274287568-30253-2-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
Message-ID: <20100520063317.GR31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Wed, May 19, 2010 at 06:45:57PM +0200, Eric B?nard wrote:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |   55 +++++++++++++++++++++++---
>  1 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
> index c9e4452..0f201c5 100644
> --- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
> +++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
> @@ -24,6 +24,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> +#include <linux/backlight.h>
> +#include <video/platform_lcd.h>
>  
>  #include <asm/mach/arch.h>
>  
> @@ -103,12 +105,6 @@ static struct gpio_led gpio_leds[] = {
>  		.active_low		= 1,
>  		.gpio			= GPIO_PORTF | 19,
>  	},
> -	{
> -		.name			= "backlight",
> -		.default_trigger	= "backlight",
> -		.active_low		= 0,
> -		.gpio			= GPIO_PORTE | 5,
> -	},
>  };
>  
>  static struct gpio_led_platform_data gpio_led_info = {
> @@ -153,6 +149,47 @@ static struct imx_fb_platform_data eukrea_mbimx27_fb_data = {
>  	.dmacr		= 0x00040060,
>  };
>  
> +static void eukrea_mbimx27_bl_set_intensity(int intensity)
> +{
> +	if (intensity)
> +		gpio_direction_output(GPIO_PORTE | 5, 1);
> +	else
> +		gpio_direction_output(GPIO_PORTE | 5, 0);
> +}

PE5 is connected to a PWM for which we have a driver in the tree. Don't
you want to use it? As it happens my collegue just some code to make it
usable on the pca100 board. I can send you the code if you want to.



> +
> +static struct generic_bl_info eukrea_mbimx27_bl_info = {
> +	.name			= "eukrea_mbimx27-bl",
> +	.max_intensity		= 0xff,
> +	.default_intensity	= 0xff,
> +	.set_bl_intensity	= eukrea_mbimx27_bl_set_intensity,
> +};
> +
> +static struct platform_device eukrea_mbimx27_bl_dev = {
> +	.name			= "generic-bl",
> +	.id			= 1,
> +	.dev = {
> +		.platform_data	= &eukrea_mbimx27_bl_info,
> +	},
> +};
> +
> +static void eukrea_mbimx27_lcd_power_set(struct plat_lcd_data *pd,
> +				   unsigned int power)
> +{
> +	if (power)
> +		gpio_direction_output(GPIO_PORTA | 25, 1);
> +	else
> +		gpio_direction_output(GPIO_PORTA | 25, 0);
> +}
> +
> +static struct plat_lcd_data eukrea_mbimx27_lcd_power_data = {
> +	.set_power		= eukrea_mbimx27_lcd_power_set,
> +};
> +
> +static struct platform_device eukrea_mbimx27_lcd_powerdev = {
> +	.name			= "platform-lcd",
> +	.dev.platform_data	= &eukrea_mbimx27_lcd_power_data,
> +};
> +
>  static struct imxuart_platform_data uart_pdata[] = {
>  	{
>  		.flags = IMXUART_HAVE_RTSCTS,
> @@ -244,6 +281,12 @@ void __init eukrea_mbimx27_baseboard_init(void)
>  	mxc_gpio_mode(GPIO_PORTF | 19 | GPIO_GPIO | GPIO_OUT);
>  	/* Backlight */
>  	mxc_gpio_mode(GPIO_PORTE | 5 | GPIO_GPIO | GPIO_OUT);
> +	gpio_request(GPIO_PORTE | 5, "backlight");
> +	platform_device_register(&eukrea_mbimx27_bl_dev);
> +	/* LCD Reset */
> +	mxc_gpio_mode(GPIO_PORTA | 25 | GPIO_GPIO | GPIO_OUT);
> +	gpio_request(GPIO_PORTA | 25, "lcd_enable");
> +	platform_device_register(&eukrea_mbimx27_lcd_powerdev);
>  
>  	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
>  }
> -- 
> 1.6.3.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
