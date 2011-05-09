From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 9 May 2011 15:02:54 -0700
Subject: [PATCH v3] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <1302554157-24145-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302097097.22904.41.camel@rex>
	<1302554157-24145-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110509150254.e7da059f.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Apr 2011 22:35:57 +0200
Uwe Kleine-K__nig  <u.kleine-koenig@pengutronix.de> wrote:

> This function makes a deep copy of the platform data to allow it to live
> in init memory.
> The definition cannot go into leds-gpio.c because it needs to be builtin
> to be usable by platforms.
> 

Well...  why?  The changelog tells us what the function does but
provides no information explaining why you think it's needed, nor how
it is expected to be used, etc.

Please send a complete and useful changelog!

> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -14,6 +14,11 @@ config LEDS_CLASS
>  	  This option enables the led sysfs class in /sys/class/leds.  You'll
>  	  need this to do anything useful with LEDs.  If unsure, say N.
>  
> +config LED_REGISTER_GPIO
> +	bool
> +	help
> +	  This option provides the function gpio_led_register_device.
> +

Every other LEDS Kconfig symbol uses "LEDS", not "LED".  I'll make that
change.

>  if NEW_LEDS
>  
>  comment "LED drivers"
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 39c80fc..ca428bd 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -3,6 +3,7 @@
>  obj-$(CONFIG_NEW_LEDS)			+= led-core.o
>  obj-$(CONFIG_LEDS_CLASS)		+= led-class.o
>  obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o
> +obj-y					+= led-register.o
>  
>  # LED Platform Drivers
>  obj-$(CONFIG_LEDS_88PM860X)		+= leds-88pm860x.o
> diff --git a/drivers/leds/led-register.c b/drivers/leds/led-register.c
> new file mode 100644
> index 0000000..d3731ea
> --- /dev/null
> +++ b/drivers/leds/led-register.c
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (C) 2011 Pengutronix
> + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/leds.h>
> +
> +#if defined(CONFIG_LED_REGISTER_GPIO)
> +struct platform_device *__init gpio_led_register_device(
> +		int id, const struct gpio_led_platform_data *pdata)
> +{
> +	struct platform_device *ret;
> +	struct gpio_led_platform_data _pdata = *pdata;
> +
> +	_pdata.leds = kmemdup(pdata->leds,
> +			pdata->num_leds * sizeof(*pdata->leds), GFP_KERNEL);
> +	if (!_pdata.leds)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = platform_device_register_resndata(NULL, "leds-gpio", id,
> +			NULL, 0, &_pdata, sizeof(_pdata));
> +	if (IS_ERR(ret))
> +		kfree(_pdata.leds);
> +
> +	return ret;
> +}
> +#endif
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 61e0340..b20474d 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -207,5 +207,17 @@ struct gpio_led_platform_data {
>  					unsigned long *delay_off);
>  };
>  
> +/**
> + * gpio_led_register_device - register a gpio-led device
> + * @pdata: the platform data used for the new device
> + *
> + * Use this function instead of platform_device_add()ing a static struct
> + * platform_device.
> + *
> + * Note: as pdata and pdata->leds is copied these usually can and should be
> + * __initdata.
> + */
> +struct platform_device *gpio_led_register_device(
> +		int id, const struct gpio_led_platform_data *pdata);

It's unusual to document functions in the .h file.  There's a bit of
precedent for that in leds.h, but there is more precedent in
drivers/leds/*.c

Personally I think that putting the documentation in .h is rather sucky
- it happens so rarely that one just doesn't think of looking in there.

The description isn't terribly useful if the reader doesn't know what
"platform_device_add()ing a static struct platform_device" is for.  Can
we describe this in some manner whcih doesn't refer to something else
which is probably undocumented?

The comment doesn't document return values.
