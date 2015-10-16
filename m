From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 16 Oct 2015 14:21:23 +0300
Subject: [PATCH v2] ARM: edma: special case slot limit workaround
In-Reply-To: <87a8rjt7p9.fsf_-_@linutronix.de>
References: <87eggws90a.fsf@linutronix.de> <561F8860.4030507@ti.com>
 <87a8rjt7p9.fsf_-_@linutronix.de>
Message-ID: <5620DDB3.9050300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2015 01:43 PM, John Ogness wrote:
> Currently drivers are limited to 19 slots for cyclic transfers.
> However, if the DMA burst size is the same as the period size,
> the period size can be changed to the full buffer size and
> intermediate interrupts activated. Since intermediate interrupts
> will trigger for each burst and the burst size is the same as
> the period size, the driver will get interrupts each period as
> expected. This has the benefit of allowing the functionality of
> many more slots, but only uses 2 slots.
> 
> This workaround is only active if more than 19 slots are needed
> and the burst size matches the period size.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  v1-v2 changes
>  . rebased for next-20151016
> 
>  drivers/dma/edma.c |   25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 7eefbf1..f846935 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -1364,6 +1364,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
>  	struct edma_desc *edesc;
>  	dma_addr_t src_addr, dst_addr;
>  	enum dma_slave_buswidth dev_width;
> +	bool use_intermediate = false;
>  	u32 burst;
>  	int i, ret, nslots;
>  
> @@ -1405,8 +1406,21 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
>  	 * but the synchronization is difficult to achieve with Cyclic and
>  	 * cannot be guaranteed, so we error out early.
>  	 */
> -	if (nslots > MAX_NR_SG)
> -		return NULL;
> +	if (nslots > MAX_NR_SG) {
> +		/*
> +		 * If the burst and period sizes are the same, we can put
> +		 * the full buffer into a single period and activate
> +		 * intermediate interrupts. This will produce interrupts
> +		 * after each burst, which is also after each desired period.
> +		 */
> +		if (burst == period_len) {
> +			period_len = buf_len;
> +			nslots = 2;
> +			use_intermediate = true;
> +		} else {
> +			return NULL;
> +		}
> +	}
>  
>  	edesc = kzalloc(sizeof(*edesc) + nslots * sizeof(edesc->pset[0]),
>  			GFP_ATOMIC);
> @@ -1484,8 +1498,13 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
>  		/*
>  		 * Enable period interrupt only if it is requested
>  		 */
> -		if (tx_flags & DMA_PREP_INTERRUPT)
> +		if (tx_flags & DMA_PREP_INTERRUPT) {
>  			edesc->pset[i].param.opt |= TCINTEN;
> +
> +			/* Also enable intermediate interrupts if necessary */
> +			if (use_intermediate)
> +				edesc->pset[i].param.opt |= ITCINTEN;
> +		}
>  	}
>  
>  	/* Place the cyclic channel to highest priority queue */
> 


-- 
P?ter
