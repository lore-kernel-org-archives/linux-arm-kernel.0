From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 24 Nov 2015 09:43:25 +0100
Subject: [RFC] dma: at_xdmac.c: enable descriptor reuse
In-Reply-To: <CALnQHM0FZn+df7m-4wE8iiea=92fFDJsX5Dq0oeNxAoyTg1TSQ@mail.gmail.com>
References: <CALnQHM0FZn+df7m-4wE8iiea=92fFDJsX5Dq0oeNxAoyTg1TSQ@mail.gmail.com>
Message-ID: <20151124084325.GA14390@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Sorry to answer a bit late.

I am interested if you have some benches about the benefit of reuse.

On Fri, Nov 13, 2015 at 01:39:16PM -0700, David Mosberger wrote:
> Ludovic et al,
> 
> I'd be interested in comments on the patch below.  We'd like to be able to
> issue a DMA transfer from time to time and want to avoid the overhead of
> setting up a new DMA descriptor for each (identical) transfer.  The cyclic
> DMA support doesn't quite work for us (I think) because, as I understand
> it, that would continuously issue the DMA transfer.  From what I can see,
> enabling descriptor-reuse just requires two lines of changes to the driver:
> (a) mark the driver as capable of supporting descriptor_reuse and (b) skip
> putting the descriptor on the free-list upon completion of a transfer, if
> it is marked for reuse.
> 
> The patch also changes at_xdmac_remove_xfer() to clear the active_xfer
> flag.  Without this change, at_xdmac_tasklet() may miss starting a pending
> transfer on a re-used descriptor, because the active_xfer flag would not
> have been cleared since that normally happens when a descriptor gets
> reallocated and then reinitialized with at_xdmac_init_used_desc().
> 
> Like I said: at this point I'm just trying to understand if this patch is
> going in the right direction and whether anybody sees any potential issues
> with doing something along those lines.
>

I have never thought about using reuse but I don't see any issue with your
patch.
 
> ?  --david??
> 
> -- 
> eGauge Systems LLC, http://egauge.net/, 1.877-EGAUGE1, fax 720.545.9768

> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index b5e132d..eea6b40 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1455,7 +1510,16 @@ static void at_xdmac_remove_xfer(struct at_xdmac_chan *atchan,
>  	 * descriptors into the free descriptors list.
>  	 */
>  	list_del(&desc->xfer_node);
> -	list_splice_init(&desc->descs_list, &atchan->free_descs_list);
> +	/*
> +	 * Mark descriptor as inactive so new transfers can be
> +	 * started.
> +	 */
> +	desc->active_xfer = false;
> +	/*
> +	 * Put descriptor on the free list unless it's marked to be reused.
> +	 */
> +	if (!dmaengine_desc_test_reuse(&desc->tx_dma_desc))
> +		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
>  }

Since setting active_xfer to false is done in at_xdmac_init_used_desc(),
I would write it in this to show that doing it here is only related to reuse
case.

if (!dmaengine_desc_test_reuse(&desc->tx_dma_desc))
	list_splice_init(&desc->descs_list, &atchan->free_descs_list);
else
	desc->active_xfer = false;

>  
>  static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
> @@ -1930,6 +2000,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
>  	atxdmac->dma.dst_addr_widths = AT_XDMAC_DMA_BUSWIDTHS;
>  	atxdmac->dma.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>  	atxdmac->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +	atxdmac->dma.descriptor_reuse = true;
>  
>  	/* Disable all chans and interrupts. */
>  	at_xdmac_off(atxdmac);

Regards

Ludovic
