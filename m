From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Oct 2013 16:16:15 -0400 (EDT)
Subject: [PATCH V3] ARM: mm: make UACCESS_WITH_MEMCPY huge page aware
In-Reply-To: <1381489919-2508-1-git-send-email-steve.capper@linaro.org>
References: <1381489919-2508-1-git-send-email-steve.capper@linaro.org>
Message-ID: <alpine.LFD.2.03.1310111615570.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Steve Capper wrote:

> The memory pinning code in uaccess_with_memcpy.c does not check
> for HugeTLB or THP pmds, and will enter an infinite loop should
> a __copy_to_user or __clear_user occur against a huge page.
> 
> This patch adds detection code for huge pages to pin_page_for_write.
> As this code can be executed in a fast path it refers to the actual
> pmds rather than the vma. If a HugeTLB or THP is found (they have
> the same pmd representation on ARM), the page table spinlock is
> taken to prevent modification whilst the page is pinned.
> 
> On ARM, huge pages are only represented as pmds, thus no huge pud
> checks are performed. (For huge puds one would lock the page table
> in a similar manner as in the pmd case).
> 
> Two helper functions are introduced; pmd_thp_or_huge will check
> whether or not a page is huge or transparent huge (which have the
> same pmd layout on ARM), and pmd_hugewillfault will detect whether
> or not a page fault will occur on write to the page.
> 
> Running the following test (with the chunking from read_zero
> removed):
>  $ dd if=/dev/zero of=/dev/null bs=10M count=1024
> Gave:  2.3 GB/s backed by normal pages,
>        2.9 GB/s backed by huge pages,
>        5.1 GB/s backed by huge pages, with page mask=HPAGE_MASK.
> 
> After some discussion, it was decided not to adopt the HPAGE_MASK,
> as this would have a significant detrimental effect on the overall
> system latency due to page_table_lock being held for too long.
> This could be revisited if split huge page locks are adopted.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Changes in V3:
> pmd_hugewillfault and pmd_thp_or_huge were erroneously ommitted from
> pgtable-2level.h causing build problems. Empty stubs are added for now
> as we don't have huge page support for short descriptors.
> 
> Nicolas, can I please re-add your Reviewed-by to this?

Yes.



> ---
>  arch/arm/include/asm/pgtable-2level.h |  7 ++++++
>  arch/arm/include/asm/pgtable-3level.h |  3 +++
>  arch/arm/lib/uaccess_with_memcpy.c    | 41 ++++++++++++++++++++++++++++++++---
>  3 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index f97ee02..86a659a 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -181,6 +181,13 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  
>  #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
>  
> +/*
> + * We don't have huge page support for short descriptors, for the moment
> + * define empty stubs for use by pin_page_for_write.
> + */
> +#define pmd_hugewillfault(pmd)	(0)
> +#define pmd_thp_or_huge(pmd)	(0)
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_PGTABLE_2LEVEL_H */
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 5689c18..39c54cf 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -206,6 +206,9 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  #define __HAVE_ARCH_PMD_WRITE
>  #define pmd_write(pmd)		(!(pmd_val(pmd) & PMD_SECT_RDONLY))
>  
> +#define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
> +#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
>  #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
> diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
> index 025f742..3e58d71 100644
> --- a/arch/arm/lib/uaccess_with_memcpy.c
> +++ b/arch/arm/lib/uaccess_with_memcpy.c
> @@ -18,6 +18,7 @@
>  #include <linux/hardirq.h> /* for in_atomic() */
>  #include <linux/gfp.h>
>  #include <linux/highmem.h>
> +#include <linux/hugetlb.h>
>  #include <asm/current.h>
>  #include <asm/page.h>
>  
> @@ -40,7 +41,35 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
>  		return 0;
>  
>  	pmd = pmd_offset(pud, addr);
> -	if (unlikely(pmd_none(*pmd) || pmd_bad(*pmd)))
> +	if (unlikely(pmd_none(*pmd)))
> +		return 0;
> +
> +	/*
> +	 * A pmd can be bad if it refers to a HugeTLB or THP page.
> +	 *
> +	 * Both THP and HugeTLB pages have the same pmd layout
> +	 * and should not be manipulated by the pte functions.
> +	 *
> +	 * Lock the page table for the destination and check
> +	 * to see that it's still huge and whether or not we will
> +	 * need to fault on write, or if we have a splitting THP.
> +	 */
> +	if (unlikely(pmd_thp_or_huge(*pmd))) {
> +		ptl = &current->mm->page_table_lock;
> +		spin_lock(ptl);
> +		if (unlikely(!pmd_thp_or_huge(*pmd)
> +			|| pmd_hugewillfault(*pmd)
> +			|| pmd_trans_splitting(*pmd))) {
> +			spin_unlock(ptl);
> +			return 0;
> +		}
> +
> +		*ptep = NULL;
> +		*ptlp = ptl;
> +		return 1;
> +	}
> +
> +	if (unlikely(pmd_bad(*pmd)))
>  		return 0;
>  
>  	pte = pte_offset_map_lock(current->mm, pmd, addr, &ptl);
> @@ -94,7 +123,10 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
>  		from += tocopy;
>  		n -= tocopy;
>  
> -		pte_unmap_unlock(pte, ptl);
> +		if (pte)
> +			pte_unmap_unlock(pte, ptl);
> +		else
> +			spin_unlock(ptl);
>  	}
>  	if (!atomic)
>  		up_read(&current->mm->mmap_sem);
> @@ -147,7 +179,10 @@ __clear_user_memset(void __user *addr, unsigned long n)
>  		addr += tocopy;
>  		n -= tocopy;
>  
> -		pte_unmap_unlock(pte, ptl);
> +		if (pte)
> +			pte_unmap_unlock(pte, ptl);
> +		else
> +			spin_unlock(ptl);
>  	}
>  	up_read(&current->mm->mmap_sem);
>  
> -- 
> 1.8.1.4
> 
