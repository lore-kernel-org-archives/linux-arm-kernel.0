From: rokhanna@nvidia.com (Rohit Khanna)
Date: Tue, 22 May 2018 18:08:03 +0000
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <f2db11aa-1a88-0447-6139-435536de2c61@arm.com>
References: <1526952438-22126-1-git-send-email-rokhanna@nvidia.com>,
 <f2db11aa-1a88-0447-6139-435536de2c61@arm.com>
Message-ID: <1527012507683.32009@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Suzuki, I have modified the patch and will send it for review.

Thanks
Rohit
________________________________________
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Sent: Tuesday, May 22, 2018 8:09 AM
To: Rohit Khanna; catalin.marinas at arm.com; robin.murphy at arm.com; mark.rutland at arm.com
Cc: Bo Yan; Alexander Van Brunt; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] arm64: alternative:flush cache with unpatched code

Rohit,

On 22/05/18 02:27, Rohit Khanna wrote:
> In the current implementation,  __apply_alternatives patches
> flush_icache_range and then executes it without invalidating the icache.
> Thus, icache can contain some of the old instructions for
> flush_icache_range. This can cause unpredictable behavior as during
> execution we can get a mix of old and new instructions for
> flush_icache_range.
>
> This patch :
>
> 1. Adds a new function flush_cache_kernel_range for flushing kernel
> memory range. This function is not patched during boot and can be safely
> used to flush cache during code patching.
>
> 2. Modifies __apply_alternatives so that it uses
> flush_cache_kernel_range to flush the cache range after patching code.
>
> Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
> ---
>   arch/arm64/include/asm/cacheflush.h |  1 +
>   arch/arm64/kernel/alternative.c     |  2 +-
>   arch/arm64/mm/cache.S               | 42 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 0094c6653b06..54692fabdf74 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -73,6 +73,7 @@
>    */
>   extern void flush_icache_range(unsigned long start, unsigned long end);
>   extern int  invalidate_icache_range(unsigned long start, unsigned long end);
> +extern void flush_cache_kernel_range(unsigned long start, unsigned long end);
>   extern void __flush_dcache_area(void *addr, size_t len);
>   extern void __inval_dcache_area(void *addr, size_t len);
>   extern void __clean_dcache_area_poc(void *addr, size_t len);
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index 5c4bce4ac381..a5408a3c297a 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -155,7 +155,7 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
>
>               alt_cb(alt, origptr, updptr, nr_inst);
>
> -             flush_icache_range((uintptr_t)origptr,
> +             flush_cache_kernel_range((uintptr_t)origptr,
>                                  (uintptr_t)(origptr + nr_inst));
>       }
>   }
> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index 30334d81b021..4dd09352a044 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -81,6 +81,48 @@ ENDPROC(flush_icache_range)
>   ENDPROC(__flush_cache_user_range)
>
>   /*
> + *   flush_cache_kernel_range(start,end)
> + *
> + *   Ensure that the I and D caches are coherent within specified kernel
> + *   region.
> + *   This is typically used when code has been written to a kernel memory
> + *   region and will be executed.
> + *
> + *   NOTE - This macro cannot have "alternatives" applied to it as its
> + *   used to update alternatives
> + *
> + *   - start   - virtual start address of region
> + *   - end     - virtual end address of region
> + */
> +ENTRY(flush_cache_kernel_range)
> +     dcache_line_size x2, x3
...

> +     icache_line_size x2, x3

You must use raw_{d,i}cache_line_size helpers above to avoid
using hot-patched code. The above helpers are patched if you
have mismatched cache line sizes.

Suzuki
