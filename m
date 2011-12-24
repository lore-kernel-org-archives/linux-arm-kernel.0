From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 24 Dec 2011 18:00:14 +1100
Subject: [PATCH 00/14] DMA-mapping framework redesign preparation
In-Reply-To: <20111223163516.GO20129@parisc-linux.org>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
 <20111223163516.GO20129@parisc-linux.org>
Message-ID: <1324710014.6632.23.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-12-23 at 09:35 -0700, Matthew Wilcox wrote:
> I really think this wants to be a separate function.
> dma_alloc_coherent
> is for allocating memory to be shared between the kernel and a driver;
> we already have dma_map_sg for mapping userspace I/O as an alternative
> interface.  This feels like it's something different again rather than
> an option to dma_alloc_coherent. 

Depends. There can be some interesting issues with some of the ARM stuff
out there (and to a lesser extent older ppc embedded stuff).

For example, some devices really want a physically contiguous chunk, and
are not cache coherent. In that case, you can't keep the linear mapping
around. But you also don't waste your precious kernel virtual space
creating a separate non-cachable mapping for those.

In general, dma mapping attributes as a generic feature make sense,
whether this specific attribute does or not though. And we probably want
space for platform specific attributes, for example, FSL embedded
iommu's have "interesting" features for directing data toward a specific
core cache etc... that we might want to expose using such attributes.

Cheers,
Ben.
