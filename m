From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Nov 2014 12:18:30 +0000
Subject: [PATCH RESEND] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <1416481742-23868-1-git-send-email-js07.lee@gmail.com>
References: <1416481742-23868-1-git-send-email-js07.lee@gmail.com>
Message-ID: <20141120121830.GC17633@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 11:09:02AM +0000, Jungseung Lee wrote:
> Modern ARMv7-A/R cores can optionally implement below new
> hardware feature:
> 
> - PXN:
> Privileged execute-never(PXN) is a security feature. PXN bit
> determines whether the processor can execute software from
> the region. This is effective solution against ret2usr attack.
> On an implementation that does not include the LPAE, PXN is
> optionally supported.
> 
> This patch set PXN bit on user page table for preventing
> user code execution with privilege mode.
> 
> Signed-off-by: Jungseung Lee <js07.lee@gmail.com>

I looked at the previous version but didn't get the time to reply. The
idea is good but I have some comments below.

> ---
>  arch/arm/include/asm/pgalloc.h              | 12 +++++++++++-
>  arch/arm/include/asm/pgtable-2level-hwdef.h |  2 ++
>  arch/arm/kernel/setup.c                     |  7 +++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> index 78a7793..a931544 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -25,6 +25,10 @@
>  #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_USER))
>  #define _PAGE_KERNEL_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_KERNEL))
>  
> +#ifdef CONFIG_CPU_V7
> +extern bool cpu_has_pxn;
> +#endif

It's better to use a function, e.g. cpu_has_pxn(), which is defined as 0
when !CONFIG_CPU_V7. This way you don't need many #ifdef's throughout
the code.

>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> @@ -157,7 +161,13 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
>  static inline void
>  pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
>  {
> -	__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
> +#ifdef CONFIG_CPU_V7
> +	if (cpu_has_pxn)
> +		__pmd_populate(pmdp, page_to_phys(ptep),
> +				_PAGE_USER_TABLE | PMD_PXNTABLE);
> +	else
> +#endif
> +		__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);

For the classic MMU, we can only set the PXN at the PMD level. With
LPAE, you could indeed use the hierarchical domain attributes (PXNTable)
or set it at the PTE directly. I would strongly recommend the use of PXN
attribute at the block/PTE level (bit 53). The reason for this is that
with LPAE we allow huge pages and the pmd becomes a block mapping with
the same bit layout as the PTE.

So you could define a cpu_has_classic_pxn() function and always set a
PTE_EXT_PXN on user ptes (basically anywhere we use L_PTE_USER with
LPAE).

> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index c031063..8556044 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -104,6 +104,9 @@ EXPORT_SYMBOL(elf_hwcap);
>  unsigned int elf_hwcap2 __read_mostly;
>  EXPORT_SYMBOL(elf_hwcap2);
>  
> +#ifdef CONFIG_CPU_V7
> +bool cpu_has_pxn;
> +#endif
>  
>  #ifdef MULTI_CPU
>  struct processor processor __read_mostly;
> @@ -390,6 +393,10 @@ static void __init cpuid_init_hwcaps(void)
>  
>  	/* LPAE implies atomic ldrd/strd instructions */
>  	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
> +#ifdef CONFIG_CPU_V7
> +	if (vmsa >= 4)
> +		cpu_has_pxn = 1;
> +#endif

No need for #ifdef here as this function exits early if less then ARMv7.

-- 
Catalin
