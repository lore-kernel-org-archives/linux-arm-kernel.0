From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 08:35:14 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104212129.17013.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
Message-ID: <20110427073514.GH17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 09:29:16PM +0200, Arnd Bergmann wrote:
> 1. Fix the arm version of dma_alloc_coherent. It's in use today and
>    is broken on modern CPUs because it results in both cached and
>    uncached mappings. Rebecca suggested different approaches how to
>    get there.

I also suggested various approaches and produced patches, which I'm slowly
feeding in.  However, I think whatever we do, we'll end up breaking
something along the line - especially as various places assume that
dma_alloc_coherent() is ultimately backed by memory with a struct page.

> 2. Implement dma_alloc_noncoherent on ARM. Marek pointed out
>    that this is needed, and it currently is not implemented, with
>    an outdated comment explaining why it used to not be possible
>    to do it.

dma_alloc_noncoherent is an entirely pointless API afaics.

> 3. Convert ARM to use asm-generic/dma-mapping-common.h. We need
>    both IOMMU and direct mapped DMA on some machines.
> 
> 4. Implement an architecture independent version of dma_map_ops
>    based on the iommu.h API. As Joerg mentioned, this has been
>    missing for some time, and it would be better to do it once
>    than for each IOMMU separately. This is probably a lot of work.

dma_map_ops design is broken - we can't have the entire DMA API indirected
through that structure.  Whether you have an IOMMU or not is completely
independent of whether you have to do DMA cache handling.  Moreover, with
dmabounce, having the DMA cache handling in place doesn't make sense.

So you can't have a dma_map_ops for the cache handling bits, a dma_map_ops
for IOMMU, and a dma_map_ops for the dmabounce stuff.  It just doesn't
work like that.

I believe the dma_map_ops stuff in asm-generic to be entirely unsuitable
for ARM.
