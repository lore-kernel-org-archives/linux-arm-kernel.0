From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 7 Aug 2015 10:42:28 +0200
Subject: [PATCH v5 1/3] iommu: Implement common IOMMU ops for DMA mapping
In-Reply-To: <6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
Message-ID: <20150807084228.GU14980@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:18:27PM +0100, Robin Murphy wrote:
> +int iommu_get_dma_cookie(struct iommu_domain *domain)
> +{
> +	struct iova_domain *iovad;
> +
> +	if (domain->dma_api_cookie)
> +		return -EEXIST;

Why do you call that dma_api_cookie? It is just a pointer to an iova
allocator, you can just name it as such, like domain->iova.

> +static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
> +		dma_addr_t dma_limit)

I think you also need a struct device here to take segment boundary and
dma_mask into account.

> +/* The IOVA allocator knows what we mapped, so just unmap whatever that was */
> +static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
> +{
> +	struct iova_domain *iovad = domain->dma_api_cookie;
> +	unsigned long shift = iova_shift(iovad);
> +	unsigned long pfn = dma_addr >> shift;
> +	struct iova *iova = find_iova(iovad, pfn);
> +	size_t size = iova_size(iova) << shift;
> +
> +	/* ...and if we can't, then something is horribly, horribly wrong */
> +	BUG_ON(iommu_unmap(domain, pfn << shift, size) < size);

This is a WARN_ON@most, not a BUG_ON condition, especially since this
type of bug is also catched with the dma-api debugging code.

> +static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
> +{
> +	struct page **pages;
> +	unsigned int i = 0, array_size = count * sizeof(*pages);
> +
> +	if (array_size <= PAGE_SIZE)
> +		pages = kzalloc(array_size, GFP_KERNEL);
> +	else
> +		pages = vzalloc(array_size);
> +	if (!pages)
> +		return NULL;
> +
> +	/* IOMMU can map any pages, so himem can also be used here */
> +	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
> +
> +	while (count) {
> +		struct page *page = NULL;
> +		int j, order = __fls(count);
> +
> +		/*
> +		 * Higher-order allocations are a convenience rather
> +		 * than a necessity, hence using __GFP_NORETRY until
> +		 * falling back to single-page allocations.
> +		 */
> +		for (order = min(order, MAX_ORDER); order > 0; order--) {
> +			page = alloc_pages(gfp | __GFP_NORETRY, order);
> +			if (!page)
> +				continue;
> +			if (PageCompound(page)) {
> +				if (!split_huge_page(page))
> +					break;
> +				__free_pages(page, order);
> +			} else {
> +				split_page(page, order);
> +				break;
> +			}
> +		}
> +		if (!page)
> +			page = alloc_page(gfp);
> +		if (!page) {
> +			__iommu_dma_free_pages(pages, i);
> +			return NULL;
> +		}
> +		j = 1 << order;
> +		count -= j;
> +		while (j--)
> +			pages[i++] = page++;
> +	}
> +	return pages;
> +}

Hmm, most dma-api implementation just try to allocate a big enough
region from the page-alloctor. Is it implemented different here to avoid
the use of CMA?


	Joerg
