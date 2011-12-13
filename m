From: joe@perches.com (Joe Perches)
Date: Tue, 13 Dec 2011 13:06:57 -0800
Subject: [PATCH v3 resend2] s3c/s3c24xx: arm: leds: Make s3c24xx LEDS
 driver use gpiolib
In-Reply-To: <4EE7B41C.5080006@solonet.org.ua>
References: <4EE7B41C.5080006@solonet.org.ua>
Message-ID: <1323810417.3837.25.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-12-13 at 22:22 +0200, Denis Kuzmenko wrote:
> Make s3c24xx LEDS driver use gpiolib. Fix error disabling pull during probe.
[]
> diff --git a/drivers/leds/leds-s3c24xx.c b/drivers/leds/leds-s3c24xx.c
[]
> @@ -45,23 +45,35 @@ static void s3c24xx_led_set(struct led_classdev *led_cdev,
> +	/*
> +	 * ensure value is 0 or 1 to use it with bitwise XOR (^)
> +	 * (only 100% brightness is supported)
> +	 */
> +	value = value ? 1 : 0;

Maybe value = !!value;

> +		/* no point in having a pull-up as we are always driving */
> +		s3c_gpio_setpull(pdata->gpio, S3C_GPIO_PULL_NONE);
> +		ret = gpio_direction_output(pdata->gpio,
> +				!!(pdata->flags & S3C24XX_LEDF_ACTLOW));

akin to this use.
