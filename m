From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 28 Jan 2015 14:17:00 +0000
Subject: [PATCH] arm64: drop unnecessary cache+tlb maintenance
In-Reply-To: <1422377570-16761-1-git-send-email-mark.rutland@arm.com>
References: <1422377570-16761-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20150128141659.GA16652@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 04:52:50PM +0000, Mark Rutland wrote:
> In paging_init, we call flush_cache_all, but this is backed by Set/Way
> operations which may not achieve anything in the presence of cache line
> migration and/or system caches. If the caches are already in an
> inconsistent state at this point, there is nothing we can do (short of
> flushing the entire physical address space by VA) to empty architected
> and system caches. As such, flush_cache_all only serves to mask other
> potential bugs. Hence, this patch removes the boot-time call to
> flush_cache_all.
> 
> Immediately after the cache maintenance we flush the TLBs, but this is
> also unnecessary. Before enabling the MMU, the TLBs are invalidated, and
> thus are initially clean. When changing the contents of active tables
> (e.g. in fixup_executable() for DEBUG_RODATA) we perform the required
> TLB maintenance following the update, and therefore no additional
> maintenance is required to ensure the new table entries are in effect.
> Since activating the MMU we will not have modified system register
> fields permitted to be cached in a TLB, and therefore do not need
> maintenance for any cached system register fields. Hence, the TLB flush
> is unnecessary.
> 
> Shortly after the unnecessary TLB flush, we update TTBR0 to point to an
> empty zero page rather than the idmap, and flush the TLBs. This
> maintenance is necessary to remove the global idmap entries from the
> TLBs (as they would conflict with userspace mappings), and is retained.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>

Hi Mark,

This looks reasonable to me.

Please feel free to add:

Acked-by: Steve Capper <steve.capper@linaro.org>

Cheers,
-- 
Steve

> ---
>  arch/arm64/mm/mmu.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 29fe8aa..88f7ac2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -431,13 +431,6 @@ void __init paging_init(void)
>  	map_mem();
>  	fixup_executable();
>  
> -	/*
> -	 * Finally flush the caches and tlb to ensure that we're in a
> -	 * consistent state.
> -	 */
> -	flush_cache_all();
> -	flush_tlb_all();
> -
>  	/* allocate the zero page. */
>  	zero_page = early_alloc(PAGE_SIZE);
>  
> -- 
> 1.9.1
> 
