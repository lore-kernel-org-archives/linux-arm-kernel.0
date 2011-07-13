From: boojin.kim@samsung.com (boojin)
Date: Wed, 13 Jul 2011 20:04:17 +0900
Subject: [PATCH V2 03/12] DMA: PL330: Add DMA capabilities
In-Reply-To: <20110713091403.GI23270@n2100.arm.linux.org.uk>
References: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
	<1310546857-6304-4-git-send-email-kgene.kim@samsung.com>
	<20110713091403.GI23270@n2100.arm.linux.org.uk>
Message-ID: <007701cc414c$9befb680$d3cf2380$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA cyclic capability and Slave configuration.
DMA cyclic capability is only used for audio circular buffer.

Russell king wrote:
> On Wed, Jul 13, 2011 at 05:47:28PM +0900, Kukjin Kim wrote:
> > +static void pl330_tasklet_cyclic(unsigned long data)
> > +{
> > +	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
> > +	struct dma_pl330_desc *desc, *_dt;
> > +	unsigned long flags;
> > +	LIST_HEAD(list);
> > +
> > +	spin_lock_irqsave(&pch->lock, flags);
> > +
> > +	/* Pick up ripe tomatoes */
> > +	list_for_each_entry_safe(desc, _dt, &pch->work_list, node)
> > +		if ((desc->status == DONE) && desc->cyclic) {
> > +			dma_async_tx_callback callback;
> > +
> > +			list_move_tail(&desc->node, &pch->work_list);
> > +			pch->completed = desc->txd.cookie;
> > +
> > +			desc->status = PREP;
> > +
> > +			/* Try to submit a req imm.
> > +			next to the last completed cookie */
> > +			fill_queue(pch);
> > +
> > +			/* Make sure the PL330 Channel thread is active */
> > +			pl330_chan_ctrl(pch->pl330_chid, PL330_OP_START);
> > +
> > +			callback = desc->txd.callback;
> > +			if (callback)
> > +				callback(desc->txd.callback_param);
> 
> How does this work when callbacks are allowed to queue new requests?
> Aren't you going to deadlock on the spinlock?
> 
> I don't see 'list' being used in this function either.
> 
>
Cyclic capability re-uses the requests that were submitted through
tx_submit().
It's possible because Cyclic capability uses same DMA configuration.
This pl330_tasklet_cyclic() makes the status of the done request into
'PREP'. 
And, re-submit it to PL330.
There are no deadlock because callback function just gathers transmit
position.
And Cyclic capability doesn't use 'list' for queue new requests.

> > +
> > +		}
> > +
> > +	spin_unlock_irqrestore(&pch->lock, flags);
> > +}
> > +
> > +static void pl330_cyclic_free(struct dma_pl330_chan *pch)
> > +{
> > +	struct dma_pl330_dmac *pdmac = pch->dmac;
> > +	struct dma_pl330_desc *desc, *_dt;
> > +	unsigned long flags;
> > +	LIST_HEAD(list);
> > +
> > +	spin_lock_irqsave(&pdmac->pool_lock, flags);
> > +
> > +	list_for_each_entry_safe(desc, _dt, &pch->work_list, node)
> > +	if (desc->cyclic)
> > +		list_move_tail(&desc->node, &list);
> > +
> > +	list_splice_tail_init(&list, &pdmac->desc_pool);
> 
> As you're not using 'list' after this point, would 'list_splice_tail'
> do here?
Yes, You're right. the 'list' isn't used after device_free_chan_resources().
So, I release it to desc_pool by using 'list_splice_tail'

> 
> > +
> > +	spin_unlock_irqrestore(&pdmac->pool_lock, flags);
> > +	pch->cyclic_task = NULL;
> > +}
> > +
> >  static void pl330_tasklet(unsigned long data)
> >  {
> >  	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
> > @@ -227,6 +285,9 @@ static void dma_pl330_rqcb(void *token, enum
> pl330_op_err err)
> >
> >  	spin_unlock_irqrestore(&pch->lock, flags);
> >
> > +	if (pch->cyclic_task)
> > +		tasklet_schedule(pch->cyclic_task);
> > +	else
> >  	tasklet_schedule(&pch->task);
> 
> This 'tasklet_schedule' wants to be indented.
I will address your guide. Thanks

> 
> >  }
> >
> > @@ -256,25 +317,58 @@ static int pl330_alloc_chan_resources(struct
> dma_chan *chan)
> >  static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> unsigned long arg)
> >  {
> >  	struct dma_pl330_chan *pch = to_pchan(chan);
> > -	struct dma_pl330_desc *desc;
> > +	struct dma_pl330_desc *desc, *_dt;
> >  	unsigned long flags;
> > +	struct dma_pl330_dmac *pdmac = pch->dmac;
> > +	struct dma_slave_config *slave_config;
> > +	struct dma_pl330_peri *peri;
> > +	int i;
> > +	LIST_HEAD(list);
> >
> > -	/* Only supports DMA_TERMINATE_ALL */
> > -	if (cmd != DMA_TERMINATE_ALL)
> > -		return -ENXIO;
> > -
> > -	spin_lock_irqsave(&pch->lock, flags);
> > -
> > -	/* FLUSH the PL330 Channel thread */
> > -	pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
> > +	switch (cmd) {
> > +	case DMA_TERMINATE_ALL:
> > +		spin_lock_irqsave(&pch->lock, flags);
> >
> > -	/* Mark all desc done */
> > -	list_for_each_entry(desc, &pch->work_list, node)
> > -		desc->status = DONE;
> > +		/* FLUSH the PL330 Channel thread */
> > +		pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
> >
> > -	spin_unlock_irqrestore(&pch->lock, flags);
> > +		/* Mark all desc done */
> > +		list_for_each_entry_safe(desc, _dt, &pch->work_list , node)
> {
> > +			desc->status = DONE;
> > +			pch->completed = desc->txd.cookie;
> > +			list_move_tail(&desc->node, &list);
> > +		}
> >
> > -	pl330_tasklet((unsigned long) pch);
> > +		list_splice_tail_init(&list, &pdmac->desc_pool);
> 
> Again, would list_splice_tail() do here?
This code is for 'flush' operation that releases all of the pre-loaded
requests.
I uses 'list_splice_tail_init' for it instead of 'pl330_tasklet' that also
calls 'list_splice_tail_init'.

> 
> > +		spin_unlock_irqrestore(&pch->lock, flags);
> > +		break;
> > +	case DMA_SLAVE_CONFIG:
> > +		slave_config = (struct dma_slave_config *)arg;
> > +		peri = pch->chan.private;
> > +
> > +		if (slave_config->direction == DMA_TO_DEVICE) {
> > +			if (slave_config->dst_addr)
> > +				peri->fifo_addr = slave_config->dst_addr;
> > +			if (slave_config->dst_addr_width) {
> > +				i = 0;
> > +				while (slave_config->dst_addr_width != (1 <<
i))
> > +					i++;
> > +				peri->burst_sz = i;
> > +			}
> > +		} else if (slave_config->direction == DMA_FROM_DEVICE) {
> > +			if (slave_config->src_addr)
> > +				peri->fifo_addr = slave_config->src_addr;
> > +			if (slave_config->src_addr_width) {
> > +				i = 0;
> > +				while (slave_config->src_addr_width != (1 <<
i))
> > +					i++;
> > +				peri->burst_sz = i;
> > +			}
> > +		}
> 
> It would make more sense to store the M2P and P2M address/width/burst size
> separately, so you don't have to make DMA_SLAVE_CONFIG calls before every
> transfer.
DMA_SLAVE_CONFIG is called the first time that DMA client driver requests
DMA channel.
