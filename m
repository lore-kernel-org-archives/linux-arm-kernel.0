From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Jun 2013 11:19:14 +0100
Subject: DMA mapping API(IOMMU) for ARM64?
In-Reply-To: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
Message-ID: <20130618101914.GB3539@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 03:39:55AM +0100, Hiroshi Doyu wrote:
> Hi,

Hello Hiroshi,

> Currently ARM64 supports swiotlb only as below[1]. AFAIU, swiotlb
> provides some kind of bounce buffer for some restricted H/Ws, and it
> cannot replace IOMMU H/W completely. So I'm wondering that we would
> need the IOMMU versions of dma_map_ops as Marek did for ARM32. If my
> understanding is correct, do you guys have any idea how it's going to
> be implemented? Can we reuse the current version of "iommu_ops" in
> "arch/arm/mm/dma-mapping.c" for ARM64 as well? Or do we need to
> rewrite 64bit version of iommu_ops completely in the same file as one
> with swiotlb, "arch/arm64/mm/dma-mapping.c"?
> 
> Any feedback would be really appreciated.

I've spoken briefly with Catalin about this and it seems like there might be
*some* scope for sharing common dma-mapping code between architectures.
There doesn't really need to be any architecture-specific details in
allocating iova space and the interface to the iommu drivers is
well-defined. The arch-specific stuff is bogged down in the non-coherent
buffer management, but that doesn't necessarily equate to lots of code.

So, the best bet would be to figure out how to split up what we have under
arch/arm/ so that it can be re-used by arm64 and potentially other
architectures (powerpc has some simple stuff for coherent mappings and some
less-simple stuff for non-coherent buffers).

Will
