From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 10:09:23 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104271056.49920.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
	<20110427073514.GH17290@n2100.arm.linux.org.uk>
	<201104271056.49920.arnd@arndb.de>
Message-ID: <20110427090923.GO17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 10:56:49AM +0200, Arnd Bergmann wrote:
> We probably still need to handle both the coherent and noncoherent case
> in each dma_map_ops implementation, at least for those combinations where
> they matter (definitely the linear mapping). However, I think that using
> dma_mapping_common.h would let us use an architecture-independent dma_map_ops
> for the generic iommu code that Marek wants to introduce now.

The 'do we have an iommu or not' question and the 'do we need to do cache
coherency' question are two independent questions which are unrelated to
each other.  There are four unique but equally valid combinations.

Pushing the cache coherency question down into the iommu stuff will mean
that we'll constantly be fighting against the 'but this iommu works on x86'
shite that we've fought with over block device crap for years.  I have
no desire to go there.

What we need is a proper abstraction where the DMA ops can say whether
they can avoid DMA cache handling (eg, swiotlb or dmabounce stuff) but
default to DMA cache handling being the norm - and the DMA cache handling
performed in the level above the DMA ops indirection.

Anything else is asking for an endless stream of shite iommu stuff
getting DMA cache handling wrong.
