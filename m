From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Aug 2014 18:35:06 +0100
Subject: [PATCH v2 1/2] spi: davinci: add support to configure gpio cs
 through dt
In-Reply-To: <1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
 <1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140801173506.GB30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 07:40:32PM +0300, Grygorii Strashko wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> Currently driver supports only configuration of GPIO CS through
> platform data. This patch enhances the driver to configure GPIO
> CS through DT. Also update the DT binding documentation to
> reflect the availability of cs-gpios.

Ah, sorry - this is the unapplied patch from before.  It would have been
much better to submit this as the second patch after your rework patch
since this...

> -	if (pdata->chip_sel && chip_sel < pdata->num_chipselect &&
> -				pdata->chip_sel[chip_sel] != SPI_INTERN_CS)
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

...still looks excessively confusing - it is way more logic than I'd
expect to see on every chip select.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/813b5f28/attachment.sig>
