From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jul 2011 14:09:07 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110711170141.GA8486@n2100.arm.linux.org.uk>
References: <20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704155835.GA30189@e102109-lin.cambridge.arm.com>
	<20110704195819.GG8286@n2100.arm.linux.org.uk>
	<20110704232019.GK8286@n2100.arm.linux.org.uk>
	<20110706160551.GH32020@e102109-lin.cambridge.arm.com>
	<20110706180814.GL8286@n2100.arm.linux.org.uk>
	<20110711164919.GB18871@e102109-lin.cambridge.arm.com>
	<20110711170141.GA8486@n2100.arm.linux.org.uk>
Message-ID: <20110712130907.GE13235@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 06:01:41PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 11, 2011 at 05:49:20PM +0100, Catalin Marinas wrote:
> > On Wed, Jul 06, 2011 at 07:08:14PM +0100, Russell King - ARM Linux wrote:
> > > The area which needs more to focus some further work is
> > > __sync_icache_dcache(), which is fairly over-zealous about all the
> > > flushing.
> > 
> > Another thing that could be optimised is not to clean and invalidate the
> > D-cache but only clean to the PoU. The only problem is that
> > (flush|invalidate)_kernel_vmap_area, functions that seem to used only in
> > a single place. The semantics in cachetlb.txt claim to be used for I/O,
> > which means that they are already broken since we don't handle the L2
> > cache.
> 
> Those are newly introduced to cope with XFS wanting DMA to vmap'd areas
> to work.  They're there to handle the vmalloc-space alias of the pages.
> The DMA API sorts out the kernel direct-mapped plus L2 for non-virtually
> tagged L2 caches.
> 
> So they're just an additional pre-flush and post-invalidate calls around
> the DMA API to cope with vmalloc space aliases.  So I don't think they're
> broken.

OK, so in this case these functions need to go to the point of
coherency. We could also optimise them to do pre-cleaning and
post-invalidation rather than always clean&invalidate.

Can we not use dmac_flush_range() (or dma_clean_range and dma_inv_range
via dmac_(map|unmap)_area) instead of __cpuc_flush_dcache_area?

-- 
Catalin
