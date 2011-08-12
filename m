From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Aug 2011 17:00:30 +0200
Subject: [PATCH 8/9] ARM: integrate CMA with DMA-mapping subsystem
In-Reply-To: <1313146711-1767-9-git-send-email-m.szyprowski@samsung.com>
References: <1313146711-1767-1-git-send-email-m.szyprowski@samsung.com>
	<1313146711-1767-9-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201108121700.30967.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 August 2011, Marek Szyprowski wrote:
> @@ -82,16 +103,16 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
>  	if (mask < 0xffffffffULL)
>  		gfp |= GFP_DMA;
>  
> -	page = alloc_pages(gfp, order);
> -	if (!page)
> -		return NULL;
> -
>  	/*
> -	 * Now split the huge page and free the excess pages
> +	 * Allocate contiguous memory
>  	 */
> -	split_page(page, order);
> -	for (p = page + (size >> PAGE_SHIFT), e = page + (1 << order); p < e; p++)
> -		__free_page(p);
> +	if (cma_available())
> +		page = dma_alloc_from_contiguous(dev, count, order);
> +	else
> +		page = __dma_alloc_system_pages(count, gfp, order);
> +
> +	if (!page)
> +		return NULL;

Why do you need the fallback here? I would assume that CMA now has to be available
on ARMv6 and up to work at all. When you allocate from __dma_alloc_system_pages(),
wouldn't that necessarily fail in the dma_remap_area() stage?

>  
> -	if (arch_is_coherent() || nommu()) {
> +	if (arch_is_coherent() || nommu() ||
> +	   (cma_available() && !(gfp & GFP_ATOMIC))) {
> +		/*
> +		 * Allocate from system or CMA pages
> +		 */
>  		struct page *page = __dma_alloc_buffer(dev, size, gfp);
>  		if (!page)
>  			return NULL;
> +		dma_remap_area(page, size, area->prot);
>  		pfn = page_to_pfn(page);
>  		ret = page_address(page);

Similarly with coherent and nommu. It seems to me that lumping too
many cases together creates extra complexity here.

How about something like

	if (arch_is_coherent() || nommu())
		ret = alloc_simple_buffer();
	else if (arch_is_v4_v5())
		ret = alloc_remap();
	else if (gfp & GFP_ATOMIC)
		ret = alloc_from_pool();
	else
		ret = alloc_from_contiguous();

This also allows a natural conversion to dma_map_ops when we get there.

>  	/* reserve any platform specific memblock areas */
>  	if (mdesc->reserve)
>  		mdesc->reserve();
>  
> +	dma_coherent_reserve();
> +	dma_contiguous_reserve();
> +
>  	memblock_analyze();
>  	memblock_dump_all();
>  }

Since we can handle most allocations using CMA on ARMv6+, I would think
that we can have a much smaller reserved area. Have you tried changing
dma_coherent_reserve() to allocate out of the contiguous area instead of
wasting a full 2MB section of memory?

	Arnd
