From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 16:41:26 +0000
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <50FCD463.5000006@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com> <50FCD463.5000006@ti.com>
Message-ID: <20130121164125.GU23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 11:08:43AM +0530, Sekhar Nori wrote:
> > +	if (IS_ERR_OR_NULL(r)) {
> > +		dev_err(dev, "platform_get_resource() error: %ld\n",
> > +			PTR_ERR(r));
> > +
> > +		return PTR_ERR(r);

Sigh.  Bug.

> > +	}
> > +	host1cfg_physaddr = (unsigned long)r->start;
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(dev, "platform_get_irq(pdev, 0) error: %d\n", irq);
> > +
> > +		return irq;
> > +	}
> > +
> > +	irq_data = irq_get_irq_data(irq);
> > +	if (IS_ERR_OR_NULL(irq_data)) {
> > +		dev_err(dev, "irq_get_irq_data(%d) error: %ld\n",
> > +			irq, PTR_ERR(irq_data));
> > +
> > +		return PTR_ERR(irq_data);

Bug.

> > +	}
> > +	ack_fxn = irq_data->chip->irq_ack;
> > +
> > +	ret = request_threaded_irq(irq, davinci_rproc_callback, handle_event,
> > +		0, "davinci-remoteproc", drproc);
> > +	if (ret) {
> > +		dev_err(dev, "request_threaded_irq error: %d\n", ret);
> > +
> > +		return ret;
> > +	}
> > +
> > +	syscfg0_base = ioremap(host1cfg_physaddr & PAGE_MASK, SZ_4K);
> > +	host1cfg_offset = offset_in_page(host1cfg_physaddr);
> > +	writel(rproc->bootaddr, syscfg0_base + host1cfg_offset);
> > +
> > +	dsp_clk = clk_get(dev, NULL);
> 
> devm_clk_get() here.
> 
> > +	if (IS_ERR_OR_NULL(dsp_clk)) {
> > +		dev_err(dev, "clk_get error: %ld\n", PTR_ERR(dsp_clk));
> > +		ret = PTR_ERR(dsp_clk);

Bug.

See, yet again... almost every use of IS_ERR_OR_NULL() is a bug.
