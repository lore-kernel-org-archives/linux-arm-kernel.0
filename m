From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 22 May 2014 08:17:21 +0200
Subject: [PATCH] arm: dma-mapping: add checking cma area initialized
In-Reply-To: <1400733503-1302-1-git-send-email-gioh.kim@lge.com>
References: <1400733503-1302-1-git-send-email-gioh.kim@lge.com>
Message-ID: <537D9671.6030505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-05-22 06:38, Gioh Kim wrote:
> If CMA is turned on and CMA size is set to zero, kernel should
> behave as if CMA was not enabled at compile time.
> Every dma allocation should check existence of cma area
> before requesting memory.
>
> Signed-off-by: Gioh Kim <gioh.kim@lge.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Acked-by: Michal Nazarewicz <mina86@mina86.com>

Thanks for this patch! The initial version was really ugly, but
this one really does what should be there from the begging.

I've applied this patch with redundant empty line add removed.

> ---
>   arch/arm/mm/dma-mapping.c |    7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 18e98df..9173a13 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -390,12 +390,13 @@ static int __init atomic_pool_init(void)
>   	if (!pages)
>   		goto no_pages;
>   
> -	if (IS_ENABLED(CONFIG_DMA_CMA))
> +	if (dev_get_cma_area(NULL))
>   		ptr = __alloc_from_contiguous(NULL, pool->size, prot, &page,
>   					      atomic_pool_init);
>   	else
>   		ptr = __alloc_remap_buffer(NULL, pool->size, gfp, prot, &page,
>   					   atomic_pool_init);
> +
>   	if (ptr) {
>   		int i;
>   
> @@ -701,7 +702,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>   		addr = __alloc_simple_buffer(dev, size, gfp, &page);
>   	else if (!(gfp & __GFP_WAIT))
>   		addr = __alloc_from_pool(size, &page);
> -	else if (!IS_ENABLED(CONFIG_DMA_CMA))
> +	else if (!dev_get_cma_area(dev))
>   		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
>   	else
>   		addr = __alloc_from_contiguous(dev, size, prot, &page, caller);
> @@ -790,7 +791,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   		__dma_free_buffer(page, size);
>   	} else if (__free_from_pool(cpu_addr, size)) {
>   		return;
> -	} else if (!IS_ENABLED(CONFIG_DMA_CMA)) {
> +	} else if (!dev_get_cma_area(dev)) {
>   		__dma_free_remap(cpu_addr, size);
>   		__dma_free_buffer(page, size);
>   	} else {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
