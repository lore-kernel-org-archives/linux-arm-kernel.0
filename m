From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 14:46:31 +0000
Subject: [PATCH v3 0/2] ARM: IOMMU: tegra: Add iommu_ops for GART/SMMU
 driver
In-Reply-To: <20120105.162930.604365154868332443.hdoyu@nvidia.com>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com>
 <20120105091718.3fb378b2a1d390f9dd63c396@nvidia.com>
 <20120105125326.GT11810@n2100.arm.linux.org.uk>
 <20120105.162930.604365154868332443.hdoyu@nvidia.com>
Message-ID: <20120105144631.GV11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 03:29:30PM +0100, Hiroshi Doyu wrote:
> Ok, the above function order should be as below?
> 
>   page = alloc_page(GFP_KERNEL);
>       cpu_addr = kmap(page);
>       memset(cpu_addr, 0xa5, PAGE_SIZE);
>   	dma_addr = dma_map_page(dev, page, 0, PAGE_SIZE, DMA_TO_DEVICE);
>   	    < expect GPU does something >
>   	dma_unmap_page(dev, dma_addr, PAGE_SIZE, DMA_TO_DEVICE);
>       < CPU can access data here again>
>       kunmap(cpu_addr);
>   __free_page(page);

That should work, but it's not particularly nice to wrap kmap around
the DMA API.

Bear in mind that alloc_page(GFP_KERNEL) will always give you a lowmem
page.  So, you might as well do:

	page = alloc_page(GFP_KERNEL);
	cpu_addr = page_address(page);
	memset()
	dma_addr = dma_map_single(dev, cpu_addr, PAGE_SIZE, DMA_TO_DEVICE);
		< GPU access >
	dma_unmap_single(dev, dma_ddr, PAGE_SIZE, DMA_TO_DEVICE);
	< CPU access >
	__free_page(page);

and this doesn't raise any issues with kmap vs DMA API.
