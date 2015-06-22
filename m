From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Jun 2015 15:45:27 +0530
Subject: [PATCH v5 2/2] dma: Add Xilinx AXI Central Direct Memory Access
 Engine driver support
In-Reply-To: <1433839690-5491-1-git-send-email-appanad@xilinx.com>
References: <1433839690-5491-1-git-send-email-appanad@xilinx.com>
Message-ID: <20150622101527.GB19530@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 02:18:10PM +0530, Kedareswara rao Appana wrote:

pls conform to the subsystem naming convention which git log on
subsystem should have told you that it is dmaengine: xxx......

> This is the driver for the AXI Central Direct Memory Access (AXI
> CDMA) core, which is a soft Xilinx IP core that provides high-bandwidth
> Direct Memory Access (DMA) between a memory-mapped source address and a
> memory-mapped destination address.
> 
> This module works on Zynq (ARM Based SoC) and Microblaze platforms.
> 
> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> This patch is rebased on the commit
> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
why a random, unrelated commit? and no mention of tree..

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
and why are you doing this ?

> +int xilinx_cdma_channel_set_config(struct dma_chan *dchan,
> +					struct xilinx_cdma_config *cfg)
> +{
> +	struct xilinx_cdma_chan *chan = to_xilinx_chan(dchan);
> +	u32 reg = cdma_read(chan, XILINX_CDMA_CONTROL_OFFSET);
> +
> +	if (!xilinx_cdma_is_idle(chan))
> +		return -EBUSY;
Why cant it be like dma_slave_config and take effect on next descriptor
prepare?

> +
> +	if (cfg->reset)
> +		return xilinx_cdma_chan_reset(chan);
Why do you want to reset this externally, that sounds bad to me

> +
> +	if (cfg->coalesc <= XILINX_CDMA_COALESCE_MAX) {
> +		reg &= ~XILINX_CDMA_XR_COALESCE_MASK;
> +		reg |= cfg->coalesc << XILINX_CDMA_COALESCE_SHIFT;
> +	}
Can you explain what coalesc means here?

> +
> +	if (cfg->delay <= XILINX_CDMA_DELAY_MAX) {
> +		reg &= ~XILINX_CDMA_XR_DELAY_MASK;
> +		reg |= cfg->delay << XILINX_CDMA_DELAY_SHIFT;
> +	}
> +
> +	cdma_write(chan, XILINX_CDMA_CONTROL_OFFSET, reg);
Shouldn't you save it apply for a descriptor?
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(xilinx_cdma_channel_set_config);
not EXPORT_SYMBOL_GPL?


> +static int xilinx_cdma_chan_probe(struct xilinx_cdma_device *xdev,
> +					struct device_node *node)
> +{
> +	struct xilinx_cdma_chan *chan;
> +	bool has_dre;
> +	u32 value, width;
> +	int err;
> +
> +	/* Alloc channel */
> +	chan = devm_kzalloc(xdev->dev, sizeof(*chan), GFP_NOWAIT);
Why do you use GFP_NOWAIT in probe?

-- 
~Vinod
