From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2009 15:31:35 +0000
Subject: [RFC 02/11] ARM: Fix errata 411920 workarounds
In-Reply-To: <6af8ea18ac64a74700e374489751a63e643ac394.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<6af8ea18ac64a74700e374489751a63e643ac394.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <1256743895.27121.39.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-10-24 at 22:36 +0100, Russell King wrote:
> Errata 411920 indicates that any "invalidate entire instruction cache"
> operation can fail if the right conditions are present.  This is not
> limited just to those operations in flush.c, but elsewhere.  Place the
> workaround in the already existing __flush_icache_all() function
> instead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/cacheflush.h |    5 +++++
>  arch/arm/mm/context.c             |    4 ++--
>  arch/arm/mm/flush.c               |   31 ++++++-------------------------
>  3 files changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 3147f75..af0624c 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -412,9 +412,14 @@ extern void flush_dcache_page(struct page *);
>  
>  static inline void __flush_icache_all(void)
>  {
> +#ifdef CONFIG_ARM_ERRATA_411920
> +	extern void v6_icache_inval_all(void);
> +	v6_icache_inval_all();
> +#else

I think some compiler complain of "extern" declarations inside a
function, not entirely sure.

>         asm("mcr        p15, 0, %0, c7, c5, 0   @ invalidate I-cache\n"
>             :
>             : "r" (0));
> +#endif
>  }

For correctness, can we add a dsb() at the end of this function so that
the I-cache operation is guaranteed to complete?

> diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> index 6bda76a..d4f8275 100644
> --- a/arch/arm/mm/context.c
> +++ b/arch/arm/mm/context.c
> @@ -50,8 +50,8 @@ void __new_context(struct mm_struct *mm)
>  		isb();
>  		flush_tlb_all();
>  		if (icache_is_vivt_asid_tagged()) {
> -			asm("mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache\n"
> -			    "mcr	p15, 0, %0, c7, c5, 6	@ flush BTAC/BTB\n"
> +			__flush_icache_all();
> +			asm("mcr	p15, 0, %0, c7, c5, 6	@ flush BTAC/BTB"

IIUC, we don't need to flush the BTAC after a full I-cache invalidation
(not sure why I added it).
 
-- 
Catalin
