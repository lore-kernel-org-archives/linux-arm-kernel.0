From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Oct 2018 15:53:25 +0100
Subject: [PATCH] arm64: mm: Use #ifdef for the  __PAGETABLE_P?D_FOLDED
 defines
In-Reply-To: <20181005134916.12937-1-james.morse@arm.com>
References: <20181005134916.12937-1-james.morse@arm.com>
Message-ID: <20181005145324.e3o6i3zeszilzuzx@blommer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 02:49:16PM +0100, James Morse wrote:
> __is_defined(__PAGETABLE_P?D_FOLDED) doesn't quite work as intended
> as these symbols are internal to asm-generic and aren't defined in the
> way kconfig expects. This makes them always evaluate to false.
> Switch to #ifdef.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: Mark Rutland <mark.rutland@arm.com>

Sorry for the bogus cleanup.

FWIW: Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> 
>  arch/arm64/include/asm/pgtable.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b58f764babf8..50b1ef8584c0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -445,10 +445,12 @@ static inline bool in_swapper_pgdir(void *addr)
>  
>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  {
> -	if (__is_defined(__PAGETABLE_PMD_FOLDED) && in_swapper_pgdir(pmdp)) {
> +#ifdef __PAGETABLE_PMD_FOLDED
> +	if (in_swapper_pgdir(pmdp)) {
>  		set_swapper_pgd((pgd_t *)pmdp, __pgd(pmd_val(pmd)));
>  		return;
>  	}
> +#endif /* __PAGETABLE_PMD_FOLDED */
>  
>  	WRITE_ONCE(*pmdp, pmd);
>  
> @@ -503,10 +505,12 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>  
>  static inline void set_pud(pud_t *pudp, pud_t pud)
>  {
> -	if (__is_defined(__PAGETABLE_PUD_FOLDED) && in_swapper_pgdir(pudp)) {
> +#ifdef __PAGETABLE_PUD_FOLDED
> +	if (in_swapper_pgdir(pudp)) {
>  		set_swapper_pgd((pgd_t *)pudp, __pgd(pud_val(pud)));
>  		return;
>  	}
> +#endif /* __PAGETABLE_PUD_FOLDED */
>  
>  	WRITE_ONCE(*pudp, pud);
>  
> -- 
> 2.19.0
> 
