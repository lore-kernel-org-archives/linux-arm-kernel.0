From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 16 Jul 2015 18:05:48 +0530
Subject: [PATCH v3 2/2] dma: Add Xilinx zynqmp dma engine driver support
In-Reply-To: <1434422083-8653-2-git-send-email-punnaia@xilinx.com>
References: <1434422083-8653-1-git-send-email-punnaia@xilinx.com>
 <1434422083-8653-2-git-send-email-punnaia@xilinx.com>
Message-ID: <20150716123548.GO5086@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 08:04:43AM +0530, Punnaiah Choudary Kalluri wrote:
> +/* Register Offsets */
> +#define ISR				0x100
> +#define IMR				0x104
> +#define IER				0x108
> +#define IDS				0x10C
> +#define CTRL0				0x110
> +#define CTRL1				0x114
> +#define STATUS				0x11C
> +#define DATA_ATTR			0x120
> +#define DSCR_ATTR			0x124
> +#define SRC_DSCR_WRD0			0x128
> +#define SRC_DSCR_WRD1			0x12C
> +#define SRC_DSCR_WRD2			0x130
> +#define SRC_DSCR_WRD3			0x134
> +#define DST_DSCR_WRD0			0x138
> +#define DST_DSCR_WRD1			0x13C
> +#define DST_DSCR_WRD2			0x140
> +#define DST_DSCR_WRD3			0x144
> +#define SRC_START_LSB			0x158
> +#define SRC_START_MSB			0x15C
> +#define DST_START_LSB			0x160
> +#define DST_START_MSB			0x164
> +#define TOTAL_BYTE			0x188
> +#define RATE_CTRL			0x18C
> +#define IRQ_SRC_ACCT			0x190
> +#define IRQ_DST_ACCT			0x194
> +#define CTRL2				0x200
Can you namespace these and other defines

> +struct zynqmp_dma_chan {
> +	struct zynqmp_dma_device *xdev;
xdev seems an odd name, i suspect copy paste error!

> +	void __iomem *regs;
> +	spinlock_t lock;
> +	struct list_head pending_list;
> +	struct list_head free_list;
> +	struct list_head active_list;
> +	struct zynqmp_dma_desc_sw *sw_desc_pool;
> +	struct list_head done_list;
> +	struct dma_chan common;
> +	void *desc_pool_v;
> +	dma_addr_t desc_pool_p;
why two pools and one void *?

> +/**
> + * zynqmp_dma_alloc_chan_resources - Allocate channel resources
> + * @dchan: DMA channel
> + *
> + * Return: '0' on success and failure value on error
wrong, its number of descriptors which maybe 0

> + */
> +static int zynqmp_dma_alloc_chan_resources(struct dma_chan *dchan)
> +{
> +	struct zynqmp_dma_chan *chan = to_chan(dchan);
> +	struct zynqmp_dma_desc_sw *desc;
> +	int i;
> +
> +	chan->sw_desc_pool = kzalloc(sizeof(*desc) * ZYNQMP_DMA_NUM_DESCS,
> +				     GFP_KERNEL);
and you are allocating the number so pls return that

Btw is ZYNQMP_DMA_NUM_DESCS sw or HW limit

> +static void zynqmp_dma_start_transfer(struct zynqmp_dma_chan *chan)
> +{
> +	struct zynqmp_dma_desc_sw *desc;
> +
> +	if (!zynqmp_dma_chan_is_idle(chan))
> +		return;
> +
> +	desc = list_first_entry_or_null(&chan->pending_list,
> +					struct zynqmp_dma_desc_sw, node);
> +	if (!desc)
> +		return;
> +
> +	if (chan->has_sg)
> +		list_splice_tail_init(&chan->pending_list, &chan->active_list);
> +	else
> +		list_move_tail(&desc->node, &chan->active_list);
> +
> +	if (chan->has_sg)
> +		zynqmp_dma_update_desc_to_ctrlr(chan, desc);
> +	else
> +		zynqmp_dma_config_simple_desc(chan, desc->src, desc->dst,
> +					      desc->len);
> +	zynqmp_dma_start(chan);
> +}
Lots of the list management will get simplified if you use the vchan to do
so

> +
> +
> +/**
> + * zynqmp_dma_chan_desc_cleanup - Cleanup the completed descriptors
> + * @chan: ZynqMP DMA channel
> + */
> +static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
> +{
> +	struct zynqmp_dma_desc_sw *desc, *next;
> +
> +	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
> +		dma_async_tx_callback callback;
> +		void *callback_param;
> +
> +		list_del(&desc->node);
> +
> +		callback = desc->async_tx.callback;
> +		callback_param = desc->async_tx.callback_param;
> +		if (callback)
> +			callback(callback_param);
> +
and you are calling the callback with lock held and user can do further
submissions so this is wrong!

> +static enum dma_status zynqmp_dma_tx_status(struct dma_chan *dchan,
> +				      dma_cookie_t cookie,
> +				      struct dma_tx_state *txstate)
> +{
> +	return dma_cookie_status(dchan, cookie, txstate);

no residue calculation?

> +static struct dma_async_tx_descriptor *zynqmp_dma_prep_memcpy(
> +				struct dma_chan *dchan, dma_addr_t dma_dst,
> +				dma_addr_t dma_src, size_t len, ulong flags)
> +{
> +	struct zynqmp_dma_chan *chan;
> +	struct zynqmp_dma_desc_sw *new, *first = NULL;
> +	void *desc = NULL, *prev = NULL;
> +	size_t copy;
> +	u32 desc_cnt;
> +
> +	chan = to_chan(dchan);
> +
> +	if ((len > ZYNQMP_DMA_MAX_TRANS_LEN) && !chan->has_sg)
why sg?

> +static int zynqmp_dma_remove(struct platform_device *pdev)
> +{
> +	struct zynqmp_dma_device *xdev = platform_get_drvdata(pdev);
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&xdev->common);
> +
> +	zynqmp_dma_chan_remove(xdev->chan);
Please free up irq here explictly and also ensure tasklet is not running

-- 
~Vinod
