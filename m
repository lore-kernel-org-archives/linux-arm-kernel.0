From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 12:53:26 +0000
Subject: [PATCH v3 0/2] ARM: IOMMU: tegra: Add iommu_ops for GART/SMMU
 driver
In-Reply-To: <20120105091718.3fb378b2a1d390f9dd63c396@nvidia.com>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com>
 <20120105091718.3fb378b2a1d390f9dd63c396@nvidia.com>
Message-ID: <20120105125326.GT11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 09:17:18AM +0200, Hiroshi Doyu wrote:
> Just for DMA mapping test from MPU side, the following one is used.

This patch is buggy.

> +static void dmaapi_test_map_page(struct device *dev)
> +{
> +	struct page *page;
> +	dma_addr_t dma_addr;
> +	void *cpu_addr;
> +
> +	page = alloc_page(GFP_KERNEL);
> +	BUG_ON(!page);
> +
> +	dma_addr = dma_map_page(dev, page, 0, PAGE_SIZE, DMA_TO_DEVICE);
> +	BUG_ON(!dma_addr);
> +
> +	cpu_addr = kmap(page);
> +	BUG_ON(!cpu_addr);
> +	memset(cpu_addr, 0xa5, PAGE_SIZE);
> +	kunmap(cpu_addr);

The DMA API works like this:

- The CPU owns the page or buffer and can access it.
- You map the page or buffer.
- The device owns the page or buffer; the CPU must explicitly access it.
- You unmap the page or buffer.
- The CPU again owns the page/buffer and can access it.

Please respect the DMA API rules.

So.  Once dma_map_page() has returned, you must not kmap() or otherwise
access the data contained in that page until after you have unmapped it.
