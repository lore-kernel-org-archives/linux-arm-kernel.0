From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 28 Apr 2011 14:59:24 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428124242.GJ17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<20110427073514.GH17290@n2100.arm.linux.org.uk>
	<20110428104143.GB13402@8bytes.org>
	<20110428110129.GE17290@n2100.arm.linux.org.uk>
	<20110428122508.GC13402@8bytes.org>
	<20110428124242.GJ17290@n2100.arm.linux.org.uk>
Message-ID: <20110428125924.GD13402@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 01:42:42PM +0100, Russell King - ARM Linux wrote:

> Sigh.  You're not seeing the point.
> 
> There is _no_ point doing the cache management _if_ we're using something
> like dmabounce or swiotlb, as we'll be using memcpy() at some point with
> the buffer.  Moreover, dmabounce or swiotlb may have to do its own cache
> management _after_ that memcpy() to ensure that the page cache requirements
> are met.

Well, I was talking about a generic dma_ops implementation based on the
iommu-api so that every system that has iommu hardware can use a common
code-set.
If you have to dma-bounce you don't have iommu hardware and thus you
don't use this common implementation of dma_ops (but probably the
swiotlb implementation which is already mostly generic).

> Doing DMA cache management for dmabounce or swiotlb will result in
> unnecessary overhead - and as we can see from the MMC discussions,
> it has a _significant_ performance impact.

Yeah, I see that from your explanation below. But as I said, swiotlb
backend is not a target use-case for a common iommu-api-bound dma_ops
implementation.

> Think about it.  If you're using dmabounce, but still do the cache
> management:
> 
> 1. you flush the data out of the CPU cache back to memory.
> 2. you allocate new memory using dma_alloc_coherent() for the DMA buffer
>    which is accessible to the device.
> 3. you memcpy() the data out of the buffer you just flushed into the
>    DMA buffer - this re-fills the cache, evicting entries which may
>    otherwise be hot due to the cache fill policy.
> 
> Step 1 is entirely unnecessary and is just a complete and utter waste of
> CPU resources.

Thanks for the explanation.

Regards,

	Joerg
