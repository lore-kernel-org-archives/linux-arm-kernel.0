From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Nov 2015 09:29:39 +0100
Subject: [PATCH v4 1/7] spi: imx: Fix DMA transfer
In-Reply-To: <1448666165-7473-2-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1448666165-7473-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1448666165-7473-2-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <20151130082939.GU11966@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2015 at 12:15:59AM +0100, Anton Bondarenko wrote:
> RX DMA tail data handling doesn't work correctly in many cases with
> current implementation. It happens because SPI core was setup
> to generates both RX watermark level and RX DATA TAIL events
> incorrectly. SPI transfer triggering for DMA also done in wrong way.
> 
> SPI client wants to transfer 70 words for example. The old DMA
> implementation setup RX DATA TAIL equal 6 words. In this case
> RX DMA event will be generated after 6 words read from RX FIFO.
> The garbage can be read out from RX FIFO because SPI HW does
> not receive all required words to trigger RX watermark event.
> 
> New implementation change handling of RX data tail. DMA is used to process
> all TX data and only full chunks of RX data with size aligned to FIFO/2.
> Driver is waiting until both TX and RX DMA transaction done and all
> TX data are pushed out. At that moment there is only RX data tail in
> the RX FIFO. This data read out using PIO.
> 
> Transfer triggering changed to avoid RX data loss.
> 
> Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>

This patch doesn't make me feel very comfortable. It's quite big and I
think it contains multiple logical changes. It should be split up
further.

> ---
>  drivers/spi/spi-imx.c | 115 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 76 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 0e5723a..bd7b721 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -53,6 +53,7 @@
>  /* generic defines to abstract from the different register layouts */
>  #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
>  #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
> +#define MXC_INT_TCEN	BIT(7)   /* Transfer complete */
>  
>  /* The maximum  bytes that a sdma BD can transfer.*/
>  #define MAX_SDMA_BD_BYTES  (1 << 15)
> @@ -104,9 +105,7 @@ struct spi_imx_data {
>  	unsigned int dma_is_inited;
>  	unsigned int dma_finished;
>  	bool usedma;
> -	u32 rx_wml;
> -	u32 tx_wml;
> -	u32 rxt_wml;
> +	u32 wml;

One logical change is: Merge the different FIFO watermark level
variables into a single variable since they are all the same.

>  	struct completion dma_rx_completion;
>  	struct completion dma_tx_completion;
>  
> @@ -939,17 +944,18 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  	/* Trigger the cspi module. */
>  	spi_imx->dma_finished = 0;
>  
> -	dma = readl(spi_imx->base + MX51_ECSPI_DMA);
> -	dma = dma & (~MX51_ECSPI_DMA_RXT_WML_MASK);
> -	/* Change RX_DMA_LENGTH trigger dma fetch tail data */
> -	left = transfer->len % spi_imx->rxt_wml;
> -	if (left)
> -		writel(dma | (left << MX51_ECSPI_DMA_RXT_WML_OFFSET),
> -				spi_imx->base + MX51_ECSPI_DMA);
> +	/*
> +	 * Set these order to avoid potential RX overflow. The overflow may
> +	 * happen if we enable SPI HW before starting RX DMA due to rescheduling
> +	 * for another task and/or interrupt.
> +	 * So RX DMA enabled first to make sure data would be read out from FIFO
> +	 * ASAP. TX DMA enabled next to start filling TX FIFO with new data.
> +	 * And finaly SPI HW enabled to start actual data transfer.
> +	 */
> +	dma_async_issue_pending(master->dma_rx);
> +	dma_async_issue_pending(master->dma_tx);
>  	spi_imx->devtype_data->trigger(spi_imx);
>  
> -	dma_async_issue_pending(master->dma_tx);
> -	dma_async_issue_pending(master->dma_rx);

Here you fix the order of the different step to start a transfer. This
could also be a separate patch, no?

>  	/* Wait SDMA to finish the data transfer.*/
>  	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
>  						IMX_DMA_TIMEOUT);
> @@ -958,6 +964,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  			dev_driver_string(&master->dev),
>  			dev_name(&master->dev));
>  		dmaengine_terminate_all(master->dma_tx);
> +		dmaengine_terminate_all(master->dma_rx);

This could also be a separate "Add missing dmaengine_terminate_all() for
rx dma" patch.

>  	} else {
>  		timeout = wait_for_completion_timeout(
>  				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
> @@ -967,10 +974,40 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  				dev_name(&master->dev));
>  			spi_imx->devtype_data->reset(spi_imx);
>  			dmaengine_terminate_all(master->dma_rx);
> +		} else if (left) {
> +			void *pio_buffer = transfer->rx_buf
> +						+ (transfer->len - left);
> +
> +			dma_sync_sg_for_cpu(master->dma_rx->device->dev,
> +					    &rx->sgl[rx->nents - 1], 1,
> +					    DMA_FROM_DEVICE);
> +
> +			spi_imx->rx_buf = pio_buffer;
> +			spi_imx->txfifo = left;
> +			reinit_completion(&spi_imx->xfer_done);
> +
> +			spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TCEN);
> +
> +			timeout = wait_for_completion_timeout(
> +					&spi_imx->xfer_done, IMX_DMA_TIMEOUT);
> +			if (!timeout) {
> +				pr_warn("%s %s: I/O Error in RX tail\n",
> +					dev_driver_string(&master->dev),
> +					dev_name(&master->dev));
> +			}
> +
> +			/*
> +			 * WARNING: this call will cause DMA debug complains
> +			 * about wrong combination of DMA direction and sync
> +			 * function. But we must use it to make sure the data
> +			 * read by PIO mode will be cleared from CPU cache.
> +			 * Otherwise SPI core will invalidate it during unmap of
> +			 * SG buffers.
> +			 */
> +			dma_sync_sg_for_device(master->dma_rx->device->dev,
> +					       &rx->sgl[rx->nents - 1], 1,
> +					       DMA_TO_DEVICE);

This is the most scary place in this patch and I think this should not
be resolved like that. The problem you are solving here is that you want
to transfer most of the data using DMA and only the remaining non
burstsize aligned data using PIO. Such a mixed DMA/PIO transfer doesn't
seem to be supported by the SPI core. To support it we must probably add
some possibility to call __spi_unmap_msg from the driver.

A much simpler approach to fix the issue would be to just forbid DMA
when the transfer size is not a multiple of the burstsize. Only bigger
transfers benefit from DMA, for the smaller ones DMA can even be slower.
I assume that the bigger transfers are burstsize aligned anyway, so it
might even not be necessary to have support for non burstsize aligned
DMA transfers.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
