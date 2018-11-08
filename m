From: Steve.Capper@arm.com (Steve Capper)
Date: Thu, 8 Nov 2018 10:36:27 +0000
Subject: [PATCH V3 5/5] arm64/mm: Enable HugeTLB migration for contiguous
 bit HugeTLB pages
In-Reply-To: <1540299721-26484-6-git-send-email-anshuman.khandual@arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-6-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181108103616.22z3imossjb5ffkw@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 06:32:01PM +0530, Anshuman Khandual wrote:
> Let arm64 subscribe to the previously added framework in which architecture
> can inform whether a given huge page size is supported for migration. This
> just overrides the default function arch_hugetlb_migration_supported() and
> enables migration for all possible HugeTLB page sizes on arm64. With this,
> HugeTLB migration support on arm64 now covers all possible HugeTLB options.
> 
>         CONT PTE    PMD    CONT PMD    PUD
>         --------    ---    --------    ---
> 4K:        64K      2M        32M      1G
> 16K:        2M     32M         1G
> 64K:        2M    512M        16G
> 
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Steve Capper <steve.capper@arm.com>

> ---
>  arch/arm64/include/asm/hugetlb.h |  5 +++++
>  arch/arm64/mm/hugetlbpage.c      | 20 ++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index e73f685..656f70e 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -20,6 +20,11 @@
>  
>  #include <asm/page.h>
>  
> +#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> +#define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
> +extern bool arch_hugetlb_migration_supported(struct hstate *h);
> +#endif
> +
>  static inline pte_t huge_ptep_get(pte_t *ptep)
>  {
>  	return READ_ONCE(*ptep);
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 21512ca..f3afdcf 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -27,6 +27,26 @@
>  #include <asm/tlbflush.h>
>  #include <asm/pgalloc.h>
>  
> +#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> +bool arch_hugetlb_migration_supported(struct hstate *h)
> +{
> +	size_t pagesize = huge_page_size(h);
> +
> +	switch (pagesize) {
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	case PUD_SIZE:
> +#endif
> +	case PMD_SIZE:
> +	case CONT_PMD_SIZE:
> +	case CONT_PTE_SIZE:
> +		return true;
> +	}
> +	pr_warn("%s: unrecognized huge page size 0x%lx\n",
> +			__func__, pagesize);
> +	return false;
> +}
> +#endif
> +
>  int pmd_huge(pmd_t pmd)
>  {
>  	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
> -- 
> 2.7.4
> 
