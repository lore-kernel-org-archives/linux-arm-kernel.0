From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 28 Apr 2011 12:41:44 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110427073514.GH17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<20110427073514.GH17290@n2100.arm.linux.org.uk>
Message-ID: <20110428104143.GB13402@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 08:35:14AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 21, 2011 at 09:29:16PM +0200, Arnd Bergmann wrote:

> dma_map_ops design is broken - we can't have the entire DMA API indirected
> through that structure.  Whether you have an IOMMU or not is completely
> independent of whether you have to do DMA cache handling.  Moreover, with
> dmabounce, having the DMA cache handling in place doesn't make sense.
> 
> So you can't have a dma_map_ops for the cache handling bits, a dma_map_ops
> for IOMMU, and a dma_map_ops for the dmabounce stuff.  It just doesn't
> work like that.

Nobody says that the complete feature-set of the dma_ops needs to be
provided through the IOMMU-API. The different APIs are there to solve
different problems:

The IOMMU-API provides low-level access to IOMMU hardware and to map io
addresses to physical addresses (which can be chosen by the caller). The
IOMMU-API does not care about address space layout or cache management.

The DMA-API cares about address management. Every dma_ops implementation
using an IOMMU has an address allocator for io addresses implemented.
the DMA-API also cares about cache-management.

So if we can abstract the different IOMMUs on all architectures in the
IOMMU-API I see no reason why we can't have a common dma_ops
implementation. The dma-buffer ownership management (cpu<->device) can
be put into archtectural call-backs so that architectures that need it
just implement them and everything should work.

Or I am too naive to believe that (which is possible because of my
limited ARM knowledge). In this case please correct me :)

Regards,

	Joerg
