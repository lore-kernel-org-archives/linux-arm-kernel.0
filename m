From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Dec 2012 09:30:27 +0000
Subject: [PATCH v4] backlight: corgi_lcd: Use gpio_set_value_cansleep()
 to avoid WARN_ON
In-Reply-To: <000201cdd283$baf50160$30df0420$%han@samsung.com>
References: <000201cdd283$baf50160$30df0420$%han@samsung.com>
Message-ID: <20121205093027.GK14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 09:59:07AM +0900, Jingoo Han wrote:
> -	if (gpio_is_valid(lcd->gpio_backlight_cont))
> -		gpio_set_value(lcd->gpio_backlight_cont, cont);
> +	if (gpio_is_valid(lcd->gpio_backlight_cont)) {
> +		if (gpio_cansleep(lcd->gpio_backlight_cont))
> +			gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
> +		else
> +			gpio_set_value(lcd->gpio_backlight_cont, cont);
> +	}

Why not simply:

+	if (gpio_is_valid(lcd->gpio_backlight_cont))
+		gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);

If you read the gpiolib code and documentation, what you will realise is
that the two calls are identical except for the "might_sleep_if()" in
gpio_set_value_cansleep().  You will also note that gpiolib itself _only_
calls gpio_set_value_cansleep() without checking gpio_cansleep() in
contexts where sleeping is possible.  So if it's good enough for gpiolib,
it should be good enough here.
