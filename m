From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 5 Jan 2012 15:29:30 +0100
Subject: [PATCH v3 0/2] ARM: IOMMU: tegra: Add iommu_ops for GART/SMMU
 driver
In-Reply-To: <20120105125326.GT11810@n2100.arm.linux.org.uk>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com><20120105091718.3fb378b2a1d390f9dd63c396@nvidia.com><20120105125326.GT11810@n2100.arm.linux.org.uk>
Message-ID: <20120105.162930.604365154868332443.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 0/2] ARM: IOMMU: tegra: Add iommu_ops for GART/SMMU driver
Date: Thu, 5 Jan 2012 13:53:26 +0100
Message-ID: <20120105125326.GT11810@n2100.arm.linux.org.uk>

> On Thu, Jan 05, 2012 at 09:17:18AM +0200, Hiroshi Doyu wrote:
> > Just for DMA mapping test from MPU side, the following one is used.
>
> This patch is buggy.
>
> > +static void dmaapi_test_map_page(struct device *dev)
> > +{
> > +	struct page *page;
> > +	dma_addr_t dma_addr;
> > +	void *cpu_addr;
> > +
> > +	page = alloc_page(GFP_KERNEL);
> > +	BUG_ON(!page);
> > +
> > +	dma_addr = dma_map_page(dev, page, 0, PAGE_SIZE, DMA_TO_DEVICE);
> > +	BUG_ON(!dma_addr);
> > +
> > +	cpu_addr = kmap(page);
> > +	BUG_ON(!cpu_addr);
> > +	memset(cpu_addr, 0xa5, PAGE_SIZE);
> > +	kunmap(cpu_addr);
>
> The DMA API works like this:
>
> - The CPU owns the page or buffer and can access it.
> - You map the page or buffer.
> - The device owns the page or buffer; the CPU must explicitly access it.
> - You unmap the page or buffer.
> - The CPU again owns the page/buffer and can access it.
>
> Please respect the DMA API rules.

Right, I do.

> So.  Once dma_map_page() has returned, you must not kmap() or otherwise
> access the data contained in that page until after you have unmapped it.

Ok, the above function order should be as below?

  page = alloc_page(GFP_KERNEL);
      cpu_addr = kmap(page);
      memset(cpu_addr, 0xa5, PAGE_SIZE);
  	dma_addr = dma_map_page(dev, page, 0, PAGE_SIZE, DMA_TO_DEVICE);
  	    < expect GPU does something >
  	dma_unmap_page(dev, dma_addr, PAGE_SIZE, DMA_TO_DEVICE);
      < CPU can access data here again>
      kunmap(cpu_addr);
  __free_page(page);
