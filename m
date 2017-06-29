From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 29 Jun 2017 12:16:45 +0100
Subject: [PATCH v2] ARM: memblock limit must be pmd-aligned
In-Reply-To: <20170627173330.13804-1-opendmb@gmail.com>
References: <20170627173330.13804-1-opendmb@gmail.com>
Message-ID: <20170629111645.GC11040@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 10:33:29AM -0700, Doug Berger wrote:
> The pmd containing memblock_limit is cleared by prepare_page_table()
> which creates the opportunity for early_alloc() to allocate unmapped
> memory if memblock_limit is not pmd aligned causing a boot-time hang.
> 
> Commit 965278dcb8ab ("ARM: 8356/1: mm: handle non-pmd-aligned end of RAM")
> attempted to resolve this problem, but there is a path through the
> adjust_lowmem_bounds() routine where if all memory regions start and
> end on pmd-aligned addresses the memblock_limit will be set to
> arm_lowmem_limit.
> 
> Since arm_lowmem_limit can be affected by the vmalloc early parameter,
> the value of arm_lowmem_limit may not be pmd-aligned. This commit
> corrects this oversight such that memblock_limit is always rounded
> down to pmd-alignment.
> 
> Fixes: 965278dcb8ab ("ARM: 8356/1: mm: handle non-pmd-aligned end of RAM")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>

As a minor nit, it would be better for the title to be something like
"ARM: ensure memblock-limit is pmd-aligned", but either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Assuming Russell doesn't have any furhter comments, this looks good to
drop into the patch system. See:

  http://www.arm.linux.org.uk/developer/patches/info.php

... for instructions on how to send patches there.

Thanks,
Mark.

> ---
> Changes for v2:
>  - Cleaner equivalent implementation suggested by Mark Rutland
>  - Revised description to better capture the history
> 
>  arch/arm/mm/mmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 31af3cb59a60..e46a6a446cdd 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1218,15 +1218,15 @@ void __init adjust_lowmem_bounds(void)
>  
>  	high_memory = __va(arm_lowmem_limit - 1) + 1;
>  
> +	if (!memblock_limit)
> +		memblock_limit = arm_lowmem_limit;
> +
>  	/*
>  	 * Round the memblock limit down to a pmd size.  This
>  	 * helps to ensure that we will allocate memory from the
>  	 * last full pmd, which should be mapped.
>  	 */
> -	if (memblock_limit)
> -		memblock_limit = round_down(memblock_limit, PMD_SIZE);
> -	if (!memblock_limit)
> -		memblock_limit = arm_lowmem_limit;
> +	memblock_limit = round_down(memblock_limit, PMD_SIZE);
>  
>  	if (!IS_ENABLED(CONFIG_HIGHMEM) || cache_is_vipt_aliasing()) {
>  		if (memblock_end_of_DRAM() > arm_lowmem_limit) {
> -- 
> 2.13.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
