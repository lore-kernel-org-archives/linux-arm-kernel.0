From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 4 Jul 2014 15:35:22 +0200
Subject: [PATCHv4 5/5] arm64: Add atomic pool for non-coherent and CMA
 allocations.
In-Reply-To: <1404324218-4743-6-git-send-email-lauraa@codeaurora.org>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-6-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140704133517.GA9860@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 11:03:38AM -0700, Laura Abbott wrote:
[...]
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
[...]
> +static struct gen_pool *atomic_pool;
> +
> +#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
> +static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;

There doesn't seem to be much use for this since it can't be overridden
via init_dma_coherent_pool_size like on ARM.

> +static int __free_from_pool(void *start, size_t size)
> +{
> +	if (!__in_atomic_pool(start, size))
> +		return 0;
> +
> +	gen_pool_free(atomic_pool, (unsigned long)start, size);
> +
> +	return 1;
> +}
> +
> +

There's a gratuituous blank line here.

>  static void *__dma_alloc_coherent(struct device *dev, size_t size,
>  				  dma_addr_t *dma_handle, gfp_t flags,
>  				  struct dma_attrs *attrs)
> @@ -53,7 +103,8 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
>  	if (IS_ENABLED(CONFIG_ZONE_DMA) &&
>  	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
>  		flags |= GFP_DMA;
> -	if (IS_ENABLED(CONFIG_DMA_CMA)) {
> +
> +	if (!(flags & __GFP_WAIT) && IS_ENABLED(CONFIG_DMA_CMA)) {

I think the diff would be more readable here if this wasn't introducing
a blank linke and kept the IS_ENABLED() first.

>  		struct page *page;
>  
>  		size = PAGE_ALIGN(size);
> @@ -73,50 +124,56 @@ static void __dma_free_coherent(struct device *dev, size_t size,
>  				void *vaddr, dma_addr_t dma_handle,
>  				struct dma_attrs *attrs)
>  {
> +	bool freed;
> +	phys_addr_t paddr = dma_to_phys(dev, dma_handle);
> +
>  	if (dev == NULL) {
>  		WARN_ONCE(1, "Use an actual device structure for DMA allocation\n");
>  		return;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_DMA_CMA)) {
> -		phys_addr_t paddr = dma_to_phys(dev, dma_handle);
>  
> -		dma_release_from_contiguous(dev,

The above leaves an unnecessary blank line in place.

>  	ptr = __dma_alloc_coherent(dev, size, dma_handle, flags, attrs);
>  	if (!ptr)
>  		goto no_mem;
> -	map = kmalloc(sizeof(struct page *) << order, flags & ~GFP_DMA);
> -	if (!map)
> -		goto no_map;
>  
>  	/* remove any dirty cache lines on the kernel alias */
>  	__dma_flush_range(ptr, ptr + size);
>  
> +

Adds an unnecessary blank line.

> @@ -332,6 +391,67 @@ static struct notifier_block amba_bus_nb = {
>  
>  extern int swiotlb_late_init_with_default_size(size_t default_size);
>  
> +static int __init atomic_pool_init(void)
> +{
> +	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
> +	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
> +	struct page *page;
> +	void *addr;
> +
> +

There's another gratuituous blank line here...

> +	if (dev_get_cma_area(NULL))
> +		page = dma_alloc_from_contiguous(NULL, nr_pages,
> +					get_order(atomic_pool_size));
> +	else
> +		page = alloc_pages(GFP_KERNEL, get_order(atomic_pool_size));
> +
> +

and here.

> +	if (page) {
> +		int ret;
> +
> +		atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
> +		if (!atomic_pool)
> +			goto free_page;
> +
> +		addr = dma_common_contiguous_remap(page, atomic_pool_size,
> +					VM_USERMAP, prot, atomic_pool_init);
> +
> +		if (!addr)
> +			goto destroy_genpool;
> +
> +		memset(addr, 0, atomic_pool_size);
> +		__dma_flush_range(addr, addr + atomic_pool_size);
> +
> +		ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
> +					page_to_phys(page),
> +					atomic_pool_size, -1);
> +		if (ret)
> +			goto remove_mapping;
> +
> +		gen_pool_set_algo(atomic_pool,
> +				  gen_pool_first_fit_order_align, NULL);
> +
> +		pr_info("DMA: preallocated %zd KiB pool for atomic allocations\n",

I think this should be "%zu" because atomic_pool_size is a size_t, not a
ssize_t.

> +			atomic_pool_size / 1024);
> +		return 0;
> +	}
> +	goto out;
> +
> +remove_mapping:
> +	dma_common_free_remap(addr, atomic_pool_size, VM_USERMAP);
> +destroy_genpool:
> +	gen_pool_destroy(atomic_pool);
> +	atomic_pool == NULL;

This probably doesn't belong here.

> +free_page:
> +	if (!dma_release_from_contiguous(NULL, page, nr_pages))
> +		__free_pages(page, get_order(atomic_pool_size));

You use get_order(atomic_pool_size) a lot, perhaps it should be a
temporary variable?

> +out:
> +	pr_err("DMA: failed to allocate %zx KiB pool for atomic coherent allocation\n",
> +		atomic_pool_size / 1024);

Print in decimal rather than hexadecimal?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/1e719c0a/attachment.sig>
