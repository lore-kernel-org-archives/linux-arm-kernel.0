From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 15:30:22 +0200
Subject: [PATCH 8/9] dma IPU: rework irq handling
In-Reply-To: <alpine.LFD.2.02.1105201507250.3078@ionos>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
	<1305878365-827-10-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1105201507250.3078@ionos>
Message-ID: <20110520133022.GE10403@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 03:16:42PM +0200, Thomas Gleixner wrote:
> On Fri, 20 May 2011, Sascha Hauer wrote:
> > @@ -354,48 +139,41 @@ static struct irq_chip ipu_irq_chip = {
> >  /* Install the IRQ handler */
> >  int __init ipu_irq_attach_irq(struct ipu *ipu, struct platform_device *dev)
> >  {
> > -	struct ipu_platform_data *pdata = dev->dev.platform_data;
> > -	unsigned int irq, irq_base, i;
> > +	unsigned int irq, irq_base;
> >  
> > -	irq_base = pdata->irq_base;
> > +	irq_base = irq_alloc_descs(-1, 0, IPU_IRQ_NR_BANKS * 32, 0);
> 
>   	IPU_NUM_IRQS perhaps ?
> 
> > +	if (irq_base < 0)
> > +		return irq_base;
>   
> So this allocates 160 interrupts. How many of them are actually going
> to be used ?

One for the framebuffer and another one for the camera...

BTW often enough it's the same for the gpio interrupts. I have plenty of
boards ending up with a single gpio interrupt out of 160 used for a
external network controller.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
