From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 11:03:53 +0000
Subject: [PATCH 15/15] spi: add locomo SPI driver
In-Reply-To: <1414454528-24240-16-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-16-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141028110353.GR18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:02:08AM +0300, Dmitry Eremin-Solenikov wrote:
> LoCoMo chip has a built-in simple SPI controller. On Sharp SL-5500 PDDAs
> it is connected to external MMC slot.

> +config SPI_LOCOMO
> +	tristate "Locomo SPI master"
> +	depends on MFD_LOCOMO
> +	select SPI_BITBANG

Rather than using SPI_BITBANG it'd be good for new drivers to convert to
using the core transfer_one() functionality which replaces most of what
the bitbang code is doing.  The bitbang functionality was misnamed for
most of the users and we're going to try to move most of the functionality
not actually related to bitbanging out of it.

> +	/* if (locomospi_carddetect()) { */
> +	r = readw(spidev->base + LOCOMO_SPIMD);
> +	r |= LOCOMO_SPIMD_XON;
> +	writew(r, spidev->base + LOCOMO_SPIMD);
> +
> +	r = readw(spidev->base + LOCOMO_SPIMD);
> +	r |= LOCOMO_SPIMD_XEN;
> +	writew(r, spidev->base + LOCOMO_SPIMD);
> +	/* } */

Either remove or implement the comments.

> +	r = readw(spidev->base + LOCOMO_SPICT);
> +	r |= LOCOMO_SPIMD_XEN; /* FIXME */
> +	writew(r, spidev->base + LOCOMO_SPICT);

FIXME?

> +	if (t)
> +		hz = t->speed_hz;
> +	if (!hz)
> +		hz = spi->max_speed_hz;

The core will ensure that the transfer always has a speed set in it.

> +static int locomo_spi_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct spi_master *master;
> +	struct locomospi_dev *spidev;
> +	int ret;
> +
> +	dev_info(&pdev->dev, "LoCoO SPI Driver\n");

Remove this, it's not adding anything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/216aec7a/attachment.sig>
