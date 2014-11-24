From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Nov 2014 14:32:08 +0000
Subject: [PATCH] arm64:mm: free the useless initial page table
In-Reply-To: <1416558460-7257-1-git-send-email-zhichang.yuan@linaro.org>
References: <1416558460-7257-1-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <20141124143208.GE15872@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 08:27:40AM +0000, zhichang.yuan at linaro.org wrote:
> From: "zhichang.yuan" <zhichang.yuan@linaro.org>
> 
> For 64K page system, after mapping a PMD section, the corresponding initial
> page table is not needed any more. That page can be freed.
> 
> Signed-off-by: Zhichang Yuan <zhichang.yuan@linaro.org>
> ---
>  arch/arm64/mm/mmu.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index f4f8b50..12a336b 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -191,8 +191,11 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>  			 * Check for previous table entries created during
>  			 * boot (__create_page_tables) and flush them.
>  			 */
> -			if (!pmd_none(old_pmd))
> +			if (!pmd_none(old_pmd)) {
>  				flush_tlb_all();
> +				if (pmd_table(old_pmd))
> +					memblock_free(pte_pfn(pmd_pte(old_pmd)) << PAGE_SHIFT, PAGE_SIZE);
> +			}

For consistency with alloc_init_pud(), could you do:

	phys_addr_t table = __pa(pte_offset(&old_pmd, 0));
	memblock_free(table, PAGE_SIZE);

Since you are at this, for alloc_init_pud() could you please move the
flush_tlb_all() before memblock_free()? Theoretical problem really but
it's nice for consistency.

Thanks.

-- 
Catalin
