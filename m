From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Feb 2011 15:09:19 -0700
Subject: [PATCH 1/4] spi/pl022: use dmaengine helper macros
In-Reply-To: <1297166592-5098-1-git-send-email-linus.walleij@stericsson.com>
References: <1297166592-5098-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110215220919.GF28005@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 01:03:12PM +0100, Linus Walleij wrote:
> This simplifies the DMA code a bit by using the dmaengine helpers.
> The cookie from descriptor submission can be ignored in this case
> as has been established in review of the MMCI/PL180 driver.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.

> ---
>  drivers/spi/amba-pl022.c |   27 ++++++++++-----------------
>  1 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 71a1219..4220aad 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -917,7 +917,6 @@ static int configure_dma(struct pl022 *pl022)
>  	struct dma_chan *txchan = pl022->dma_tx_channel;
>  	struct dma_async_tx_descriptor *rxdesc;
>  	struct dma_async_tx_descriptor *txdesc;
> -	dma_cookie_t cookie;
>  
>  	/* Check that the channels are available */
>  	if (!rxchan || !txchan)
> @@ -962,10 +961,8 @@ static int configure_dma(struct pl022 *pl022)
>  		tx_conf.dst_addr_width = rx_conf.src_addr_width;
>  	BUG_ON(rx_conf.src_addr_width != tx_conf.dst_addr_width);
>  
> -	rxchan->device->device_control(rxchan, DMA_SLAVE_CONFIG,
> -				       (unsigned long) &rx_conf);
> -	txchan->device->device_control(txchan, DMA_SLAVE_CONFIG,
> -				       (unsigned long) &tx_conf);
> +	dmaengine_slave_config(rxchan, &rx_conf);
> +	dmaengine_slave_config(txchan, &tx_conf);
>  
>  	/* Create sglists for the transfers */
>  	pages = (pl022->cur_transfer->len >> PAGE_SHIFT) + 1;
> @@ -1018,23 +1015,19 @@ static int configure_dma(struct pl022 *pl022)
>  	rxdesc->callback_param = pl022;
>  
>  	/* Submit and fire RX and TX with TX last so we're ready to read! */
> -	cookie = rxdesc->tx_submit(rxdesc);
> -	if (dma_submit_error(cookie))
> -		goto err_submit_rx;
> -	cookie = txdesc->tx_submit(txdesc);
> -	if (dma_submit_error(cookie))
> -		goto err_submit_tx;
> -	rxchan->device->device_issue_pending(rxchan);
> -	txchan->device->device_issue_pending(txchan);
> +	dmaengine_submit(rxdesc);
> +	dmaengine_submit(txdesc);
> +	dma_async_issue_pending(rxchan);
> +	dma_async_issue_pending(txchan);
>  
>  	return 0;
>  
>  err_submit_tx:
>  err_submit_rx:
>  err_txdesc:
> -	txchan->device->device_control(txchan, DMA_TERMINATE_ALL, 0);
> +	dmaengine_terminate_all(txchan);
>  err_rxdesc:
> -	rxchan->device->device_control(rxchan, DMA_TERMINATE_ALL, 0);
> +	dmaengine_terminate_all(rxchan);
>  	dma_unmap_sg(txchan->device->dev, pl022->sgt_tx.sgl,
>  		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
>  err_tx_sgmap:
> @@ -1101,8 +1094,8 @@ static void terminate_dma(struct pl022 *pl022)
>  	struct dma_chan *rxchan = pl022->dma_rx_channel;
>  	struct dma_chan *txchan = pl022->dma_tx_channel;
>  
> -	rxchan->device->device_control(rxchan, DMA_TERMINATE_ALL, 0);
> -	txchan->device->device_control(txchan, DMA_TERMINATE_ALL, 0);
> +	dmaengine_terminate_all(rxchan);
> +	dmaengine_terminate_all(txchan);
>  	unmap_free_dma_scatter(pl022);
>  }
>  
> -- 
> 1.7.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
