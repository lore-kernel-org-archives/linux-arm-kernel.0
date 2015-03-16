From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 16 Mar 2015 14:57:56 +0530
Subject: [PATCH v7 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 engine driver
In-Reply-To: <1426158921-8987-2-git-send-email-rsahu@apm.com>
References: <1426158921-8987-1-git-send-email-rsahu@apm.com>
 <1426158921-8987-2-git-send-email-rsahu@apm.com>
Message-ID: <20150316092756.GH32683@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 04:45:19PM +0530, Rameshwar Prasad Sahu wrote:
> +/* DMA ring csr registers and bit definations */
> +#define DMA_RING_CONFIG			0x04
> +#define DMA_RING_ENABLE			BIT(31)
> +#define DMA_RING_ID			0x08
> +#define DMA_RING_ID_SETUP(v)		((v) | BIT(31))
> +#define DMA_RING_ID_BUF			0x0C
> +#define DMA_RING_ID_BUF_SETUP(v)	(((v) << 9) | BIT(21))
> +#define DMA_RING_THRESLD0_SET1		0x30
> +#define DMA_RING_THRESLD0_SET1_VAL	0X64
> +#define DMA_RING_THRESLD1_SET1		0x34
> +#define DMA_RING_THRESLD1_SET1_VAL	0xC8
> +#define DMA_RING_HYSTERESIS		0x68
> +#define DMA_RING_HYSTERESIS_VAL		0xFFFFFFFF
> +#define DMA_RING_STATE			0x6C
> +#define DMA_RING_STATE_WR_BASE		0x70
> +#define DMA_RING_NE_INT_MODE		0x017C
> +#define DMA_RING_NE_INT_MODE_SET(m, v)		\
> +	((m) = ((m) & ~BIT(31 - (v))) | BIT(31 - (v)))
> +#define DMA_RING_NE_INT_MODE_RESET(m, v)	\
> +	((m) &= (~BIT(31 - (v))))
> +#define DMA_RING_CLKEN			0xC208
> +#define DMA_RING_SRST			0xC200
> +#define DMA_RING_MEM_RAM_SHUTDOWN	0xD070
> +#define DMA_RING_BLK_MEM_RDY		0xD074
> +#define DMA_RING_BLK_MEM_RDY_VAL	0xFFFFFFFF
> +#define DMA_RING_DESC_CNT(v)		(((v) & 0x0001FFFE) >> 1)
> +#define DMA_RING_ID_GET(owner, num)	(((owner) << 6) | (num))
> +#define DMA_RING_DST_ID(v)		((1 << 10) | (v))
> +#define DMA_RING_CMD_OFFSET		0x2C
> +#define DMA_RING_CMD_BASE_OFFSET(v)	((v) << 6)
> +#define DMA_RING_COHERENT_SET(m)	(((u32 *)(m))[2] |= BIT(4))
> +#define DMA_RING_ADDRL_SET(m, v)	(((u32 *)(m))[2] |= (((v) >> 8) << 5))
> +#define DMA_RING_ADDRH_SET(m, v)	(((u32 *)(m))[3] |= ((v) >> 35))
> +#define DMA_RING_ACCEPTLERR_SET(m)	(((u32 *)(m))[3] |= BIT(19))
> +#define DMA_RING_SIZE_SET(m, v)		(((u32 *)(m))[3] |= ((v) << 23))
> +#define DMA_RING_RECOMBBUF_SET(m)	(((u32 *)(m))[3] |= BIT(27))
> +#define DMA_RING_RECOMTIMEOUTL_SET(m)	(((u32 *)(m))[3] |= (0x7 << 28))
> +#define DMA_RING_RECOMTIMEOUTH_SET(m)	(((u32 *)(m))[4] |= 0x3)
> +#define DMA_RING_SELTHRSH_SET(m)	(((u32 *)(m))[4] |= BIT(3))
> +#define DMA_RING_TYPE_SET(m, v)		(((u32 *)(m))[4] |= ((v) << 19))
These are very generic name as can conflicts, can you please namespace
these...

> +/* DMA device csr registers and bit definitions */
> +#define DMA_IPBRR			0x0
> +#define DMA_DEV_ID_RD(v)		((v) & 0x00000FFF)
> +#define DMA_BUS_ID_RD(v)		(((v) >> 12) & 3)
> +#define DMA_REV_NO_RD(v)		(((v) >> 14) & 3)
> +#define DMA_GCR				0x10
> +#define DMA_CH_SETUP(v)			((v) = ((v) & ~0x000FFFFF) | 0x000AAFFF)
> +#define DMA_ENABLE(v)			((v) |= BIT(31))
> +#define DMA_DISABLE(v)			((v) &= ~BIT(31))
> +#define DMA_RAID6_CONT			0x14
> +#define DMA_RAID6_MULTI_CTRL(v)		((v) << 24)
> +#define DMA_INT				0x70
> +#define DMA_INT_MASK			0x74
> +#define DMA_INT_ALL_MASK		0xFFFFFFFF
> +#define DMA_INT_ALL_UNMASK		0x0
> +#define DMA_INT_MASK_SHIFT		0x14
> +#define DMA_RING_INT0_MASK		0x90A0
> +#define DMA_RING_INT1_MASK		0x90A8
> +#define DMA_RING_INT2_MASK		0x90B0
> +#define DMA_RING_INT3_MASK		0x90B8
> +#define DMA_RING_INT4_MASK		0x90C0
> +#define DMA_CFG_RING_WQ_ASSOC		0x90E0
> +#define DMA_ASSOC_RING_MNGR1		0xFFFFFFFF
> +#define DMA_MEM_RAM_SHUTDOWN		0xD070
> +#define DMA_BLK_MEM_RDY			0xD074
> +#define DMA_BLK_MEM_RDY_VAL		0xFFFFFFFF
same here and throughout the driver..

> +static void xgene_dma_free_descriptor(struct xgene_dma_chan *chan,
> +				      struct xgene_dma_desc_sw *desc)
> +{
> +	list_del(&desc->node);
> +	chan_dbg(chan, "LD %p free\n", desc);
> +	dma_pool_free(chan->desc_pool, desc, desc->tx.phys);
where is the descriptor freed? Perhpas we can say clean rather than free
here to not confuse...

> +}
> +
> +static struct xgene_dma_desc_sw *xgene_dma_alloc_descriptor(
> +				 struct xgene_dma_chan *chan)
> +{
> +	struct xgene_dma_desc_sw *desc;
> +	dma_addr_t phys;
> +
> +	desc = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT, &phys);
> +	if (!desc) {
> +		chan_dbg(chan, "Failed to allocate LDs\n");
not error?

> +static void xgene_dma_free_desc_list_reverse(struct xgene_dma_chan *chan,
> +					     struct list_head *list)
do we really care about free order?

> +{
> +	struct xgene_dma_desc_sw *desc, *_desc;
> +
> +	list_for_each_entry_safe_reverse(desc, _desc, list, node)
> +		xgene_dma_free_descriptor(chan, desc);
> +}
> +
> +static void xgene_dma_free_chan_resources(struct dma_chan *dchan)
> +{
> +	struct xgene_dma_chan *chan = to_dma_chan(dchan);
> +
> +	chan_dbg(chan, "Free all resources\n");
> +
> +	if (!chan->desc_pool)
> +		return;
> +
> +	spin_lock_bh(&chan->lock);
> +
> +	/* Process all running descriptor */
> +	xgene_dma_cleanup_descriptors(chan);
> +
> +	/* Clean all link descriptor queues */
> +	xgene_dma_free_desc_list(chan, &chan->ld_pending);
> +	xgene_dma_free_desc_list(chan, &chan->ld_running);
> +	xgene_dma_free_desc_list(chan, &chan->ld_completed);
> +
> +	spin_unlock_bh(&chan->lock);
> +
> +	/* Delete this channel DMA pool */
> +	dma_pool_destroy(chan->desc_pool);
> +	chan->desc_pool = NULL;
> +}
> +
> +static struct dma_async_tx_descriptor *xgene_dma_prep_memcpy(
> +	struct dma_chan *dchan, dma_addr_t dst, dma_addr_t src,
> +	size_t len, unsigned long flags)
> +{
> +	struct xgene_dma_desc_sw *first = NULL, *new;
> +	struct xgene_dma_chan *chan;
> +	size_t copy;
> +	u32 desc_id;
> +
> +	if (unlikely(!dchan || !len))
> +		return NULL;
> +
> +	chan = to_dma_chan(dchan);
> +
> +	/* Get the id for this group of descriptors */
> +	desc_id = atomic_inc_return(&chan->desc_id);
> +
> +	do {
> +		/* Allocate the link descriptor from DMA pool */
> +		new = xgene_dma_alloc_descriptor(chan);
> +		if (!new)
> +			goto fail;
> +
> +		/* Create the largest transaction possible */
> +		copy = min_t(size_t, len, DMA_MAX_64B_DESC_BYTE_CNT);
> +
> +		/* Prepare DMA descriptor */
> +		xgene_dma_prep_cpy_desc(chan, new, dst, src, copy, desc_id);
> +
> +		if (!first)
> +			first = new;
> +
> +		new->first = first;
> +		first->desc_cnt++;
> +		new->desc_id = desc_id;
> +
> +		new->tx.cookie = 0;
> +		async_tx_ack(&new->tx);
> +
> +		/* Update metadata */
> +		len -= copy;
> +		dst += copy;
> +		src += copy;
> +
> +		/* Insert the link descriptor to the LD ring */
> +		list_add_tail(&new->node, &first->tx_list);
> +	} while (len);
> +
> +	first->tx.flags = flags; /* client is in control of this ack */
> +	first->tx.cookie = -EBUSY;
> +	first->flags |= DMA_FLAG_FIRST_DESC;
> +
> +	return &first->tx;
where are you mapping dma buffers?

> +static enum dma_status xgene_dma_find_tx_desc_status(
> +	struct xgene_dma_chan *chan, dma_cookie_t cookie,
> +	struct dma_tx_state *txstate)
> +{
> +	struct xgene_dma_desc_sw *desc;
> +
> +	spin_lock_bh(&chan->lock);
> +
> +	/* Check if this tx descriptor is still in pending queue */
> +	list_for_each_entry(desc, &chan->ld_pending, node) {
> +		if (desc->tx.cookie == cookie) {
> +			xgene_chan_xfer_ld_pending(chan);
why are you calling this here, status check shouldnt do this...
> +			spin_unlock_bh(&chan->lock);
> +			return DMA_IN_PROGRESS;
residue here is size of transacation.
> +		}
> +	}
> +
> +	/* Check if this descriptor is in running queue */
> +	list_for_each_entry(desc, &chan->ld_running, node) {
> +		if (desc->tx.cookie == cookie) {
> +			/* Cleanup any running and executed descriptors */
> +			xgene_dma_cleanup_descriptors(chan);
ditto?
> +			spin_unlock_bh(&chan->lock);
> +			return dma_cookie_status(&chan->dma_chan,
> +						 cookie, txstate);
and you havent touched txstate so what is the intent here...?
> +		}
> +	}
> +
> +	spin_unlock_bh(&chan->lock);
> +
> +	return DMA_COMPLETE;
> +}
> +
> +static enum dma_status xgene_dma_tx_status(struct dma_chan *dchan,
> +					   dma_cookie_t cookie,
> +					   struct dma_tx_state *txstate)
> +{
> +	struct xgene_dma_chan *chan = to_dma_chan(dchan);
> +
> +	enum dma_status status;
> +
> +	status = dma_cookie_status(dchan, cookie, txstate);
> +	if (status == DMA_COMPLETE)
you should do this if txstate in NULL, no point doing calculations..

> +		return status;
> +
> +	return xgene_dma_find_tx_desc_status(chan, cookie, txstate);
> +}
> +
> +static void xgene_dma_tasklet_cb(unsigned long data)
> +{
> +	struct xgene_dma_chan *chan = (struct xgene_dma_chan *)data;
> +
> +	spin_lock_bh(&chan->lock);
> +
> +	/* Run all cleanup for descriptors which have been completed */
> +	xgene_dma_cleanup_descriptors(chan);
> +
> +	/* Re-enable DMA channel IRQ */
> +	enable_irq(chan->rx_irq);
> +
> +	spin_unlock_bh(&chan->lock);
> +}
> +
> +static irqreturn_t xgene_dma_chan_ring_isr(int irq, void *id)
> +{
> +	struct xgene_dma_chan *chan = (struct xgene_dma_chan *)id;
> +
> +	BUG_ON(!chan);
> +
> +	/*
> +	 * Disable DMA channel IRQ until we process completed
> +	 * descriptors
> +	 */
> +	disable_irq_nosync(chan->rx_irq);
and why is that?

> +
> +	/*
> +	 * Schedule the tasklet to handle all cleanup of the current
> +	 * transaction. It will start a new transaction if there is
> +	 * one pending.
> +	 */
> +	tasklet_schedule(&chan->tasklet);
for better results why not schedule the next transaction here..?
> +
> +	return IRQ_HANDLED;
> +}
> +

> +static void xgene_dma_async_unregister(struct xgene_dma *pdma)
> +{
> +	int i;
> +
> +	for (i = 0; i < DMA_MAX_CHANNEL; i++)
> +		dma_async_device_unregister(&pdma->dma_dev[i]);
how do you ensure irq is disabled and tasklets killed?

> +MODULE_DESCRIPTION("APM X-Gene SoC DMA driver");
> +MODULE_AUTHOR("Rameshwar Prasad Sahu <rsahu@apm.com>");
> +MODULE_AUTHOR("Loc Ho <lho@apm.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0");
why do you need this?
> --
> 1.8.2.1
> 

-- 
