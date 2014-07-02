From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Jul 2014 17:56:51 +0100
Subject: [PATCH 1/3 v5] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140702165651.GK410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 09:29:50AM +0530, Naveen Krishna Chatradhi wrote:

> Hence, spi-s3c64xx.c is broken since "Jun 21 11:26:12 2013" and
> considering the time with no compliants about the breakage.

I'm not clear what the breakage is?  Some boards are broken but what's
the driver issue?

>  	if (!spi_get_ctldata(spi)) {
>  		/* Request gpio only if cs line is asserted by gpio pins */
> -		if (sdd->cs_gpio) {
> -			err = gpio_request_one(cs->line, GPIOF_OUT_INIT_HIGH,
> -					dev_name(&spi->dev));
> +		if (gpio_is_valid(spi->cs_gpio)) {
> +			err = gpio_request_one(spi->cs_gpio,
> +						GPIOF_OUT_INIT_HIGH,
> +						dev_name(&spi->dev));
>  			if (err) {
>  				dev_err(&spi->dev,
>  					"Failed to get /CS gpio [%d]: %d\n",
> -					cs->line, err);
> +					spi->cs_gpio, err);
>  				goto err_gpio_req;
>  			}
> -
> -			spi->cs_gpio = cs->line;
> +		} else {
> +			dev_err(&spi->dev, "chip select gpio is invalid\n");
> +			return -EINVAL;
>  		}

This appears to be making it mandatory to specify a GPIO when previously
it was not mandatory which I believe breaks some SoCs - the native chip
select has to be used on some devices as there is no pinmux option to
make it a GPIO (this was why the native chip select support was added).

Also I'd need to check but are you sure that GPIO 0 is not valid?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140702/78876b08/attachment.sig>
