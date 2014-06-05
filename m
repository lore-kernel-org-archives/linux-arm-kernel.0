From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jun 2014 18:05:00 +0100
Subject: [PATCHv2] arm64: Add atomic pool for non-coherent and CMA
 allocaitons.
In-Reply-To: <1401739432-5358-1-git-send-email-lauraa@codeaurora.org>
References: <1401739432-5358-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140605170500.GC27946@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Mon, Jun 02, 2014 at 09:03:52PM +0100, Laura Abbott wrote:
> Neither CMA nor noncoherent allocations support atomic allocations.
> Add a dedicated atomic pool to support this.

CMA indeed doesn't support atomic allocations but swiotlb does, the only
problem being the vmap() to create a non-cacheable mapping. Could we not
use the atomic pool only for non-coherent allocations?

> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
[...]
>  static void *__dma_alloc_coherent(struct device *dev, size_t size,
>  				  dma_addr_t *dma_handle, gfp_t flags,
>  				  struct dma_attrs *attrs)
> @@ -53,7 +157,16 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
>  	if (IS_ENABLED(CONFIG_ZONE_DMA) &&
>  	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
>  		flags |= GFP_DMA;
> -	if (IS_ENABLED(CONFIG_DMA_CMA)) {

So here just check for:

	if ((flags & __GFP_WAIT) && IS_ENABLED(CONFIG_DMA_CMA)) {

> +
> +	if (!(flags & __GFP_WAIT)) {
> +		struct page *page = NULL;
> +		void *addr = __alloc_from_pool(size, &page, true);
> +
> +		if (addr)
> +			*dma_handle = phys_to_dma(dev, page_to_phys(page));
> +
> +		return addr;

and ignore the __alloc_from_pool() call.

> @@ -78,7 +191,9 @@ static void __dma_free_coherent(struct device *dev, size_t size,
>  		return;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_DMA_CMA)) {
> +	if (__free_from_pool(vaddr, size, true)) {
> +		return;
> +	} else if (IS_ENABLED(CONFIG_DMA_CMA)) {
>  		phys_addr_t paddr = dma_to_phys(dev, dma_handle);
>  
>  		dma_release_from_contiguous(dev,

Here you check for the return value of dma_release_from_contiguous() and
if false, fall back to the swiotlb release.

I guess we don't even need the IS_ENABLED(DMA_CMA) check since when
disabled those functions return NULL/false anyway.

> @@ -100,9 +215,21 @@ static void *__dma_alloc_noncoherent(struct device *dev, size_t size,
>  	size = PAGE_ALIGN(size);
>  	order = get_order(size);
>  
> +	if (!(flags & __GFP_WAIT)) {
> +		struct page *page = NULL;
> +		void *addr = __alloc_from_pool(size, &page, false);
> +
> +		if (addr)
> +			*dma_handle = phys_to_dma(dev, page_to_phys(page));
> +
> +		return addr;
> +
> +	}

Here we need the atomic pool as we can't remap the memory as uncacheable
in atomic context.

> @@ -332,6 +461,65 @@ static struct notifier_block amba_bus_nb = {
>  
>  extern int swiotlb_late_init_with_default_size(size_t default_size);
>  
> +static int __init atomic_pool_init(void)
> +{
> +	struct dma_pool *pool = &atomic_pool;
> +	pgprot_t prot = pgprot_writecombine(pgprot_default);

In linux-next I got rid of pgprot_default entirely, just use
__pgprot(PROT_NORMAL_NC).

> +	unsigned long nr_pages = pool->size >> PAGE_SHIFT;
> +	unsigned long *bitmap;
> +	struct page *page;
> +	struct page **pages;
> +	int bitmap_size = BITS_TO_LONGS(nr_pages) * sizeof(long);
> +
> +	bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> +	if (!bitmap)
> +		goto no_bitmap;
> +
> +	pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
> +	if (!pages)
> +		goto no_pages;
> +
> +	if (IS_ENABLED(CONFIG_CMA))
> +		page = dma_alloc_from_contiguous(NULL, nr_pages,
> +					get_order(pool->size));
> +	else
> +		page = alloc_pages(GFP_KERNEL, get_order(pool->size));

I think the safest is to use GFP_DMA as well. Without knowing exactly
what devices will do, what their dma masks are, I think that's a safer
bet. I plan to limit the CMA buffer to ZONE_DMA as well for lack of a
better option.

BTW, most of this code could be turned into a library, especially if we
don't need to separate coherent/non-coherent pools. Also, a lot of code
is similar to the dma_alloc_from_coherent() implementation (apart from
the ioremap() call in dma_declare_coherent_memory() and per-device pool
rather than global one).

-- 
Catalin
