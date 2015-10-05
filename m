From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 5 Oct 2015 16:18:17 +0100
Subject: [PATCH v6 2/2] dmaengine: Add Xilinx AXI Central Direct Memory
 Access Engine driver support
In-Reply-To: <1441629198-17663-1-git-send-email-appanad@xilinx.com>
References: <1441629198-17663-1-git-send-email-appanad@xilinx.com>
Message-ID: <20151005151816.GD13501@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 06:03:18PM +0530, Kedareswara rao Appana wrote:

> +static struct xilinx_cdma_tx_segment *
> +xilinx_cdma_alloc_tx_segment(struct xilinx_cdma_chan *chan)
> +{
> +	struct xilinx_cdma_tx_segment *segment;
> +	dma_addr_t phys;
> +
> +	segment = dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &phys);
> +	if (!segment)
> +		return NULL;
> +
> +	memset(segment, 0, sizeof(*segment));
dma_pool_zalloc() pls

> +static void xilinx_cdma_start_transfer(struct xilinx_cdma_chan *chan)
> +{
> +	struct xilinx_cdma_tx_descriptor *head_desc, *tail_desc;
> +	struct xilinx_cdma_tx_segment *tail_segment;
> +	u32 ctrl_reg = cdma_read(chan, XILINX_CDMA_CONTROL_OFFSET);
> +
> +	if (chan->err)
> +		return;
> +
> +	if (list_empty(&chan->pending_list))
> +		return;
> +
> +	if (!chan->idle)
> +		return;
this and err case can be combined !


> +static struct dma_async_tx_descriptor *
> +xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
> +			dma_addr_t dma_src, size_t len, unsigned long flags)
> +{
> +	struct xilinx_cdma_chan *chan = to_xilinx_chan(dchan);
> +	struct xilinx_cdma_desc_hw *hw;
> +	struct xilinx_cdma_tx_descriptor *desc;
> +	struct xilinx_cdma_tx_segment *segment, *prev;
> +
> +	if (!len || len > XILINX_CDMA_MAX_TRANS_LEN)
> +		return NULL;
> +
> +	desc = xilinx_cdma_alloc_tx_descriptor(chan);
> +	if (!desc)
> +		return NULL;
> +
> +	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> +	desc->async_tx.tx_submit = xilinx_cdma_tx_submit;
> +	async_tx_ack(&desc->async_tx);

Why do you need this ?

> +static int xilinx_cdma_terminate_all(struct dma_chan *dchan)
> +{
> +	struct xilinx_cdma_chan *chan = to_xilinx_chan(dchan);
> +
> +	/* Reset the channel */
> +	xilinx_cdma_chan_reset(chan);

what about the irqs that are already fired/tasklets scheduled?

> +
> +	/* Remove and free all of the descriptors in the lists */
> +	xilinx_cdma_free_descriptors(chan);
> +
> +	return 0;
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * Probe and remove
> + */
> +
> +/**
> + * xilinx_cdma_free_channel - Channel remove function
> + * @chan: Driver specific cdma channel
> + */
> +static void xilinx_cdma_free_channel(struct xilinx_cdma_chan *chan)

Free channel is a bad name, as we alloc and free channels from dmaengine API

-- 
~Vinod
