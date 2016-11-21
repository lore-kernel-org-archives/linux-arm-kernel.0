From: stefan@agner.ch (Stefan Agner)
Date: Mon, 21 Nov 2016 15:22:09 -0800
Subject: [PATCH v2 4/4] spi: spi-fsl-dspi: Minor code cleanup and error
 path fixes
In-Reply-To: <971874d8e662622c0cfe478adaa4c75b08388d0e.1479706671.git.maitysanchayan@gmail.com>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
 <971874d8e662622c0cfe478adaa4c75b08388d0e.1479706671.git.maitysanchayan@gmail.com>
Message-ID: <43b518a92352986f09b0893646ff8016@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-20 21:54, Sanchayan Maity wrote:
> Code cleanup for improving code readability and error path fixes
> and cleanup removing use of devm_kfree.

Two things in one, not very nice. Especially the dma_free_coherent is
really a bug and the other is a cleanup. Can you make a separate patch
for the bug?

As for the cleanup, I don't like the one line conditions too, but I
don't think it is worth a patch. At least the TX path should be solved
with my suggestion in patch 2.

--
Stefan

> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 08882f7..2987a16 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -226,8 +226,10 @@ static void dspi_rx_dma_callback(void *arg)
>  	if (!(dspi->dataflags & TRAN_STATE_RX_VOID)) {
>  		for (i = 0; i < dma->curr_xfer_len; i++) {
>  			d = dspi->dma->rx_dma_buf[i];
> -			rx_word ? (*(u16 *)dspi->rx = d) :
> -						(*(u8 *)dspi->rx = d);
> +			if (rx_word)
> +				*(u16 *)dspi->rx = d;
> +			else
> +				*(u8 *)dspi->rx = d;
>  			dspi->rx += rx_word + 1;
>  		}
>  	}
> @@ -247,14 +249,20 @@ static int dspi_next_xfer_dma_submit(struct
> fsl_dspi *dspi)
>  	tx_word = is_double_byte_mode(dspi);
>  
>  	for (i = 0; i < dma->curr_xfer_len - 1; i++) {
> -		val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
> +		if (tx_word)
> +			val = *(u16 *) dspi->tx;
> +		else
> +			val = *(u8 *) dspi->tx;
>  		dspi->dma->tx_dma_buf[i] =
>  			SPI_PUSHR_TXDATA(val) | SPI_PUSHR_PCS(dspi->cs) |
>  			SPI_PUSHR_CTAS(0) | SPI_PUSHR_CONT;
>  		dspi->tx += tx_word + 1;
>  	}
>  
> -	val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
> +	if (tx_word)
> +		val = *(u16 *) dspi->tx;
> +	else
> +		val = *(u8 *) dspi->tx;
>  	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
>  					SPI_PUSHR_PCS(dspi->cs) |
>  					SPI_PUSHR_CTAS(0);
> @@ -430,9 +438,11 @@ static int dspi_request_dma(struct fsl_dspi
> *dspi, phys_addr_t phy_addr)
>  	return 0;
>  
>  err_slave_config:
> -	devm_kfree(dev, dma->rx_dma_buf);
> +	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
> +			dma->rx_dma_buf, dma->rx_dma_phys);
>  err_rx_dma_buf:
> -	devm_kfree(dev, dma->tx_dma_buf);
> +	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
> +			dma->tx_dma_buf, dma->tx_dma_phys);
>  err_tx_dma_buf:
>  	dma_release_channel(dma->chan_tx);
>  err_tx_channel:
