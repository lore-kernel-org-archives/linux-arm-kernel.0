From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Feb 2014 11:36:14 +0100
Subject: [PATCH 4/5] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <1393327695.28803.25.camel@smile.fi.intel.com>
References: <1393258967-4843-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393258967-4843-5-git-send-email-maxime.ripard@free-electrons.com>
 <1393327695.28803.25.camel@smile.fi.intel.com>
Message-ID: <20140228103614.GM607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Tue, Feb 25, 2014 at 01:28:15PM +0200, Andy Shevchenko wrote:
> > +static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
> > +{
> > +	struct sun6i_dma_dev *sdev = (struct sun6i_dma_dev *)dev_id;
> > +	struct sun6i_vchan *vchan;
> > +	struct sun6i_pchan *pchan;
> > +	int i, j, ret = 0;
> > +	u32 status;
> > +
> > +	for (i = 0; i < 2; i++) {
> > +		status = readl(sdev->base + DMA_IRQ_STAT(i));
> > +		if (!status) {
> > +			ret |= IRQ_NONE;
> 
> Maybe move this to definition block.
> 
> > +			continue;
> > +		}
> > +
> > +		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
> > +			i ? "high" : "low", status);
> > +
> > +		writel(status, sdev->base + DMA_IRQ_STAT(i));
> > +
> > +		for (j = 0; (j < 8) && status; j++) {
> > +			if (status & DMA_IRQ_QUEUE) {
> > +				pchan = sdev->pchans + j;
> > +				vchan = pchan->vchan;
> > +
> > +				if (vchan) {
> > +					unsigned long flags;
> > +
> > +					spin_lock_irqsave(&vchan->vc.lock,
> > +							  flags);
> > +					vchan_cookie_complete(&pchan->desc->vd);
> > +					pchan->done = pchan->desc;
> > +					spin_unlock_irqrestore(&vchan->vc.lock,
> > +							       flags);
> > +				}
> > +			}
> > +
> > +			status = status >> 4;
> > +		}
> > +
> > +		ret |= IRQ_HANDLED;
> 
> In case one is handled, another is not, what you have to do?

The interrupt status is split across two registers. In the case where
one of the two register reports an interrupt, we still have to handle
our interrupt, we actually did, so we have to return IRQ_HANDLED.

[ ... ]

> > +static int sun6i_dma_probe(struct platform_device *pdev)
> > +{
> > +	struct sun6i_dma_dev *sdc;
> > +	struct resource *res;
> > +	int irq;
> > +	int ret, i;
> > +
> > +	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
> > +	if (!sdc)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	sdc->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(sdc->base))
> > +		return PTR_ERR(sdc->base);
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	ret = devm_request_irq(&pdev->dev, irq, sun6i_dma_interrupt, 0,
> > +			       dev_name(&pdev->dev), sdc);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Cannot request IRQ\n");
> > +		return ret;
> > +	}
> > +
> > +	sdc->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(sdc->clk)) {
> > +		dev_err(&pdev->dev, "No clock specified\n");
> > +		return PTR_ERR(sdc->clk);
> > +	}
> > +
> > +	sdc->rstc = devm_reset_control_get(&pdev->dev, NULL);
> > +	if (IS_ERR(sdc->rstc)) {
> > +		dev_err(&pdev->dev, "No reset controller specified\n");
> > +		return PTR_ERR(sdc->rstc);
> > +	}
> > +
> > +	sdc->pool = dma_pool_create(dev_name(&pdev->dev), &pdev->dev,
> > +					sizeof(struct sun6i_dma_lli), 4, 0);
> 
> dmam_pool_create()

Aaah. I looked for a devm_dma_pool_create, but I missed this one.

> 
> > +	if (!sdc->pool) {
> > +		dev_err(&pdev->dev, "No memory for descriptors dma pool\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, sdc);
> > +	INIT_LIST_HEAD(&sdc->pending);
> > +	spin_lock_init(&sdc->lock);
> > +
> > +	dma_cap_set(DMA_PRIVATE, sdc->slave.cap_mask);
> > +	dma_cap_set(DMA_MEMCPY, sdc->slave.cap_mask);
> > +	dma_cap_set(DMA_SLAVE, sdc->slave.cap_mask);
> > +
> > +	INIT_LIST_HEAD(&sdc->slave.channels);
> > +	sdc->slave.device_alloc_chan_resources	= sun6i_dma_alloc_chan_resources;
> > +	sdc->slave.device_free_chan_resources	= sun6i_dma_free_chan_resources;
> > +	sdc->slave.device_tx_status		= sun6i_dma_tx_status;
> > +	sdc->slave.device_issue_pending		= sun6i_dma_issue_pending;
> > +	sdc->slave.device_prep_slave_sg		= sun6i_dma_prep_slave_sg;
> > +	sdc->slave.device_prep_dma_memcpy	= sun6i_dma_prep_dma_memcpy;
> > +	sdc->slave.device_control		= sun6i_dma_control;
> > +	sdc->slave.chancnt			= NR_MAX_VCHANS;
> > +
> > +	sdc->slave.dev = &pdev->dev;
> > +
> > +	sdc->pchans = devm_kzalloc(&pdev->dev,
> > +				   NR_MAX_CHANNELS * sizeof(struct sun6i_pchan),
> > +				   GFP_KERNEL);
> > +	if (!sdc->pchans) {
> > +		ret = -ENOMEM;
> > +		goto err_dma_pool_destroy;
> > +	}
> > +
> > +	sdc->vchans = devm_kzalloc(&pdev->dev,
> > +				   NR_MAX_VCHANS * sizeof(struct sun6i_vchan),
> > +				   GFP_KERNEL);
> > +	if (!sdc->vchans) {
> > +		ret = -ENOMEM;
> > +		goto err_dma_pool_destroy;
> > +	}
> > +
> > +	tasklet_init(&sdc->task, sun6i_dma_tasklet, (unsigned long)sdc);
> > +
> > +	for (i = 0; i < NR_MAX_CHANNELS; i++) {
> > +		struct sun6i_pchan *pchan = &sdc->pchans[i];
> > +
> > +		pchan->idx = i;
> > +		pchan->base = sdc->base + 0x100 + i * 0x40;
> > +	}
> > +
> > +	for (i = 0; i < NR_MAX_VCHANS; i++) {
> > +		struct sun6i_vchan *vchan = &sdc->vchans[i];
> > +
> > +		INIT_LIST_HEAD(&vchan->node);
> > +		vchan->vc.desc_free = sun6i_dma_free_desc;
> > +		vchan_init(&vchan->vc, &sdc->slave);
> > +	}
> > +
> > +	reset_control_deassert(sdc->rstc);
> > +
> > +	clk_prepare_enable(sdc->clk);
> 
> Would you like to check an return code here?

Yep, right.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/e8fe33d8/attachment.sig>
