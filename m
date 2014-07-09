From: msalter@redhat.com (Mark Salter)
Date: Wed, 09 Jul 2014 16:49:02 -0400
Subject: [PATCH 1/2] arm: use generic fixmap.h
In-Reply-To: <1404898792-4201-2-git-send-email-leif.lindholm@linaro.org>
References: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
 <1404898792-4201-2-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1404938942.24950.12.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-09 at 10:39 +0100, Leif Lindholm wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> ARM is different from other architectures in that fixmap pages are
> indexed with a positive offset from FIXADDR_START. Other architectures
> index with a negative offset from FIXADDR_TOP. In order to use the
> generic fixmap.h definitions, this patch redefines FIXADDR_TOP to be
> inclusive of the useable range. That is, FIXADDR_TOP is the virtual
> address of the topmost fixed page. The newly defined FIXADDR_END is
> the first virtual address past the fixed mappings.
> 
> The patch also introduces local helper macros in highmem.c to reverse
> the iteration order of fixmap pages.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> [Rebased to 3.16-rc4, reverse kmap fixmap traversal]
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  arch/arm/include/asm/fixmap.h |   45 ++++++++++++++++++++++++++---------------
>  arch/arm/mm/highmem.c         |   13 +++++++-----
>  arch/arm/mm/init.c            |    2 +-
>  3 files changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
> index 74124b0..8992431 100644
> --- a/arch/arm/include/asm/fixmap.h
> +++ b/arch/arm/include/asm/fixmap.h
> @@ -1,28 +1,41 @@
>  #ifndef _ASM_FIXMAP_H
>  #define _ASM_FIXMAP_H
>  
> +#include <asm/pgtable.h>
> +
>  #define FIXADDR_START		0xffc00000UL
> -#define FIXADDR_TOP		0xffe00000UL
> -#define FIXADDR_SIZE		(FIXADDR_TOP - FIXADDR_START)
> +#define FIXADDR_END		0xffe00000UL
> +#define FIXADDR_SIZE		(FIXADDR_END - FIXADDR_START)
> +#define FIXADDR_TOP		(FIXADDR_END - PAGE_SIZE)
>  
>  #define FIX_KMAP_NR_PTES	(FIXADDR_SIZE >> PAGE_SHIFT)
>  
> -#define __fix_to_virt(x)	(FIXADDR_START + ((x) << PAGE_SHIFT))
> -#define __virt_to_fix(x)	(((x) - FIXADDR_START) >> PAGE_SHIFT)
> +enum fixed_addresses {
> +	FIX_KMAP_BEGIN,
> +	FIX_KMAP_END = FIX_KMAP_NR_PTES - 1,
> +	__end_of_fixed_addresses
> +};
> +
> +/*
> + * Temporary boot-time mappings, used by early_ioremap(),
> + * before ioremap() is functional.
> + *
> + * (P)re-using the last pmd of the FIXADDR region, which is used for
> + * highmem later on, and statically aligned to 1MB.
> + * Growing down from FIXADDR_TOP
> + */
> +#define NR_FIX_BTMAPS		32
> +#define FIX_BTMAPS_SLOTS	(PTRS_PER_PTE / NR_FIX_BTMAPS)
> +#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> +#define FIX_BTMAP_END		FIX_KMAP_BEGIN
> +#define FIX_BTMAP_BEGIN		(FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1)
>  
> -extern void __this_fixmap_does_not_exist(void);
> +#define FIXMAP_PAGE_NORMAL (L_PTE_MT_WRITEBACK | L_PTE_YOUNG | L_PTE_PRESENT)
> +#define FIXMAP_PAGE_IO (L_PTE_MT_DEV_NONSHARED | L_PTE_YOUNG | L_PTE_PRESENT)
>  
> -static inline unsigned long fix_to_virt(const unsigned int idx)
> -{
> -	if (idx >= FIX_KMAP_NR_PTES)
> -		__this_fixmap_does_not_exist();
> -	return __fix_to_virt(idx);
> -}
> +extern void __early_set_fixmap(enum fixed_addresses idx,
> +			       phys_addr_t phys, pgprot_t flags);
>  
> -static inline unsigned int virt_to_fix(const unsigned long vaddr)
> -{
> -	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
> -	return __virt_to_fix(vaddr);
> -}
> +#include <asm-generic/fixmap.h>
>  
>  #endif
> diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
> index 45aeaac..3c59cdf 100644
> --- a/arch/arm/mm/highmem.c
> +++ b/arch/arm/mm/highmem.c
> @@ -20,16 +20,19 @@
>  
>  pte_t *fixmap_page_table;
>  
> +#define __kmap_fix_to_virt(x)	(__fix_to_virt(FIX_KMAP_NR_PTES - 1 - (x)))

FIX_KMAP_END - (x) ?

> +#define __kmap_virt_to_fix(x)	(FIX_KMAP_NR_PTES - 1 - __fix_to_virt(x))

shouldn't this use __virt_to_fix(x)?

> +
>  static inline void set_fixmap_pte(int idx, pte_t pte)
>  {
> -	unsigned long vaddr = __fix_to_virt(idx);
> +	unsigned long vaddr = __kmap_fix_to_virt(idx);
>  	set_pte_ext(fixmap_page_table + idx, pte, 0);
>  	local_flush_tlb_kernel_page(vaddr);
>  }
>  
>  static inline pte_t get_fixmap_pte(unsigned long vaddr)
>  {
> -	unsigned long idx = __virt_to_fix(vaddr);
> +	unsigned long idx = __kmap_virt_to_fix(vaddr);
>  	return *(fixmap_page_table + idx);
>  }
>  
> @@ -78,7 +81,7 @@ void *kmap_atomic(struct page *page)
>  	type = kmap_atomic_idx_push();
>  
>  	idx = type + KM_TYPE_NR * smp_processor_id();
> -	vaddr = __fix_to_virt(idx);
> +	vaddr = __kmap_fix_to_virt(idx);
>  #ifdef CONFIG_DEBUG_HIGHMEM
>  	/*
>  	 * With debugging enabled, kunmap_atomic forces that entry to 0.
> @@ -109,7 +112,7 @@ void __kunmap_atomic(void *kvaddr)
>  		if (cache_is_vivt())
>  			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
>  #ifdef CONFIG_DEBUG_HIGHMEM
> -		BUG_ON(vaddr != __fix_to_virt(idx));
> +		BUG_ON(vaddr != __kmap_fix_to_virt(idx));
>  		set_fixmap_pte(idx, __pte(0));
>  #else
>  		(void) idx;  /* to kill a warning */
> @@ -132,7 +135,7 @@ void *kmap_atomic_pfn(unsigned long pfn)
>  
>  	type = kmap_atomic_idx_push();
>  	idx = type + KM_TYPE_NR * smp_processor_id();
> -	vaddr = __fix_to_virt(idx);
> +	vaddr = __kmap_fix_to_virt(idx);
>  #ifdef CONFIG_DEBUG_HIGHMEM
>  	BUG_ON(!pte_none(*(fixmap_page_table + idx)));
>  #endif
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 659c75d..ad82c05 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -570,7 +570,7 @@ void __init mem_init(void)
>  			MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
>  			MLK(ITCM_OFFSET, (unsigned long) itcm_end),
>  #endif
> -			MLK(FIXADDR_START, FIXADDR_TOP),
> +			MLK(FIXADDR_START, FIXADDR_END),
>  			MLM(VMALLOC_START, VMALLOC_END),
>  			MLM(PAGE_OFFSET, (unsigned long)high_memory),
>  #ifdef CONFIG_HIGHMEM
