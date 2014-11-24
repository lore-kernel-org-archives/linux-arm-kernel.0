From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Nov 2014 21:12:09 +0100
Subject: For the problem when using swiotlb
In-Reply-To: <20141121180925.GG19783@e104818-lin.cambridge.arm.com>
References: <5469E26B.2010905@huawei.com> <20141121175118.GA10451@localhost>
 <20141121180925.GG19783@e104818-lin.cambridge.arm.com>
Message-ID: <2166613.l2i4mdmtLA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 18:09:25 Catalin Marinas wrote:
> On Fri, Nov 21, 2014 at 05:51:19PM +0000, Catalin Marinas wrote:
> > On Fri, Nov 21, 2014 at 05:04:28PM +0000, Arnd Bergmann wrote:
> > > On Friday 21 November 2014 16:57:09 Catalin Marinas wrote:
> > > > There is a scenario where smaller mask would work on arm64. For example
> > > > Juno, you can have 2GB of RAM in the 32-bit phys range (starting at
> > > > 0x80000000). A device with 31-bit mask and a dma_pfn_offset of
> > > > 0x80000000 would still work (there isn't any but just as an example). So
> > > > the check in dma_alloc_coherent() would be something like:
> > > > 
> > > > 	phys_to_dma(top of ZONE_DMA) - dma_pfn_offset <= coherent_dma_mask
> > > > 
> > > > (or assuming RAM starts at 0 and ignoring dma_pfn_offset for now)
> > > > 
> > > > If the condition above fails, dma_alloc_coherent() would no longer fall
> > > > back to swiotlb but issue a dev_warn() and return NULL.
> > > 
> > > Ah, that looks like it should work on all architectures, very nice.
> > > How about checking this condition, and then printing a small warning
> > > (dev_warn, not WARN_ON) and setting the dma_mask pointer to NULL?
> > 
> > I would not add the above ZONE_DMA check to of_dma_configure(). For
> > example on arm64, we may not support a small coherent_dma_mask but the
> > same value for dma_mask could be fine via swiotlb bouncing (or IOMMU).
> > However, that's an arch-specific decision. Maybe after the above setting
> > of dev->coherent_dma_mask in of_dma_configure(), we could add:
> > 

You seem to implement the opposite:

> +	/*
> +	 * If the bus dma-ranges property specifies a size smaller than 4GB,
> +	 * the device would not be capable of accessing the whole 32-bit
> +	 * space, so reduce the default coherent_dma_mask accordingly.
> +	 */
> +	if (size && size < (1ULL << 32))
> +		dev->coherent_dma_mask = DMA_BIT_MASK(ilog2(size));
> +
> +	/*
> +	 * Set dma_mask to coherent_dma_mask by default if the architecture
> +	 * code has not set it and DMA on such mask is supported.
> +	 */
> +	if (!dev->dma_mask && dma_supported(dev, dev->coherent_dma_mask))
> +		dev->dma_mask = &dev->coherent_dma_mask;
>  }
>  

Here, coherent_dma_mask wouldn't work while dma_mask might be
fine in case of swiotlb, but you set a nonzero coherent_dma_mask
and an invalid dma_mask.

	Arnd
