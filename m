From: stefan@agner.ch (Stefan Agner)
Date: Thu, 17 Nov 2016 17:07:24 -0800
Subject: [PATCH 3/4] spi: spi-fsl-dspi: Fix continuous selection format
In-Reply-To: <c1e51fc92dbcc9c31dcdcdfab3eed40d7745308a.1479384571.git.maitysanchayan@gmail.com>
References: <cover.1479384571.git.maitysanchayan@gmail.com>
 <c1e51fc92dbcc9c31dcdcdfab3eed40d7745308a.1479384571.git.maitysanchayan@gmail.com>
Message-ID: <c1c4a3f3eac6d4e7378971431bd5f595@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-17 04:16, Sanchayan Maity wrote:
> Current DMA implementation was not handling the continuous selection
> format viz. SPI chip select would be deasserted even between sequential
> serial transfers. Use the cs_change variable and correctly set or
> reset the CONT bit accordingly for case where peripherals require
> the chip select to be asserted between sequential transfers.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index aee8c88..164e2e1 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -258,9 +258,16 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  	}
>  
>  	val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
> -	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
> -					SPI_PUSHR_PCS(dspi->cs) |
> -					SPI_PUSHR_CTAS(0);
> +	if (dspi->cs_change) {
> +		dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
> +						SPI_PUSHR_PCS(dspi->cs) |
> +						SPI_PUSHR_CTAS(0);
> +	} else {
> +		dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
> +						SPI_PUSHR_PCS(dspi->cs) |
> +						SPI_PUSHR_CTAS(0) |
> +						SPI_PUSHR_CONT;
> +	}

How about:


	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
					SPI_PUSHR_PCS(dspi->cs) |
					SPI_PUSHR_CTAS(0);

+	if (dspi->cs_change)
+		dspi->dma->tx_dma_buf[i] |= SPI_PUSHR_CONT;


Avoids code duplication...

--
Stefan



>  	dspi->tx += tx_word + 1;
>  
>  	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
