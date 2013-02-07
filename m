From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 7 Feb 2013 11:55:47 +0000
Subject: [PATCH 3/4] spi: s3c64xx: add gpio quirk for controller
In-Reply-To: <1360105784-12282-4-git-send-email-ks.giri@samsung.com>
References: <1360105784-12282-1-git-send-email-ks.giri@samsung.com>
 <1360105784-12282-4-git-send-email-ks.giri@samsung.com>
Message-ID: <20130207115546.GA3801@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 03:09:43PM -0800, Girish K S wrote:
> This patch adds support for spi controllers with
> dedicated clk/miso/mosi/cs pins. It skips the gpio
> parsing and initialization for controllers that
> have dedicated pins.

>  		if (sdd->tgl_spi != spi) { /* if last mssg on diff device */
>  			/* Deselect the last toggled device */
>  			cs = sdd->tgl_spi->controller_data;
> -			gpio_set_value(cs->line,
> -				spi->mode & SPI_CS_HIGH ? 0 : 1);
> +			if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_GPIO))
> +				gpio_set_value(cs->line,
> +					spi->mode & SPI_CS_HIGH ? 0 : 1);
>  		}

This isn't going to work with system designs which ignore the /CS line
the controller has and just use a GPIO instead.  This is very common,
for example when connecting multiple devices to the same SPI bus.

It seems like there's really two changes here.  One change is making the
provision of pinmux information optional, the other is allowing the user
to use the controller /CS management rather than using GPIO.
