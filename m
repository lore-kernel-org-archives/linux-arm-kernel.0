From: julien.grall@arm.com (Julien Grall)
Date: Thu, 26 Apr 2018 11:55:46 +0100
Subject: [PATCH v2 04/17] arm64: Refactor pud_huge for reusability
In-Reply-To: <1522156531-28348-5-git-send-email-suzuki.poulose@arm.com>
References: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
 <1522156531-28348-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <388557a3-f387-4c6c-b19f-88c958476f93@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 27/03/18 14:15, Suzuki K Poulose wrote:
> Make pud_huge reusable for stage2 tables, independent
> of the stage1 levels.
> 
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

> ---
>   arch/arm64/include/asm/pgtable.h | 5 +++++
>   arch/arm64/mm/hugetlbpage.c      | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 5e22503..4a16c11 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -479,6 +479,11 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>   #define __raw_pud_bad(pud)	(!(pud_val(pud) & PUD_TABLE_BIT))
>   #define __raw_pud_present(pud)	pte_present(pud_pte(pud))
>   
> +static inline int __raw_pud_huge(pud_t pud)
> +{
> +	return pud_val(pud) && !(pud_val(pud) & PUD_TABLE_BIT);
> +}
> +
>   static inline void __raw_set_pud(pud_t *pudp, pud_t pud)
>   {
>   	WRITE_ONCE(*pudp, pud);
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index ecc6818..3f4bb43 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -35,7 +35,7 @@ int pmd_huge(pmd_t pmd)
>   int pud_huge(pud_t pud)
>   {
>   #ifndef __PAGETABLE_PMD_FOLDED
> -	return pud_val(pud) && !(pud_val(pud) & PUD_TABLE_BIT);
> +	return __raw_pud_huge(pud);
>   #else
>   	return 0;
>   #endif
> 

-- 
Julien Grall
