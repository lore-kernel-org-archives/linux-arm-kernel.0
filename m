From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jul 2015 18:27:11 +0100
Subject: [PATCH v4 3/4] arm64: Add IOMMU dma_ops
In-Reply-To: <f51a6dfad1367107b07ca43624a990a62f3d4f3c.1437070995.git.robin.murphy@arm.com>
References: <cover.1437070995.git.robin.murphy@arm.com>
 <f51a6dfad1367107b07ca43624a990a62f3d4f3c.1437070995.git.robin.murphy@arm.com>
Message-ID: <20150728172710.GB536@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 07:40:14PM +0100, Robin Murphy wrote:
> +static void *__iommu_alloc_attrs(struct device *dev, size_t size,
> +				 dma_addr_t *handle, gfp_t gfp,
> +				 struct dma_attrs *attrs)
> +{
> +	bool coherent = is_device_dma_coherent(dev);
> +	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
> +	void *addr;
> +
> +	if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
> +		return NULL;
> +
> +	/*
> +	 * Some drivers rely on this, and we may not want to potentially
> +	 * expose stale kernel data to devices anyway.
> +	 */
> +	gfp |= __GFP_ZERO;
> +
> +	if (gfp & __GFP_WAIT) {
> +		struct page **pages;
> +		pgprot_t pgprot = coherent ? __pgprot(PROT_NORMAL) :
> +					     __pgprot(PROT_NORMAL_NC);
> +
> +		pgprot = __get_dma_pgprot(attrs, pgprot, coherent);

I think you can simplify this:

		pgprot_t pgprot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);

(and we could do the same in __dma_alloc)

> +		pages = iommu_dma_alloc(dev, size, gfp, ioprot,	handle,
> +					coherent ? NULL : flush_page);

I commented on patch 2/4. If we checked for IOMMU_CACHE in
iommu_dma_alloc(), we could always pass flush_page here without the
NULL.

> +		if (!pages)
> +			return NULL;
> +
> +		addr = dma_common_pages_remap(pages, size, VM_USERMAP, pgprot,
> +					      __builtin_return_address(0));
> +		if (!addr)
> +			iommu_dma_free(dev, pages, size, handle);

For arm64, it would have been easier to simply flush the caches here and
avoid the flush_page argument. However, I reread your earlier reply, so
if we ever honour the ATTR_NO_KERNEL_MAPPING, then we would have to
iterate over the individual pages in the arch code. Let's leave it as
per your patch 2/4 (with a flush_page argument).

-- 
Catalin
