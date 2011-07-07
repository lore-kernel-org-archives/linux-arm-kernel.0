From: gdavis@mvista.com (George G. Davis)
Date: Thu, 7 Jul 2011 00:25:40 -0400
Subject: parallel load of modules on an ARM multicore
In-Reply-To: <20110621155030.GA21245@1n450.cable.virginmedia.net>
References: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
	<20110621155030.GA21245@1n450.cable.virginmedia.net>
Message-ID: <20110707042540.GH402@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 21, 2011 at 04:50:30PM +0100, Catalin Marinas wrote:

// CUT

> ARM: Allow lazy cache flushing on ARM11MPCore
> 
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> The ARM11MPCore doesn't broadcast the cache maintenance operations in
> hardware, therefore the flush_dcache_page() currently performs the cache
> flushing non-lazily. But since not all drivers call this function after
> writing to a page cache page, the kernel needs a different approach like
> using read-for-ownership on the CPU flushing the cache to force the
> dirty cache lines migration from other CPUs. This way the cache flushing
> operation can be done lazily via __sync_icache_dcache().
> 
> Since we cannot force read-for-ownership on the I-cache, the patch
> invalidates the whole I-cache when a thread migrates to another CPU.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/include/asm/mmu_context.h |    3 ++-
>  arch/arm/mm/cache-v6.S             |    8 ++++++++
>  arch/arm/mm/flush.c                |    3 +--
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
> index 71605d9..d116a23 100644
> --- a/arch/arm/include/asm/mmu_context.h
> +++ b/arch/arm/include/asm/mmu_context.h
> @@ -114,7 +114,8 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  #ifdef CONFIG_SMP
>  	/* check for possible thread migration */
>  	if (!cpumask_empty(mm_cpumask(next)) &&
> -	    !cpumask_test_cpu(cpu, mm_cpumask(next)))
> +	    (cache_ops_need_broadcast() ||
> +	     !cpumask_test_cpu(cpu, mm_cpumask(next))))
>  		__flush_icache_all();
>  #endif
>  	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index 73b4a8b..bdc1cc1 100644
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -133,6 +133,10 @@ ENTRY(v6_coherent_user_range)
>  #ifdef HARVARD_CACHE
>  	bic	r0, r0, #CACHE_LINE_SIZE - 1
>  1:
> +#ifdef CONFIG_SMP

s/CONFIG_SMP/CONFIG_RWFO/

> +	/* no cache maintenance broadcasting on ARM11MPCore */
> + USER(	ldr	r2, [r0]		)	@ read for ownership
> +#endif
>   USER(	mcr	p15, 0, r0, c7, c10, 1	)	@ clean D line
>  	add	r0, r0, #CACHE_LINE_SIZE
>  2:
> @@ -178,6 +182,10 @@ ENTRY(v6_flush_kern_dcache_area)
>  	add	r1, r0, r1
>  	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>  1:
> +#ifdef CONFIG_SMP

s/CONFIG_SMP/CONFIG_RWFO/


--
Regards,
George

> +	/* no cache maintenance broadcasting on ARM11MPCore */
> +	ldr	r2, [r0]			@ read for ownership
> +#endif
>  #ifdef HARVARD_CACHE
>  	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
>  #else
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 1a8d4aa..72f9333 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -291,8 +291,7 @@ void flush_dcache_page(struct page *page)
>  
>  	mapping = page_mapping(page);
>  
> -	if (!cache_ops_need_broadcast() &&
> -	    mapping && !mapping_mapped(mapping))
> +	if (mapping && !mapping_mapped(mapping))
>  		clear_bit(PG_dcache_clean, &page->flags);
>  	else {
>  		__flush_dcache_page(mapping, page);
> 
> -- 
> Catalin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
