From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Dec 2014 16:01:13 +0000
Subject: [PATCH] arm64: mm: Add pgd_page to support RCU fast_gup
In-Reply-To: <0341C428-A85D-4085-9F75-893576D42A65@gmail.com>
References: <11B98DF8-2B98-414B-88E5-14C97ADAA60E@gmail.com>
 <20141221105633.GJ23242@arm.com>
 <20141222123051.GC20269@e104818-lin.cambridge.arm.com>
 <374BBC79-DD7B-4FEC-A1B3-DD6D14ED30A8@gmail.com>
 <20141222153111.GA15240@e104818-lin.cambridge.arm.com>
 <20141222162823.GB15240@e104818-lin.cambridge.arm.com>
 <0341C428-A85D-4085-9F75-893576D42A65@gmail.com>
Message-ID: <20141223160113.GD21816@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 03:37:14PM +0000, Jungseok Lee wrote:
> It looks like that pmd_page cannot be written using pmd_pfn unless pmd_pfn is
> changed since pmd_pfn masks an input value with PMD_MASK, but pmd_page does not.
> Additionally, I'm not sure about whether pmd_pfn with PMD_MASK works well for an
> user process page table.
> 
> So, my change on pmd_pfn and pmd_page is as follows. Please correct me if I am wrong.
> 
> -----8<-----
> 
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -294,11 +294,11 @@ void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
>  
>  #define pmd_mkhuge(pmd)                (__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
>  
> -#define pmd_pfn(pmd)           (((pmd_val(pmd) & PMD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
> +#define pmd_pfn(pmd)           ((pmd_val(pmd) & PHYS_MASK) >> PAGE_SHIFT)
>  #define pfn_pmd(pfn,prot)      (__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
>  #define mk_pmd(page,prot)      pfn_pmd(page_to_pfn(page),prot)
>  
> -#define pmd_page(pmd)           pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
> +#define pmd_page(pmd)          pfn_to_page(pmd_pfn(pmd))
>  #define pud_write(pud)         pte_write(pud_pte(pud))
>  #define pud_pfn(pud)           (((pud_val(pud) & PUD_MASK) & PHYS_MASK) >> PAGE_SHIFT)

It looks like pmd_pfn() is only used for huge pages, so the original
code was safe. As I said, I won't do further changes here, at least not
for 3.19.

-- 
Catalin
