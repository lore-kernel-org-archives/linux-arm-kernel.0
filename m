From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 1 Jul 2018 14:02:55 +0200
Subject: [RFC net-next 07/15] net: lora: Add Semtech SX1276
In-Reply-To: <20180701110804.32415-8-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-8-afaerber@suse.de>
Message-ID: <d17bd315-a250-6bc5-da4d-f29e8b76cda3@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.07.2018 um 13:07 schrieb Andreas F?rber:
> diff --git a/drivers/net/lora/sx1276.c b/drivers/net/lora/sx1276.c
> new file mode 100644
> index 000000000000..d6732111247a
> --- /dev/null
> +++ b/drivers/net/lora/sx1276.c
[...]
> +static int sx1276_probe(struct spi_device *spi)
> +{
> +	struct net_device *netdev;
> +	struct sx1276_priv *priv;
> +	int rst, dio[6], ret, model, i;
> +	u32 freq_xosc, freq_band;
> +	unsigned long long freq_rf;
> +	u8 val;
> +
> +	rst = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
> +	if (rst == -ENOENT)
> +		dev_warn(&spi->dev, "no reset GPIO available, ignoring");
> +
> +	for (i = 0; i < 6; i++) {
> +		dio[i] = of_get_named_gpio(spi->dev.of_node, "dio-gpios", i);
> +		if (dio[i] == -ENOENT)
> +			dev_dbg(&spi->dev, "DIO%d not available, ignoring", i);
> +		else {
> +			ret = gpio_direction_input(dio[i]);
> +			if (ret)
> +				dev_err(&spi->dev, "couldn't set DIO%d to input", i);
> +		}
> +	}
> +
> +	if (gpio_is_valid(rst)) {
> +		gpio_set_value(rst, 1);
> +		udelay(100);
> +		gpio_set_value(rst, 0);
> +		msleep(5);
> +	}
> +
> +	spi->bits_per_word = 8;
> +	spi_setup(spi);
> +
> +	ret = sx1276_read_single(spi, REG_VERSION, &val);
> +	if (ret) {
> +		dev_err(&spi->dev, "version read failed");
> +		return ret;
> +	}
> +
> +	if (val == 0x22)
> +		model = 1272;
> +	else {
> +		if (gpio_is_valid(rst)) {
> +			gpio_set_value(rst, 0);
> +			udelay(100);
> +			gpio_set_value(rst, 1);
> +			msleep(5);
> +		}
> +
> +		ret = sx1276_read_single(spi, REG_VERSION, &val);
> +		if (ret) {
> +			dev_err(&spi->dev, "version read failed");
> +			return ret;
> +		}
> +
> +		if (val == 0x12)
> +			model = 1276;
> +		else {
> +			dev_err(&spi->dev, "transceiver not recognized (RegVersion = 0x%02x)", (unsigned)val);
> +			return -EINVAL;
> +		}
> +	}
[snip]

To counter my own point, this file of course still has leftover model
detection heuristics; should check for the of_device_id match instead!
SX1272 vs. SX1276 have the reset pin inverted, so - knowing which model
it's supposed to be - we can do the right reset from the start and, if
it doesn't work, report an error to the user.

Also I should update that code to use gpiod, as seen in later patches.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
