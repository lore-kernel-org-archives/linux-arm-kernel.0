From: stefan@agner.ch (Stefan Agner)
Date: Thu, 17 Nov 2016 17:03:19 -0800
Subject: [PATCH 2/4] spi: spi-fsl-dspi: Fix incorrect DMA setup
In-Reply-To: <d83f4896d77f577ca92fd70534f6198bb3288d8a.1479384571.git.maitysanchayan@gmail.com>
References: <cover.1479384571.git.maitysanchayan@gmail.com>
 <d83f4896d77f577ca92fd70534f6198bb3288d8a.1479384571.git.maitysanchayan@gmail.com>
Message-ID: <bc8d9b808b99d3b217361df6fa8853ea@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-17 04:16, Sanchayan Maity wrote:
> Currently dmaengine_prep_slave_single was being called with length
> set to the complete DMA buffer size. This resulted in unwanted bytes
> being transferred to the SPI register leading to clock and MOSI lines
> having unwanted data even after chip select got deasserted and the
> required bytes having been transferred.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index b1ee1f5..aee8c88 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -265,7 +265,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  
>  	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
>  					dma->tx_dma_phys,
> -					DSPI_DMA_BUFSIZE, DMA_MEM_TO_DEV,
> +					dma->curr_xfer_len *
> +					DMA_SLAVE_BUSWIDTH_4_BYTES /
> +					(tx_word ? 2 : 1),
> +					DMA_MEM_TO_DEV,

Hm, this is getting ridiculous, I think we convert curr_xfer_len from
bytes to DMA transfers in almost every use.

Can we make it be transfer length in actual 4 byte transfers? We then
probably have to convert it to bytes once to subtract from
curr_remaining_bytes, but I think it would simplify code overall...

--
Stefan


>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!dma->tx_desc) {
>  		dev_err(dev, "Not able to get desc for DMA xfer\n");
> @@ -281,7 +284,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  
>  	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
>  					dma->rx_dma_phys,
> -					DSPI_DMA_BUFSIZE, DMA_DEV_TO_MEM,
> +					dma->curr_xfer_len *
> +					DMA_SLAVE_BUSWIDTH_4_BYTES /
> +					(tx_word ? 2 : 1),
> +					DMA_DEV_TO_MEM,
>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!dma->rx_desc) {
>  		dev_err(dev, "Not able to get desc for DMA xfer\n");
