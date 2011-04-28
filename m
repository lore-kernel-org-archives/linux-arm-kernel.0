From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 12:01:29 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428104143.GB13402@8bytes.org>
References: <201104212129.17013.arnd@arndb.de>
	<20110427073514.GH17290@n2100.arm.linux.org.uk>
	<20110428104143.GB13402@8bytes.org>
Message-ID: <20110428110129.GE17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 12:41:44PM +0200, Joerg Roedel wrote:
> So if we can abstract the different IOMMUs on all architectures in the
> IOMMU-API I see no reason why we can't have a common dma_ops
> implementation. The dma-buffer ownership management (cpu<->device) can
> be put into archtectural call-backs so that architectures that need it
> just implement them and everything should work.

That is precisely what I'm arguing for.  The DMA cache management is
architecture specific and should stay in the architecture specific code.
The IOMMU level stuff should bolt into that at the architecture specific
level.

So, eg, for ARM:

dma_addr_t dma_map_page(struct device *dev, struct page *page, size_t offset,
                        size_t size, enum dma_data_direction dir)
{
	struct dma_map_ops *ops = get_dma_ops(dev);
	dma_addr_t addr;

	BUG_ON(!valid_dma_direction(dir));
	if (ops->flags & DMA_MANAGE_CACHE || !dev->dma_cache_coherent)
		__dma_page_cpu_to_dev(page, offset, size, dir);
	addr = ops->map_page(dev, page, offset, size, dir, NULL);
	debug_dma_map_page(dev, page, offset, size, dir, addr, false);

	return addr;
}

Things like swiotlb and dmabounce would not set DMA_MANAGE_CACHE in
ops->flags, but real iommus and the standard no-iommu implementations
would be required to set it to ensure that data is visible in memory
for CPUs which have DMA incoherent caches.

Maybe renaming DMA_MANAGE_CACHE to DMA_DATA_DEVICE_VISIBLE or something
like that would be more explicit as to its function.

dev->dma_cache_coherent serves to cover the case mentioned by the DRM
folk.
