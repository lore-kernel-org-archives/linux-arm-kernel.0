From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 10:27:49 +0100
Subject: [PATCH V4 04/14] DMA: PL330: Add DMA_CYCLIC capability
In-Reply-To: <1311557312-26107-5-git-send-email-boojin.kim@samsung.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-5-git-send-email-boojin.kim@samsung.com>
Message-ID: <20110725092749.GB9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 10:28:22AM +0900, Boojin Kim wrote:
> +static void pl330_tasklet_cyclic(unsigned long data)
> +{
> +	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
> +	struct dma_pl330_desc *desc, *_dt;
> +	unsigned long flags;
> +	LIST_HEAD(list);
> +
> +	spin_lock_irqsave(&pch->lock, flags);
...
> +			callback = desc->txd.callback;
> +			if (callback)
> +				callback(desc->txd.callback_param);

On this again - what if the callback wants to terminate the DMA activity
because there's no more audio data to be sent/received from the device?

> +

Useless blank line.

> +		}
> +
> +	spin_unlock_irqrestore(&pch->lock, flags);
> +}
> +
>  static void pl330_tasklet(unsigned long data)
>  {
>  	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
> @@ -227,6 +267,9 @@ static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
>  
>  	spin_unlock_irqrestore(&pch->lock, flags);
>  
> +	if (pch->cyclic_task)
> +		tasklet_schedule(pch->cyclic_task);
> +	else
>  	tasklet_schedule(&pch->task);

Indentation error.

>  }
>  
> @@ -316,6 +359,15 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
>  	pl330_release_channel(pch->pl330_chid);
>  	pch->pl330_chid = NULL;
>  
> +	if (pch->cyclic) {
> +		pch->cyclic = false;
> +		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
> +		if (pch->cyclic_task) {
> +			tasklet_kill(pch->cyclic_task);
> +			pch->cyclic_task = NULL;
> +		}
> +	}
> +
>  	spin_unlock_irqrestore(&pch->lock, flags);
>  }
>  
> @@ -547,6 +599,63 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
>  	return burst_len;
>  }
>  
> +static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
> +		struct dma_chan *chan, dma_addr_t dma_addr, size_t len,
> +		size_t period_len, enum dma_data_direction direction)
> +{
> +	struct dma_pl330_desc *desc;
> +	struct dma_pl330_chan *pch = to_pchan(chan);
> +	struct dma_pl330_peri *peri = chan->private;
> +	dma_addr_t dst;
> +	dma_addr_t src;
> +
> +	pch = to_pchan(chan);
> +	if (!pch)
> +		return NULL;

You've already done the to_pchan() thing when declaring pch.  You've
already dereferenced 'chan', so there's no way that pch could be NULL
here.

> +
> +	desc = pl330_get_desc(pch);
> +	if (!desc) {
> +		dev_err(pch->dmac->pif.dev, "%s:%d Unable to fetch desc\n",
> +			__func__, __LINE__);
> +		return NULL;
> +	}
> +
> +	switch (direction) {
> +	case DMA_TO_DEVICE:
> +		desc->rqcfg.src_inc = 1;
> +		desc->rqcfg.dst_inc = 0;
> +		src = dma_addr;
> +		dst = peri->fifo_addr;
> +		break;
> +	case DMA_FROM_DEVICE:
> +		desc->rqcfg.src_inc = 0;
> +		desc->rqcfg.dst_inc = 1;
> +		src = peri->fifo_addr;
> +		dst = dma_addr;
> +		break;
> +	default:
> +		dev_err(pch->dmac->pif.dev, "%s:%d Invalid dma direction\n",
> +		__func__, __LINE__);
> +		return NULL;
> +	}
> +
> +	desc->rqcfg.brst_size = peri->burst_sz;
> +	desc->rqcfg.brst_len = 1;
> +
> +	if (!pch->cyclic_task) {
> +		pch->cyclic_task =
> +			kmalloc(sizeof(struct tasklet_struct), GFP_KERNEL);
> +		tasklet_init(pch->cyclic_task,
> +			pl330_tasklet_cyclic, (unsigned int)pch);

Here you allocate memory for the cyclic task.  Above you set this pointer
to NULL.  That sounds like a memory leak to me.  Why are you kmallocing
this memory - why can't it be part of the dma_pl330_chan structure?  It's
only 28 bytes.
