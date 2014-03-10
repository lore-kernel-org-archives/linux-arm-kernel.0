From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Mar 2014 17:51:56 +0100
Subject: [PATCH v4 6/7] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <2475487.axlvKsBQ0c@wuerfel>
References: <1394462512-11620-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394462512-11620-7-git-send-email-maxime.ripard@free-electrons.com>
 <2475487.axlvKsBQ0c@wuerfel>
Message-ID: <20140310165156.GI2815@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 10, 2014 at 04:34:04PM +0100, Arnd Bergmann wrote:
> On Monday 10 March 2014 15:41:51 Maxime Ripard wrote:
> 
> > +/*
> > + * Hardware representation of the LLI
> > + *
> > + * The hardware will be fed the physical address of this structure,
> > + * and read its content in order to start the transfer.
> > + */
> > +struct sun6i_dma_lli {
> > +	u32			cfg;
> > +	u32			src;
> > +	u32			dst;
> > +	u32			len;
> > +	u32			para;
> > +	u32			p_lli_next;
> > +	struct sun6i_dma_lli	*v_lli_next;
> > +} __packed;
> 
> It looks strange to have a pointer in a hardware structure, since
> the pointer doesn't make sense to the device.

Actually, it's not used at all by the device itself. It's used only by
the driver to be able to follow that list whenever we need to
free/dump it.

> Also, the '__packed' attribute seems strange. Are you sure
> you want to reduce the alignment from 4 bytes to 1 byte?

What I wanted to make sure is that the structure is actually what I
declared above in memory, but it's true that it's completely useless
here.

> > +static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
> > +{
> > +	struct sun6i_dma_dev *sdev = dev_id;
> > +	struct sun6i_vchan *vchan;
> > +	struct sun6i_pchan *pchan;
> > +	int i, j, ret = IRQ_NONE;
> > +	u32 status;
> > +
> > +	for (i = 0; i < 2; i++) {
> > +		status = readl(sdev->base + DMA_IRQ_STAT(i));
> > +		if (!status)
> > +			continue;
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
> 
> Interrupts are already disabled here.

True.

> > +	sdc->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(sdc->clk)) {
> > +		dev_err(&pdev->dev, "No clock specified\n");
> > +		return PTR_ERR(sdc->clk);
> > +	}
> > +
> > +	mux = devm_clk_get(&pdev->dev, "ahb1_mux");
> > +	if (IS_ERR(mux)) {
> > +		dev_err(&pdev->dev, "Couldn't get AHB1 Mux\n");
> > +		return PTR_ERR(mux);
> > +	}
> > +
> > +	pll6 = devm_clk_get(&pdev->dev, "pll6");
> > +	if (IS_ERR(pll6)) {
> > +		dev_err(&pdev->dev, "Couldn't get PLL6\n");
> > +		return PTR_ERR(pll6);
> > +	}
> > +
> > +	ret = clk_set_parent(mux, pll6);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Couldn't reparent AHB1 on PLL6\n");
> > +		return ret;
> > +	}
> 
> Neither "pll6" nor "ahb1_mux" are listed in the DT binding. Also, why
> is it the driver's business to set the parent?

Those are global clocks, so it's not really part pof the driver
binding itself. But I can add them.

About the reparenting itself, other devices are actually fine having
any parent they want, only the DMA is picky about it (at least, from
what we know), so it made sense to me to put it into the driver
itself. Where would you put it?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/2e057db9/attachment.sig>
