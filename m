From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 27 Nov 2012 08:42:09 +0100
Subject: [PATCH] ARM: eukrea_mbimx27-baseboard - use stock
 get_pendown_state() in ads7846
In-Reply-To: <20121124082529.GA7687@core.coreip.homeip.net>
References: <20121124082529.GA7687@core.coreip.homeip.net>
Message-ID: <20121127074209.GL10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2012 at 12:25:30AM -0800, Dmitry Torokhov wrote:
> The default implementation matches exactly our custom one so we can switch
> to using the default one. As a bonus the driver will take care of setting
> GPIO line for us.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Not tested - no hardware, but should be fine.
> 
>  arch/arm/mach-imx/eukrea_mbimx27-baseboard.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> index 98aef57..b20fc55 100644
> --- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> +++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> @@ -238,24 +238,8 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
>  	.flags = IMXUART_HAVE_RTSCTS,
>  };
>  
> -#define ADS7846_PENDOWN (GPIO_PORTD | 25)
> -
> -static void __maybe_unused ads7846_dev_init(void)
> -{
> -	if (gpio_request(ADS7846_PENDOWN, "ADS7846 pendown") < 0) {
> -		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
> -		return;
> -	}
> -	gpio_direction_input(ADS7846_PENDOWN);
> -}
> -
> -static int ads7846_get_pendown_state(void)
> -{
> -	return !gpio_get_value(ADS7846_PENDOWN);
> -}
> -
>  static struct ads7846_platform_data ads7846_config __initdata = {
> -	.get_pendown_state	= ads7846_get_pendown_state,
> +	.gpio_pendown		= (GPIO_PORTD | 25),

Please use IMX_GPIO_NR(4, 25) instead. Otherwise this looks ok.

Eric, ok with you?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
