From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 17 Mar 2015 16:37:39 +0530
Subject: [PATCH v5] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <6f3b34935c0f405199cacd5312e972ac@BN1BFFO11FD017.protection.gbl>
References: <6f3b34935c0f405199cacd5312e972ac@BN1BFFO11FD017.protection.gbl>
Message-ID: <20150317110739.GE32683@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 11:25:11PM +0530, Kedareswara rao Appana wrote:
> This is the driver for the AXI Direct Memory Access (AXI DMA)
> core, which is a soft Xilinx IP core that provides high-
> bandwidth direct memory access between memory and AXI4-Stream
> type target peripherals.
> 
> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> This patch is rebased on top of dma: xilinx-dma: move header file
> to common location.
but not on slave-dma next some API update is required..


> +/*
> + * DMA driver for Xilinx DMA Engine
> + *
> + * Copyright (C) 2010 - 2014 Xilinx, Inc. All rights reserved.
2015?

> +static struct xilinx_dma_tx_descriptor *
> +xilinx_dma_alloc_tx_descriptor(struct xilinx_dma_chan *chan)
> +{
> +	struct xilinx_dma_tx_descriptor *desc;
> +	unsigned long flags;
> +
> +	if (chan->allocated_desc)
> +		return chan->allocated_desc;
> +
> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
GFP_NOWAIT

> +static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
> +					    dma_cookie_t cookie,
> +					    struct dma_tx_state *txstate)
> +{
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	ret = dma_cookie_status(dchan, cookie, txstate);
> +	if (ret != DMA_COMPLETE) {
txstate can be null

> +		spin_lock_irqsave(&chan->lock, flags);
> +		dma_set_residue(txstate, chan->residue);
the queried descriptor may not be submitted to HW. Also the expectations are
that you will read current value from HW and calculate residue

> +static int xilinx_dma_device_slave_caps(struct dma_chan *dchan,
> +					struct dma_slave_caps *caps)
> +{
> +	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	caps->cmd_terminate = true;
> +	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +
> +	return 0;
> +}
this is based on older API, pls update


> +static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
> +{
> +	struct xilinx_dma_tx_descriptor *desc;
> +	struct xilinx_dma_tx_segment *segment, *next;
> +	struct xilinx_dma_desc_hw *hw;
> +	unsigned long flags;
> +	u32 residue = 0;
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +
> +	desc = chan->active_desc;
> +	if (!desc) {
> +		dev_dbg(chan->dev, "no running descriptors\n");
> +		goto out_unlock;
> +	}
> +
> +	if (chan->has_sg) {
> +		list_for_each_entry_safe(segment, next, &desc->segments, node) {
> +			hw = &segment->hw;
> +			residue += (hw->control - hw->status) &
> +				   XILINX_DMA_MAX_TRANS_LEN;
> +		}
why are we calculating residue here?
> +	}
> +
> +	chan->residue = residue;
and this is used in status call, so completely wrong!

> +static dma_cookie_t xilinx_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(tx->chan);
> +	dma_cookie_t cookie;
> +	unsigned long flags;
> +	int err;
> +
> +	if (chan->err) {
> +		/*
> +		 * If reset fails, need to hard reset the system.
> +		 * Channel is no longer functional
> +		 */
> +		err = xilinx_dma_reset(chan);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +
> +	cookie = dma_cookie_assign(tx);
> +
> +	/* Append the transaction to the pending transactions queue. */
> +	list_add_tail(&desc->node, &chan->pending_list);
> +
> +	/* Free the allocated desc */
> +	chan->allocated_desc = NULL;
this bit is confusing, can you explain what is going on?

> +static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
> +	struct dma_chan *dchan, struct scatterlist *sgl, unsigned int sg_len,
> +	enum dma_transfer_direction direction, unsigned long flags,
> +	void *context)
> +{
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> +	struct xilinx_dma_tx_descriptor *desc;
> +	struct xilinx_dma_tx_segment *segment;
> +	struct xilinx_dma_desc_hw *hw;
> +	u32 *app_w = (u32 *)context;
> +	struct scatterlist *sg;
> +	size_t copy, sg_used;
> +	int i;
> +
> +	if (!is_slave_direction(direction))
> +		return NULL;
> +
> +	/* Allocate a transaction descriptor. */
> +	desc = xilinx_dma_alloc_tx_descriptor(chan);
> +	if (!desc)
> +		return NULL;
> +
> +	desc->direction = direction;
> +	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> +	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
> +	desc->async_tx.cookie = 0;
?

> +	async_tx_ack(&desc->async_tx);
why?

> +
> +	/* Build transactions using information in the scatter gather list */
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		sg_used = 0;
> +
> +		/* Loop until the entire scatterlist entry is used */
> +		while (sg_used < sg_dma_len(sg)) {
> +
> +			/* Get a free segment */
> +			segment = xilinx_dma_alloc_tx_segment(chan);
> +			if (!segment)
> +				goto error;
> +
> +			/*
> +			 * Calculate the maximum number of bytes to transfer,
> +			 * making sure it is less than the hw limit
> +			 */
> +			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
> +				     XILINX_DMA_MAX_TRANS_LEN);
> +			hw = &segment->hw;
> +
> +			/* Fill in the descriptor */
> +			hw->buf_addr = sg_dma_address(sg) + sg_used;
> +
> +			hw->control = copy;
> +
> +			if (direction == DMA_MEM_TO_DEV) {
> +				if (app_w)
> +					memcpy(hw->app, app_w, sizeof(u32) *
> +					       XILINX_DMA_NUM_APP_WORDS);
> +
> +				/*
> +				 * For the first DMA_MEM_TO_DEV transfer,
> +				 * set SOP
> +				 */
> +				if (!i)
> +					hw->control |= XILINX_DMA_BD_SOP;
> +			}
no else?

> +static int xilinx_dma_remove(struct platform_device *pdev)
> +{
> +	struct xilinx_dma_device *xdev = platform_get_drvdata(pdev);
> +	int i;
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&xdev->common);
> +
> +	for (i = 0; i < XILINX_DMA_MAX_CHANS_PER_DEVICE; i++)
> +		if (xdev->chan[i])
> +			xilinx_dma_chan_remove(xdev->chan[i]);
> +
at this point your irq is active and tasklet cna still be scheduled


-- 
~Vinod
