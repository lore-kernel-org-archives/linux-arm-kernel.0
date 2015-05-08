From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 8 May 2015 12:04:34 +0530
Subject: [PATCH v2 3/5] dmaengine: pxa: add pxa dmaengine driver
In-Reply-To: <1428781236-25806-4-git-send-email-robert.jarzmik@free.fr>
References: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
 <1428781236-25806-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150508063434.GZ3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 09:40:34PM +0200, Robert Jarzmik wrote:
> This is a new driver for pxa SoCs, which is also compatible with the former
> mmp_pdma.
The rationale is fine, is there a plan to remove old mmp_pdma then?

> +config PXA_DMA
> +	bool "PXA DMA support"
no prompt?

> +
> +#define DRCMR(n)	((((n) < 64) ? 0x0100 : 0x1100) + (((n) & 0x3f) << 2))
care to put a comment on this calculation

> +#define DRCMR_MAPVLD	BIT(7)	/* Map Valid (read / write) */
> +#define DRCMR_CHLNUM	0x1f	/* mask for Channel Number (read / write) */
> +
> +#define DDADR_DESCADDR	0xfffffff0	/* Address of next descriptor (mask) */
> +#define DDADR_STOP	BIT(0)	/* Stop (read / write) */
> +
> +#define DCMD_INCSRCADDR	BIT(31)	/* Source Address Increment Setting. */
> +#define DCMD_INCTRGADDR	BIT(30)	/* Target Address Increment Setting. */
> +#define DCMD_FLOWSRC	BIT(29)	/* Flow Control by the source. */
> +#define DCMD_FLOWTRG	BIT(28)	/* Flow Control by the target. */
> +#define DCMD_STARTIRQEN	BIT(22)	/* Start Interrupt Enable */
> +#define DCMD_ENDIRQEN	BIT(21)	/* End Interrupt Enable */
> +#define DCMD_ENDIAN	BIT(18)	/* Device Endian-ness. */
> +#define DCMD_BURST8	(1 << 16)	/* 8 byte burst */
> +#define DCMD_BURST16	(2 << 16)	/* 16 byte burst */
> +#define DCMD_BURST32	(3 << 16)	/* 32 byte burst */
> +#define DCMD_WIDTH1	(1 << 14)	/* 1 byte width */
> +#define DCMD_WIDTH2	(2 << 14)	/* 2 byte width (HalfWord) */
> +#define DCMD_WIDTH4	(3 << 14)	/* 4 byte width (Word) */
> +#define DCMD_LENGTH	0x01fff		/* length mask (max = 8K - 1) */
Please namespace these ...

> +#define tx_to_pxad_desc(tx)					\
> +	container_of(tx, struct pxad_desc_sw, async_tx)
> +#define to_pxad_chan(dchan)					\
> +	container_of(dchan, struct pxad_chan, vc.chan)
> +#define to_pxad_dev(dmadev)					\
> +	container_of(dmadev, struct pxad_device, slave)
> +#define to_pxad_sw_desc(_vd)				\
> +	container_of((_vd), struct pxad_desc_sw, vd)
> +
> +#define pdma_err(pdma, fmt, arg...) \
> +	dev_err(pdma->slave.dev, "%s: " fmt, __func__, ## arg)
> +#define chan_dbg(_chan, fmt, arg...)					\
> +	dev_dbg(&(_chan)->vc.chan.dev->device, "%s(chan=%p): " fmt,	\
> +		__func__, (_chan), ## arg)
> +#define chan_vdbg(_chan, fmt, arg...)					\
> +	dev_vdbg(&(_chan)->vc.chan.dev->device, "%s(chan=%p): " fmt,	\
> +		__func__, (_chan), ## arg)
> +#define chan_warn(_chan, fmt, arg...)					\
> +	dev_warn(&(_chan)->vc.chan.dev->device, "%s(chan=%p): " fmt,	\
> +		 __func__, (_chan), ## arg)
> +#define chan_err(_chan, fmt, arg...)					\
> +	dev_err(&(_chan)->vc.chan.dev->device, "%s(chan=%p): " fmt,	\
> +		__func__, (_chan), ## arg)
am not a big fan of driver specfic debug macros, can we use dev_ ones please

> +
> +#define _phy_readl_relaxed(phy, _reg)					\
> +	readl_relaxed((phy)->base + _reg((phy)->idx))
> +#define phy_readl_relaxed(phy, _reg)					\
> +	({								\
> +		u32 _v;							\
> +		_v = readl_relaxed((phy)->base + _reg((phy)->idx));	\
> +		chan_vdbg(phy->vchan, "readl(%s): 0x%08x\n", #_reg,	\
> +			  _v);						\
> +		_v;							\
> +	})
> +#define phy_writel(phy, val, _reg)					\
> +	do {								\
> +		writel((val), (phy)->base + _reg((phy)->idx));		\
> +		chan_vdbg((phy)->vchan, "writel(0x%08x, %s)\n",		\
> +			  (u32)(val), #_reg);				\
> +	} while (0)
> +#define phy_writel_relaxed(phy, val, _reg)				\
> +	do {								\
> +		writel_relaxed((val), (phy)->base + _reg((phy)->idx));	\
> +		chan_vdbg((phy)->vchan, "writel(0x%08x, %s)\n",		\
> +			  (u32)(val), #_reg);				\
> +	} while (0)
> +
> +/*
??
Does this code compile?

> +
> +static struct pxad_phy *lookup_phy(struct pxad_chan *pchan)
> +{
> +	int prio, i;
> +	struct pxad_device *pdev = to_pxad_dev(pchan->vc.chan.device);
> +	struct pxad_phy *phy, *found = NULL;
> +	unsigned long flags;
> +
> +	/*
> +	 * dma channel priorities
> +	 * ch 0 - 3,  16 - 19  <--> (0)
> +	 * ch 4 - 7,  20 - 23  <--> (1)
> +	 * ch 8 - 11, 24 - 27  <--> (2)
> +	 * ch 12 - 15, 28 - 31  <--> (3)
> +	 */
> +
> +	spin_lock_irqsave(&pdev->phy_lock, flags);
> +	for (prio = pchan->prio; prio >= PXAD_PRIO_HIGHEST; prio--) {
> +		for (i = 0; i < pdev->nr_chans; i++) {
> +			if (prio != (i & 0xf) >> 2)
> +				continue;
> +			phy = &pdev->phys[i];
> +			if (!phy->vchan) {
> +				phy->vchan = pchan;
> +				found = phy;
> +				goto out_unlock;
what does phy have to do with priorty here?

> +static bool pxad_try_hotchain(struct virt_dma_chan *vc,
> +				  struct virt_dma_desc *vd)
> +{
> +	struct virt_dma_desc *vd_last_issued = NULL;
> +	struct pxad_chan *chan = to_pxad_chan(&vc->chan);
> +
> +	/*
> +	 * Attempt to hot chain the tx if the phy is still running. This is
> +	 * considered successful only if either the channel is still running
> +	 * after the chaining, or if the chained transfer is completed after
> +	 * having been hot chained.
> +	 * A change of alignment is not allowed, and forbids hotchaining.
> +	 */
okay, so what if while you are hotchaining the first txn completes, how do
we prevent these sort of races with HW?


> +static struct pxad_desc_sw *
> +pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
> +{
> +	struct pxad_desc_sw *sw_desc;
> +	dma_addr_t dma;
> +	int i;
> +
> +	sw_desc = kzalloc(sizeof(*sw_desc) +
> +			  nb_hw_desc * sizeof(struct pxad_desc_hw *),
> +			  GFP_ATOMIC);
> +	if (!sw_desc) {
> +		chan_err(chan, "Couldn't allocate a sw_desc\n");
this is not required, memory allocator will spew this as well. I think
checkpatch should have warned you..

> +static inline struct dma_async_tx_descriptor *
> +pxad_tx_prep(struct virt_dma_chan *vc, struct virt_dma_desc *vd,
> +		 unsigned long tx_flags)
> +{
> +	struct dma_async_tx_descriptor *tx;
> +
> +	tx = vchan_tx_prep(vc, vd, tx_flags);
> +	tx->tx_submit = pxad_tx_submit;
> +	tx->tx_release = pxad_tx_release;
tx_release?


> +static int pxad_config(struct dma_chan *dchan,
> +		       struct dma_slave_config *cfg)
> +{
> +	struct pxad_chan *chan = to_pxad_chan(dchan);
> +	u32 maxburst = 0, dev_addr = 0;
> +	enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +
> +	if (!dchan)
> +		return -EINVAL;
> +
> +	chan->dir = cfg->direction;
> +	chan->dcmd_base = 0;
> +
> +	if (cfg->direction == DMA_DEV_TO_MEM) {
direction is depricated, please copy the parameters and then use them in
your prep_ based on direction passed


> +static unsigned int pxad_residue(struct pxad_chan *chan,
> +				 dma_cookie_t cookie)
> +{
> +	struct virt_dma_desc *vd = NULL;
> +	struct pxad_desc_sw *sw_desc = NULL;
> +	struct pxad_desc_hw *hw_desc = NULL;
> +	u32 curr, start, len, end, residue = 0;
> +	unsigned long flags;
> +	bool passed = false, prev_completed = true;
> +	int i;
> +
> +	/*
> +	 * If the channel does not have a phy pointer anymore, it has already
> +	 * been completed. Therefore, its residue is 0.
> +	 */
> +	if (!chan->phy)
> +		return 0;
> +
> +	if (chan->dir == DMA_DEV_TO_MEM)
> +		curr = phy_readl_relaxed(chan->phy, DTADR);
> +	else
> +		curr = phy_readl_relaxed(chan->phy, DSADR);
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	list_for_each_entry(vd, &chan->vc.desc_issued, node) {
> +		sw_desc = to_pxad_sw_desc(vd);
> +
> +		if (vd->tx.cookie == cookie && !prev_completed) {
> +			residue = sw_desc->len;
> +			break;
> +		}
> +		prev_completed = is_desc_completed(vd);
why not use vchan_find_desc() ?

> +
> +		if (vd->tx.cookie != cookie)
> +			continue;
> +
> +		for (i = 0; i < sw_desc->nb_desc - 1; i++) {
> +			hw_desc = sw_desc->hw_desc[i];
> +			if (chan->dir == DMA_DEV_TO_MEM)
> +				start = hw_desc->dtadr;
> +			else
> +				start = hw_desc->dsadr;
> +			len = hw_desc->dcmd & DCMD_LENGTH;
> +			end = start + len;
> +
> +			/*
> +			 * 'passed' will be latched once we found the descriptor
> +			 * which lies inside the boundaries of the curr
> +			 * pointer. All descriptors that occur in the list
> +			 * _after_ we found that partially handled descriptor
> +			 * are still to be processed and are hence added to the
> +			 * residual bytes counter.
> +			 */
> +
> +			if (passed) {
> +				residue += len;
> +			} else if (curr >= start && curr <= end) {
> +				residue += end - curr;
> +				passed = true;
> +			}
> +		}
> +
> +		break;
> +	}
> +
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +	chan_dbg(chan, "txd %p[%x] sw_desc=%p: %d\n",
> +		 vd, cookie, sw_desc, residue);
> +	return residue;
> +}
> +
> +static enum dma_status pxad_tx_status(struct dma_chan *dchan,
> +				      dma_cookie_t cookie,
> +				      struct dma_tx_state *txstate)
> +{
> +	struct pxad_chan *chan = to_pxad_chan(dchan);
> +	enum dma_status ret;
> +
> +	ret = dma_cookie_status(dchan, cookie, txstate);
pls check if txstate is valid 

> +	if (likely(ret != DMA_ERROR))
> +		dma_set_residue(txstate, pxad_residue(chan, cookie));
> +
> +	return ret;
> +}
> +
> +static void pxad_free_channels(struct dma_device *dmadev)
> +{
> +	struct pxad_chan *c, *cn;
> +
> +	list_for_each_entry_safe(c, cn, &dmadev->channels,
> +				 vc.chan.device_node) {
> +		list_del(&c->vc.chan.device_node);
> +		tasklet_kill(&c->vc.task);
> +	}
> +}
> +
> +static int pxad_remove(struct platform_device *op)
> +{
> +	struct pxad_device *pdev = platform_get_drvdata(op);
> +
you should free up irq as well, otherwise device can still generate
interrupts

Thanks
-- 
~Vinod
