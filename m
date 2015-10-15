From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 15 Oct 2015 14:05:04 +0300
Subject: [PATCH] ARM: edma: special case slot limit workaround
In-Reply-To: <87eggws90a.fsf@linutronix.de>
References: <87eggws90a.fsf@linutronix.de>
Message-ID: <561F8860.4030507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 01:48 PM, John Ogness wrote:
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

To: Vinod
CC: l-o, Sekhar at least

> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/dma/edma.c |   25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 493c774..16bd193 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -585,6 +585,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
>  	struct edma_desc *edesc;
>  	dma_addr_t src_addr, dst_addr;
>  	enum dma_slave_buswidth dev_width;
> +	bool use_intermediate = false;
>  	u32 burst;
>  	int i, ret, nslots;
>  
> @@ -626,8 +627,21 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
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
>  	edesc = kzalloc(sizeof(*edesc) + nslots *
>  		sizeof(edesc->pset[0]), GFP_ATOMIC);
> @@ -706,8 +720,13 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
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

The workaround looks fine, but please rebase it on the latest edma code from
linux-next.

-- 
P?ter
