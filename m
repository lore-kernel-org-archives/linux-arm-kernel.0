From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 28 Jul 2014 17:54:31 +0200
Subject: [PATCH v3 1/2] dma: at_xdmac: creation of the atmel eXtended DMA
 Controller driver
In-Reply-To: <20140725071631.GH8181@intel.com>
References: <1404825096-15724-1-git-send-email-ludovic.desroches@atmel.com>
 <1404825096-15724-2-git-send-email-ludovic.desroches@atmel.com>
 <20140725071631.GH8181@intel.com>
Message-ID: <20140728155431.GV2349@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vinod,

Thanks for your review,

On Fri, Jul 25, 2014 at 12:46:31PM +0530, Vinod Koul wrote:
> On Tue, Jul 08, 2014 at 03:11:35PM +0200, Ludovic Desroches wrote:
> > New atmel DMA controller known as XDMAC, introduced with SAMA5D4
> > devices.
> Didnt check, but how much is delta b/w X/H Dmacs?

If you are wondering if we can have only one driver for both DMA
controller, I don't think so. At the moment you won't find documentation
about this controller since the device is not yet released.

The content of the register has changed, the way irq is managed has
changed too.

> 
> > +/* Call with lock hold. */
> > +static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
> > +				struct at_xdmac_desc *first)
> > +{
> > +	struct at_xdmac	*atxdmac = to_at_xdmac(atchan->chan.device);
> > +	u32		reg;
> > +
> > +	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, first);
> > +
> > +	if (at_xdmac_chan_is_enabled(atchan)) {
> > +		dev_err(chan2dev(&atchan->chan),
> > +			"BUG: Attempted to start a non-idle channel\n");
> This shouldnt be BUG though. Your tasklet is always supposed to start and if
> nothing to silent just return!
> 

Ok, I'll remove this error message.

> 
> > +
> > +static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
> > +{
> > +	struct at_xdmac_desc	*desc = txd_to_at_desc(tx);
> > +	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(tx->chan);
> > +	dma_cookie_t		cookie;
> > +	unsigned long		flags;
> > +
> > +	spin_lock_irqsave(&atchan->lock, flags);
> > +	cookie = dma_cookie_assign(tx);
> > +
> > +	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
> > +		 __func__, atchan, desc);
> > +	list_add_tail(&desc->xfer_node, &atchan->xfers_list);
> > +	if (list_is_singular(&atchan->xfers_list))
> > +		at_xdmac_start_xfer(atchan, desc);
> so you dont start if list has more than 1 descriptors, why?
> 

Because I will let at_xdmac_advance_work managing the queue if not
empty. So the only moment when I have to start the transfer in tx_submit
is when I have only one transfer in the queue.

> > +
> > +	spin_unlock_irqrestore(&atchan->lock, flags);
> > +	return cookie;
> > +}
> > +
> > +static struct at_xdmac_desc *at_xdmac_alloc_desc(struct dma_chan *chan,
> > +						 gfp_t gfp_flags)
> why do we need last argument?
> 

No specific reason, I can remove it and use GFP_NOWAIT directly.

> > +{
> > +	struct at_xdmac_desc	*desc;
> > +	struct at_xdmac		*atxdmac = to_at_xdmac(chan->device);
> > +	dma_addr_t		phys;
> > +
> > +	desc = dma_pool_alloc(atxdmac->at_xdmac_desc_pool, gfp_flags, &phys);
> > +	if (desc) {
> > +		memset(desc, 0, sizeof(*desc));
> > +		INIT_LIST_HEAD(&desc->descs_list);
> > +		dma_async_tx_descriptor_init(&desc->tx_dma_desc, chan);
> > +		desc->tx_dma_desc.tx_submit = at_xdmac_tx_submit;
> > +		desc->tx_dma_desc.phys = phys;
> > +	}
> > +
> > +	return desc;
> > +}
> > +
> > +/* Call must be protected by lock. */
> > +static struct at_xdmac_desc *at_xdmac_get_desc(struct at_xdmac_chan *atchan)
> > +{
> > +	struct at_xdmac_desc *desc;
> > +
> > +	if (list_empty(&atchan->free_descs_list)) {
> > +		desc = at_xdmac_alloc_desc(&atchan->chan, GFP_ATOMIC);
> GFP_NOWAIT pls
> 

Ok

> > +static struct dma_async_tx_descriptor *
> > +at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> > +			 size_t len, unsigned long flags)
> > +{
> > +	struct at_xdmac_chan 	*atchan = to_at_xdmac_chan(chan);
> > +	struct at_xdmac_desc	*first = NULL, *prev = NULL;
> > +	size_t			remaining_size = len, xfer_size = 0, ublen;
> > +	dma_addr_t		src_addr = src, dst_addr = dest;
> > +	u32			dwidth;
> > +	/*
> > +	 * WARNING: The channel configuration is set here since there is no
> > +	 * dmaengine_slave_config call in this case. Moreover we don't know the
> > +	 * direction, it involves we can't dynamically set the source and dest
> > +	 * interface so we have to use the same one. Only interface 0 allows EBI
> > +	 * access. Hopefully we can access DDR through both ports (at least on
> > +	 * SAMA5D4x), so we can use the same interface for source and dest,
> > +	 * that solves the fact we don't know the direction.
> and why do you need slave config for memcpy?
> 

Maybe the comments is not clear. With slave config we have the direction
per to mem or mem to per. Of course when doing memcpy we don't need this
information. But I use this information not only to set the transfer
direction but also to set the interfaces to use for the source and dest
(these interfaces depend on the connection on the matrix).
So slave config was useful due to direction field  to tell which interface
to use as source and which one as dest.
I am lucky because NAND and DDR are on the same interfaces so it's not a
problem.

This comment is more a warning for myself to keep in mind this possible 
issue in order to not have a device with NAND and DDR on different
interfaces because it will be difficult to tell which interface is the
source and which one is the dest.

> > +static enum dma_status
> > +at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> > +		struct dma_tx_state *txstate)
> > +{
> > +	struct at_xdmac_chan 	*atchan = to_at_xdmac_chan(chan);
> > +	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
> > +	struct at_xdmac_desc	*desc, *_desc;
> > +	unsigned long		flags;
> > +	enum dma_status		ret;
> > +	int			residue;
> > +	u32			cur_nda;
> > +
> > +	ret = dma_cookie_status(chan, cookie, txstate);
> > +	if (ret == DMA_COMPLETE)
> > +		return ret;
> > +
> > +	spin_lock_irqsave(&atchan->lock, flags);
> > +
> > +	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc, xfer_node);
> > +
> > +	if (!desc->active_xfer)
> > +		dev_err(chan2dev(chan),
> > +			"something goes wrong, there is no active transfer\n");
> We can query resiude even when tx_submit hasnt been invoked. You need to
> return the full length in that case.

Ok, I was not aware about this case.

> > +
> > +	residue = desc->xfer_size;
> 
> Also do check if txsate is NULL, in case just bail out here.

Return value will be the one returned by dma_cookie_status?

> 
> > +
> > +	/* Flush FIFO. */
> > +	at_xdmac_write(atxdmac, AT_XDMAC_GSWF, atchan->mask);
> > +	while (!(at_xdmac_chan_read(atchan, AT_XDMAC_CIS) & AT_XDMAC_CIS_FIS));
> > +		cpu_relax();
> > +
> > +	cur_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
> > +	/*
> > +	 * Remove size of all microblocks already transferred and the current
> > +	 * one. Then add the remaining size to transfer of the current
> > +	 * microblock.
> > +	 */
> > +	list_for_each_entry_safe(desc, _desc, &desc->descs_list, desc_node) {
> > +		residue -= (desc->lld.mbr_ubc & 0xffffff) << atchan->dwidth;
> > +		if ((desc->lld.mbr_nda & 0xfffffffc) == cur_nda)
> > +			break;
> > +	}
> > +	residue += at_xdmac_chan_read(atchan, AT_XDMAC_CUBC) << atchan->dwidth;
> > +
> > +	spin_unlock_irqrestore(&atchan->lock, flags);
> > +
> > +	dma_set_residue(txstate, residue);
> > +
> > +	dev_dbg(chan2dev(chan),
> > +		 "%s: desc=0x%p, tx_dma_desc.phys=0x%08x, tx_status=%d, cookie=%d, residue=%d\n",
> > +		 __func__, desc, desc->tx_dma_desc.phys, ret, cookie, residue);
> > +
> > +	return ret;
> > +}
> > +
> > +static void at_xdmac_terminate_xfer(struct at_xdmac_chan *atchan,
> > +				    struct at_xdmac_desc *desc)
> > +{
> > +	dev_dbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
> > +
> > +	/*
> > +	 * It's necessary to remove the transfer before calling the callback
> > +	 * because some devices can call dma_engine_terminate_all causing to do
> > +	 * dma_cookie_complete two times on the same cookie.
> why would terminate call dma_cookie_complete?
> 

This comment should be remove. It was a comment from the first draft I
did, I have forgotten to remove it. At that time I was calling
dma_cookie_complete here.

> > +	 */
> > +	list_del(&desc->xfer_node);
> > +	list_splice_init(&desc->descs_list, &atchan->free_descs_list);
> shouldnt you move all the desc in active list in one shot ?
> 

Sorry I don't get it. What are you suggesting by one shot?

> > +static void at_xdmac_tasklet(unsigned long data)
> > +{
> > +	struct at_xdmac_chan	*atchan = (struct at_xdmac_chan *)data;
> > +	struct at_xdmac_desc	*desc;
> > +	u32			error_mask;
> > +
> > +	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08lx\n",
> > +		 __func__, atchan->status);
> > +
> > +	error_mask = AT_XDMAC_CIS_RBEIS
> > +		     | AT_XDMAC_CIS_WBEIS
> > +		     | AT_XDMAC_CIS_ROIS;
> > +
> > +	if (at_xdmac_chan_is_cyclic(atchan)) {
> > +		at_xdmac_handle_cyclic(atchan);
> > +	} else if ((atchan->status & AT_XDMAC_CIS_LIS)
> > +		   || (atchan->status & error_mask)) {
> > +		struct dma_async_tx_descriptor  *txd;
> > +
> > +		if (atchan->status & AT_XDMAC_CIS_RBEIS)
> > +			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
> > +		else if (atchan->status & AT_XDMAC_CIS_WBEIS)
> > +			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
> > +		else if (atchan->status & AT_XDMAC_CIS_ROIS)
> > +			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
> > +
> > +		desc = list_first_entry(&atchan->xfers_list,
> > +					struct at_xdmac_desc,
> > +					xfer_node);
> > +		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
> > +		BUG_ON(!desc->active_xfer);
> > +
> > +		txd = &desc->tx_dma_desc;
> > +
> > +		at_xdmac_terminate_xfer(atchan, desc);
> why terminate here? This looks wrong

Why? What do you have in mind? It is not obvious for me that it is the
wrong place.

> 
> > +static int at_xdmac_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> > +			    unsigned long arg)
> > +{
> > +	struct at_xdmac_desc	*desc, *_desc;
> > +	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
> > +	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
> > +	unsigned long		flags;
> > +	int			ret = 0;
> > +
> > +	dev_dbg(chan2dev(chan), "%s: cmd=%d\n", __func__, cmd);
> > +
> > +	spin_lock_irqsave(&atchan->lock, flags);
> > +
> > +	switch (cmd) {
> > +	case DMA_PAUSE:
> > +		at_xdmac_write(atxdmac, AT_XDMAC_GRWS, atchan->mask);
> > +		set_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
> > +		break;
> empty line here pls
>

Ok

> > +	case DMA_RESUME:
> > +		if (!at_xdmac_chan_is_paused(atchan))
> > +			break;
> > +
> > +		at_xdmac_write(atxdmac, AT_XDMAC_GRWR, atchan->mask);
> > +		clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
> > +		break;
> > +	case DMA_TERMINATE_ALL:
> > +		at_xdmac_write(atxdmac, AT_XDMAC_GIE, atchan->mask);
> > +		at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
> > +		while (at_xdmac_read(atxdmac, AT_XDMAC_GS) & atchan->mask)
> > +			cpu_relax();
> > +
> > +		/* Cancel all pending transfers. */
> > +		list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node)
> > +			at_xdmac_terminate_xfer(atchan, desc);
> > +
> > +		clear_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
> > +		break;
> > +	case DMA_SLAVE_CONFIG:
> > +		ret = at_xdmac_set_slave_config(chan,
> > +				(struct dma_slave_config *)arg);
> > +		break;
> > +	default:
> > +		dev_err(chan2dev(chan),
> > +			"unmanaged or unknown dma control cmd: %d\n", cmd);
> > +		ret = -ENXIO;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&atchan->lock, flags);
> > +
> > +	return ret;
> > +}
> 
> > +static int atmel_xdmac_resume_noirq(struct device *dev)
> > +{
> > +	struct platform_device	*pdev = to_platform_device(dev);
> > +	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
> > +	struct at_xdmac_chan	*atchan;
> > +	struct dma_chan		*chan, *_chan;
> > +	int			i;
> > +
> > +	clk_prepare_enable(atxdmac->clk);
> > +
> > +	/* Clear pending interrupts. */
> > +	for (i = 0; i < atxdmac->dma.chancnt; i++) {
> > +		atchan = &atxdmac->chan[i];
> > +		while (at_xdmac_chan_read(atchan, AT_XDMAC_CIS))
> > +			cpu_relax();
> > +	}
> > +
> > +	at_xdmac_write(atxdmac, AT_XDMAC_GIE, atxdmac->save_gim);
> > +	at_xdmac_write(atxdmac, AT_XDMAC_GE, atxdmac->save_gs);
> > +	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
> > +		atchan = to_at_xdmac_chan(chan);
> > +		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->cfg);
> > +		if (at_xdmac_chan_is_cyclic(atchan)) {
> > +			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
> > +			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
> > +			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
> > +			at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
> > +		}
> > +	}
> > +	return 0;
> > +}
> why noirq variants?

I was wondering which variants should be the one I have to use. Since I
was not sure, I have chosen to do it in the same way as at_hdmac driver.

> 
> > +
> > +static int at_xdmac_probe(struct platform_device *pdev)
> > +{
> > +	struct resource	*res;
> > +	struct at_xdmac	*atxdmac;
> > +	int		irq, size, nr_channels, i, ret;
> > +	void __iomem	*base;
> > +	u32		reg;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -EINVAL;
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	/*
> > +	 * Read number of xdmac channels, read helper function can't be used
> > +	 * since atxdmac is not yet allocated and we need to know the number
> > +	 * of channels to do the allocation.
> > +	 */
> > +	reg = readl_relaxed(base + AT_XDMAC_GTYPE);
> > +	nr_channels = AT_XDMAC_NB_CH(reg);
> > +	if (nr_channels > AT_XDMAC_MAX_CHAN) {
> > +		dev_err(&pdev->dev, "invalid number of channels (%u)\n",
> > +			nr_channels);
> > +		return -EINVAL;
> > +	}
> > +
> > +	size = sizeof(*atxdmac);
> > +	size += nr_channels * sizeof(struct at_xdmac_chan);
> > +	atxdmac = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> devm_kmalloc_array/devm_kcalloc pls

Useful for allocating the channels structures but there is also the
at_xdmac structure.

> 
> > +	if (!atxdmac) {
> > +		dev_err(&pdev->dev, "can't allocate at_xdmac structure\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	atxdmac->regs = base;
> > +	atxdmac->irq = irq;
> > +
> > +	ret = devm_request_irq(&pdev->dev, atxdmac->irq, at_xdmac_interrupt, 0,
> > +			       "at_xdmac", atxdmac);
> and this can invoke your irq handler and you may not be ready. Second this
> cause races with tasklet, so usualy recommednation is to use regular
> request_irq()

You mean it is specific to devm variant, isn't it?

> > +	if (ret) {
> > +		dev_err(&pdev->dev, "can't request irq\n");
> > +		return ret;
> > +	}
> > +
> > +	atxdmac->clk = devm_clk_get(&pdev->dev, "dma_clk");
> > +	if (IS_ERR(atxdmac->clk)) {
> > +		dev_err(&pdev->dev, "can't get dma_clk\n");
> > +		return PTR_ERR(atxdmac->clk);
> > +	}
> > +
> > +	ret = clk_prepare_enable(atxdmac->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "can't prepare or enable clock\n");
> > +		return ret;
> > +	}
> > +
> > +	atxdmac->at_xdmac_desc_pool =
> > +		dmam_pool_create(dev_name(&pdev->dev), &pdev->dev,
> > +				sizeof(struct at_xdmac_desc), 4, 0);
> > +	if (!atxdmac->at_xdmac_desc_pool) {
> > +		dev_err(&pdev->dev, "no memory for descriptors dma pool\n");
> > +		ret = -ENOMEM;
> > +		goto err_clk_disable;
> > +	}
> > +
> > +	dma_cap_set(DMA_CYCLIC, atxdmac->dma.cap_mask);
> > +	dma_cap_set(DMA_MEMCPY, atxdmac->dma.cap_mask);
> > +	dma_cap_set(DMA_SLAVE, atxdmac->dma.cap_mask);
> > +	atxdmac->dma.dev				= &pdev->dev;
> > +	atxdmac->dma.device_alloc_chan_resources	= at_xdmac_alloc_chan_resources;
> > +	atxdmac->dma.device_free_chan_resources		= at_xdmac_free_chan_resources;
> > +	atxdmac->dma.device_tx_status			= at_xdmac_tx_status;
> > +	atxdmac->dma.device_issue_pending		= at_xdmac_issue_pending;
> > +	atxdmac->dma.device_prep_dma_cyclic		= at_xdmac_prep_dma_cyclic;
> > +	atxdmac->dma.device_prep_dma_memcpy		= at_xdmac_prep_dma_memcpy;
> > +	atxdmac->dma.device_prep_slave_sg		= at_xdmac_prep_slave_sg;
> > +	atxdmac->dma.device_control			= at_xdmac_control;
> > +	atxdmac->dma.chancnt				= nr_channels;
> no caps, pls do implement that as you have cyclic dma too

Sorry I don't understand what you mean here.

> > +
> > +	/* Disable all chans and interrupts. */
> > +	at_xdmac_off(atxdmac);
> > +
> > +	/* Init channels. */
> > +	INIT_LIST_HEAD(&atxdmac->dma.channels);
> > +	for (i = 0; i < nr_channels; i++) {
> > +		struct at_xdmac_chan *atchan = &atxdmac->chan[i];
> > +
> > +		atchan->chan.device = &atxdmac->dma;
> > +		list_add_tail(&atchan->chan.device_node,
> > +			      &atxdmac->dma.channels);
> > +
> > +		atchan->ch_regs = at_xdmac_chan_reg_base(atxdmac, i);
> > +		atchan->mask = 1 << i;
> > +
> > +		spin_lock_init(&atchan->lock);
> > +		INIT_LIST_HEAD(&atchan->xfers_list);
> > +		INIT_LIST_HEAD(&atchan->free_descs_list);
> > +		tasklet_init(&atchan->tasklet, at_xdmac_tasklet,
> > +			     (unsigned long)atchan);
> > +
> > +		/* Clear pending interrupts. */
> > +		while (at_xdmac_chan_read(atchan, AT_XDMAC_CIS))
> > +			cpu_relax();
> > +	}
> > +	platform_set_drvdata(pdev, atxdmac);
> > +
> > +	ret = dma_async_device_register(&atxdmac->dma);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "fail to register DMA engine device\n");
> > +		goto err_clk_disable;
> > +	}
> > +
> > +	ret = of_dma_controller_register(pdev->dev.of_node,
> > +					 at_xdmac_xlate, atxdmac);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "could not register of dma controller\n");
> > +		goto err_dma_unregister;
> > +	}
> > +
> > +	dev_info(&pdev->dev, "%d channels, mapped at 0x%p\n",
> > +		 nr_channels, atxdmac->regs);
> > +
> > +	return 0;
> > +
> > +err_dma_unregister:
> > +	dma_async_device_unregister(&atxdmac->dma);
> > +err_clk_disable:
> > +	clk_disable_unprepare(atxdmac->clk);
> > +	return ret;
> > +}
> > +
> > +static int at_xdmac_remove(struct platform_device *pdev)
> > +{
> > +	struct at_xdmac	*atxdmac = (struct at_xdmac*)platform_get_drvdata(pdev);
> > +	int		i;
> > +
> > +	at_xdmac_off(atxdmac);
> > +	of_dma_controller_free(pdev->dev.of_node);
> > +	dma_async_device_unregister(&atxdmac->dma);
> > +	clk_disable_unprepare(atxdmac->clk);
> > +
> > +	synchronize_irq(atxdmac->irq);
> > +
> > +	for (i = 0; i < atxdmac->dma.chancnt; i++) {
> > +		struct at_xdmac_chan *atchan = &atxdmac->chan[i];
> > +
> > +		tasklet_kill(&atchan->tasklet);
> > +		at_xdmac_free_chan_resources(&atchan->chan);
> > +	}
> and you can still get irq!

Why? I thought deactivating irq on device side and calling synchronize
irq will do the stuff. 

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops atmel_xdmac_dev_pm_ops = {
> > +	.prepare	= atmel_xdmac_prepare,
> > +	.suspend_noirq	= atmel_xdmac_suspend_noirq,
> > +	.resume_noirq	= atmel_xdmac_resume_noirq,
> > +};
> no ifdef CONFIG_PM?

I'll add it.

> You might want to make them late_suspend and early_resume to allow
> clients suspending first

Ok, as I told before I was wondering which variant to use. For my
knowledge, it will be the case also with noirq, isn't it? It is called
after suspend_late.

> 
> Thanks
> -- 
> ~Vinod
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
