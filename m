From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 11 Jan 2012 15:24:40 +0100
Subject: [PATCH v3 0/2] ARM: IOMMU: tegra: Add iommu_ops for GART/SMMU
 driver
In-Reply-To: <20120105144631.GV11810@n2100.arm.linux.org.uk>
References: <20120105125326.GT11810@n2100.arm.linux.org.uk><20120105.162930.604365154868332443.hdoyu@nvidia.com><20120105144631.GV11810@n2100.arm.linux.org.uk>
Message-ID: <20120111.162440.1854857348878391112.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 0/2] ARM: IOMMU: tegra: Add iommu_ops for GART/SMMU driver
Date: Thu, 5 Jan 2012 15:46:31 +0100
Message-ID: <20120105144631.GV11810@n2100.arm.linux.org.uk>

> On Thu, Jan 05, 2012 at 03:29:30PM +0100, Hiroshi Doyu wrote:
> > Ok, the above function order should be as below?
> > 
> >   page = alloc_page(GFP_KERNEL);
> >       cpu_addr = kmap(page);
> >       memset(cpu_addr, 0xa5, PAGE_SIZE);
> >   	dma_addr = dma_map_page(dev, page, 0, PAGE_SIZE, DMA_TO_DEVICE);
> >   	    < expect GPU does something >
> >   	dma_unmap_page(dev, dma_addr, PAGE_SIZE, DMA_TO_DEVICE);
> >       < CPU can access data here again>
> >       kunmap(cpu_addr);
> >   __free_page(page);
> 
> That should work, but it's not particularly nice to wrap kmap around
> the DMA API.
> 
> Bear in mind that alloc_page(GFP_KERNEL) will always give you a lowmem
> page.  So, you might as well do:
> 
> 	page = alloc_page(GFP_KERNEL);
> 	cpu_addr = page_address(page);
> 	memset()
> 	dma_addr = dma_map_single(dev, cpu_addr, PAGE_SIZE, DMA_TO_DEVICE);
> 		< GPU access >
> 	dma_unmap_single(dev, dma_ddr, PAGE_SIZE, DMA_TO_DEVICE);
> 	< CPU access >
> 	__free_page(page);
> 
> and this doesn't raise any issues with kmap vs DMA API.

Attached the update one just in case that someone wants to use it for theirs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-NOT-FOR-MERGE-TEST-Simple-dma-iommu-mapping-API-TEST.patch
Type: text/x-patch
Size: 6451 bytes
Desc: 0001-NOT-FOR-MERGE-TEST-Simple-dma-iommu-mapping-API-TEST.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120111/f10945ee/attachment.bin>
