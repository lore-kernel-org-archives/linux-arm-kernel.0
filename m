From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 17:51:55 +0000
Subject: [PATCHv5] dmaengine: Add support for BCM2835
In-Reply-To: <1384537403.14845.131.camel@smile>
References: <52864BBC.7000506@koalo.de> <1384537403.14845.131.camel@smile>
Message-ID: <20131115175155.GQ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 05:43:45PM +0000, Shevchenko, Andriy wrote:
> On Fri, 2013-11-15 at 17:28 +0100, Florian Meier wrote:
> > +static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
> > +{
> > +	unsigned i;
> > +	size_t size;
> 
> size = 0 here is better.

See my other comment to Joe.

> > +	for (size = i = 0; i < d->frames; i++) {
> > +		struct bcm2835_dma_cb *control_block =
> > +			&d->control_block_base[i];
> > +		size_t this_size = control_block->length;
> > +		dma_addr_t dma;
> > +
> > +		if (d->dir == DMA_DEV_TO_MEM)
> > +			dma = control_block->dst;
> > +		else
> > +			dma = control_block->src;
> 
> Do you think it must be dependent on the direction?

Of course it does.  Take a moment to think about it please.

> Do you have information of how many bytes transferred already in the DMA
> controller registers? Would it be better to use it?
> 
> > +		if (size)
> > +			size += this_size;
> > +		else if (addr >= dma && addr < dma + this_size)
> > +			size += dma + this_size - addr;
> 
> += -> =

No functional change, as 'size' has to be initialised anyway.  The
code is fine.

> > +	if (!pdev->dev.dma_mask)
> > +		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> > +
> > +	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +	if (rc)
> > +		return rc;
> > +	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> 
> There is nice helper you may use instead of those two above and remove
> 'if' condition as well.

There is _now_ but at the time this is being developed, it wasn't there.
Such a change is probably only appropriate at least after -rc1 has
happened.  Since I'm the one who introduced that helper, and I haven't
said to use it yet in this driver, that suggests I've already thought
about this point...

> > +module_platform_driver(bcm2835_dma_driver);
> 
> Is it possible to get driver initialized after that one that uses it?

Doesn't quite make sense.  If you're asking whether other drivers can
try to make use of this driver before it's initialised, then the answer
is no.  We have mechanisms to cope with that - see deferred probing.
