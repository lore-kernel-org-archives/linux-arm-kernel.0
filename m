From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Jun 2013 16:10:36 +0530
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130621104036.GF23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 12:54:32PM +0800, Zhangfei Gao wrote:
> Add dmaengine driver for hisilicon k3 platform based on virt_dma
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Kai Yang <jean.yangkai@huawei.com>
> ---
[snip]

> +#define to_k3_dma(dmadev) container_of(dmadev, struct k3_dma_dev, slave)
> +
> +static struct k3_dma_chan *to_k3_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct k3_dma_chan, vc.chan);
> +}
> +
> +static void terminate_chan(struct k3_dma_phy *phy, struct k3_dma_dev *d)
namespace pls
> +{
> +	u32 val = 0;
> +
> +	val = readl_relaxed(phy->base + CX_CONFIG);
> +	val &= ~CCFG_EN;
> +	writel_relaxed(val, phy->base + CX_CONFIG);
> +
> +	val = 0x1 << phy->idx;
> +	writel_relaxed(val, d->base + INT_TC1_RAW);
> +	writel_relaxed(val, d->base + INT_ERR1_RAW);
> +	writel_relaxed(val, d->base + INT_ERR2_RAW);
> +}
> +
> +static void set_desc(struct k3_dma_phy *phy, struct k3_desc_hw *hw)
namespace pls
> +{
> +	writel_relaxed(hw->lli, phy->base + CX_LLI);
> +	writel_relaxed(hw->count, phy->base + CX_CNT);
> +	writel_relaxed(hw->saddr, phy->base + CX_SRC);
> +	writel_relaxed(hw->daddr, phy->base + CX_DST);
> +	writel_relaxed(hw->config, phy->base + CX_CONFIG);
> +}
> +
> +static u32 get_curr_cnt(struct k3_dma_dev *d, struct k3_dma_phy *phy)
ditto
> +{
> +	u32 cnt = 0;
> +
> +	cnt = readl_relaxed(d->base + CX_CUR_CNT + phy->idx * 0x10);
> +	cnt &= 0xffff;
> +	return cnt;
> +}
> +
> +static u32 get_curr_lli(struct k3_dma_phy *phy)
> +{
> +	return readl_relaxed(phy->base + CX_LLI);
> +}
> +
> +static u32 get_chan_stat(struct k3_dma_dev *d)
> +{
> +	return readl_relaxed(d->base + CH_STAT);
> +}
> +
> +static void trigger_dma(struct k3_dma_dev *d, bool on)
ditto
> +{
> +	if (on) {
> +		/* set same priority */
> +		writel_relaxed(0x0, d->base + CH_PRI);
> +
> +		/* unmask irq */
> +		writel_relaxed(0xffff, d->base + INT_TC1_MASK);
> +		writel_relaxed(0xffff, d->base + INT_ERR1_MASK);
> +		writel_relaxed(0xffff, d->base + INT_ERR2_MASK);
> +	} else {
> +		/* mask irq */
> +		writel_relaxed(0x0, d->base + INT_TC1_MASK);
> +		writel_relaxed(0x0, d->base + INT_ERR1_MASK);
> +		writel_relaxed(0x0, d->base + INT_ERR2_MASK);
> +	}
> +}
> +
> +static irqreturn_t k3_dma_int_handler(int irq, void *dev_id)
> +{
> +	struct k3_dma_dev *d = (struct k3_dma_dev *)dev_id;
> +	struct k3_dma_phy *p;
> +	u32 stat = readl_relaxed(d->base + INT_STAT);
> +	u32 tc1  = readl_relaxed(d->base + INT_TC1);
> +	u32 err1 = readl_relaxed(d->base + INT_ERR1);
> +	u32 err2 = readl_relaxed(d->base + INT_ERR2);
> +	u32 i, irq_chan = 0;
> +
> +	while (stat) {
> +		i = __ffs(stat);
> +		stat &= (stat - 1);
> +		if (likely(tc1 & BIT(i))) {
> +			p = &d->phy[i];
> +			p->ds_done = p->ds_run;
> +			vchan_cookie_complete(&p->ds_run->vd);
> +			irq_chan |= BIT(i);
> +		}
> +		if (unlikely((err1 & BIT(i)) || (err2 & BIT(i))))
> +			dev_warn(d->slave.dev, "DMA ERR\n");
> +	}
> +
> +	writel_relaxed(irq_chan, d->base + INT_TC1_RAW);
> +	writel_relaxed(err1, d->base + INT_ERR1_RAW);
> +	writel_relaxed(err2, d->base + INT_ERR2_RAW);
> +
> +	if (irq_chan) {
> +		tasklet_schedule(&d->task);
> +		return IRQ_HANDLED;
> +	} else
> +		return IRQ_NONE;
> +}
> +
> +static int k3_dma_start_txd(struct k3_dma_chan *c)
> +{
> +	struct k3_dma_dev *d = to_k3_dma(c->vc.chan.device);
> +	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
> +
> +	if (BIT(c->phy->idx) & get_chan_stat(d))
> +		return -EAGAIN;
> +
> +	if (vd) {
> +		struct k3_dma_desc_sw *ds =
> +			container_of(vd, struct k3_dma_desc_sw, vd);
> +		/*
> +		 * fetch and remove request from vc->desc_issued
> +		 * so vc->desc_issued only contains desc pending
> +		 */
> +		list_del(&ds->vd.node);
> +		c->phy->ds_run = ds;
> +		c->phy->ds_done = NULL;
> +		/* start dma */
> +		set_desc(c->phy, &ds->desc_hw[0]);
> +		return 0;
> +	}
> +	c->phy->ds_done = NULL;
> +	c->phy->ds_run = NULL;
> +	return -EAGAIN;
> +}
> +
> +static void k3_dma_tasklet(unsigned long arg)
> +{
> +	struct k3_dma_dev *d = (struct k3_dma_dev *)arg;
> +	struct k3_dma_phy *p;
> +	struct k3_dma_chan *c;
> +	unsigned pch, pch_alloc = 0;
> +
> +	dev_dbg(d->slave.dev, "tasklet enter\n");
> +
> +	/* check new dma request of running channel in vc->desc_issued */
> +	list_for_each_entry(c, &d->slave.channels, vc.chan.device_node) {
this should use _safe, you might be adding a new txn while executing this

> +		spin_lock_irq(&c->vc.lock);
> +		p = c->phy;
> +		if (p && p->ds_done) {
> +			if (k3_dma_start_txd(c)) {
> +				/* No current txd associated with this channel */
> +				dev_dbg(d->slave.dev, "pchan %u: free\n", p->idx);
> +				/* Mark this channel free */
> +				c->phy = NULL;
> +				p->vchan = NULL;
> +			}
> +		}
> +		spin_unlock_irq(&c->vc.lock);
> +	}
> +
> +	/* check new channel request in d->chan_pending */
> +	spin_lock_irq(&d->lock);
> +	for (pch = 0; pch < NR_PHY_CHAN; pch++) {
> +		p = &d->phy[pch];
> +
> +		if (p->vchan == NULL && !list_empty(&d->chan_pending)) {
> +			c = list_first_entry(&d->chan_pending,
> +				struct k3_dma_chan, node);
> +			/* remove from d->chan_pending */
> +			list_del_init(&c->node);
> +
> +			pch_alloc |= 1 << pch;
> +
> +			/* Mark this channel allocated */
> +			p->vchan = c;
> +			dev_dbg(d->slave.dev, "pchan %u: alloc vchan %p\n", pch, &c->vc);
> +		}
> +	}
> +	spin_unlock_irq(&d->lock);
> +
> +	for (pch = 0; pch < NR_PHY_CHAN; pch++) {
> +		if (pch_alloc & (1 << pch)) {
> +			p = &d->phy[pch];
> +			c = p->vchan;
> +			spin_lock_irq(&c->vc.lock);
> +			c->phy = p;
> +			k3_dma_start_txd(c);
> +			spin_unlock_irq(&c->vc.lock);
> +		}
> +	}
> +
> +	dev_dbg(d->slave.dev, "tasklet exit\n");
> +}
> +
> +static int k3_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	return 0;
> +}
> +
> +static void k3_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct k3_dma_chan *c = to_k3_chan(chan);
> +	struct k3_dma_dev *d = to_k3_dma(chan->device);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&d->lock, flags);
> +	list_del_init(&c->node);
> +	spin_unlock_irqrestore(&d->lock, flags);
> +
> +	vchan_free_chan_resources(&c->vc);
> +	c->ccfg = 0;
> +}
> +
> +static enum dma_status k3_dma_tx_status(struct dma_chan *chan,
> +	dma_cookie_t cookie, struct dma_tx_state *state)
> +{
> +	struct k3_dma_chan *c = to_k3_chan(chan);
> +	struct k3_dma_dev *d = to_k3_dma(chan->device);
> +	struct k3_dma_phy *p;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +	enum dma_status ret;
> +	size_t bytes = 0;
> +
> +	ret = dma_cookie_status(&c->vc.chan, cookie, state);
> +	if (ret == DMA_SUCCESS)
> +		return ret;
> +
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	p = c->phy;
> +
> +	/*
> +	 * If the cookie is on our issue queue, then the residue is
> +	 * its total size.
> +	 */
> +	vd = vchan_find_desc(&c->vc, cookie);
> +	if (vd) {
> +		bytes = container_of(vd, struct k3_dma_desc_sw, vd)->size;
> +	} else if ((!p) || (!p->ds_run)) {
> +		bytes = 0;
> +	} else {
> +		struct k3_dma_desc_sw *ds = p->ds_run;
> +		u32 clli = 0, index = 0;
> +
> +		bytes = get_curr_cnt(d, p);
> +		clli = get_curr_lli(p);
> +		index = (clli - ds->desc_hw_lli) / sizeof(struct k3_desc_hw);
> +		for (; index < LLI_MAX_NUM; index++) {
> +			bytes += ds->desc_hw[index].count;
> +			/* end of lli */
> +			if (!ds->desc_hw[index].lli)
> +				break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&c->vc.lock, flags);
> +	dma_set_residue(state, bytes);
> +	return ret;
> +}
> +
> +static void k3_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct k3_dma_chan *c = to_k3_chan(chan);
> +	struct k3_dma_dev *d = to_k3_dma(chan->device);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	/* add request to vc->desc_issued */
> +	if (vchan_issue_pending(&c->vc)) {
> +		if (!c->phy) {
> +			spin_lock(&d->lock);
> +			if (list_empty(&c->node)) {
> +				/* if new channel, add chan_pending */
> +				list_add_tail(&c->node, &d->chan_pending);
> +				/* check in tasklet */
> +				tasklet_schedule(&d->task);
> +				dev_dbg(d->slave.dev, "vchan %p: issued\n", &c->vc);
> +			}
> +			spin_unlock(&d->lock);
> +		}
> +	} else
> +		dev_dbg(d->slave.dev, "vchan %p: nothing to issue\n", &c->vc);
> +	spin_unlock_irqrestore(&c->vc.lock, flags);
> +}
> +
> +static void k3_fill_desc(struct k3_dma_desc_sw *ds, dma_addr_t dst,
> +			dma_addr_t src, size_t len, u32 num, u32 ccfg)
> +{
> +	BUG_ON(num >= LLI_MAX_NUM);
> +
> +	ds->desc_hw[num].lli = ds->desc_hw_lli + (num + 1) *
> +		sizeof(struct k3_desc_hw);
> +	ds->desc_hw[num].lli |= CX_LLI_CHAIN_EN;
> +	ds->desc_hw[num].count = len;
> +	ds->desc_hw[num].saddr = src;
> +	ds->desc_hw[num].daddr = dst;
> +	ds->desc_hw[num].config = ccfg;
> +}
> +
> +static struct dma_async_tx_descriptor *k3_dma_prep_memcpy(
> +	struct dma_chan *chan,	dma_addr_t dst, dma_addr_t src,
> +	size_t len, unsigned long flags)
> +{
> +	struct k3_dma_chan *c = to_k3_chan(chan);
> +	struct k3_dma_dev *d = to_k3_dma(chan->device);
> +	struct k3_dma_desc_sw *ds;
> +	size_t copy = 0;
> +	int num_desc = 0;
> +
> +	if (!len)
> +		return NULL;
> +
> +	ds = kzalloc(sizeof(struct k3_dma_desc_sw), GFP_NOWAIT);
sizeof (* ds) would be a better approach
> +	if (!ds) {
> +		dev_dbg(chan->device->dev, "vchan %p: kzalloc fail\n", &c->vc);
> +		return NULL;
> +	}
> +
> +	ds->desc_hw = dma_pool_alloc(d->pool, GFP_NOWAIT, &ds->desc_hw_lli);
> +	if (!ds->desc_hw) {
> +		kfree(ds);
> +		dev_dbg(chan->device->dev, "vchan %p: poolalloc fail\n", &c->vc);
> +		return NULL;
> +	}
> +	ds->size = len;
> +
> +	if (!c->ccfg) {
> +		/* default is memtomem, without calling device_control */
> +		c->ccfg = CCFG_SRCINCR | CCFG_DSTINCR | CCFG_EN;
> +		c->ccfg |= (0xf << 20) | (0xf << 24);	/* burst = 16 */
> +		c->ccfg |= (0x3 << 12) | (0x3 << 16);	/* width = 64 bit */
> +	}
> +
> +	do {
> +		copy = min_t(size_t, len, DMA_MAX_SIZE);
> +		k3_fill_desc(ds, dst, src, copy, num_desc++, c->ccfg);
> +
> +		if (c->dir == DMA_MEM_TO_DEV) {
> +			src += copy;
> +		} else if (c->dir == DMA_DEV_TO_MEM) {
> +			dst += copy;
> +		} else {
> +			src += copy;
> +			dst += copy;
> +		}
> +		len -= copy;
> +	} while (len);
> +
> +	/* end of link */
> +	ds->desc_hw[num_desc-1].lli = 0;
> +	return vchan_tx_prep(&c->vc, &ds->vd, flags);
> +}
> +
> +static struct dma_async_tx_descriptor *k3_dma_prep_slave_sg(
> +	struct dma_chan *chan, struct scatterlist *sgl, unsigned int sglen,
> +	enum dma_transfer_direction dir, unsigned long flags, void *context)
> +{
> +	struct k3_dma_chan *c = to_k3_chan(chan);
> +	struct k3_dma_dev *d = to_k3_dma(chan->device);
> +	struct k3_dma_desc_sw *ds;
> +	size_t len, avail, total = 0;
> +	struct scatterlist *sg;
> +	dma_addr_t addr, src = 0, dst = 0;
> +	int num_desc = 0, i;
> +
> +	if (sgl == 0)
> +		return NULL;
> +
> +	ds = kzalloc(sizeof(struct k3_dma_desc_sw), GFP_NOWAIT);
ditto
> +	if (!ds) {
> +		dev_dbg(chan->device->dev, "vchan %p: kzalloc fail\n", &c->vc);
> +		return NULL;
> +	}
> +
> +	ds->desc_hw = dma_pool_alloc(d->pool, GFP_NOWAIT, &ds->desc_hw_lli);
> +	if (!ds->desc_hw) {
> +		kfree(ds);
> +		dev_dbg(chan->device->dev, "vchan %p: poolalloc fail\n", &c->vc);
> +		return NULL;
> +	}
> +
> +	for_each_sg(sgl, sg, sglen, i) {
> +		addr = sg_dma_address(sg);
> +		avail = sg_dma_len(sg);
> +		total += avail;
> +
> +		do {
> +			len = min_t(size_t, avail, DMA_MAX_SIZE);
> +
> +			if (dir == DMA_MEM_TO_DEV) {
> +				src = addr;
> +				dst = c->dev_addr;
> +			} else if (dir == DMA_DEV_TO_MEM) {
> +				src = c->dev_addr;
> +				dst = addr;
> +			}
> +
> +			k3_fill_desc(ds, dst, src, len, num_desc++, c->ccfg);
> +
> +			addr += len;
> +			avail -= len;
> +		} while (avail);
> +	}
> +
> +	/* end of link */
> +	ds->desc_hw[num_desc-1].lli = 0;
> +	ds->size = total;
> +	return vchan_tx_prep(&c->vc, &ds->vd, flags);
> +}
> +
> +static int k3_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +	unsigned long arg)
> +{
> +	struct k3_dma_chan *c = to_k3_chan(chan);
> +	struct k3_dma_dev *d = to_k3_dma(chan->device);
> +	struct dma_slave_config *cfg = (void *)arg;
> +	struct k3_dma_phy *p = NULL;
> +	unsigned long flags;
> +	u32 maxburst = 0, val = 0;
> +	enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +	LIST_HEAD(head);
> +
> +	switch (cmd) {
> +	case DMA_SLAVE_CONFIG:
> +		if (cfg == NULL)
> +			return -EINVAL;
> +		c->dir = cfg->direction;
> +		if (c->dir == DMA_DEV_TO_MEM) {
> +			c->ccfg = CCFG_DSTINCR;
> +			c->dev_addr = cfg->src_addr;
> +			maxburst = cfg->src_maxburst;
> +			width = cfg->src_addr_width;
> +		} else if (c->dir == DMA_MEM_TO_DEV) {
> +			c->ccfg = CCFG_SRCINCR;
> +			c->dev_addr = cfg->dst_addr;
> +			maxburst = cfg->dst_maxburst;
> +			width = cfg->dst_addr_width;
> +		}
looks like this could use some empty line above
> +
> +		if (width == DMA_SLAVE_BUSWIDTH_1_BYTE)
> +			val = 0;
> +		else if (width == DMA_SLAVE_BUSWIDTH_2_BYTES)
> +			val = 1;
> +		else if (width == DMA_SLAVE_BUSWIDTH_4_BYTES)
> +			val = 2;
> +		else if (width == DMA_SLAVE_BUSWIDTH_8_BYTES)
> +			val = 3;
and perhpas a switch case here or better a get_width macro

> +		c->ccfg |= (val << 12) | (val << 16);
> +
> +		if ((maxburst == 0) || (maxburst > 16))
> +			val = 16;
> +		else
> +			val = maxburst - 1;
> +		c->ccfg |= (val << 20) | (val << 24);
> +		c->ccfg |= CCFG_MEM2PER | CCFG_EN;
> +
> +		/* specific request line */
> +		c->ccfg |= c->vc.chan.chan_id << 4;
> +		break;
> +
> +	case DMA_TERMINATE_ALL:
> +		dev_dbg(d->slave.dev, "vchan %p: terminate all\n", &c->vc);
> +		/* Clear the tx descriptor lists */
> +		spin_lock_irqsave(&c->vc.lock, flags);
> +		vchan_get_all_descriptors(&c->vc, &head);
> +		if (c)
> +			p = c->phy;
> +		if (p) {
> +			/* vchan is assigned to a pchan - stop the channel */
> +			terminate_chan(p, d);
> +			c->phy = NULL;
> +			p->vchan = NULL;
> +			p->ds_run = p->ds_done = NULL;
> +			tasklet_schedule(&d->task);
> +		}
> +		spin_unlock_irqrestore(&c->vc.lock, flags);
> +		vchan_dma_desc_free_list(&c->vc, &head);
> +		break;
> +	default:
> +		return -ENXIO;
> +	}
> +	return 0;
> +}
> +
> +static void k3_dma_free_desc(struct virt_dma_desc *vd)
> +{
> +	struct k3_dma_desc_sw *ds =
> +		container_of(vd, struct k3_dma_desc_sw, vd);
> +	struct k3_dma_chan *c = to_k3_chan(vd->tx.chan);
> +	struct k3_dma_dev *d = to_k3_dma(c->vc.chan.device);
> +
> +	if (ds->desc_hw)
> +		dma_pool_free(d->pool, ds->desc_hw, ds->desc_hw_lli);
> +
> +	kfree(ds);
> +}
> +
> +static struct of_device_id k3_pdma_dt_ids[] = {
> +	{ .compatible = "hisilicon,k3-dma-1.0", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
> +
> +static struct of_dma_filter_info k3_dma_filter;
> +static bool k3_dma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	return  (*(int *)param == chan->chan_id);
> +}
> +
> +static int k3_dma_probe(struct platform_device *op)
> +{
> +	struct k3_dma_dev *d;
> +	const struct of_device_id *of_id;
> +	struct resource *iores;
> +	int i, ret, irq = 0;
> +	int dma_channels = 0;
> +
> +	iores = platform_get_resource(op, IORESOURCE_MEM, 0);
> +	if (!iores)
> +		return -EINVAL;
> +
> +	d = devm_kzalloc(&op->dev, sizeof(*d), GFP_KERNEL);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	d->base = devm_request_and_ioremap(&op->dev, iores);
> +	if (!d->base)
> +		return -EADDRNOTAVAIL;
> +
> +	of_id = of_match_device(k3_pdma_dt_ids, &op->dev);
> +	if (of_id)
> +		of_property_read_u32((&op->dev)->of_node,
> +				"dma-channels", &dma_channels);
> +
> +	d->clk = devm_clk_get(&op->dev, NULL);
> +	if (IS_ERR(d->clk)) {
> +		dev_err(&op->dev, "no dma clk\n");
> +		return PTR_ERR(d->clk);
> +	}
> +
> +	irq = platform_get_irq(op, 0);
> +	ret = devm_request_irq(&op->dev, irq,
> +			k3_dma_int_handler, IRQF_DISABLED, DRIVER_NAME, d);
> +	if (ret)
> +		return ret;
> +
> +	/* init phy channel */
> +	for (i = 0; i < NR_PHY_CHAN; i++) {
> +		struct k3_dma_phy *p = &d->phy[i];
> +
> +		p->idx = i;
> +		p->base = d->base + i * 0x40;
> +	}
> +
> +	INIT_LIST_HEAD(&d->slave.channels);
> +	dma_cap_set(DMA_SLAVE, d->slave.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, d->slave.cap_mask);
> +	dma_cap_set(DMA_SLAVE, d->slave.cap_mask);
DMA_SLAVE set twice?

> +	d->slave.dev = &op->dev;
> +	d->slave.device_alloc_chan_resources = k3_dma_alloc_chan_resources;
> +	d->slave.device_free_chan_resources = k3_dma_free_chan_resources;
> +	d->slave.device_tx_status = k3_dma_tx_status;
> +	d->slave.device_prep_dma_memcpy = k3_dma_prep_memcpy;
> +	d->slave.device_prep_slave_sg = k3_dma_prep_slave_sg;
> +	d->slave.device_issue_pending = k3_dma_issue_pending;
> +	d->slave.device_control = k3_dma_control;
> +	d->slave.copy_align = DMA_ALIGN;
> +	d->slave.chancnt = dma_channels;
> +
> +	/* init virtual channel */
> +	for (i = 0; i < dma_channels; i++) {
> +		struct k3_dma_chan *c;
> +
> +		c = devm_kzalloc(&op->dev,
> +				sizeof(struct k3_dma_chan), GFP_KERNEL);
> +		if (c == NULL)
> +			return -ENOMEM;
> +
> +		INIT_LIST_HEAD(&c->node);
> +		c->vc.desc_free = k3_dma_free_desc;
> +		vchan_init(&c->vc, &d->slave);
> +	}
> +
> +	/* Enable clock before accessing registers */
> +	ret = clk_prepare_enable(d->clk);
> +	if (ret < 0) {
> +		dev_err(&op->dev, "clk_prepare_enable failed: %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	trigger_dma(d, true);
is this turning on dma, if so why at probe?
> +
> +	/* A DMA memory pool for LLIs */
> +	d->pool = dma_pool_create(DRIVER_NAME, &op->dev,
> +			LLI_SIZE, __alignof__(struct k3_desc_hw), 0);
> +	if (!d->pool)
> +		return -ENOMEM;
> +
> +	ret = dma_async_device_register(&d->slave);
> +	if (ret)
> +		goto of_dma_register_fail;
> +
> +	k3_dma_filter.dma_cap = d->slave.cap_mask;
> +	k3_dma_filter.filter_fn = k3_dma_filter_fn;
> +	ret = of_dma_controller_register((&op->dev)->of_node, of_dma_simple_xlate, &k3_dma_filter);
> +	if (ret)
> +		goto dma_async_regitster_fail;
> +
> +	spin_lock_init(&d->lock);
> +	INIT_LIST_HEAD(&d->chan_pending);
> +	tasklet_init(&d->task, k3_dma_tasklet, (unsigned long)d);
> +	platform_set_drvdata(op, d);
> +	dev_info(&op->dev, "initialized\n");
> +
> +	return 0;
> +
> +of_dma_register_fail:
> +	dma_async_device_unregister(&d->slave);
> +dma_async_regitster_fail:
> +	dma_pool_destroy(d->pool);
> +	return ret;
> +}
> +
> +static int k3_dma_remove(struct platform_device *op)
> +{
> +	struct k3_dma_chan *c, *cn;
> +	struct k3_dma_dev *d = platform_get_drvdata(op);
> +
> +	dma_async_device_unregister(&d->slave);
> +	of_dma_controller_free((&op->dev)->of_node);
> +
> +	list_for_each_entry_safe(c, cn, &d->slave.channels, vc.chan.device_node) {
> +		list_del(&c->vc.chan.device_node);
> +		tasklet_kill(&c->vc.task);
> +	}
> +	tasklet_kill(&d->task);
> +	dma_pool_destroy(d->pool);
> +	clk_disable_unprepare(d->clk);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
PM_SLEEP?

> +static int k3_dma_suspend(struct device *dev)
> +{
> +	struct k3_dma_dev *d = dev_get_drvdata(dev);
> +	u32 stat = 0;
> +
> +	stat = get_chan_stat(d);
> +	if (stat) {
> +		dev_warn(d->slave.dev,
> +			"chan %d is running fail to suspend\n", stat);
> +		return -1;
> +	}
> +	trigger_dma(d, false);
> +	clk_disable_unprepare(d->clk);
> +	return 0;
> +}
> +
> +static int k3_dma_resume(struct device *dev)
> +{
> +	struct k3_dma_dev *d = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = clk_prepare_enable(d->clk);
> +	if (ret < 0) {
> +		dev_err(d->slave.dev, "clk_prepare_enable failed: %d\n", ret);
> +		return -EINVAL;
> +	}
> +	trigger_dma(d, true);
> +	return 0;
> +}
> +#else
> +#define k3_dma_suspend NULL
> +#define k3_dma_resume NULL
> +#endif
you can use SET_SYSTEM_SLEEP_PM_OPS macro instead

> +
> +static const struct dev_pm_ops k3_dma_pm_ops = {
> +	.suspend = k3_dma_suspend,
> +	.resume = k3_dma_resume,
> +};
> +
> +static struct platform_driver k3_pdma_driver = {
> +	.driver		= {
> +		.name	= DRIVER_NAME,
> +		.owner  = THIS_MODULE,
> +		.pm	= &k3_dma_pm_ops,
> +		.of_match_table = k3_pdma_dt_ids,
> +	},
> +	.probe		= k3_dma_probe,
> +	.remove		= k3_dma_remove,
> +};
> +
> +module_platform_driver(k3_pdma_driver);
> +
> +MODULE_DESCRIPTION("Hisilicon k3 DMA Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5
> 

-- 
~Vinod
