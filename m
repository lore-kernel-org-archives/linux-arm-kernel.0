From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Aug 2015 16:16:04 +0100
Subject: [PATCH] ARM: dma-mapping: Don't use outer_flush_range when the
 L2C is coherent
In-Reply-To: <1439474365-12058-1-git-send-email-gregory.clement@free-electrons.com>
References: <1439474365-12058-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150813151603.GB4602@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 03:59:25PM +0200, Gregory CLEMENT wrote:
> @@ -241,12 +241,15 @@ static void __dma_clear_buffer(struct page *page, size_t size)
>  			page++;
>  			size -= PAGE_SIZE;
>  		}
> -		outer_flush_range(base, end);
> +		if (!is_coherent)
> +			outer_flush_range(base, end);

There is a dmac_flush_range() call above this (in the "while" block),
please add a check for is_coherent in there as well.

> @@ -540,7 +545,13 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
>  	if (!page)
>  		return NULL;
>  
> -	__dma_clear_buffer(page, size);
> +	/*
> +	 * We are either called from __dma_alloc on the non-coherent
> +	 * case or only once from atomic_pool_init. It is called
> +	 * during boot time so it is harmless to use the non-coherent
> +	 * case even if the L2C is coherent.
> +	 */
> +	__dma_clear_buffer(page, size, false);

This is no longer the case with commit 21caf3a765b0 ("ARM: 8398/1: arm
DMA: Fix allocation from CMA for coherent DMA") in -next. So you need
another argument for __alloc_from_contiguous() that can be passed down
to __dma_clear_buffer().

> @@ -1131,7 +1143,8 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
>  }
>  
>  static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
> -					  gfp_t gfp, struct dma_attrs *attrs)
> +					gfp_t gfp, struct dma_attrs *attrs,
> +					bool is_coherent)
>  {
>  	struct page **pages;
>  	int count = size >> PAGE_SHIFT;
> @@ -1154,7 +1167,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>  		if (!page)
>  			goto error;
>  
> -		__dma_clear_buffer(page, size);
> +		__dma_clear_buffer(page, size, is_coherent);
>  
>  		for (i = 0; i < count; i++)
>  			pages[i] = page + i;
> @@ -1198,7 +1211,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>  				pages[i + j] = pages[i] + j;
>  		}
>  
> -		__dma_clear_buffer(pages[i], PAGE_SIZE << order);
> +		__dma_clear_buffer(pages[i], PAGE_SIZE << order, is_coherent);
>  		i += 1 << order;
>  		count -= 1 << order;
>  	}
> @@ -1359,8 +1372,9 @@ static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
>  	__free_from_pool(cpu_addr, size);
>  }
>  
> -static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
> -	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
> +static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
> +	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs,
> +	    bool is_coherent)
>  {
>  	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
>  	struct page **pages;
> @@ -1381,7 +1395,7 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
>  	 */
>  	gfp &= ~(__GFP_COMP);
>  
> -	pages = __iommu_alloc_buffer(dev, size, gfp, attrs);
> +	pages = __iommu_alloc_buffer(dev, size, gfp, attrs, is_coherent);
>  	if (!pages)
>  		return NULL;
>  

I can see you are trying to fix the iommu_alloc code to cope with
coherent devices. I think it's currently broken and if you want to fix
it, you'd better add a separate patch. Otherwise, if no-one needs it,
just pass false to __dma_clear_buffer() in __iommu_alloc_buffer()
(though it's better if we fixed it).

In arm_iommu_alloc_attrs(), there is an __iommu_alloc_atomic() call
which goes to the non-cacheable pool, it should use
__alloc_simple_buffer() instead if is_coherent.

-- 
Catalin
