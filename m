From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Mar 2017 14:18:24 +0000
Subject: [PATCH 5/7] arm64: hugetlb: Remove spurious calls to
 huge_ptep_offset
In-Reply-To: <20170321180421.18332-6-punit.agrawal@arm.com>
References: <20170321180421.18332-1-punit.agrawal@arm.com>
 <20170321180421.18332-6-punit.agrawal@arm.com>
Message-ID: <20170322141823.GF2977@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 06:04:19PM +0000, Punit Agrawal wrote:
> From: Steve Capper <steve.capper@arm.com>
> 
> We don't need to call huge_ptep_offset as our accessors are already
> supplied with the pte_t *. This patch removes those spurious calls.
> 
> Cc: David Woods <dwoods@mellanox.com>
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Reviwewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/mm/hugetlbpage.c | 37 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 44d637eb32a7..c868c80a9d6b 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -208,21 +208,19 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  	if (pte_cont(*ptep)) {
>  		int ncontig, i;
>  		size_t pgsize;
> -		pte_t *cpte;
>  		bool is_dirty = false;
>  
> -		cpte = huge_pte_offset(mm, addr);
> -		ncontig = find_num_contig(mm, addr, cpte, &pgsize);
> +		ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>  		/* save the 1st pte to return */
> -		pte = ptep_get_and_clear(mm, addr, cpte);
> +		pte = ptep_get_and_clear(mm, addr, ptep);
>  		for (i = 1, addr += pgsize; i < ncontig; ++i, addr += pgsize) {
>  			/*
>  			 * If HW_AFDBM is enabled, then the HW could
>  			 * turn on the dirty bit for any of the page
>  			 * in the set, so check them all.
>  			 */
> -			++cpte;
> -			if (pte_dirty(ptep_get_and_clear(mm, addr, cpte)))
> +			++ptep;
> +			if (pte_dirty(ptep_get_and_clear(mm, addr, ptep)))
>  				is_dirty = true;
>  		}
>  		if (is_dirty)
> @@ -238,8 +236,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  			       unsigned long addr, pte_t *ptep,
>  			       pte_t pte, int dirty)
>  {
> -	pte_t *cpte;
> -
>  	if (pte_cont(pte)) {
>  		int ncontig, i, changed = 0;
>  		size_t pgsize = 0;
> @@ -247,12 +243,11 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  		/* Select all bits except the pfn */
>  		pgprot_t hugeprot = pte_pgprot(pte);
>  
> -		cpte = huge_pte_offset(vma->vm_mm, addr);
> -		pfn = pte_pfn(*cpte);
> -		ncontig = find_num_contig(vma->vm_mm, addr, cpte,
> +		pfn = pte_pfn(pte);
> +		ncontig = find_num_contig(vma->vm_mm, addr, ptep,
>  					  &pgsize);
> -		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize) {
> -			changed |= ptep_set_access_flags(vma, addr, cpte,
> +		for (i = 0; i < ncontig; ++i, ++ptep, addr += pgsize) {
> +			changed |= ptep_set_access_flags(vma, addr, ptep,
>  							pfn_pte(pfn,
>  								hugeprot),
>  							dirty);
> @@ -269,13 +264,11 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  {
>  	if (pte_cont(*ptep)) {
>  		int ncontig, i;
> -		pte_t *cpte;
>  		size_t pgsize = 0;
>  
> -		cpte = huge_pte_offset(mm, addr);
> -		ncontig = find_num_contig(mm, addr, cpte, &pgsize);
> -		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize)
> -			ptep_set_wrprotect(mm, addr, cpte);
> +		ncontig = find_num_contig(mm, addr, ptep, &pgsize);
> +		for (i = 0; i < ncontig; ++i, ++ptep, addr += pgsize)
> +			ptep_set_wrprotect(mm, addr, ptep);
>  	} else {
>  		ptep_set_wrprotect(mm, addr, ptep);
>  	}
> @@ -286,14 +279,12 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  	if (pte_cont(*ptep)) {
>  		int ncontig, i;
> -		pte_t *cpte;
>  		size_t pgsize = 0;
>  
> -		cpte = huge_pte_offset(vma->vm_mm, addr);
> -		ncontig = find_num_contig(vma->vm_mm, addr, cpte,
> +		ncontig = find_num_contig(vma->vm_mm, addr, ptep,
>  					  &pgsize);
> -		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize)
> -			ptep_clear_flush(vma, addr, cpte);
> +		for (i = 0; i < ncontig; ++i, ++ptep, addr += pgsize)
> +			ptep_clear_flush(vma, addr, ptep);
>  	} else {
>  		ptep_clear_flush(vma, addr, ptep);
>  	}
> -- 
> 2.11.0
> 
