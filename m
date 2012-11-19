From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 19 Nov 2012 11:01:44 +0100
Subject: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
In-Reply-To: <20121018222046.GA28541@animalcreek.com>
References: <20121018222046.GA28541@animalcreek.com>
Message-ID: <50AA0388.4020803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/19/2012 12:20 AM, Mark A. Greer wrote:
> Enable DMA prefetching by setting the 'OMAP_DMA_DST_SYNC_PREFETCH'
> flag whenever there is a destination synchronized DMA transfer.
> Prefetching is not allowed on source synchronized DMA transfers.
> 
> Enabling prefetch significantly improves DMA performance.
> For example, running 'modprobe tcrypt sec=2 mode=403' which
> exercises the omap-sham driver on an am37x EVM yeilds the
> following results:

>  drivers/dma/omap-dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index bb2d8e7..aadddb2 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -310,7 +310,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>  		dev_addr = c->cfg.dst_addr;
>  		dev_width = c->cfg.dst_addr_width;
>  		burst = c->cfg.dst_maxburst;
> -		sync_type = OMAP_DMA_DST_SYNC;
> +		sync_type = OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;

This should be:
 -		sync_type = OMAP_DMA_DST_SYNC;
 +		sync_type = OMAP_DMA_DST_SYNC_PREFETCH;


>  	} else {
>  		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
>  		return NULL;
> @@ -387,7 +387,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
>  		dev_addr = c->cfg.dst_addr;
>  		dev_width = c->cfg.dst_addr_width;
>  		burst = c->cfg.dst_maxburst;
> -		sync_type = OMAP_DMA_DST_SYNC;
> +		sync_type = OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;

We should not enable the prefetch for cyclic right now. We will investigate it
more.

>  	} else {
>  		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
>  		return NULL;
> 

-- 
P?ter
