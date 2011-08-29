From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 29 Aug 2011 19:25:41 +0530
Subject: [PATCH v7 02/15] DMA: PL330: Update PL330 DMA API driver
In-Reply-To: <1314238425-6480-3-git-send-email-boojin.kim@samsung.com>
References: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
	<1314238425-6480-3-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314626141.1606.139.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-25 at 11:13 +0900, Boojin Kim wrote:
> This patch updates following 3 items.
> @@ -69,6 +70,10 @@ struct dma_pl330_chan {
>  	 * NULL if the channel is available to be acquired.
>  	 */
>  	void *pl330_chid;
> +
> +	/* For D-to-M and M-to-D channels */
> +	int burst_sz; /* the peripheral fifo width */
> +	dma_addr_t fifo_addr;
>  };
Why should you store peripheral address and burst size in channel
structure. You should take these from the API and dma_slave_structure
>  
>  struct dma_pl330_dmac {
> @@ -456,7 +461,7 @@ static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
>  
>  	if (peri) {
>  		desc->req.rqtype = peri->rqtype;
> -		desc->req.peri = peri->peri_id;
> +		desc->req.peri = pch->chan.chan_id;
>  	} else {
>  		desc->req.rqtype = MEMTOMEM;
>  		desc->req.peri = 0;
> @@ -582,7 +587,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	struct dma_pl330_peri *peri = chan->private;
>  	struct scatterlist *sg;
>  	unsigned long flags;
> -	int i, burst_size;
> +	int i;
>  	dma_addr_t addr;
>  
>  	if (unlikely(!pch || !sgl || !sg_len || !peri))
> @@ -598,8 +603,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		return NULL;
>  	}
>  
> -	addr = peri->fifo_addr;
> -	burst_size = peri->burst_sz;
> +	addr = pch->fifo_addr;
what you removed is the correct way to do...

-- 
~Vinod
