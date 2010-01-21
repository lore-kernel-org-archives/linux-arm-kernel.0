From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 20 Jan 2010 22:12:31 -0800
Subject: [PATCH] gpiolib: add gpio_lookup_chip() to get chip information
	for gpio
In-Reply-To: <1262932348-2888-2-git-send-email-ben-linux@fluff.org>
References: <1262932348-2888-1-git-send-email-ben-linux@fluff.org>
	<1262932348-2888-2-git-send-email-ben-linux@fluff.org>
Message-ID: <20100120221231.573ebca6.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  8 Jan 2010 06:32:28 +0000 Ben Dooks <ben-linux@fluff.org> wrote:

> Add a call to get the 'struct gpio_chip' pointer for a given gpio, so
> that core implementations which want to use gpiolib gpio numbering for
> things like mux configuration can get back to the gpio_chip that they
> registered without having to have their own list of gpio.
> 
> This is especially useful for the Samsung S3C64XX series where the GPIO
> bank sizes can vary from 32 down to 3, making it difficult to store an
> array to convert a number to chip.
> 
> ...
>  
> +/**
> + * gpio_lookup_chip - return the chip for a given gpio
> + * @gpio: The GPIO number to lookup
> + *
> + * Returns NULL if the GPIO chip is not valid or there is no chip registered
> + * for that GPIO. This call is available for core code to turn a GPIO number
> + * into a chip so that further information can be looked up.
> + *
> + * This call makes no guarantees about the actuall gpio_chip's state, or
> + * whether the @gpio itself is requested.
> + */
> +struct gpio_chip *gpio_lookup_chip(unsigned gpio)
> +{
> +	struct gpio_chip *chip;
> +	unsigned long flags;
> +
> +	if (!gpio_is_valid(gpio))
> +		return NULL;
> +
> +	spin_lock_irqsave(&gpio_lock, flags);
> +	chip = gpio_to_chip(gpio);
> +	spin_unlock_irqrestore(&gpio_lock, flags);
> +
> +	return chip;
> +}
> +

The locking looks fishy.  What's the point in locking the array lookup and
then returning the thing which was looked up after dropping the lock?

Should this function have been exported to modules?

Please cc myself and David Brownell on gpio patches.
