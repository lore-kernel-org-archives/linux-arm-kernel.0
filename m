From: joelf@ti.com (Joel Fernandes)
Date: Thu, 17 Apr 2014 19:45:29 -0500
Subject: [patch 6/6] dma: edma: Provide granular accounting
In-Reply-To: <20140417143250.066998289@linutronix.de>
References: <20140417133737.892475126@linutronix.de>
 <20140417143250.066998289@linutronix.de>
Message-ID: <535075A9.9040904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 09:40 AM, Thomas Gleixner wrote:
> The first slot in the ParamRAM of EDMA holds the current active
> subtransfer. Depending on the direction we read either the source or
> the destination address from there. In the internat psets we have the
> address of the buffer(s).
> 
> In the cyclic case we only use the internal pset[0] which holds the
> start address of the circular buffer and calculate the remaining room
> to the end of the buffer.
> 
> In the SG case we read the current address and compare it to the
> internal psets address and length. If the current address is outside
> of this range, the pset has been processed already and we can mark it
> done, update the residue value and process the next set. If its inside
> the range we know that we look at the current active set and stop the
> walk. In case of intermediate transfers we update the stats in the
> callback function before starting the next batch of transfers.
> 
> The tx_status callback and the callback are serialized via vchan.lock.
> 
> In the unexpected case that the read of the paramram fails due to
> concurrent updates by the DMA engine, we return the last good value.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/dma/edma.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 79 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/dma/edma.c
> ===================================================================
> --- linux-2.6.orig/drivers/dma/edma.c
> +++ linux-2.6/drivers/dma/edma.c
> @@ -71,7 +71,10 @@ struct edma_desc {
>  	int				absync;
>  	int				pset_nr;
>  	int				processed;
> +	int				processed_stat;
>  	u32				residue;
> +	u32				residue_stat;
> +	int				slot0;

Instead of slot0, perhaps storing a pointer to the echan would be great
incase in the future we need to access something else in the channel.
Then you can just do edesc->echan->slot[0].

>  	struct edma_pset		pset[0];
>  };
>  
> @@ -448,6 +451,8 @@ static struct dma_async_tx_descriptor *e
>  		}
>  	}
>  
> +	edesc->slot0 = echan->slot[0];
> +
>  	/* Configure PaRAM sets for each SG */
>  	for_each_sg(sgl, sg, sg_len, i) {
>  		/* Get address for each SG */
> @@ -476,6 +481,7 @@ static struct dma_async_tx_descriptor *e
>  		if (i == sg_len - 1)
>  			edesc->pset[i].hwpar.opt |= TCINTEN;
>  	}
> +	edesc->residue_stat = edesc->residue;
>  
>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
>  }
> @@ -543,7 +549,7 @@ static struct dma_async_tx_descriptor *e
>  
>  	edesc->cyclic = 1;
>  	edesc->pset_nr = nslots;
> -	edesc->residue = buf_len;
> +	edesc->residue = edesc->residue_stat = buf_len;
>  	edesc->direction = direction;
>  
>  	dev_dbg(dev, "%s: nslots=%d\n", __func__, nslots);
> @@ -613,6 +619,7 @@ static struct dma_async_tx_descriptor *e
>  		 */
>  		edesc->pset[i].hwpar.opt |= TCINTEN;
>  	}
> +	edesc->slot0 = echan->slot[0];
>  
>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
>  }
> @@ -645,7 +652,17 @@ static void edma_callback(unsigned ch_nu
>  				vchan_cookie_complete(&edesc->vdesc);
>  				edma_execute(echan);
>  			} else {
> +				int i, n;
> +
>  				dev_dbg(dev, "Intermediate transfer complete on channel %d\n", ch_num);
> +
> +				/* Update statistics for tx_status */
> +				n = edesc->processed;
> +				for (i = edesc->processed_stat; i < n; i++)
> +					edesc->residue -= edesc->pset[i].len;
> +				edesc->processed_stat = n;
> +				edesc->residue_stat = edesc->residue;
> +

This is a bit of a NAK since it is O(n) on every intermediate transfer
completion. I'm not sure of a better way to do it but I certainly don't
want the IRQ slowed down anymore... Is there a way to pre-calculate the
size of the intermediate transfer and store it somewhere for accounting?

Also another thing is I don't think processed_stat is required at all,
because I think you introduced it for the possibility that there might
be delays in processing interrupts for intermediate transfers. That is
actually an impossibility because such a scenario would result in
catastrophic failure anyway. Because for intermediate transfer
interrupts shouldn't be missed, so in this case you can just do:

for (i = 1; i <= MAX_NR_SG; i++) {
	edesc->residue -= edesc->pset[edesc->processed - i].len;
}

I think that'll work.


>  				edma_execute(echan);
>  			}
>  		}
> @@ -773,6 +790,66 @@ static void edma_issue_pending(struct dm
>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
>  }
>  
> +static u32 edma_residue(struct edma_desc *edesc)
> +{
> +	bool dst = edesc->direction == DMA_DEV_TO_MEM;
> +	struct edma_pset *pset = edesc->pset;
> +	dma_addr_t done, pos;
> +	int ret, i;
> +
> +	/*
> +	 * We always read the dst/src position from the first RamPar
> +	 * pset. That's the one which is active now.
> +	 */
> +	ret = edma_get_position(edesc->slot0, &pos, dst);
> +
> +	/*
> +	 * edma_get_position() can fail due to concurrent
> +	 * updates to the pset. Unlikely, but can happen.
> +	 * Return the last known residue value.
> +	 */
> +	if (ret)
> +		return edesc->residue_stat;
> +

This check could be dropped following the discussion in earlier patch
and also residue_stat could be dropped if there's no other use for it.

> +	/*
> +	 * Cyclic is simple. Just subtract pset[0].addr from pos.
> +	 *
> +	 * We never update edesc->residue in the cyclic case, so we
> +	 * can tell the remaining room to the end of the circular
> +	 * buffer.
> +	 */
> +	if (edesc->cyclic) {
> +		done = pos - pset->addr;
> +		edesc->residue_stat = edesc->residue - done;
> +		return edesc->residue_stat;
> +	}
> +
> +	/*
> +	 * For SG operation we catch up with the last processed
> +	 * status.
> +	 */
> +	pset += edesc->processed_stat;
> +
> +	for (i = edesc->processed_stat; i < edesc->processed; i++, pset++) {
> +		/*
> +		 * If we are inside this pset address range, we know
> +		 * this is the active one. Get the current delta and
> +		 * stop walking the psets.
> +		 */
> +		if (pos >= pset->addr && pos < pset->addr + pset->len) {
> +			edesc->residue_stat = edesc->residue;
> +			edesc->residue_stat -= pos - pset->addr;
> +			break;
> +		}
> +
> +		/* Otherwise mark it done and update residue[_stat]. */
> +		edesc->processed_stat++;
> +		edesc->residue -= pset->len;
> +		edesc->residue_stat = edesc->residue;
> +	}


Also, just curious - doesn't calling status too aggressively result in
any slowness for you? Since vchan lock spinlock will be held during the
duration of this processing, and interrupts would be disabled causing
edma_callback interrupt delays possibly. I'm not saying you introduced
the lock or anything because status would previously also hold the lock.
I just haven't played status enough to know how it will behave when
happening concurrently with DMA transfers.

thanks,
  -Joel

> +	return edesc->residue_stat;
> +}
> +
>  /* Check request completion status */
>  static enum dma_status edma_tx_status(struct dma_chan *chan,
>  				      dma_cookie_t cookie,
> @@ -789,7 +866,7 @@ static enum dma_status edma_tx_status(st
>  
>  	spin_lock_irqsave(&echan->vchan.lock, flags);
>  	if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie)
> -		txstate->residue = echan->edesc->residue;
> +		txstate->residue = edma_residue(echan->edesc);
>  	else if ((vdesc = vchan_find_desc(&echan->vchan, cookie)))
>  		txstate->residue = to_edma_desc(&vdesc->tx)->residue;
>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
> 
> 
