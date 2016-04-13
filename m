From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 13 Apr 2016 19:23:24 +0530
Subject: [PATCH] dmaengine: pxa: handle bus errors
In-Reply-To: <1459200744-13245-1-git-send-email-robert.jarzmik@free.fr>
References: <1459200744-13245-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160413135324.GQ2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 11:32:24PM +0200, Robert Jarzmik wrote:
> In the current state, upon bus error the driver will spin endlessly,
> relaunching the last tx, which will fail again and again :
>  - a bus error happens
>  - pxad_chan_handler() is called
>  - as PXA_DCSR_STOPSTATE is true, the last non-terminated transaction is
>    lauched, which is the one triggering the bus error, as it didn't
>    terminate
>  - moreover, the STOP interrupt fires a new, as the STOPIRQEN is still
>    active
> 
> Break this logic by stopping the automatic relaunch of a dma channel
> upon a bus error, even if there are still pending issued requests on it.
> 
> As dma_cookie_status() seems unable to return DMA_ERROR in its current
> form, ie. there seems no way to mark a DMA_ERROR on a per-async-tx
> basis, it is chosen in this patch to remember on the channel which
> transaction failed, and report it in pxad_tx_status().
> 
> It's a bit misleading because if T1, T2, T3 and T4 were queued, and T1
> was completed while T2 causes a bus error, the status of T3 and T4 will
> be reported as DMA_IN_PROGRESS, while the channel is actually stopped.

No it is not misleading. The subsequent descriptor can be submitted and
continued. But yes you are right on the error reporting part, that is
something we need to add.

So what exactly are you trying to fix/achive here?

> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/dma/pxa_dma.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index debca824bed6..0dc5a528c463 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -117,6 +117,7 @@ struct pxad_chan {
>  	/* protected by vc->lock */
>  	struct pxad_phy		*phy;
>  	struct dma_pool		*desc_pool;	/* Descriptors pool */
> +	dma_cookie_t		bus_error;
>  };
>  
>  struct pxad_device {
> @@ -560,6 +561,7 @@ static void pxad_launch_chan(struct pxad_chan *chan,
>  			return;
>  		}
>  	}
> +	chan->bus_error = 0;
>  
>  	/*
>  	 * Program the descriptor's address into the DMA controller,
> @@ -663,6 +665,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
>  	struct virt_dma_desc *vd, *tmp;
>  	unsigned int dcsr;
>  	unsigned long flags;
> +	dma_cookie_t last_started = 0;
>  
>  	BUG_ON(!chan);
>  
> @@ -675,6 +678,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
>  		dev_dbg(&chan->vc.chan.dev->device,
>  			"%s(): checking txd %p[%x]: completed=%d\n",
>  			__func__, vd, vd->tx.cookie, is_desc_completed(vd));
> +		last_started = vd->tx.cookie;
>  		if (to_pxad_sw_desc(vd)->cyclic) {
>  			vchan_cyclic_callback(vd);
>  			break;
> @@ -687,7 +691,12 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
>  		}
>  	}
>  
> -	if (dcsr & PXA_DCSR_STOPSTATE) {
> +	if (dcsr & PXA_DCSR_BUSERR) {
> +		chan->bus_error = last_started;
> +		phy_disable(phy);
> +	}
> +
> +	if (!chan->bus_error && dcsr & PXA_DCSR_STOPSTATE) {
>  		dev_dbg(&chan->vc.chan.dev->device,
>  		"%s(): channel stopped, submitted_empty=%d issued_empty=%d",
>  			__func__,
> @@ -1245,6 +1254,9 @@ static enum dma_status pxad_tx_status(struct dma_chan *dchan,
>  	struct pxad_chan *chan = to_pxad_chan(dchan);
>  	enum dma_status ret;
>  
> +	if (cookie == chan->bus_error)
> +		return DMA_ERROR;
> +
>  	ret = dma_cookie_status(dchan, cookie, txstate);
>  	if (likely(txstate && (ret != DMA_ERROR)))
>  		dma_set_residue(txstate, pxad_residue(chan, cookie));
> -- 
> 2.1.4
> 

-- 
~Vinod
