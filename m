From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Jan 2013 17:15:28 +0000
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform
 coherency exit/setup
In-Reply-To: <20130114170851.GA1967@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
 <20130114170851.GA1967@linaro.org>
Message-ID: <20130114171528.GF23616@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 05:08:51PM +0000, Dave Martin wrote:
> From b64f305c90e7ea585992df2d710f62ec6a7b5395 Mon Sep 17 00:00:00 2001
> From: Dave Martin <dave.martin@linaro.org>
> Date: Mon, 14 Jan 2013 16:25:47 +0000
> Subject: [PATCH] ARM: b.L: Fix outer cache handling for coherency setup/exit helpers
> 
> This patch addresses the following issues:
> 
>   * When invalidating stale data from the cache before a read,
>     outer caches must be invalidated _before_ inner caches, not
>     after, otherwise stale data may be re-filled from outer to
>     inner after the inner cache is flushed.
> 
>     We still retain an inner clean before touching the outer cache,
>     to avoid stale data being rewritten from there into the outer
>     cache after the outer cache is flushed.
> 
>   * All the sync_mem() calls synchronise either reads or writes,
>     but not both.  This patch splits sync_mem() into separate
>     functions for reads and writes, to avoid excessive inner
>     flushes in the write case.
> 
>     The two functions are different from the original sync_mem(),
>     to fix the above issues.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> NOTE: This patch is build-tested only.
> 
>  arch/arm/common/bL_entry.c |   57 ++++++++++++++++++++++++++++++++++----------
>  1 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c
> index 1ea4ec9..3e1a404 100644
> --- a/arch/arm/common/bL_entry.c
> +++ b/arch/arm/common/bL_entry.c
> @@ -119,16 +119,47 @@ int bL_cpu_powered_up(void)
>  
>  struct bL_sync_struct bL_sync;
>  
> -static void __sync_range(volatile void *p, size_t size)
> +/*
> + * Ensure preceding writes to *p by this CPU are visible to
> + * subsequent reads by other CPUs:
> + */
> +static void __sync_range_w(volatile void *p, size_t size)
>  {
>  	char *_p = (char *)p;
>  
>  	__cpuc_flush_dcache_area(_p, size);
> -	outer_flush_range(__pa(_p), __pa(_p + size));
> +	outer_clean_range(__pa(_p), __pa(_p + size));
>  	outer_sync();

It's not part of your patch but I thought about commenting here. The
outer_clean_range() already has a cache_sync() operation, so no need for
the additional outer_sync().

>  }
>  
> -#define sync_mem(ptr) __sync_range(ptr, sizeof *(ptr))
> +/*
> + * Ensure preceding writes to *p by other CPUs are visible to
> + * subsequent reads by this CPU:
> + */
> +static void __sync_range_r(volatile void *p, size_t size)
> +{
> +	char *_p = (char *)p;
> +
> +#ifdef CONFIG_OUTER_CACHE
> +	if (outer_cache.flush_range) {
> +		/*
> +		 * Ensure ditry data migrated from other CPUs into our cache
> +		 * are cleaned out safely before the outer cache is cleaned:
> +		 */
> +		__cpuc_flush_dcache_area(_p, size);
> +
> +		/* Clean and invalidate stale data for *p from outer ... */
> +		outer_flush_range(__pa(_p), __pa(_p + size));
> +		outer_sync();

Same here.

-- 
Catalin
