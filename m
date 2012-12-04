From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 4 Dec 2012 14:58:22 -0800
Subject: [PATCH v3] backlight: corgi_lcd: Use gpio_set_value_cansleep()
 to avoid WARN_ON
In-Reply-To: <000b01cdd1e0$293f0d90$7bbd28b0$%han@samsung.com>
References: <000b01cdd1e0$293f0d90$7bbd28b0$%han@samsung.com>
Message-ID: <20121204145822.056b6cf6.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Dec 2012 14:28:15 +0900
Jingoo Han <jg1.han@samsung.com> wrote:

> From: Marko Katic <dromede@gmail.com>
> 
> Changing backlight intensity on an Akita (Sharp Zaurus C-1000)
> triggers WARN_ON message:

Well, I queued it up.

> ...
>
> --- a/drivers/video/backlight/corgi_lcd.c
> +++ b/drivers/video/backlight/corgi_lcd.c
> @@ -408,11 +408,20 @@ static int corgi_bl_set_intensity(struct corgi_lcd *lcd, int intensity)
>  	/* Bit 5 via GPIO_BACKLIGHT_CONT */
>  	cont = !!(intensity & 0x20) ^ lcd->gpio_backlight_cont_inverted;
>  
> -	if (gpio_is_valid(lcd->gpio_backlight_cont))
> -		gpio_set_value(lcd->gpio_backlight_cont, cont);
> +	if (gpio_is_valid(lcd->gpio_backlight_cont)) {
> +		if (gpio_cansleep(lcd->gpio_backlight_cont))
> +			gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
> +		else
> +			gpio_set_value(lcd->gpio_backlight_cont, cont);
> +	}

But this looks utterly daft.  Grant, these two things are the same - do
we need both of them?
