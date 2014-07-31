From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Jul 2014 20:35:15 +0100
Subject: [PATCH 2/2] spi: davinci: add support to configure gpio cs
 through dt
In-Reply-To: <1406827995-30913-3-git-send-email-grygorii.strashko@ti.com>
References: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
 <1406827995-30913-3-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140731193515.GO17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 08:33:15PM +0300, Grygorii Strashko wrote:

> +	if (np && master->cs_gpios != NULL && spi->cs_gpio >= 0) {
> +		/* SPI core parse and update master->cs_gpio */
>  		gpio_chipsel = true;
> +		gpio = spi->cs_gpio;
> +	} else if (pdata->chip_sel &&
> +		   chip_sel < pdata->num_chipselect &&
> +		   pdata->chip_sel[chip_sel] != SPI_INTERN_CS) {
> +		/* platform data defines chip_sel */
> +		gpio_chipsel = true;
> +		gpio = pdata->chip_sel[chip_sel];
> +	}

This would all be a lot simpler and more direct if you were to arrange
to use cs_gpio in the struct spi_device, and move you closer to
converting to use more of the core functionality.

> +		if (np && (master->cs_gpios != NULL) && (spi->cs_gpio >= 0)) {
> +			retval =
> +				gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> +			if (retval) {
> +				dev_err(&spi->dev,
> +					"GPIO %d request failed\n",
> +					spi->cs_gpio);
> +				return -ENODEV;
> +			}
> +			gpio_direction_output(spi->cs_gpio,
> +					      !(spi->mode & SPI_CS_HIGH));
> +			internal_cs = false;

It's much better to use gpio_request_one() rather than using
gpio_request(), it's one function apart from anything else.  The above
is also discarding the return code of gpio_request() meaning it's broken
for deferred probe.  The error code should also appear in the error
message.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/9580c14e/attachment.sig>
