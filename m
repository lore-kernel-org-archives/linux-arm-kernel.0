From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 16:25:35 +0800
Subject: [PATCH] dmaengine: imx-dma: fix format warnings
In-Reply-To: <E1VbgJK-0006iu-9m@rmk-PC.arm.linux.org.uk>
References: <E1VbgJK-0006iu-9m@rmk-PC.arm.linux.org.uk>
Message-ID: <20131031082531.GK23549@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 12:40:30AM +0000, Russell King wrote:
> drivers/dma/imx-dma.c:575:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:575:3: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:589:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:599:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:929:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:929:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:959:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:959:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t'
> 

We should probably mention the compiler version that we're seeing these
warnings with.  It seems that my gcc 4.6.3 does not complain about them.

Shawn

> We can't use the %pa format for these because this relates to phys_addr_t,
> and dma_addr_t can be a different size.  So, fix these by converting them
> to %llx and casting the dma_addr_t to always be unsigned long long.
> 
> While we're here, also use %zu for size_t.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/dma/imx-dma.c |   40 +++++++++++++++++++++++-----------------
>  1 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index 55852c026791..1c0d85d56562 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -572,9 +572,11 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
>  
>  		imx_dmav1_writel(imxdma, d->len, DMA_CNTR(imxdmac->channel));
>  
> -		dev_dbg(imxdma->dev, "%s channel: %d dest=0x%08x src=0x%08x "
> -			"dma_length=%d\n", __func__, imxdmac->channel,
> -			d->dest, d->src, d->len);
> +		dev_dbg(imxdma->dev,
> +			"%s channel: %d dest=0x%08llx src=0x%08llx dma_length=%zu\n",
> +			__func__, imxdmac->channel,
> +			(unsigned long long)d->dest,
> +			(unsigned long long)d->src, d->len);
>  
>  		break;
>  	/* Cyclic transfer is the same as slave_sg with special sg configuration. */
> @@ -586,20 +588,22 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
>  			imx_dmav1_writel(imxdma, imxdmac->ccr_from_device,
>  					 DMA_CCR(imxdmac->channel));
>  
> -			dev_dbg(imxdma->dev, "%s channel: %d sg=%p sgcount=%d "
> -				"total length=%d dev_addr=0x%08x (dev2mem)\n",
> -				__func__, imxdmac->channel, d->sg, d->sgcount,
> -				d->len, imxdmac->per_address);
> +			dev_dbg(imxdma->dev,
> +				"%s channel: %d sg=%p sgcount=%d total length=%zu dev_addr=0x%08llx (dev2mem)\n",
> +				__func__, imxdmac->channel,
> +				d->sg, d->sgcount, d->len,
> +				(unsigned long long)imxdmac->per_address);
>  		} else if (d->direction == DMA_MEM_TO_DEV) {
>  			imx_dmav1_writel(imxdma, imxdmac->per_address,
>  					 DMA_DAR(imxdmac->channel));
>  			imx_dmav1_writel(imxdma, imxdmac->ccr_to_device,
>  					 DMA_CCR(imxdmac->channel));
>  
> -			dev_dbg(imxdma->dev, "%s channel: %d sg=%p sgcount=%d "
> -				"total length=%d dev_addr=0x%08x (mem2dev)\n",
> -				__func__, imxdmac->channel, d->sg, d->sgcount,
> -				d->len, imxdmac->per_address);
> +			dev_dbg(imxdma->dev,
> +				"%s channel: %d sg=%p sgcount=%d total length=%zu dev_addr=0x%08llx (mem2dev)\n",
> +				__func__, imxdmac->channel,
> +				d->sg, d->sgcount, d->len,
> +				(unsigned long long)imxdmac->per_address);
>  		} else {
>  			dev_err(imxdma->dev, "%s channel: %d bad dma mode\n",
>  				__func__, imxdmac->channel);
> @@ -870,7 +874,7 @@ static struct dma_async_tx_descriptor *imxdma_prep_dma_cyclic(
>  	int i;
>  	unsigned int periods = buf_len / period_len;
>  
> -	dev_dbg(imxdma->dev, "%s channel: %d buf_len=%d period_len=%d\n",
> +	dev_dbg(imxdma->dev, "%s channel: %d buf_len=%zu period_len=%zu\n",
>  			__func__, imxdmac->channel, buf_len, period_len);
>  
>  	if (list_empty(&imxdmac->ld_free) ||
> @@ -926,8 +930,9 @@ static struct dma_async_tx_descriptor *imxdma_prep_dma_memcpy(
>  	struct imxdma_engine *imxdma = imxdmac->imxdma;
>  	struct imxdma_desc *desc;
>  
> -	dev_dbg(imxdma->dev, "%s channel: %d src=0x%x dst=0x%x len=%d\n",
> -			__func__, imxdmac->channel, src, dest, len);
> +	dev_dbg(imxdma->dev, "%s channel: %d src=0x%llx dst=0x%llx len=%zu\n",
> +		__func__, imxdmac->channel, (unsigned long long)src,
> +		(unsigned long long)dest, len);
>  
>  	if (list_empty(&imxdmac->ld_free) ||
>  	    imxdma_chan_is_doing_cyclic(imxdmac))
> @@ -956,9 +961,10 @@ static struct dma_async_tx_descriptor *imxdma_prep_dma_interleaved(
>  	struct imxdma_engine *imxdma = imxdmac->imxdma;
>  	struct imxdma_desc *desc;
>  
> -	dev_dbg(imxdma->dev, "%s channel: %d src_start=0x%x dst_start=0x%x\n"
> -		"   src_sgl=%s dst_sgl=%s numf=%d frame_size=%d\n", __func__,
> -		imxdmac->channel, xt->src_start, xt->dst_start,
> +	dev_dbg(imxdma->dev, "%s channel: %d src_start=0x%llx dst_start=0x%llx\n"
> +		"   src_sgl=%s dst_sgl=%s numf=%zu frame_size=%zu\n", __func__,
> +		imxdmac->channel, (unsigned long long)xt->src_start,
> +		(unsigned long long) xt->dst_start,
>  		xt->src_sgl ? "true" : "false", xt->dst_sgl ? "true" : "false",
>  		xt->numf, xt->frame_size);
>  
> -- 
> 1.7.4.4
> 
