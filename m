From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Jun 2015 16:19:32 +0530
Subject: [PATCH v7] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <1433831736-18253-1-git-send-email-appanad@xilinx.com>
References: <1433831736-18253-1-git-send-email-appanad@xilinx.com>
Message-ID: <20150622104932.GC19530@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 12:05:36PM +0530, Kedareswara rao Appana wrote:
> This is the driver for the AXI Direct Memory Access (AXI DMA)
> core, which is a soft Xilinx IP core that provides high-
> bandwidth direct memory access between memory and AXI4-Stream
> type target peripherals.
> 
> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> The deivce tree doc got applied in the slave-dmaengine.git.
> 
> This patch is rebased on the commit
> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
same stuff everywhere, sigh

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
> +
> +			sg_used += copy;
> +
> +			/*
> +			 * Insert the segment into the descriptor segments
> +			 * list.
> +			 */
> +			list_add_tail(&segment->node, &desc->segments);
> +		}
> +	}
> +
> +	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
> +	if (direction == DMA_MEM_TO_DEV) {
> +		segment = list_last_entry(&desc->segments,
> +					  struct xilinx_dma_tx_segment,
> +					  node);
> +		segment->hw.control |= XILINX_DMA_BD_EOP;
> +	}
where is the hardware addr programmed? I can see you are using sg list
passed for porgramming one side of a transfer where is other side
programmed?

> +int xilinx_dma_channel_set_config(struct dma_chan *dchan,
> +				  struct xilinx_dma_config *cfg)
> +{
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> +	u32 reg = dma_ctrl_read(chan, XILINX_DMA_REG_CONTROL);
> +
> +	if (!xilinx_dma_is_idle(chan))
> +		return -EBUSY;
> +
> +	if (cfg->reset)
> +		return xilinx_dma_chan_reset(chan);
> +
> +	if (cfg->coalesc <= XILINX_DMA_CR_COALESCE_MAX)
> +		reg |= cfg->coalesc << XILINX_DMA_CR_COALESCE_SHIFT;
> +
> +	if (cfg->delay <= XILINX_DMA_CR_DELAY_MAX)
> +		reg |= cfg->delay << XILINX_DMA_CR_DELAY_SHIFT;
> +
> +	dma_ctrl_write(chan, XILINX_DMA_REG_CONTROL, reg);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(xilinx_dma_channel_set_config);
Same question here as the other driver, why reset, why not _GPL here etc
etc.

Also what is differenace betwene these two drivers, why cant we have one
driver for both?

> +static int xilinx_dma_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_dma_device *xdev;
> +	struct device_node *child, *node;
> +	struct resource *res;
> +	int i, ret;
> +
> +	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
> +	if (!xdev)
> +		return -ENOMEM;
> +
> +	xdev->dev = &(pdev->dev);
> +	INIT_LIST_HEAD(&xdev->common.channels);
> +
> +	node = pdev->dev.of_node;
> +
> +	/* Map the registers */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xdev->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(xdev->regs))
> +		return PTR_ERR(xdev->regs);
> +
> +	/* Check if SG is enabled */
> +	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
> +
> +	/* Axi DMA only do slave transfers */
> +	dma_cap_set(DMA_SLAVE, xdev->common.cap_mask);
> +	dma_cap_set(DMA_PRIVATE, xdev->common.cap_mask);
> +	xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
> +	xdev->common.device_terminate_all = xilinx_dma_terminate_all;
> +	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
> +	xdev->common.device_alloc_chan_resources =
> +		xilinx_dma_alloc_chan_resources;
> +	xdev->common.device_free_chan_resources =
> +		xilinx_dma_free_chan_resources;
> +	xdev->common.device_tx_status = xilinx_dma_tx_status;
> +	xdev->common.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	xdev->common.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +	xdev->common.dev = &pdev->dev;
no dma_slave_config handler?

 

-- 
~Vinod
