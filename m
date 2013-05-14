From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 14 May 2013 15:28:13 -0400 (EDT)
Subject: [PATCH] ARM: DMA-mapping: mark all !DMA_TO_DEVICE pages in
 unmapping as clean
In-Reply-To: <1367572365-18905-1-git-send-email-ming.lei@canonical.com>
References: <1367572365-18905-1-git-send-email-ming.lei@canonical.com>
Message-ID: <alpine.LFD.2.03.1305141445480.31158@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 May 2013, Ming Lei wrote:

> It is common for one sg to include many pages, so mark all these
> pages as clean to avoid unnecessary flushing on them in
> set_pte_at() or update_mmu_cache().

[...]

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index e9db6b4..e63124a 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -879,10 +879,23 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
>  	dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
>  
>  	/*
> -	 * Mark the D-cache clean for this page to avoid extra flushing.
> +	 * Mark the D-cache clean for these pages to avoid extra flushing.
>  	 */
> -	if (dir != DMA_TO_DEVICE && off == 0 && size >= PAGE_SIZE)
> -		set_bit(PG_dcache_clean, &page->flags);
> +	if (dir != DMA_TO_DEVICE && size >= PAGE_SIZE) {
> +		unsigned long pfn;
> +		size_t left = size;
> +
> +		pfn = page_to_pfn(page);

Could the offset ever be greater than a page?  The code in 
dma_cache_maint_page() appears to be written with that possibility in 
mind.  So you should have:

	pfn = page_to_pfn(page) + off / PAGE_SIZE;

> +		if (off) {
> +			pfn++;
> +			left -= PAGE_SIZE - off % PAGE_SIZE;
> +		}
> +		while (left >= PAGE_SIZE) {
> +			page = pfn_to_page(pfn++);
> +			set_bit(PG_dcache_clean, &page->flags);
> +			left -= PAGE_SIZE;
> +		}
> +	}
>  }

Otherwise this looks fine to me.


Nicolas
