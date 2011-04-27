From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2011 13:02:43 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110427090923.GO17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<201104271056.49920.arnd@arndb.de>
	<20110427090923.GO17290@n2100.arm.linux.org.uk>
Message-ID: <201104271302.44249.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2011, Russell King - ARM Linux wrote:
> On Wed, Apr 27, 2011 at 10:56:49AM +0200, Arnd Bergmann wrote:
> > We probably still need to handle both the coherent and noncoherent case
> > in each dma_map_ops implementation, at least for those combinations where
> > they matter (definitely the linear mapping). However, I think that using
> > dma_mapping_common.h would let us use an architecture-independent dma_map_ops
> > for the generic iommu code that Marek wants to introduce now.
> 
> The 'do we have an iommu or not' question and the 'do we need to do cache
> coherency' question are two independent questions which are unrelated to
> each other.  There are four unique but equally valid combinations.
> 
> Pushing the cache coherency question down into the iommu stuff will mean
> that we'll constantly be fighting against the 'but this iommu works on x86'
> shite that we've fought with over block device crap for years.  I have
> no desire to go there.

Ok, I see. I believe we could avoid having to fight with the people that
only care about coherent architectures if we just have two separate
implementations of dma_map_ops in the iommu code, one for coherent
and one for noncoherent DMA. Any architecture that only needs one
of them would then only enable the Kconfig options for that implementation
and not care about the other one.

> What we need is a proper abstraction where the DMA ops can say whether
> they can avoid DMA cache handling (eg, swiotlb or dmabounce stuff) but
> default to DMA cache handling being the norm - and the DMA cache handling
> performed in the level above the DMA ops indirection.

Yes, that sounds definitely possible. I guess it could be as simple
as having a flag somewhere in struct device if we want to make it
architecture independent.

As for making the default being to do cache handling, I'm not completely
sure how that would work on architectures where most devices are coherent.
If I understood the DRM people correctly, some x86 machine have noncoherent
DMA in their GPUs while everything else is coherent.

Maybe we can default to arch_is_coherent() and allow a device to override
that when it knows better.

	Arnd
