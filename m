From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 18 Jun 2013 13:01:37 +0200
Subject: DMA mapping API(IOMMU) for ARM64?
In-Reply-To: <5159282.rrJMaZuYMv@wuerfel>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com><20130618101914.GB3539@mudshark.cambridge.arm.com><5159282.rrJMaZuYMv@wuerfel>
Message-ID: <20130618.140137.1551430695673122122.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> wrote @ Tue, 18 Jun 2013 12:32:44 +0200:

> On Tuesday 18 June 2013 11:19:14 Will Deacon wrote:
> > 
> > I've spoken briefly with Catalin about this and it seems like there might be
> > *some* scope for sharing common dma-mapping code between architectures.
> > There doesn't really need to be any architecture-specific details in
> > allocating iova space and the interface to the iommu drivers is
> > well-defined. The arch-specific stuff is bogged down in the non-coherent
> > buffer management, but that doesn't necessarily equate to lots of code.
> > 
> > So, the best bet would be to figure out how to split up what we have under
> > arch/arm/ so that it can be re-used by arm64 and potentially other
> > architectures (powerpc has some simple stuff for coherent mappings and some
> > less-simple stuff for non-coherent buffers).
> 
> I'm sure that other architectures are interested in sharing the code.
> Best move it into the global mm/ directory, at least the version for
> coherent mappings.

I'm guessing that this kind of unification usually takes some time
since we need to factor out the common code from the different
${ARCH}/mm/dma-mapping.c. Also some of ${ARCH} has IOMMU support in
it. So if we want to develop our 64-bit ARM with working DMA mapping
API during this transition, the step to take would be:

1, Copy arch/arm/mm/dma-mapping.c arch/arm64/mm/dma-mapping.c(+swiotlb)
2, Adapt arch/arm64/mm/dma-mapping.c(+swiotlb) to 64bit compatible.
3, Factor out the common code from them into mm/dma-mapping.c

Also I guess that there may be the possibility that some of DMA
mapping API may be added/tweaked to satisfy requirements from multiple
${ARCH}. We have already had some of such modifications which didn't
succeed to be upstreamed yet.
