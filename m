From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Sep 2012 10:56:38 +0200
Subject: [PATCH 6/8] gpio: 74x164: Add support for daisy-chaining
In-Reply-To: <1346834457-6257-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120905105638.153471c6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed,  5 Sep 2012 10:40:55 +0200,
Maxime Ripard <maxime.ripard@free-electrons.com> a ?crit :

> +	for (i = chip->registers - 1; i >= 0; i--) {
> +		ret = spi_write(chip->spi,
> +				chip->buffer + i, sizeof(u8));
> +		if (ret)
> +			return ret;
> +	}

I think you should have a comment on top of this loop to explain why
this loop is done in the reverse direction. Of course, I personally
know why, but the reviewers/readers may not.

>  static int gen_74x164_get_value(struct gpio_chip *gc, unsigned offset)
>  {
>  	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
> +	u8 bank = offset / 8;
> +	u8 pin = offset % 8;
>  	int ret;
>  
>  	mutex_lock(&chip->lock);
> -	ret = (chip->port_config >> offset) & 0x1;
> +	ret = (*(chip->buffer + bank) >> pin) & 0x1;

	ret = (chip->buffer[bank] >> pin) & 0x1;

>  {
>  	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
> +	u8 bank = offset / 8;
> +	u8 pin = offset % 8;
>  
>  	mutex_lock(&chip->lock);
>  	if (val)
> -		chip->port_config |= (1 << offset);
> +		*(chip->buffer + bank) |= (1 << pin);

		chip->buffer[bank] |= (1 << pin)

>  	else
> -		chip->port_config &= ~(1 << offset);
> +		*(chip->buffer + bank) &= ~(1 << pin);

		chip->buffer[bank] &= ~(1 << pin)


> +	if (of_property_read_u32(spi->dev.of_node, "registers-number", &chip->registers)) {
> +		dev_err(&spi->dev, "Missing registers-number property in the DT.\n");
> +		ret = -EINVAL;
> +		goto exit_destroy;
> +	}

I'm wondering whether this shouldn't be named daisy-chain-length or
something like that, but I'm not sure.


> +	chip->gpio_chip.ngpio = 8 * chip->registers;

Maybe make "8" a #define so that it becomes self-explanatory what this
8 is?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
