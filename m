From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Apr 2015 12:27:19 +0100
Subject: [PATCH v2 09/17] spi: add locomo SPI driver
In-Reply-To: <1430178954-11138-10-git-send-email-dbaryshkov@gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-10-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150429112719.GK22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 02:55:46AM +0300, Dmitry Eremin-Solenikov wrote:

> +static int locomospi_reg_open(struct locomospi_dev *spidev)
> +{

> +static int locomospi_reg_release(struct locomospi_dev *spidev)
> +{

These are a bit weird - as far as I can tell they're just doing some
init done on probe and release?  I think I'd expect to see them either
inlined there or done as part of the PM operations too (including
runtime ones).

> +	for (j = 0; j < wait; j++) {
> +		regmap_read(spidev->regmap, LOCOMO_SPIST, &r);
> +		if (r & LOCOMO_SPI_RFW)
> +			break;
> +	}
> +	if (j == wait)
> +		dev_err(&spi->dev, "rfw timeout\n");

But we don't return an error if we time out?

> +static int locomo_spi_setup_transfer(struct spi_device *spi,
> +		struct spi_transfer *t)
> +{
> +	struct locomospi_dev *spidev;
> +	u32 hz = 0;
> +
> +	if (t)
> +		hz = t->speed_hz;
> +	if (!hz)
> +		hz = spi->max_speed_hz;

The core will set a speed on every transfer for you.

> +	if (!tx && !rx && t->len)
> +		return -EINVAL;

Put this in the core if it's needed.

> +static int locomo_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct locomospi_dev *spidev = spi_master_get_devdata(master);
> +
> +	return locomospi_reg_release(spidev);

We're doing this release before we free the master which is potentially
racy - but do we even need to do it at all?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150429/45f7d423/attachment.sig>
