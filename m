From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 12 Sep 2009 21:29:06 +0200
Subject: [PATCH 1/2] PalmTreo: generalisation of Treo680 code
In-Reply-To: <1252670222-25233-2-git-send-email-sleep_walker@suse.cz>
References: <1252670222-25233-1-git-send-email-sleep_walker@suse.cz>
	<1252670222-25233-2-git-send-email-sleep_walker@suse.cz>
Message-ID: <200909122129.06685.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 11. z??? 2009 13:57:01 Tom?? ?ech napsal(a):
> From: Tom?? ?ech <sleep walker@suse.cz>
>
> Signed-off-by: Tom?? ?ech <sleep_walker@suse.cz>
> ---
>  arch/arm/mach-pxa/Kconfig                   |    5 +
>  arch/arm/mach-pxa/Makefile                  |    2 +-
>  arch/arm/mach-pxa/include/mach/palmtreo.h   |   60 ++++++++
>  arch/arm/mach-pxa/include/mach/treo680.h    |   49 -------
>  arch/arm/mach-pxa/{treo680.c => palmtreo.c} |  202
> ++++++++++++++++----------- 5 files changed, 183 insertions(+), 135
> deletions(-)
>  create mode 100644 arch/arm/mach-pxa/include/mach/palmtreo.h
>  delete mode 100644 arch/arm/mach-pxa/include/mach/treo680.h
>  rename arch/arm/mach-pxa/{treo680.c => palmtreo.c} (69%)
>
...
> -static struct gpio_led_platform_data gpio_led_info = {
> -	.leds		= gpio_leds,
> -	.num_leds	= ARRAY_SIZE(gpio_leds),
> +static struct gpio_led_platform_data treo680_gpio_led_info = {
> +	.leds		= treo680_gpio_leds,
> +	.num_leds	= ARRAY_SIZE(treo680_gpio_leds),
>  };

Be careful so you dont run into symbol redefinition here (gpio_led_info) in case 
the kernel supports more than this one device ...
>
>  static struct platform_device treo680_leds = {
>  	.name   = "leds-gpio",
>  	.id     = -1,
>  	.dev    = {
> -		.platform_data  = &gpio_led_info,
> +		.platform_data  = &treo680_gpio_led_info,
>  	}
>  };
...
> +#endif /* CONFIG_MACH_TREO680 */
> +
>  /* setup udc GPIOs initial state */
> -static void __init treo680_udc_init(void)
> +static void __init treo_udc_init(void)
>  {
> -	if (!gpio_request(GPIO_NR_TREO680_USB_PULLUP, "UDC Vbus")) {
> -		gpio_direction_output(GPIO_NR_TREO680_USB_PULLUP, 1);
> -		gpio_free(GPIO_NR_TREO680_USB_PULLUP);
> +	if (!gpio_request(GPIO_NR_TREO_USB_PULLUP, "UDC Vbus")) {
> +		gpio_direction_output(GPIO_NR_TREO_USB_PULLUP, 1);
> +		gpio_free(GPIO_NR_TREO_USB_PULLUP);
>  	}
>  }
>

Is this really needed or is it just a copy-paste from other Palm device?

> -static void __init treo680_lcd_power_init(void)
> +static void __init treo_lcd_power_init(void)
>  {
>  	int ret;
>
> -	ret = gpio_request(GPIO_NR_TREO680_LCD_POWER, "LCD POWER");
> +	ret = gpio_request(GPIO_NR_TREO_LCD_POWER, "LCD POWER");
>  	if (ret) {
>  		pr_err("Treo680: LCD power GPIO request failed!\n");
>  		return;
>  	}
...

Cheers!
