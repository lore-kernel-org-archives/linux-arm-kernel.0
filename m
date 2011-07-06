From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 18:31:59 +0200
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <20110706154857.GG8286@n2100.arm.linux.org.uk>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<201107061651.49824.arnd@arndb.de>
	<20110706154857.GG8286@n2100.arm.linux.org.uk>
Message-ID: <201107061831.59739.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Russell King - ARM Linux wrote:
> On Wed, Jul 06, 2011 at 04:51:49PM +0200, Arnd Bergmann wrote:
> > On Wednesday 06 July 2011, Russell King - ARM Linux wrote:
> > 
> > I don't see how. The pages get allocated from an unmapped area
> > or memory, mapped into the kernel address space as uncached or wc
> > and then cleared. This should be the same for lowmem or highmem
> > pages.
> 
> You don't want to clear them via their uncached or WC mapping, but via
> their cached mapping _before_ they get their alternative mapping, and
> flush any cached out of that mapping - both L1 and L2 caches.

But there can't be any other mapping, which is the whole point of
the exercise to use highmem.
Quoting from the new dma_alloc_area() function:

        c = arm_vmregion_alloc(&area->vm, align, size,
                            gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
        if (!c)
                return NULL;
        memset((void *)c->vm_start, 0, size);

area->vm here points to an uncached location, which means that
we already zero the data through the uncached mapping. I don't
see how it's getting worse than it is already.

> > > Another issue is that when a platform has restricted DMA regions,
> > > they typically don't fall into the highmem zone.  As the dmabounce
> > > code allocates from the DMA coherent allocator to provide it with
> > > guaranteed DMA-able memory, that would be rather inconvenient.
> > 
> > True. The dmabounce code would consequently have to allocate
> > the memory through an internal function that avoids the
> > contiguous allocation area and goes straight to ZONE_DMA memory
> > as it does today.
> 
> CMA's whole purpose for existing is to provide _dma-able_ contiguous
> memory for things like cameras and such like found on crippled non-
> scatter-gather hardware.  If that memory is not DMA-able what's the
> point?

I mean not any ZONE_DMA memory, but the memory backing coherent_areas[],
which is by definition DMA-able from any device and is what is currently
being used for the purpose.

	Arnd
