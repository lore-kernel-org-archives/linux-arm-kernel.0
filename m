From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Dec 2009 17:39:22 +0000
Subject: dma_cache_maint_contiguous should be patched asdma_cache_maint do
In-Reply-To: <1260465343.23073.63.camel@pc1117.cambridge.arm.com>
References: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>
	<1260459307.23073.41.camel@pc1117.cambridge.arm.com>
	<20091210163920.GA13210@n2100.arm.linux.org.uk>
	<1260465343.23073.63.camel@pc1117.cambridge.arm.com>
Message-ID: <20091210173922.GB13210@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 05:15:43PM +0000, Catalin Marinas wrote:
> On Thu, 2009-12-10 at 16:39 +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 10, 2009 at 03:35:07PM +0000, Catalin Marinas wrote:
> > > or (2) instead of broadcasting, do a "Read or Write For Ownership"
> > > on the calling CPU before invoking the cache operation. By doing this
> > > the current CPU becomes the owner of the cache lines and it can do cache
> > > maintenance on them. For large buffers, this RFO/WFO is slower than IPI
> > > but in the general case it may be actually quicker.
> > 
> > This is probably the best we can do, and it will make DMA performance
> > suck
> 
> For relatively small buffers, this may be faster than the whole IPI
> procedure but you can't say for sure without benchmarking.

I'm basing that comment on the efficiency of PIO block IO vs DMA block
IO, which are typically multiples of 4K.  Having to read/write the
buffer is equivalent to PIO.  As a comparison for a system with IDE,
for DMA you might get 10MB/s, with PIO maybe 3-4MB/s if you're lucky.

I would be very surprised if going down this route doesn't result in
block IO data performance (and network performance) dropping my more
than 60% of the DMA value (that's DMA performance * 0.4).

> > Let's hope that all ARMv7 SMP implementations broadcast the cache
> > operations.
> 
> They do broadcast both cache operations and TLB maintenance (but for the
> latter we have an issue with global ASID allocation, see my
> corresponding patch). With speculative accesses would actually make this
> impossible if broadcasting isn't done in hardware.

Good - so we could optimize out the MMFR3 tests for ARMv7.

> >   The *only* thing that remains in the way of that
> > is the stupid flush_ioremap_region() crap for just one MTD driver.
> 
> But that calls v6_dma_inv_range() anyway.

Indeed, and will be the _only_ caller of that function.  That's my point.
Why should we have something called "flush_ioremap_region" being the sole
caller of something called "dma_inv_range".
