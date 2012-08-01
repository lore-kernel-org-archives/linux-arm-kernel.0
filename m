From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Aug 2012 21:31:07 +0100
Subject: [PATCH 06/10 V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <1343076052-27312-7-git-send-email-marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
 <1343076052-27312-7-git-send-email-marex@denx.de>
Message-ID: <20120801203106.GW4483@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 10:40:48PM +0200, Marek Vasut wrote:

> This is slightly reworked version of the SPI driver.
> Support for DT has been added and it's been converted
> to queued API.

Looks reasonable overall.

> +	bits_per_word = dev->bits_per_word;
> +	if (t && t->bits_per_word)
> +		bits_per_word = t->bits_per_word;
> +
> +	if (bits_per_word != 8) {
> +		dev_err(&dev->dev, "%s, unsupported bits_per_word=%d\n",
> +					__func__, bits_per_word);
> +		return -EINVAL;
> +	}

> +	if (dev->max_speed_hz)
> +		hz = dev->max_speed_hz;
> +	if (t && t->speed_hz)
> +		hz = t->speed_hz;
> +	if (hz == 0) {
> +		dev_err(&dev->dev, "Cannot continue with zero clock\n");
> +		return -EINVAL;
> +	}

These two blocks use a different style (the first does the first assign
unconditionally, the second uses initialisation with declaration).  I
prefer the first style but YMMV and it doesn't matter.

For the missing clock rate might it make sense to just use whatever the
clock happens to come out as?

> +static void mxs_spi_cleanup(struct spi_device *dev)
> +{
> +	return;
> +}

Empty functions are generally a warning sign...  why do we need this
one?

> +static int __devexit mxs_spi_remove(struct platform_device *pdev)
> +{

> +	clk_disable_unprepare(ssp->clk);

It'd be nice to only keep the clocks enabled while doing transfers but
again totally non-essential.
