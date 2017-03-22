From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Mar 2017 14:16:24 +0000
Subject: [PATCH 4/7] arm64: hugetlb: Introduce pte_pgprot helper
In-Reply-To: <20170321180421.18332-5-punit.agrawal@arm.com>
References: <20170321180421.18332-1-punit.agrawal@arm.com>
 <20170321180421.18332-5-punit.agrawal@arm.com>
Message-ID: <20170322141623.GE2977@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 06:04:18PM +0000, Punit Agrawal wrote:
> From: Steve Capper <steve.capper@arm.com>
> 
> Rather than xor pte bits in various places, use this helper function.
> 
> Cc: David Woods <dwoods@mellanox.com>
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Much nicer!

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/mm/hugetlbpage.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 81bc6e4cf714..44d637eb32a7 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -41,6 +41,16 @@ int pud_huge(pud_t pud)
>  #endif
>  }
>  
> +/*
> + * Select all bits except the pfn
> + */
> +static inline pgprot_t pte_pgprot(pte_t pte)
> +{
> +	unsigned long pfn = pte_pfn(pte);
> +
> +	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
> +}
> +
>  static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>  			   pte_t *ptep, size_t *pgsize)
>  {
> @@ -80,7 +90,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  
>  	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>  	pfn = pte_pfn(pte);
> -	hugeprot = __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
> +	hugeprot = pte_pgprot(pte);
>  	for (i = 0; i < ncontig; i++) {
>  		pr_debug("%s: set pte %p to 0x%llx\n", __func__, ptep,
>  			 pte_val(pfn_pte(pfn, hugeprot)));
> @@ -235,9 +245,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  		size_t pgsize = 0;
>  		unsigned long pfn = pte_pfn(pte);
>  		/* Select all bits except the pfn */
> -		pgprot_t hugeprot =
> -			__pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^
> -				 pte_val(pte));
> +		pgprot_t hugeprot = pte_pgprot(pte);
>  
>  		cpte = huge_pte_offset(vma->vm_mm, addr);
>  		pfn = pte_pfn(*cpte);
> -- 
> 2.11.0
> 
