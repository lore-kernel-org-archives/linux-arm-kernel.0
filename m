From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Sat, 6 Oct 2018 07:09:40 +0000
Subject: [RFC PATCH 2/2] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA
 Engine driver support
In-Reply-To: <20180821154635.GG2388@vkoul-mobl>
References: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1533059173-21405-3-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821154635.GG2388@vkoul-mobl>
Message-ID: <SN4PR0201MB363074E44B3E6A67B9D5ECD4C7E40@SN4PR0201MB3630.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.

> On 31-07-18, 23:16, Radhey Shyam Pandey wrote:
> >  struct xilinx_dma_config {
> > @@ -402,6 +470,7 @@ struct xilinx_dma_config {
> >  	int (*clk_init)(struct platform_device *pdev, struct clk **axi_clk,
> >  			struct clk **tx_clk, struct clk **txs_clk,
> >  			struct clk **rx_clk, struct clk **rxs_clk);
> > +	irqreturn_t (*irq_handler)(int irq, void *data);
> 
> this sounds like a preparatory change?

Yes, I will split it in a separate patch.
> 
> > +	} else if (chan->xdev->dma_config->dmatype ==
> XDMA_TYPE_AXIMCDMA) {
> > +		/* Allocate the buffer descriptors. */
> > +		chan->seg_mv = dma_zalloc_coherent(chan->dev,
> > +						  sizeof(*chan->seg_mv) *
> > +						  XILINX_DMA_NUM_DESCS,
> > +						  &chan->seg_p,
> GFP_KERNEL);
> > +		if (!chan->seg_mv) {
> > +			dev_err(chan->dev,
> > +				"unable to allocate channel %d descriptors\n",
> > +				chan->id);
> > +			return -ENOMEM;
> > +		}
> > +		for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
> > +			chan->seg_mv[i].hw.next_desc =
> > +			lower_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
> > +				((i + 1) % XILINX_DMA_NUM_DESCS));
> > +			chan->seg_mv[i].hw.next_desc_msb =
> > +			upper_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
> > +				((i + 1) % XILINX_DMA_NUM_DESCS));
> > +			chan->seg_mv[i].phys = chan->seg_p +
> > +				sizeof(*chan->seg_v) * i;
> > +			list_add_tail(&chan->seg_mv[i].node,
> > +				      &chan->free_seg_list);
> > +		}
> 
> only change with this and previous one seems to be use of seg_mv instead
> of seg_v right? if so, can you try to modularise this..
Agree. I will modularise it.

> 
> >  /**
> > + * xilinx_mcdma_start_transfer - Starts MCDMA transfer
> > + * @chan: Driver specific channel struct pointer
> > + */
> > +static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
> > +{
> > +	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
> > +	struct xilinx_axidma_tx_segment *tail_segment;
> > +	u32 reg;
> > +
> > +	if (chan->err)
> > +		return;
> > +
> > +	if (!chan->idle)
> > +		return;
> > +
> > +	if (list_empty(&chan->pending_list))
> > +		return;
> 
> okay i was thinking that we need lock here, but then this is called with
> lock held, worth mentioning in the comment though..
Ok. Will add.

> 
> > +static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
> > +{
> > +	struct xilinx_dma_chan *chan = data;
> > +	u32 status, ser_offset, chan_sermask, chan_offset = 0, chan_id;
> > +
> > +	if (chan->direction == DMA_DEV_TO_MEM)
> > +		ser_offset = XILINX_MCDMA_RXINT_SER_OFFSET;
> > +	else
> > +		ser_offset = XILINX_MCDMA_TXINT_SER_OFFSET;
> > +
> > +	/* Read the channel id raising the interrupt*/
> > +	chan_sermask = dma_ctrl_read(chan, ser_offset);
> > +	chan_id = ffs(chan_sermask);
> > +
> > +	if (!chan_id)
> > +		return IRQ_NONE;
> > +
> > +	if (chan->direction == DMA_DEV_TO_MEM)
> > +		chan_offset = XILINX_DMA_MAX_CHANS_PER_DEVICE / 2;
> > +
> > +	chan_offset = chan_offset + (chan_id - 1);
> > +	chan = chan->xdev->chan[chan_offset];
> > +	/* Read the status and ack the interrupts. */
> > +	status = dma_ctrl_read(chan,
> XILINX_MCDMA_CHAN_SR_OFFSET(chan->tdest));
> > +	if (!(status & XILINX_MCDMA_IRQ_ALL_MASK))
> > +		return IRQ_NONE;
> > +
> > +	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_SR_OFFSET(chan-
> >tdest),
> > +		       status & XILINX_MCDMA_IRQ_ALL_MASK);
> > +
> > +	if (status & XILINX_MCDMA_IRQ_ERR_MASK) {
> > +		dev_err(chan->dev, "Channel %p has errors %x cdr %x tdr
> %x\n",
> > +			chan, dma_ctrl_read(chan,
> > +			XILINX_MCDMA_CH_ERR_OFFSET),
> dma_ctrl_read(chan,
> > +			XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest)),
> > +			dma_ctrl_read(chan,
> > +				      XILINX_MCDMA_CHAN_TDESC_OFFSET
> > +				      (chan->tdest)));
> 
> this looks very hard to read, please start each dma_ctrl_read() from a
> new line to make it better

Ok . will change.
> 
> > +		chan->err = true;
> > +	}
> > +
> > +	if (status & XILINX_MCDMA_IRQ_DELAY_MASK) {
> > +		/*
> > +		 * Device takes too long to do the transfer when user requires
> > +		 * responsiveness.
> > +		 */
> > +		dev_dbg(chan->dev, "Inter-packet latency too long\n");
> 
> so we just log it..?
For now yes. It will be used later when MCDMA is used by the network client.

> 
> > +	}
> > +
> > +	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
> > +		spin_lock(&chan->lock);
> > +		xilinx_dma_complete_descriptor(chan);
> > +		chan->idle = true;
> > +		chan->start_transfer(chan);
> > +		spin_unlock(&chan->lock);
> > +	}
> > +
> > +	tasklet_schedule(&chan->tasklet);
> > +	return IRQ_HANDLED;
> > +
> 
> bogus empty line...
Will fix.
> 
> > +static struct dma_async_tx_descriptor *xilinx_mcdma_prep_slave_sg(
> > +	struct dma_chan *dchan, struct scatterlist *sgl, unsigned int sg_len,
> > +	enum dma_transfer_direction direction, unsigned long flags,
> > +	void *context)
> 
> indent is pretty bad here too :(
Will fix.
> 
> > +{
> > +	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> > +	struct xilinx_dma_tx_descriptor *desc;
> > +	struct xilinx_aximcdma_tx_segment *segment = NULL;
> > +	u32 *app_w = (u32 *)context;
> > +	struct scatterlist *sg;
> > +	size_t copy;
> > +	size_t sg_used;
> > +	unsigned int i;
> > +
> > +	if (!is_slave_direction(direction))
> > +		return NULL;
> > +
> > +	/* Allocate a transaction descriptor. */
> > +	desc = xilinx_dma_alloc_tx_descriptor(chan);
> > +	if (!desc)
> > +		return NULL;
> > +
> > +	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> > +	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
> > +
> > +	/* Build transactions using information in the scatter gather list */
> > +	for_each_sg(sgl, sg, sg_len, i) {
> > +		sg_used = 0;
> > +
> > +		/* Loop until the entire scatterlist entry is used */
> > +		while (sg_used < sg_dma_len(sg)) {
> > +			struct xilinx_aximcdma_desc_hw *hw;
> > +
> > +			/* Get a free segment */
> > +			segment = xilinx_aximcdma_alloc_tx_segment(chan);
> > +			if (!segment)
> > +				goto error;
> > +
> > +			/*
> > +			 * Calculate the maximum number of bytes to transfer,
> > +			 * making sure it is less than the hw limit
> > +			 */
> > +			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
> > +				     XILINX_DMA_MAX_TRANS_LEN);
> > +			hw = &segment->hw;
> > +
> > +			/* Fill in the descriptor */
> > +			xilinx_aximcdma_buf(chan, hw, sg_dma_address(sg),
> > +					    sg_used);
> > +			hw->control = copy;
> > +
> > +			if (chan->direction == DMA_MEM_TO_DEV) {
> > +				if (app_w)
> 
> why not make condition as: chan->direction == DMA_MEM_TO_DEV &&
> app_w
Ok . will change.

> 
> > +					memcpy(hw->app, app_w, sizeof(u32)
> *
> > +					       XILINX_DMA_NUM_APP_WORDS);
> > +			}
> > +
> > +			sg_used += copy;
> > +			/*
> > +			 * Insert the segment into the descriptor segments
> > +			 * list.
> > +			 */
> > +			list_add_tail(&segment->node, &desc->segments);
> > +		}
> > +	}
> > +
> > +	segment = list_first_entry(&desc->segments,
> > +				   struct xilinx_aximcdma_tx_segment, node);
> > +	desc->async_tx.phys = segment->phys;
> > +
> > +	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
> > +	if (chan->direction == DMA_MEM_TO_DEV) {
> > +		segment->hw.control |= XILINX_MCDMA_BD_SOP;
> > +		segment = list_last_entry(&desc->segments,
> > +					  struct xilinx_aximcdma_tx_segment,
> > +					  node);
> > +		segment->hw.control |= XILINX_MCDMA_BD_EOP;
> > +	}
> > +
> > +	return &desc->async_tx;
> > +
> > +error:
> > +	xilinx_dma_free_tx_descriptor(chan, desc);
> 
> will it free the ones allocated here or all descriptors?

It will free single descriptor and all its segments.
> 
> >  /**
> >   * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE
> transaction
> > @@ -2422,12 +2827,16 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev,
> >
> >  	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
> >  	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
> > -	    of_device_is_compatible(node, "xlnx,axi-cdma-channel")) {
> > +	    of_device_is_compatible(node, "xlnx,axi-cdma-channel") ||
> > +	    of_device_is_compatible(node, "xlnx,axi-mcdma-mm2s-channel")) {
> 
> this is not scaling, maybe you should use data with each
> compatible to check for specific things..
Yes, we can reuse axidma s2mm and mm2 channel nodes. MCDMA stuff can
be selectively programmed based on xilinx_dma_config.dmatype.

> 
> > +static const struct xilinx_dma_config aximcdma_config = {
> > +	.dmatype = XDMA_TYPE_AXIMCDMA,
> > +	.clk_init = axidma_clk_init,
> > +	.irq_handler = xilinx_mcdma_irq_handler,
> > +};
> >  static const struct xilinx_dma_config axicdma_config = {
> >  	.dmatype = XDMA_TYPE_CDMA,
> >  	.clk_init = axicdma_clk_init,
> > +	.irq_handler = xilinx_dma_irq_handler,
> 
> this should be in preparatory patch
Yes.
> --
> ~Vinod
