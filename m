From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Dec 2016 13:37:28 +0000
Subject: [PATCH v3 2/5] spi: armada-3700: Add support for the FIFO mode
In-Reply-To: <20161201102719.4291-3-romain.perier@free-electrons.com>
References: <20161201102719.4291-1-romain.perier@free-electrons.com>
 <20161201102719.4291-3-romain.perier@free-electrons.com>
Message-ID: <20161205133728.sza2pt4tfkywu35k@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 11:27:16AM +0100, Romain Perier wrote:

> Changes in v3:
>  - Don't enable the fifo mode based on the compatible string, we introduce
>    a module parameter "pio_mode". By default this option is set to zero, so
>    the fifo mode is enabled. Pass pio_mode=1 to the driver enables the PIO
>    mode.

Why?  If the hardware supports a more efficient mode of operation it
doesn't seem sensible not to use it.

> -	int i;
> +	int i, ret = 0;

Coding style - don't combine initialized and non-initalized variables on
one line.

>  static int a3700_spi_transfer_one(struct spi_master *master,
>  				  struct spi_device *spi,
>  				  struct spi_transfer *xfer)
>  {
>  	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
> -	int ret = 0;
> +	int ret;
>  
>  	a3700_spi_transfer_setup(spi, xfer);
>  
> @@ -505,6 +737,151 @@ static int a3700_spi_transfer_one(struct spi_master *master,
>  	return ret;
>  }

This appears to be a random unrelated change, should probably be part of
the initial driver commit.

> +static int a3700_spi_fifo_transfer_one(struct spi_master *master,
> +				       struct spi_device *spi,
> +				       struct spi_transfer *xfer)
> +{
> +	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
> +	int ret = 0, timeout = A3700_SPI_TIMEOUT;
> +	unsigned int nbits = 0;
> +	u32 val;
> +
> +	a3700_spi_transfer_setup(spi, xfer);
> +
> +	a3700_spi->tx_buf  = xfer->tx_buf;
> +	a3700_spi->rx_buf  = xfer->rx_buf;
> +	a3700_spi->buf_len = xfer->len;
> +
> +	/* SPI transfer headers */
> +	a3700_spi_header_set(a3700_spi);
> +
> +	if (xfer->tx_buf)
> +		nbits = xfer->tx_nbits;
> +	else if (xfer->rx_buf)
> +		nbits = xfer->rx_nbits;
> +
> +	a3700_spi_pin_mode_set(a3700_spi, nbits);
> +
> +	if (xfer->rx_buf) {
> +		/* Set read data length */
> +		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
> +			     a3700_spi->buf_len);
> +		/* Start READ transfer */
> +		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
> +		val &= ~A3700_SPI_RW_EN;
> +		val |= A3700_SPI_XFER_START;
> +		spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
> +	} else if (xfer->tx_buf) {
> +		/* Start Write transfer */

So this only supports single duplex transfers but there doesn't seem to
be anything that enforces this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161205/39205c21/attachment.sig>
