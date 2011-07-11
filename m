From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jul 2011 18:01:41 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110711164919.GB18871@e102109-lin.cambridge.arm.com>
References: <20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704155835.GA30189@e102109-lin.cambridge.arm.com>
	<20110704195819.GG8286@n2100.arm.linux.org.uk>
	<20110704232019.GK8286@n2100.arm.linux.org.uk>
	<20110706160551.GH32020@e102109-lin.cambridge.arm.com>
	<20110706180814.GL8286@n2100.arm.linux.org.uk>
	<20110711164919.GB18871@e102109-lin.cambridge.arm.com>
Message-ID: <20110711170141.GA8486@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 05:49:20PM +0100, Catalin Marinas wrote:
> On Wed, Jul 06, 2011 at 07:08:14PM +0100, Russell King - ARM Linux wrote:
> > Okay, so I can say with confidence then that how things stand in my tree,
> > which limits BTC invalidation to:
> > 
> > 1. For kernel mappings, flush_icache_range() which must be called prior
> >    to code placed in them being executed.
> > 
> > 2. For user mappings, __sync_icache_dcache's icache flush, which is
> >    called before a non-zero user PTE is inserted.
> 
> What about:
> 
> flush_cache_user_range()
> flush_ptrace_access()
> 
> They are fine as long as you haven't removed the BTC invalidation from
> __cpuc_coherent_(kern|user)_range.

That's the basis of flush_icache_range(), so that still has the BTC
invalidate.

> > The area which needs more to focus some further work is
> > __sync_icache_dcache(), which is fairly over-zealous about all the
> > flushing.
> 
> Another thing that could be optimised is not to clean and invalidate the
> D-cache but only clean to the PoU. The only problem is that
> (flush|invalidate)_kernel_vmap_area, functions that seem to used only in
> a single place. The semantics in cachetlb.txt claim to be used for I/O,
> which means that they are already broken since we don't handle the L2
> cache.

Those are newly introduced to cope with XFS wanting DMA to vmap'd areas
to work.  They're there to handle the vmalloc-space alias of the pages.
The DMA API sorts out the kernel direct-mapped plus L2 for non-virtually
tagged L2 caches.

So they're just an additional pre-flush and post-invalidate calls around
the DMA API to cope with vmalloc space aliases.  So I don't think they're
broken.
