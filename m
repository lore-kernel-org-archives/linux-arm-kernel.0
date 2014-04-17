From: joelf@ti.com (Joel Fernandes)
Date: Thu, 17 Apr 2014 18:56:32 -0500
Subject: [patch 3/6] dma: edma: Create private pset struct
In-Reply-To: <20140417143249.489574612@linutronix.de>
References: <20140417133737.892475126@linutronix.de>
 <20140417143249.489574612@linutronix.de>
Message-ID: <53506A30.4060701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 09:40 AM, Thomas Gleixner wrote:
> Preparatory patch to support finer grained accounting.
> 
> Move the edma_params array out of edma_desc so we can add further per
> pset data to it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/dma/edma.c |   67 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 31 deletions(-)
> 
> Index: linux-2.6/drivers/dma/edma.c
> ===================================================================
> --- linux-2.6.orig/drivers/dma/edma.c
> +++ linux-2.6/drivers/dma/edma.c
> @@ -57,6 +57,10 @@
>  #define EDMA_MAX_SLOTS		MAX_NR_SG
>  #define EDMA_DESCRIPTORS	16
>  
> +struct edma_pset {
> +	struct edmacc_param		hwpar;

If its ok, can this be renamed to param instead of hwpar through out the
patch? I feel that's more readable. Thanks.


> +};
> +
>  struct edma_desc {
>  	struct virt_dma_desc		vdesc;
>  	struct list_head		node;
> @@ -65,7 +69,7 @@ struct edma_desc {
>  	int				pset_nr;
>  	int				processed;
>  	u32				residue;
> -	struct edmacc_param		pset[0];
> +	struct edma_pset		pset[0];
>  };
>  
>  struct edma_cc;
> @@ -141,7 +145,7 @@ static void edma_execute(struct edma_cha
>  	/* Write descriptor PaRAM set(s) */
>  	for (i = 0; i < nslots; i++) {
>  		j = i + edesc->processed;
> -		edma_write_slot(echan->slot[i], &edesc->pset[j]);
> +		edma_write_slot(echan->slot[i], &edesc->pset[j].hwpar);
>  		dev_dbg(echan->vchan.chan.device->dev,
>  			"\n pset[%d]:\n"
>  			"  chnum\t%d\n"
> @@ -155,14 +159,14 @@ static void edma_execute(struct edma_cha
>  			"  cidx\t%08x\n"
>  			"  lkrld\t%08x\n",
>  			j, echan->ch_num, echan->slot[i],
> -			edesc->pset[j].opt,
> -			edesc->pset[j].src,
> -			edesc->pset[j].dst,
> -			edesc->pset[j].a_b_cnt,
> -			edesc->pset[j].ccnt,
> -			edesc->pset[j].src_dst_bidx,
> -			edesc->pset[j].src_dst_cidx,
> -			edesc->pset[j].link_bcntrld);
> +			edesc->pset[j].hwpar.opt,
> +			edesc->pset[j].hwpar.src,
> +			edesc->pset[j].hwpar.dst,
> +			edesc->pset[j].hwpar.a_b_cnt,
> +			edesc->pset[j].hwpar.ccnt,
> +			edesc->pset[j].hwpar.src_dst_bidx,
> +			edesc->pset[j].hwpar.src_dst_cidx,
> +			edesc->pset[j].hwpar.link_bcntrld);
>  		/* Link to the previous slot if not the last set */
>  		if (i != (nslots - 1))
>  			edma_link(echan->slot[i], echan->slot[i+1]);
> @@ -274,13 +278,14 @@ static int edma_control(struct dma_chan
>   * @dma_length: Total length of the DMA transfer
>   * @direction: Direction of the transfer
>   */
> -static int edma_config_pset(struct dma_chan *chan, struct edmacc_param *pset,
> +static int edma_config_pset(struct dma_chan *chan, struct edma_pset *epset,
>  	dma_addr_t src_addr, dma_addr_t dst_addr, u32 burst,
>  	enum dma_slave_buswidth dev_width, unsigned int dma_length,
>  	enum dma_transfer_direction direction)
>  {
>  	struct edma_chan *echan = to_edma_chan(chan);
>  	struct device *dev = chan->device->dev;
> +	struct edmacc_param *hwpar = &epset->hwpar;
>  	int acnt, bcnt, ccnt, cidx;
>  	int src_bidx, dst_bidx, src_cidx, dst_cidx;
>  	int absync;
> @@ -351,26 +356,26 @@ static int edma_config_pset(struct dma_c
>  		return -EINVAL;
>  	}
>  
> -	pset->opt = EDMA_TCC(EDMA_CHAN_SLOT(echan->ch_num));
> +	hwpar->opt = EDMA_TCC(EDMA_CHAN_SLOT(echan->ch_num));
>  	/* Configure A or AB synchronized transfers */
>  	if (absync)
> -		pset->opt |= SYNCDIM;
> +		hwpar->opt |= SYNCDIM;
>  
> -	pset->src = src_addr;
> -	pset->dst = dst_addr;
> +	hwpar->src = src_addr;
> +	hwpar->dst = dst_addr;
>  
> -	pset->src_dst_bidx = (dst_bidx << 16) | src_bidx;
> -	pset->src_dst_cidx = (dst_cidx << 16) | src_cidx;
> +	hwpar->src_dst_bidx = (dst_bidx << 16) | src_bidx;
> +	hwpar->src_dst_cidx = (dst_cidx << 16) | src_cidx;
>  
> -	pset->a_b_cnt = bcnt << 16 | acnt;
> -	pset->ccnt = ccnt;
> +	hwpar->a_b_cnt = bcnt << 16 | acnt;
> +	hwpar->ccnt = ccnt;
>  	/*
>  	 * Only time when (bcntrld) auto reload is required is for
>  	 * A-sync case, and in this case, a requirement of reload value
>  	 * of SZ_64K-1 only is assured. 'link' is initially set to NULL
>  	 * and then later will be populated by edma_execute.
>  	 */
> -	pset->link_bcntrld = 0xffffffff;
> +	hwpar->link_bcntrld = 0xffffffff;
>  	return absync;
>  }
>  
> @@ -457,11 +462,11 @@ static struct dma_async_tx_descriptor *e
>  		/* If this is the last in a current SG set of transactions,
>  		   enable interrupts so that next set is processed */
>  		if (!((i+1) % MAX_NR_SG))
> -			edesc->pset[i].opt |= TCINTEN;
> +			edesc->pset[i].hwpar.opt |= TCINTEN;
>  
>  		/* If this is the last set, enable completion interrupt flag */
>  		if (i == sg_len - 1)
> -			edesc->pset[i].opt |= TCINTEN;
> +			edesc->pset[i].hwpar.opt |= TCINTEN;
>  	}
>  
>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
> @@ -582,14 +587,14 @@ static struct dma_async_tx_descriptor *e
>  			"  cidx\t%08x\n"
>  			"  lkrld\t%08x\n",
>  			i, echan->ch_num, echan->slot[i],
> -			edesc->pset[i].opt,
> -			edesc->pset[i].src,
> -			edesc->pset[i].dst,
> -			edesc->pset[i].a_b_cnt,
> -			edesc->pset[i].ccnt,
> -			edesc->pset[i].src_dst_bidx,
> -			edesc->pset[i].src_dst_cidx,
> -			edesc->pset[i].link_bcntrld);
> +			edesc->pset[i].hwpar.opt,
> +			edesc->pset[i].hwpar.src,
> +			edesc->pset[i].hwpar.dst,
> +			edesc->pset[i].hwpar.a_b_cnt,
> +			edesc->pset[i].hwpar.ccnt,
> +			edesc->pset[i].hwpar.src_dst_bidx,
> +			edesc->pset[i].hwpar.src_dst_cidx,
> +			edesc->pset[i].hwpar.link_bcntrld);
>  
>  		edesc->absync = ret;
>  
> @@ -597,7 +602,7 @@ static struct dma_async_tx_descriptor *e
>  		 * Enable interrupts for every period because callback
>  		 * has to be called for every period.
>  		 */
> -		edesc->pset[i].opt |= TCINTEN;
> +		edesc->pset[i].hwpar.opt |= TCINTEN;
>  	}
>  
>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
> 
> 
