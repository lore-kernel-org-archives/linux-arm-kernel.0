From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 30 May 2017 15:26:48 +0530
Subject: [PATCH v2 2/2] dmaengine: mtk-hsdma: Add Mediatek High-Speed DMA
 controller on MT7623 SoC
In-Reply-To: <b22634b222b10b5c78e3a6b126af95e66cc03630.1495695814.git.sean.wang@mediatek.com>
References: <cover.1495695814.git.sean.wang@mediatek.com>
 <b22634b222b10b5c78e3a6b126af95e66cc03630.1495695814.git.sean.wang@mediatek.com>
Message-ID: <20170530095648.GO15061@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 03:12:49PM +0800, sean.wang at mediatek.com wrote:

> +/* MTK_DMA_SIZE must be 2 of power and 4 for the minimal */
> +#define MTK_DMA_SIZE			256
> +#define MTK_HSDMA_NEXT_DESP_IDX(x, y)	(((x) + 1) & ((y) - 1))
> +#define MTK_HSDMA_PREV_DESP_IDX(x, y)	(((x) - 1) & ((y) - 1))
> +#define MTK_HSDMA_MAX_LEN		0x3f80
> +#define MTK_HSDMA_ALIGN_SIZE		4
> +#define MTK_HSDMA_TIMEOUT		HZ

Why this unused define?

> +struct mtk_hsdma_device {
> +	struct dma_device ddev;
> +	void __iomem *base;
> +	struct clk *clk;
> +	u32 irq;
> +	bool busy;

what do you mean by device busy, its usually a channel which is..

> +static int mtk_hsdma_alloc_pchan(struct mtk_hsdma_device *hsdma,
> +				 struct mtk_hsdma_pchan *pc)
> +{
> +	int i, ret;
> +	struct mtk_hsdma_ring *ring = &pc->ring;
> +
> +	dev_dbg(hsdma2dev(hsdma), "Allocating pchannel\n");
> +
> +	memset(pc, 0, sizeof(*pc));
> +	pc->hsdma = hsdma;
> +	atomic_set(&pc->free_count, MTK_DMA_SIZE - 1);

why do you need atomic variables?

> +static int mtk_hsdma_alloc_chan_resources(struct dma_chan *c)
> +{
> +	struct mtk_hsdma_device *hsdma = to_hsdma_dev(c);
> +	struct mtk_hsdma_vchan  *vc = to_hsdma_vchan(c);
> +	int ret = 0;
> +
> +	if (!atomic_read(&hsdma->pc_refcnt))
> +		ret = mtk_hsdma_alloc_pchan(hsdma, &hsdma->pc);

can you please explain this..?

> +static int mtk_hsdma_consume_one_vdesc(struct mtk_hsdma_pchan *pc,
> +				       struct mtk_hsdma_vdesc *hvd)
> +{
> +	struct mtk_hsdma_device *hsdma = pc->hsdma;
> +	struct mtk_hsdma_ring *ring = &pc->ring;
> +	struct mtk_hsdma_pdesc *txd, *rxd;
> +	u32 i, tlen;
> +	u16 maxfills, prev, old_ptr, handled;
> +
> +	maxfills = min_t(u32, hvd->num_sgs, atomic_read(&pc->free_count));
> +	if (!maxfills)
> +		return -ENOSPC;
> +
> +	hsdma->busy = true;
> +	old_ptr = ring->cur_tptr;
> +	for (i = 0; i < maxfills ; i++) {
> +		tlen = (hvd->len > MTK_HSDMA_MAX_LEN) ?
> +		       MTK_HSDMA_MAX_LEN : hvd->len;
> +		txd = &ring->txd[ring->cur_tptr];
> +		WRITE_ONCE(txd->des1, hvd->src);
> +		WRITE_ONCE(txd->des2,
> +			   MTK_HSDMA_DESC_LS0 | MTK_HSDMA_DESC_PLEN(tlen));
> +		rxd = &ring->rxd[ring->cur_tptr];
> +		WRITE_ONCE(rxd->des1, hvd->dest);
> +		WRITE_ONCE(rxd->des2, MTK_HSDMA_DESC_PLEN(tlen));

interesting usage of WRITE_ONCE, can you explain why it is used?

> +static void mtk_hsdma_schedule(unsigned long data)
> +{
> +	struct mtk_hsdma_device *hsdma = (struct mtk_hsdma_device *)data;
> +	struct mtk_hsdma_vchan *vc;
> +	struct virt_dma_desc *vd;
> +	bool vc_removed;
> +
> +	vc = mtk_hsdma_pick_vchan(hsdma);
> +	if (!vc)
> +		return;
> +
> +	if (!vc->vd_uncompleted) {
> +		spin_lock(&vc->vc.lock);
> +		vd = vchan_next_desc(&vc->vc);
> +		spin_unlock(&vc->vc.lock);
> +	} else {
> +		vd = vc->vd_uncompleted;
> +		atomic_dec(&vc->refcnt);
> +	}
> +
> +	hsdma->vc_uncompleted = 0;
> +	vc->vd_uncompleted = 0;
> +
> +	while (vc && vd) {
> +		spin_lock(&hsdma->lock);
> +		vc_removed = list_empty(&vc->node);
> +		/*
> +		 * Refcnt increases for the indication that one more descriptor
> +		 * is ready for the process if the corresponding channel is
> +		 * active.
> +		 */
> +		if (!vc_removed)
> +			atomic_inc(&vc->refcnt);

okay now I understand a little bit why these are used, but the question is
why.. We can have a simpler implementation using active, pending link lists
like other drivers do.. And since you use virt_dma_chan which already keeps
track of allocated, submitted, issued and completed descriptors not sure why
we need refcount here, can you explain this?


> +static void mtk_hsdma_housekeeping(unsigned long data)

care to explain the purpose of this 'housekeeping' takslet?

> +{
> +	struct mtk_hsdma_device *hsdma = (struct mtk_hsdma_device *)data;
> +	struct mtk_hsdma_vchan *hvc;
> +	struct mtk_hsdma_pchan *pc;
> +	struct mtk_hsdma_pdesc *rxd;
> +	struct mtk_hsdma_cb *cb;
> +	struct virt_dma_chan *vc;
> +	struct virt_dma_desc *vd, *tmp;
> +	u16 next;
> +	u32 status;
> +	LIST_HEAD(comp);
> +
> +	pc = &hsdma->pc;
> +
> +	status = mtk_dma_read(hsdma, MTK_HSDMA_INT_STATUS);
> +	mtk_dma_write(hsdma, MTK_HSDMA_INT_STATUS, status);
> +
> +	while (1) {
> +		next = MTK_HSDMA_NEXT_DESP_IDX(pc->ring.cur_rptr,
> +					       MTK_DMA_SIZE);
> +		rxd = &pc->ring.rxd[next];
> +		cb = &pc->ring.cb[next];
> +
> +		/*
> +		 * If no MTK_HSDMA_DESC_DDONE is specified in rxd->des2, that
> +		 * means 1) the hardware doesn't finish the data moving yet
> +		 * for the corresponding descriptor or 2) the hardware meets
> +		 * the end of data moved.
> +		 */
> +		if (!(rxd->des2 & MTK_HSDMA_DESC_DDONE))
> +			break;
> +
> +		if (IS_VDESC_FINISHED(cb->flags))
> +			list_add_tail(&cb->vd->node, &comp);
> +
> +		WRITE_ONCE(rxd->des1, 0);
> +		WRITE_ONCE(rxd->des2, 0);
> +		cb->flags = 0;
> +		pc->ring.cur_rptr = next;
> +		atomic_inc(&pc->free_count);
> +	}
> +
> +	/*
> +	 * Ensure all changes to all the descriptors in ring space being
> +	 * flushed before we continue.
> +	 */
> +	wmb();
> +	mtk_dma_write(hsdma, MTK_HSDMA_RX_CPU, pc->ring.cur_rptr);
> +	mtk_dma_set(hsdma, MTK_HSDMA_INT_ENABLE, MTK_HSDMA_INT_RXDONE);
> +
> +	list_for_each_entry_safe(vd, tmp, &comp, node) {
> +		vc = to_virt_chan(vd->tx.chan);
> +		spin_lock(&vc->lock);
> +		vchan_cookie_complete(vd);
> +		spin_unlock(&vc->lock);
> +
> +		hvc = to_hsdma_vchan(vd->tx.chan);
> +		atomic_dec(&hvc->refcnt);
> +	}
> +
> +	/*
> +	 * An indication to HSDMA as not busy allows the user context to start
> +	 * the next HSDMA scheduler.
> +	 */
> +	if (atomic_read(&pc->free_count) == MTK_DMA_SIZE - 1)
> +		hsdma->busy = false;
> +
> +	tasklet_schedule(&hsdma->scheduler);

and we schedule another, why?

And this would be on top of virt chan tasklet... your latencies should be
off the charts

> +}
> +
> +static irqreturn_t mtk_hsdma_chan_irq(int irq, void *devid)
> +{
> +	struct mtk_hsdma_device *hsdma = devid;
> +
> +	tasklet_schedule(&hsdma->housekeeping);
> +
> +	/* Interrupt is enabled until the housekeeping tasklet is completed */
> +	mtk_dma_clr(hsdma, MTK_HSDMA_INT_ENABLE,
> +		    MTK_HSDMA_INT_RXDONE);
> +
> +	return IRQ_HANDLED;

this is bad design, we want to complete the current txn and submit new one
here, this is DMAengine and people want it to be done as fast as possible.

> +}
> +
> +static void mtk_hsdma_issue_pending(struct dma_chan *c)
> +{
> +	struct mtk_hsdma_device *hsdma = to_hsdma_dev(c);
> +	struct mtk_hsdma_vchan *vc = to_hsdma_vchan(c);
> +	bool issued;
> +
> +	spin_lock_bh(&vc->vc.lock);
> +	issued = vchan_issue_pending(&vc->vc);
> +	spin_unlock_bh(&vc->vc.lock);
> +
> +	spin_lock_bh(&hsdma->lock);
> +	if (list_empty(&vc->node))
> +		list_add_tail(&vc->node, &hsdma->vc_pending);
> +	spin_unlock_bh(&hsdma->lock);
> +
> +	if (issued && !hsdma->busy)
> +		tasklet_schedule(&hsdma->scheduler);

another tasklet, we are supposed to start the txn _now_

> +static int mtk_dma_remove(struct platform_device *pdev)
> +{
> +	struct mtk_hsdma_device *hsdma = platform_get_drvdata(pdev);
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&hsdma->ddev);
> +
> +	tasklet_kill(&hsdma->scheduler);
> +	tasklet_kill(&hsdma->housekeeping);

you need to kill vc task as well

you still have a dangling irq which can fire tasklets after you have killed
those


-- 
~Vinod
