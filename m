From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Jul 2014 22:52:37 +0100
Subject: [PATCH 2/2] spi: orion: add support for multiple chip selects
In-Reply-To: <1406498000-13079-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406498000-13079-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140728215237.GJ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 27, 2014 at 11:53:20PM +0200, Thomas Petazzoni wrote:

> @@ -150,6 +151,11 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
>  	if (rc)
>  		return rc;
>  
> +	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG,
> +			  ORION_SPI_CS_MASK);
> +	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
> +			  ORION_SPI_CS(spi->chip_select));
> +
>  	if (bits_per_word == 16)
>  		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
>  				  ORION_SPI_IF_8_16_BIT_MODE);

I would expect to see this chip select manipulation to be being done in
set_cs not in setup_transfer() otherwise we'll probably get surprised
when the driver is converted to use transfer_one() and pull the chip
select handling out of the driver (among other things).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/cf427c91/attachment-0001.sig>
