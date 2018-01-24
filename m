From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Jan 2018 12:45:42 +0000
Subject: [PATCH 2/5] drm: add ARM flush implementation
In-Reply-To: <20180124025606.3020-2-gurchetansingh@chromium.org>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
Message-ID: <20180124124542.GV17719@n2100.armlinux.org.uk>
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

NAK.  With this, you're "going under the covers" of the architecture and
using architecture private functions (dmac_map_area/dmac_unmap_area) in
a driver.

The hint is that dmac_map_area() and dmac_unmap_area() are not declared
in any asm/*.h header file, but in arch/arm/mm/dma.h, and they carry this
warning above their definition:

/*
 * These are private to the dma-mapping API.  Do not use directly.
 * Their sole purpose is to ensure that data held in the cache
 * is visible to DMA, or data written by DMA to system memory is
 * visible to the CPU.
 */

So no, this is not an acceptable approach.

Secondly, in light of spectre and meltdown, do we _really_ want to
export cache flushing to userspace in any case - these attacks rely
on being able to flush specific cache lines from the caches in order
to do the timing attacks (while leaving others in place.)

Currently, 32-bit ARM does not export such flushing capabilities to
userspace, which makes it very difficult (I'm not going to say
impossible) to get any working proof-of-code program that even
illustrates the timing attack.  Exposing this functionality changes
that game, and means that we're much more open to these exploits.
(Some may say that you can flush cache lines by reading a large
enough buffer - I'm aware, I've tried that, the results are too
unreliable even for a simple attempt which doesn't involve crossing
privilege boundaries.)

Do you really need cacheable GPU buffers, or will write combining
buffers (as we use elsewhere such as etnaviv) suffice?  Please provide
some _real_ _world_ performance measurements that demonstrate that
there is a real need for this functionality.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
