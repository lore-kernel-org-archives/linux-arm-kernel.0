From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 5 Nov 2015 13:40:14 +0900
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <1442944788-17254-1-git-send-email-rric@kernel.org>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
Message-ID: <20151105044014.GB20374@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 07:59:48PM +0200, Robert Richter wrote:
> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> 
> Increase the standard cacheline size to avoid having locks in the same
> cacheline.
> 
> Cavium's ThunderX core implements cache lines of 128 byte size. With
> current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
> share the same cache line leading a performance degradation.
> Increasing the size fixes that.

Beside, slab-side bug, I don't think this argument is valid.
Even if this change is applied, statically allocated spinlock could
share the same cache line.

If two locks should not share the same cache line, you'd better to use
compiler attribute such as ____cacheline_aligned_in_smp in appropriate
place.

Thanks.

> 
> Increasing the size has no negative impact to cache invalidation on
> systems with a smaller cache line. There is an impact on memory usage,
> but that's not too important for arm64 use cases.
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm64/include/asm/cache.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index bde449936e2f..5082b30bc2c0 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -18,7 +18,7 @@
>  
>  #include <asm/cachetype.h>
>  
> -#define L1_CACHE_SHIFT		6
> +#define L1_CACHE_SHIFT		7
>  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
>  
>  /*
> -- 
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
