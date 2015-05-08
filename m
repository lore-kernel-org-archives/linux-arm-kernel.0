From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 May 2015 09:54:39 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <554C4FCE.6070802@topic.nl>
References: <5538DD02.6050401@topic.nl>
 <20150507143010.GC2067@n2100.arm.linux.org.uk> <554C4FCE.6070802@topic.nl>
Message-ID: <8321046.lcCOUd7NLp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 May 2015 07:55:26 Mike Looijmans wrote:
> On 07-05-15 16:30, Russell King - ARM Linux wrote:
> > On Thu, May 07, 2015 at 04:08:54PM +0200, Mike Looijmans wrote:
> >> I read the rest of the thread, apparently it was never integrated.
> >>
> >> The patch for "non-consistent" is a BUG FIX, not some feature request or so.
> >> I was already wondering why my driver had to kalloc pages to get proper
> >> caching on it.
> >
> > I disagree.
> >
> >>  From https://www.kernel.org/doc/Documentation/DMA-attributes.txt:
> >> """
> >> DMA_ATTR_NON_CONSISTENT ... lets the platform to choose to return either
> >> consistent or non-consistent memory as it sees fit.  By using this API,
> >> you are guaranteeing to the platform that you have all the correct and
> >> necessary sync points for this memory in the driver.
> >> """
> >
> > DMA attributes are something that came in _after_ the DMA API had been
> > around for many years.  It's a "new feature" that was added to an
> > existing subsystem, and because there have been no need for it to be
> > implemented on ARM, the new feature was never implemented.
> >
> > More than that, the vast majority of ARM hardware can't provide this
> > kind of memory, and there are _no_ kernel APIs to ensure that if
> 
> By "non-coherent" memory I thought it meant the same kind of memory that 
> kalloc would return. But from your answer it seems I am mistaken and 
> this is something different?

It depends: on a device that is actually cache-coherent,
dma_alloc_coherent() and dma_alloc_noncoherent() both return normal
memory.

On some architectures (not ARM) that are not fully coherent,
dma_alloc_coherent() has to return uncached memory, while
dma_alloc_noncoherent() is allowed to return cached memory but
requires a dma_cache_sync() operation.

dma_alloc_attrs() with DMA_ATTR_NON_CONSISTENT is a variant of that,
but I assume the idea is that you use dma_sync_single_fo_{cpu,device}()
on that memory, which can actually work on  ARM, unlike dma_cache_sync().

> > cacheable memory were to be returned, they could issue the necessary
> > cache flushes to ensure that the device could see the data.
> 
> Then what do the dma_sync_... methods do?
> 
> It has been my understanding that one can use dma_map... and dma_sync... 
> methods to make memory ranges visible to the device.

That is correct, but the DMA_ATTR_NON_CONSISTENT flag is not meaningful
with dma_map_...(), as that memory is not assumed to be consistent unless
you call dma_sync_...() to start with.

> Using dma_sync on coherent memory is just a waste of resources. So how 
> do i allocate memory that I'm supposed to use with dma_sync?

The traditional API (before the various attributes is):

dma_alloc_coherent()      --> never requires sync
dma_alloc_writecombine()  --> never requires sync, arch specific
dma_alloc_noncoherent()   --> dma_cache_sync(), arch specific
alloc_pages + dma_map_*() --> dma_sync_*

The dma_alloc_coherent() and dma_sync_*() interfaces are supposed to
determine themselves whether they need to do any cache management
based on whether the device is coherent already or not.

	Arnd
