From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Nov 2015 10:39:13 +0000
Subject: [PATCH] ARM:dma-mapping: Handle DMA_BIDIRECTIONAL in
 _dma_page_cpu_to_dev()
In-Reply-To: <1446631008-5854-1-git-send-email-sanjeev_sharma@mentor.com>
References: <1446631008-5854-1-git-send-email-sanjeev_sharma@mentor.com>
Message-ID: <20151104103913.GC5405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 03:26:48PM +0530, Sanjeev Sharma wrote:
> _dma_page_cpu_to_dev() treat DMA_BIDIRECTIONAL similar to DMA_TO_DEVICE
> which means that destination buffer is device memory,means cpu may have
> written some data to source buffer and data may be in cache line.For
> cleaner operation we need to call outer_flush_range() which will
> clean and invalidate outer cache lines.

Why isn't the clean sufficient in this case? We're mapping the buffer
to the device, so we clean the dirty lines in the CPU caches and make
them visible to the device. If the CPU later wants to read the buffer
(i.e. after the device has DMA'd into it), you'll need to map the
buffer to the CPU, which will perform the invalidation of the CPU caches.

Will

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index e62400e..e195235 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -850,12 +850,20 @@ static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
>  	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
>  
>  	paddr = page_to_phys(page) + off;
> -	if (dir == DMA_FROM_DEVICE) {
> -		outer_inv_range(paddr, paddr + size);
> -	} else {
> -		outer_clean_range(paddr, paddr + size);
> +
> +	switch (dir) {
> +	case DMA_FROM_DEVICE:
> +			outer_inv_range(paddr, paddr + size);
> +			break;
> +	case DMA_TO_DEVICE:
> +			outer_clean_range(paddr, paddr + size);
> +			break;
> +	case DMA_BIDIRECTIONAL:
> +			outer_flush_range(paddr, paddr + size);
> +			break;
> +	default:
> +			break;
>  	}
> -	/* FIXME: non-speculating: flush on bidirectional mappings? */
>  }
>  
>  static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
> -- 
> 1.7.11.7
> 
