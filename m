From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Nov 2014 17:51:19 +0000
Subject: For the problem when using swiotlb
In-Reply-To: <2530749.roRsteyaXx@wuerfel>
References: <5469E26B.2010905@huawei.com> <5029442.vhLMp7Ns7F@wuerfel>
 <20141121165708.GF19783@e104818-lin.cambridge.arm.com>
 <2530749.roRsteyaXx@wuerfel>
Message-ID: <20141121175118.GA10451@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 05:04:28PM +0000, Arnd Bergmann wrote:
> On Friday 21 November 2014 16:57:09 Catalin Marinas wrote:
> > There is a scenario where smaller mask would work on arm64. For example
> > Juno, you can have 2GB of RAM in the 32-bit phys range (starting at
> > 0x80000000). A device with 31-bit mask and a dma_pfn_offset of
> > 0x80000000 would still work (there isn't any but just as an example). So
> > the check in dma_alloc_coherent() would be something like:
> > 
> > 	phys_to_dma(top of ZONE_DMA) - dma_pfn_offset <= coherent_dma_mask
> > 
> > (or assuming RAM starts at 0 and ignoring dma_pfn_offset for now)
> > 
> > If the condition above fails, dma_alloc_coherent() would no longer fall
> > back to swiotlb but issue a dev_warn() and return NULL.
> 
> Ah, that looks like it should work on all architectures, very nice.
> How about checking this condition, and then printing a small warning
> (dev_warn, not WARN_ON) and setting the dma_mask pointer to NULL?

I would not add the above ZONE_DMA check to of_dma_configure(). For
example on arm64, we may not support a small coherent_dma_mask but the
same value for dma_mask could be fine via swiotlb bouncing (or IOMMU).
However, that's an arch-specific decision. Maybe after the above setting
of dev->coherent_dma_mask in of_dma_configure(), we could add:

	if (!dma_supported(dev, dev->coherent_dma_mask))
		dev->dma_mask = NULL;

The arch dma_supported() can check the swiotlb bouncing or ZONE_DMA
limits.

Strangely, we don't have a coherent_dma_supported() but we can defer
such check to dma_alloc_coherent() and that's where we would check the
top of ZONE_DMA.

-- 
Catalin
