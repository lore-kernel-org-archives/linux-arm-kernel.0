From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Jun 2015 17:25:49 +0100
Subject: [RFC PATCH v3] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <1434663862-17858-1-git-send-email-lorenx4@gmail.com>
References: <1434663862-17858-1-git-send-email-lorenx4@gmail.com>
Message-ID: <20150626162549.GK3078@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 11:44:22PM +0200, Lorenzo Nava wrote:
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 7e7583d..8e7f402 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -645,15 +645,29 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  	size = PAGE_ALIGN(size);
>  	want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
>  
> -	if (is_coherent || nommu())
> +	if (nommu()) {
>  		addr = __alloc_simple_buffer(dev, size, gfp, &page);
> -	else if (!(gfp & __GFP_WAIT))
> +		goto dma_alloc_done;
> +	}
> +
> +	if (dev_get_cma_area(dev) && (gfp & __GFP_WAIT)) {
> +		addr = __alloc_from_contiguous(dev, size, prot, &page,
> +					       caller, want_vaddr);
> +		goto dma_alloc_done;
> +	}
> +
> +	if (is_coherent) {
> +		addr = __alloc_simple_buffer(dev, size, gfp, &page);
> +		goto dma_alloc_done;
> +	}
> +
> +	if (!(gfp & __GFP_WAIT))
>  		addr = __alloc_from_pool(size, &page);
> -	else if (!dev_get_cma_area(dev))
> -		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller, want_vaddr);
>  	else
> -		addr = __alloc_from_contiguous(dev, size, prot, &page, caller, want_vaddr);
> +		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page,
> +					    caller, want_vaddr);
>  
> +dma_alloc_done:
>  	if (page)
>  		*handle = pfn_to_dma(dev, page_to_pfn(page));

The logic here looks alright but I would have preferred the original
more concise "if ... else if" constructs than the gotos (just personal
preference).

> @@ -680,9 +694,14 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
>  	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
>  {
> -	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
> +	pgprot_t prot;
>  	void *memory;
>  
> +	if (attrs == NULL)
> +		 prot  = PAGE_KERNEL;
> +	else
> +		 prot  = __get_dma_pgprot(attrs, PAGE_KERNEL);
> +
>  	if (dma_alloc_from_coherent(dev, size, handle, &memory))
>  		return memory;

I still think this is the wrong way to fix. It doesn't address the
coherent dma mmap operation. I already replied on the previous version
that we should rather have an extra argument "coherent" to
__get_dma_pgprot().

> @@ -735,12 +754,12 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
>  
>  	size = PAGE_ALIGN(size);
>  
> -	if (is_coherent || nommu()) {
> +	if (nommu()) {
>  		__dma_free_buffer(page, size);
>  	} else if (__free_from_pool(cpu_addr, size)) {
>  		return;

You have an unnecessary __free_from_pool() call here in the is_coherent
case.

>  	} else if (!dev_get_cma_area(dev)) {
> -		if (want_vaddr)
> +		if (want_vaddr && !is_coherent)
>  			__dma_free_remap(cpu_addr, size);
>  		__dma_free_buffer(page, size);
>  	} else {

-- 
Catalin
