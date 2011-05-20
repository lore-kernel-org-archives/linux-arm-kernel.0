From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 20 May 2011 18:46:57 +0200 (CEST)
Subject: [PATCH 8/9] dma IPU: rework irq handling
In-Reply-To: <20110520133022.GE10403@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
	<1305878365-827-10-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1105201507250.3078@ionos>
	<20110520133022.GE10403@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1105201823050.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 May 2011, Sascha Hauer wrote:

> On Fri, May 20, 2011 at 03:16:42PM +0200, Thomas Gleixner wrote:
> > On Fri, 20 May 2011, Sascha Hauer wrote:
> > > @@ -354,48 +139,41 @@ static struct irq_chip ipu_irq_chip = {
> > >  /* Install the IRQ handler */
> > >  int __init ipu_irq_attach_irq(struct ipu *ipu, struct platform_device *dev)
> > >  {
> > > -	struct ipu_platform_data *pdata = dev->dev.platform_data;
> > > -	unsigned int irq, irq_base, i;
> > > +	unsigned int irq, irq_base;
> > >  
> > > -	irq_base = pdata->irq_base;
> > > +	irq_base = irq_alloc_descs(-1, 0, IPU_IRQ_NR_BANKS * 32, 0);
> > 
> >   	IPU_NUM_IRQS perhaps ?
> > 
> > > +	if (irq_base < 0)
> > > +		return irq_base;
> >   
> > So this allocates 160 interrupts. How many of them are actually going
> > to be used ?
> 
> One for the framebuffer and another one for the camera...
> 
> BTW often enough it's the same for the gpio interrupts. I have plenty of
> boards ending up with a single gpio interrupt out of 160 used for a
> external network controller.

We could actually be more clever about that by doing:

   irq_prealloc_irqs(from, cnt, setup_callback);

Which would return you the base nr of a linear range and at
request_irq() time we would detect the missing irq descriptor,
allocate it and call the setup_callback, which would fill in chip,
handler, data etc. That would make the few lines of init code for the
descriptor non __init, but we could avoid allocating 159 irq
descriptors for nothing.

The demux interrupt could still call generic_handle_irq() as we have a
sanity in place there now and a return value to let the demux irq know
that shite happened.

Thanks,

	tglx
