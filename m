From: joelf@ti.com (Joel Fernandes)
Date: Thu, 17 Apr 2014 19:02:31 -0500
Subject: [patch 1/6] dma: edma: Sanitize residue reporting
In-Reply-To: <20140417143249.095049101@linutronix.de>
References: <20140417133737.892475126@linutronix.de>
 <20140417143249.095049101@linutronix.de>
Message-ID: <53506B97.2060605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 04/17/2014 09:40 AM, Thomas Gleixner wrote:
> The residue reporting in edma_tx_status() is just broken. It blindly
> walks the psets and recalculates the lenght of the transfer from the
> hardware parameters. For cyclic transfers it adds the link pset, which
> results in interestingly large residues. For non-cyclic it adds the
> dummy pset, which is stupid as well.
> Aside of that it's silly to walk through the pset params when the per
> descriptor residue is known at the point of creating it.

Yes this bit had to be rewritten, after we added support to DMA SGs.
Thanks. It was written before I took over the driver ;-)

> 
> Store the information in edma_desc and use it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/dma/edma.c |   34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
> 
> Index: linux-2.6/drivers/dma/edma.c
> ===================================================================
> --- linux-2.6.orig/drivers/dma/edma.c
> +++ linux-2.6/drivers/dma/edma.c
> @@ -64,6 +64,7 @@ struct edma_desc {
>  	int				absync;
>  	int				pset_nr;
>  	int				processed;
> +	u32				residue;
>  	struct edmacc_param		pset[0];
>  };
>  
> @@ -416,6 +417,7 @@ static struct dma_async_tx_descriptor *e
>  	}
>  
>  	edesc->pset_nr = sg_len;
> +	edesc->residue = 0;
>  
>  	/* Allocate a PaRAM slot, if needed */
>  	nslots = min_t(unsigned, MAX_NR_SG, sg_len);
> @@ -450,6 +452,7 @@ static struct dma_async_tx_descriptor *e
>  		}
>  
>  		edesc->absync = ret;
> +		edesc->residue += sg_dma_len(sg);
>  
>  		/* If this is the last in a current SG set of transactions,
>  		   enable interrupts so that next set is processed */
> @@ -527,6 +530,7 @@ static struct dma_async_tx_descriptor *e
>  
>  	edesc->cyclic = 1;
>  	edesc->pset_nr = nslots;
> +	edesc->residue = buf_len;
>  
>  	dev_dbg(dev, "%s: nslots=%d\n", __func__, nslots);
>  	dev_dbg(dev, "%s: period_len=%d\n", __func__, period_len);
> @@ -622,6 +626,7 @@ static void edma_callback(unsigned ch_nu
>  				vchan_cyclic_callback(&edesc->vdesc);
>  			} else if (edesc->processed == edesc->pset_nr) {
>  				dev_dbg(dev, "Transfer complete, stopping channel %d\n", ch_num);
> +				edesc->residue = 0;
>  				edma_stop(echan->ch_num);
>  				vchan_cookie_complete(&edesc->vdesc);
>  				edma_execute(echan);
> @@ -754,25 +759,6 @@ static void edma_issue_pending(struct dm
>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
>  }
>  
> -static size_t edma_desc_size(struct edma_desc *edesc)
> -{
> -	int i;
> -	size_t size;
> -
> -	if (edesc->absync)
> -		for (size = i = 0; i < edesc->pset_nr; i++)
> -			size += (edesc->pset[i].a_b_cnt & 0xffff) *
> -				(edesc->pset[i].a_b_cnt >> 16) *
> -				 edesc->pset[i].ccnt;
> -	else
> -		size = (edesc->pset[0].a_b_cnt & 0xffff) *
> -			(edesc->pset[0].a_b_cnt >> 16) +
> -			(edesc->pset[0].a_b_cnt & 0xffff) *
> -			(SZ_64K - 1) * edesc->pset[0].ccnt;
> -
> -	return size;
> -}
> -
>  /* Check request completion status */
>  static enum dma_status edma_tx_status(struct dma_chan *chan,
>  				      dma_cookie_t cookie,
> @@ -789,12 +775,10 @@ static enum dma_status edma_tx_status(st
>  
>  	spin_lock_irqsave(&echan->vchan.lock, flags);
>  	vdesc = vchan_find_desc(&echan->vchan, cookie);
> -	if (vdesc) {
> -		txstate->residue = edma_desc_size(to_edma_desc(&vdesc->tx));
> -	} else if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie) {
> -		struct edma_desc *edesc = echan->edesc;
> -		txstate->residue = edma_desc_size(edesc);
> -	}
> +	if (vdesc)
> +		txstate->residue = to_edma_desc(&vdesc->tx)->residue;
> +	else if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie)
> +		txstate->residue = echan->edesc->residue;
>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
>  
>  	return ret;

Peter, its ok, can you ensure this works for Audio
(snd_dmaengine_pcm_pointer) users of EDMA (unless Thomas may already have).

Looks fine to me otherwise,
Reviewed-by: Joel Fernandes <joelf@ti.com>

thanks,
  -Joel
