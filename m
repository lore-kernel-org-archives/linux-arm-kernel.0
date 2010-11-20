From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 20 Nov 2010 22:48:20 +0100
Subject: [PATCH 6/6] atmel_spi: fix warning In function
	'atmel_spi_dma_map_xfer'
In-Reply-To: <1290247733-17834-6-git-send-email-plagnioj@jcrosoft.com>
References: <20101120095906.GD4216@game.jcrosoft.org>
	<1290247733-17834-6-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20101120214820.GG8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[adding spi-devel-general and lkml to Cc:]

On Sat, Nov 20, 2010 at 11:08:53AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> passing argument 2 of 'dma_map_single' discards qualifiers from pointer target type
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  drivers/spi/atmel_spi.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
> index 154529a..2cf6abd 100644
> --- a/drivers/spi/atmel_spi.c
> +++ b/drivers/spi/atmel_spi.c
> @@ -352,8 +352,10 @@ atmel_spi_dma_map_xfer(struct atmel_spi *as, struct spi_transfer *xfer)
>  
>  	xfer->tx_dma = xfer->rx_dma = INVALID_DMA_ADDRESS;
>  	if (xfer->tx_buf) {
> +		void *nonconst_tx = (void *)xfer->tx_buf; /* shut up gcc */
> +
>  		xfer->tx_dma = dma_map_single(dev,
> -				(void *) xfer->tx_buf, xfer->len,
> +				nonconst_tx, xfer->len,
>  				DMA_TO_DEVICE);
Hmm, I wonder if this is the right approach to do this.  I'd prefer to
have something like:

	dma_map_single_to_device(struct device *, const void *, ...)

don't know if that's sensible though.

And I wonder about gcc that your patch makes a difference.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
