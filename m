From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 30 Jan 2018 11:14:36 +0100
Subject: [PATCH 2/5] drm: add ARM flush implementation
In-Reply-To: <20180124025606.3020-2-gurchetansingh@chromium.org>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
Message-ID: <20180130101436.GK25930@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 06:56:03PM -0800, Gurchetan Singh wrote:
> The dma_cache_maint_page function is important for cache maintenance on
> ARM32 (this was determined via testing).
> 
> Since we desire direct control of the caches in drm_cache.c, let's make
> a copy of the function, rename it and use it.
> 
> v2: Don't use DMA API, call functions directly (Daniel)
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>

fwiw, in principle, this approach has my Ack from the drm side.

But if we can't get any agreement from the arch side then I guess we'll
just have to suck it up and mandate that any dma-buf on ARM32 must be wc
mapped, always. Not sure that's a good idea either, but should at least
get things moving.
-Daniel

> ---
>  drivers/gpu/drm/drm_cache.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
> index 89cdd32fe1f3..5124582451c6 100644
> --- a/drivers/gpu/drm/drm_cache.c
> +++ b/drivers/gpu/drm/drm_cache.c
> @@ -69,6 +69,55 @@ static void drm_cache_flush_clflush(struct page *pages[],
>  }
>  #endif
>  
> +#if defined(CONFIG_ARM)
> +static void drm_cache_maint_page(struct page *page, unsigned long offset,
> +				 size_t size, enum dma_data_direction dir,
> +				 void (*op)(const void *, size_t, int))
> +{
> +	unsigned long pfn;
> +	size_t left = size;
> +
> +	pfn = page_to_pfn(page) + offset / PAGE_SIZE;
> +	offset %= PAGE_SIZE;
> +
> +	/*
> +	 * A single sg entry may refer to multiple physically contiguous
> +	 * pages.  But we still need to process highmem pages individually.
> +	 * If highmem is not configured then the bulk of this loop gets
> +	 * optimized out.
> +	 */
> +	do {
> +		size_t len = left;
> +		void *vaddr;
> +
> +		page = pfn_to_page(pfn);
> +
> +		if (PageHighMem(page)) {
> +			if (len + offset > PAGE_SIZE)
> +				len = PAGE_SIZE - offset;
> +
> +			if (cache_is_vipt_nonaliasing()) {
> +				vaddr = kmap_atomic(page);
> +				op(vaddr + offset, len, dir);
> +				kunmap_atomic(vaddr);
> +			} else {
> +				vaddr = kmap_high_get(page);
> +				if (vaddr) {
> +					op(vaddr + offset, len, dir);
> +					kunmap_high(page);
> +				}
> +			}
> +		} else {
> +			vaddr = page_address(page) + offset;
> +			op(vaddr, len, dir);
> +		}
> +		offset = 0;
> +		pfn++;
> +		left -= len;
> +	} while (left);
> +}
> +#endif
> +
>  /**
>   * drm_flush_pages - Flush dcache lines of a set of pages.
>   * @pages: List of pages to be flushed.
> @@ -104,6 +153,12 @@ drm_flush_pages(struct page *pages[], unsigned long num_pages)
>  				   (unsigned long)page_virtual + PAGE_SIZE);
>  		kunmap_atomic(page_virtual);
>  	}
> +#elif defined(CONFIG_ARM)
> +	unsigned long i;
> +
> +	for (i = 0; i < num_pages; i++)
> +		drm_cache_maint_page(pages[i], 0, PAGE_SIZE, DMA_TO_DEVICE,
> +				     dmac_map_area);
>  #else
>  	pr_err("Architecture has no drm_cache.c support\n");
>  	WARN_ON_ONCE(1);
> @@ -135,6 +190,12 @@ drm_flush_sg(struct sg_table *st)
>  
>  	if (wbinvd_on_all_cpus())
>  		pr_err("Timed out waiting for cache flush\n");
> +#elif defined(CONFIG_ARM)
> +	struct sg_page_iter sg_iter;
> +
> +	for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
> +		drm_cache_maint_page(sg_page_iter_page(&sg_iter), 0, PAGE_SIZE,
> +				     DMA_TO_DEVICE, dmac_map_area);
>  #else
>  	pr_err("Architecture has no drm_cache.c support\n");
>  	WARN_ON_ONCE(1);
> -- 
> 2.13.5
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
