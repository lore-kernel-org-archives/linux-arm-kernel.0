From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 May 2015 15:19:46 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <554C7479.3050306@topic.nl>
References: <5538DD02.6050401@topic.nl> <8321046.lcCOUd7NLp@wuerfel>
 <554C7479.3050306@topic.nl>
Message-ID: <2808654.KNfBIY3tVp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 May 2015 10:31:53 Mike Looijmans wrote:
> On 08-05-15 09:54, Arnd Bergmann wrote:
> > On Friday 08 May 2015 07:55:26 Mike Looijmans wrote:
> >> On 07-05-15 16:30, Russell King - ARM Linux wrote:
> >>> On Thu, May 07, 2015 at 04:08:54PM +0200, Mike Looijmans wrote:
> >>>> I read the rest of the thread, apparently it was never integrated.
> >>>>
> >>>> The patch for "non-consistent" is a BUG FIX, not some feature request or so.
> >>>> I was already wondering why my driver had to kalloc pages to get proper
> >>>> caching on it.
> >>>
> >>> I disagree.
> >>>
> >>>>   From https://www.kernel.org/doc/Documentation/DMA-attributes.txt:
> >>>> """
> >>>> DMA_ATTR_NON_CONSISTENT ... lets the platform to choose to return either
> >>>> consistent or non-consistent memory as it sees fit.  By using this API,
> >>>> you are guaranteeing to the platform that you have all the correct and
> >>>> necessary sync points for this memory in the driver.
> >>>> """
> >>>
> >>> DMA attributes are something that came in _after_ the DMA API had been
> >>> around for many years.  It's a "new feature" that was added to an
> >>> existing subsystem, and because there have been no need for it to be
> >>> implemented on ARM, the new feature was never implemented.
> >>>
> >>> More than that, the vast majority of ARM hardware can't provide this
> >>> kind of memory, and there are _no_ kernel APIs to ensure that if
> >>
> >> By "non-coherent" memory I thought it meant the same kind of memory that
> >> kalloc would return. But from your answer it seems I am mistaken and
> >> this is something different?
> >
> > It depends: on a device that is actually cache-coherent,
> > dma_alloc_coherent() and dma_alloc_noncoherent() both return normal
> > memory.
> >
> > On some architectures (not ARM) that are not fully coherent,
> > dma_alloc_coherent() has to return uncached memory, while
> > dma_alloc_noncoherent() is allowed to return cached memory but
> > requires a dma_cache_sync() operation.
> >
> > dma_alloc_attrs() with DMA_ATTR_NON_CONSISTENT is a variant of that,
> > but I assume the idea is that you use dma_sync_single_fo_{cpu,device}()
> > on that memory, which can actually work on  ARM, unlike dma_cache_sync().
> 
> Ah, okay, I was misled by the names. I was under the impression that memory 
> would be either "coherent" or "non-coherent". But what is called 
> "non-coherent" here is actually something like "less-coherent", it isn't 
> normal memory as alloc_pages would return, but it also isn't completely 
> coherent. Is that a correct summary?
> 
> In that case, I stand corrected.

Almost. I think the part that you are still missing is that memory
itself it not coherent or non-coherent. It's the device access to
that memory that can be coherent or not with regard to the CPU.

The memory that is returned by alloc_pages can be coherent with one
device but non-coherent with another.

> I was looking for an interface that would allocate memory for access by my 
> device, but that would be just alloc_pages style memory. If my DMA controller 
> is limited to say only the first GB of RAM, I'd set the DMA mask to "30 bits". 
> If I just allocate memory using alloc_pages, the kernel doesn't know that I'd 
> want it to be in the lower 1GB range, and could allocate it in a spot my 
> device could not map.

If you have that low-memory restriction, you also need to ensure that there
is a ZONE_DMA that is large enough. ZONE_DMA should be sized to match the
common subset that all devices can access, so a GFP_DMA request returns
memory that is guaranteed to be accessible by all devices.

> Hence I'd expect there to be some "dma_alloc_pages(struct device* ...)" style 
> of call to get memory that my device could access (and I was under the false 
> impression that dma_alloc_noncoherent was the one I was looking for).
> 
> Currently I can get away with just using alloc_pages or kmalloc since my DMA 
> controller happens to be able to access all memory. But I also want my device 
> driver to work on 64-bit platforms (e.g. arm64 for the MPSOC and x86-64 for 
> the PCIe version of the board).

Those machines will have ZONE_DMA32, which refers to the first 4GB of memory,
so that should work fine. Alternatively you can use the iommu to get
all memory mapped into the space that is accessible by the device.
Also, on 64-bit x86 or ARM machines, all memory tends to be coherent, so
dma_sync_* will turn into a nop.

	Arnd
