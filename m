From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 07 Sep 2012 16:03:11 +0200
Subject: [PATCH 5/7] gpio: 74x164: Add support for the daisy-chaining
In-Reply-To: <1347020296-18796-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
 <1347020296-18796-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <2796775.6HPOQgPOKV@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

On Friday 07 September 2012 14:18:14 Maxime Ripard wrote:
> The shift registers have an output pin that, when enabled, propagates
> the values of its internal register to the pins. If another value comes
> to the register while the output pin is disabled, this new value will
> makae the older shift into the next register in the chain.
> 
> This patch adds support for daisy-chaining the registers, using the
> regular SPI chip select mechanism to manage the output pin, and the
> registers-number dt property to set the number of chained registers.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

[snip]

>  static int __gen_74x164_write_config(struct gen_74x164_chip *chip)
>  {
> -	return spi_write(chip->spi,
> -			 &chip->port_config, sizeof(chip->port_config));
> +	struct spi_message message;
> +	struct spi_transfer *msg_buf;
> +	int i, ret;
> +
> +	msg_buf = kzalloc(chip->registers * sizeof(struct spi_transfer),
> +			GFP_KERNEL);
> +	if (!msg_buf)
> +		return -ENOMEM;
> +
> +	spi_message_init(&message);
> +
> +	/*
> +	 * Since the registers are chained, every byte sent will make
> +	 * the previous byte shift to the next register in the
> +	 * chain. Thus, the first byte send will end up in the last
> +	 * register at the end of the transfer. So, to have a logical
> +	 * numbering, send the bytes in reverse order so that the last
> +	 * byte of the buffer will end up in the last register.
> +	 */
> +	for (i = chip->registers - 1; i >= 0; i--) {
> +		msg_buf[i].tx_buf = chip->buffer +i;
> +		msg_buf[i].len = sizeof(u8);
> +		spi_message_add_tail(msg_buf + i, &message);
> +	}
> +
> +	ret = spi_sync(chip->spi, &message);
> +	if (ret)
> +		return ret;

You are leaking msg_buf here in case of error.

> +
> +	kfree(msg_buf);
> +
> +	return 0;
>  }
>  
>  static int gen_74x164_get_value(struct gpio_chip *gc, unsigned offset)
>  {
>  	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
> +	u8 bank = offset / 8;
> +	u8 pin = offset % 8;
>  	int ret;
>  
>  	mutex_lock(&chip->lock);
> -	ret = (chip->port_config >> offset) & 0x1;
> +	ret = (chip->buffer[bank] >> pin) & 0x1;
>  	mutex_unlock(&chip->lock);
>  
>  	return ret;
> @@ -51,12 +87,14 @@ static void gen_74x164_set_value(struct gpio_chip *gc,
>  		unsigned offset, int val)
>  {
>  	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
> +	u8 bank = offset / 8;
> +	u8 pin = offset % 8;
>  
>  	mutex_lock(&chip->lock);
>  	if (val)
> -		chip->port_config |= (1 << offset);
> +		chip->buffer[bank] |= (1 << pin);
>  	else
> -		chip->port_config &= ~(1 << offset);
> +		chip->buffer[bank] &= ~(1 << pin);
>  
>  	__gen_74x164_write_config(chip);
>  	mutex_unlock(&chip->lock);
> @@ -75,6 +113,11 @@ static int __devinit gen_74x164_probe(struct spi_device 
*spi)
>  	struct gen_74x164_chip_platform_data *pdata;
>  	int ret;
>  
> +	if (!spi->dev.of_node) {
> +		dev_err(&spi->dev, "No device tree data available.\n");
> +		return -EINVAL;
> +	}

Should not this be folded in your previous patch?

> +
>  	/*
>  	 * bits_per_word cannot be configured in platform data
>  	 */
> @@ -104,7 +147,20 @@ static int __devinit gen_74x164_probe(struct spi_device 
*spi)
>  	chip->gpio_chip.direction_output = gen_74x164_direction_output;
>  	chip->gpio_chip.get = gen_74x164_get_value;
>  	chip->gpio_chip.set = gen_74x164_set_value;
> -	chip->gpio_chip.ngpio = 8;
> +
> +	if (of_property_read_u32(spi->dev.of_node, "registers-number", &chip-
>registers)) {
> +		dev_err(&spi->dev, "Missing registers-number property in the DT.
\n");
> +		ret = -EINVAL;
> +		goto exit_destroy;
> +	}
> +
> +	chip->gpio_chip.ngpio = GEN_74X164_NUMBER_GPIOS * chip->registers;
> +	chip->buffer = devm_kzalloc(&spi->dev, chip->gpio_chip.ngpio, GFP_KERNEL);
> +	if (!chip->buffer) {
> +		ret = -ENOMEM;
> +		goto exit_destroy;
> +	}
> +
>  	chip->gpio_chip.can_sleep = 1;
>  	chip->gpio_chip.dev = &spi->dev;
>  	chip->gpio_chip.owner = THIS_MODULE;
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
