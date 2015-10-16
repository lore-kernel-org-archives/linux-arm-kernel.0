From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 16 Oct 2015 16:58:59 +0300
Subject: [PATCH v2] ARM: edma: fix residue race for cyclic
In-Reply-To: <87eggvt8hi.fsf_-_@linutronix.de>
References: <87io68s931.fsf@linutronix.de> <561F862A.7040106@ti.com>
 <87eggvt8hi.fsf_-_@linutronix.de>
Message-ID: <562102A3.9030501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2015 01:26 PM, John Ogness wrote:
> When retrieving the residue value for cyclic transfers, the
> SRC/DST fields of the active PaRAM are read. However, the AM335x
> Technical Reference Manual states:
> 
>   11.3.3.6 Parameter Set Updates
> 
>   After the TR is read from the PaRAM (and is in the process
>   of being submitted to the EDMA3TC), the following fields are
>   updated as needed: ... SRC DST
> 
> This means SRC/DST is incremented even though the DMA transfer
> may not have started yet or is in progress. Thus if the reader
> of the residue accesses the DMA buffer too quickly, the CPU is
> misinformed about the data that has been successfully processed.
> 
> The CCSTAT.ACTV register is a boolean that is set if any TR is
> being processed by either the EMDA3CC or EDMA3TC. By polling
> this register it is possible to ensure that the residue value
> returned is valid for immediate processing. However, since the
> DMA engine may be active, polling may never hit a moment where
> no TR is being processed. To handle this, the SRC/DST is also
> polled to see if it changes. And as a last resort, a max loop
> count for the busy waiting exists to avoid an infinite loop.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  v1-v2 changes
>  . rebased for next-20151016
>  . added multiple exit conditions for busy wait loop
> 
>  drivers/dma/edma.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 7eefbf1..8d3b3ac 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -24,6 +24,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/ratelimit.h>
> +#include <linux/printk.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
>  #include <linux/of_irq.h>
> @@ -1785,11 +1787,24 @@ static void edma_issue_pending(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
>  }
>  
> +#define EDMA_CCSTAT_ACTV (1 << 4)
> +
> +/*
> + * This limit exists to avoid a possible infinite loop when waiting
> + * for confirmation that a particular transfer is completed. However,
> + * large bursts to/from slow devices might actually require many
> + * loops (in which case busy waiting is bad anyway). On an AM335x
> + * transfering 48 bytes from the UART RX-FIFO, as many as 55 loops
> + * have been seen.
> + */
> +#define EDMA_MAX_TR_WAIT_LOOPS 10000
> +
>  static u32 edma_residue(struct edma_desc *edesc)
>  {
>  	bool dst = edesc->direction == DMA_DEV_TO_MEM;
>  	struct edma_pset *pset = edesc->pset;

	struct edma_chan *echan = edesc->echan;

>  	dma_addr_t done, pos;
> +	int loop_count = 0;

	int loop_count = EDMA_MAX_TR_WAIT_LOOPS;

>  	int i;
>  
>  	/*
> @@ -1799,6 +1814,31 @@ static u32 edma_residue(struct edma_desc *edesc)
>  	pos = edma_get_position(edesc->echan->ecc, edesc->echan->slot[0], dst);

Use echan-> here directly and other places in this function.

>  
>  	/*
> +	 * "pos" may represent a transfer request that is still being
> +	 * processed by the EDMACC or EDMATC. We will busy wait until
> +	 * one of the situations occurs:
> +	 *   1. no transfer requests are active
> +	 *   2. a different transfer request is being processed
> +	 *   3. we hit the loop limit
> +	 */
> +	while (edma_read(edesc->echan->ecc, EDMA_CCSTAT) & EDMA_CCSTAT_ACTV) {
> +		/* check if a different transfer request is active */
> +		if (edma_get_position(edesc->echan->ecc,
> +				      edesc->echan->slot[0], dst) != pos) {
> +			break;
> +		}
> +
> +		loop_count++;
> +		if (loop_count == EDMA_MAX_TR_WAIT_LOOPS) {

		if (--loop_count) {

> +			pr_debug_ratelimited("%s: possibly returning "
> +					     "invalid residue\n", __func__);

			dev_dbg_ratelimited(echan->ecc->dev,
				"%s: timeout waiting for PaRAM update\n",
				__func__);

> +			break;
> +		}
> +
> +		cpu_relax();
> +	}
> +
> +	/*
>  	 * Cyclic is simple. Just subtract pset[0].addr from pos.
>  	 *
>  	 * We never update edesc->residue in the cyclic case, so we
> 


-- 
P?ter
