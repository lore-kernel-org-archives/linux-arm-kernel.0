From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Tue, 6 Nov 2018 13:16:01 +0000
Subject: [PATCH] arm64: hugetlb: Avoid unnecessary clearing in
 huge_ptep_set_access_flags
In-Reply-To: <20180919174437.1866-1-steve.capper@arm.com>
References: <20180919174437.1866-1-steve.capper@arm.com>
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A031841@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Steve

Sorry to late.
Thanks for your patch, and I will test your patch.

Best Regards,
Lei Zhang

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Steve
> Capper
> Sent: Thursday, September 20, 2018 2:45 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: catalin.marinas at arm.com; Steve Capper; will.deacon at arm.com; Zhang, Lei/
> ? ?
> Subject: [PATCH] arm64: hugetlb: Avoid unnecessary clearing in
> huge_ptep_set_access_flags
> 
> For contiguous hugetlb, huge_ptep_set_access_flags performs a
> get_clear_flush (which then flushes the TLBs) even when no change of ptes
> is necessary.
> 
> Unfortunately, this behaviour can lead to back-to-back page faults being
> generated when running with multiple threads that access the same
> contiguous huge page.
> 
> Thread 1                     |  Thread 2
> -----------------------------+------------------------------
> hugetlb_fault                |
> huge_ptep_set_access_flags   |
>   -> invalidate pte range    | hugetlb_fault
> continue processing          | wait for hugetlb fault mutex
> release mutex and return     | huge_ptep_set_access_flags
>                              |   -> invalidate pte range
> hugetlb_fault
> ...
> 
> This patch changes huge_ptep_set_access_flags s.t. we first read the
> contiguous range of ptes (whilst preserving dirty information); the pte
> range is only then invalidated where necessary and this prevents further
> spurious page faults.
> 
> Fixes: d8bdcff28764 ("arm64: hugetlb: Add break-before-make logic for
> contiguous entries")
> Reported-by: Lei Zhang <zhang.lei@jp.fujitsu.com>
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> 
> ---
> 
> I was unable to test this on any hardware as I'm away from the office.
> 
> Can you please test this Lei Zhang?
> 
> Cheers,
> --
> Steve
> ---
>  arch/arm64/mm/hugetlbpage.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 192b3ba07075..76d229eb6ba1 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -131,6 +131,27 @@ static pte_t get_clear_flush(struct mm_struct *mm,
>  	return orig_pte;
>  }
> 
> +static pte_t get_contig_pte(pte_t *ptep, unsigned long pgsize,
> +		unsigned long ncontig)
> +{
> +	unsigned long i;
> +	pte_t orig_pte = huge_ptep_get(ptep);
> +
> +	for (i = 0; i < ncontig; i++, ptep++) {
> +		pte_t pte = huge_ptep_get(ptep);
> +
> +		/*
> +		 * If HW_AFDBM is enabled, then the HW could turn on
> +		 * the dirty bit for any page in the set, so check
> +		 * them all.  All hugetlb entries are already young.
> +		 */
> +		if (pte_dirty(pte))
> +			orig_pte = pte_mkdirty(orig_pte);
> +	}
> +
> +	return orig_pte;
> +}
> +
>  /*
>   * Changing some bits of contiguous entries requires us to follow a
>   * Break-Before-Make approach, breaking the whole contiguous set
> @@ -324,7 +345,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct
> *vma,
>  			       unsigned long addr, pte_t *ptep,
>  			       pte_t pte, int dirty)
>  {
> -	int ncontig, i, changed = 0;
> +	int ncontig, i;
>  	size_t pgsize = 0;
>  	unsigned long pfn = pte_pfn(pte), dpfn;
>  	pgprot_t hugeprot;
> @@ -336,9 +357,16 @@ int huge_ptep_set_access_flags(struct vm_area_struct
> *vma,
>  	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
>  	dpfn = pgsize >> PAGE_SHIFT;
> 
> +	orig_pte = get_contig_pte(ptep, pgsize, ncontig);
> +	if (pte_same(orig_pte, pte))
> +		return 0;
> +
> +	/*
> +	 * we need to get our orig_pte again as HW DBM may have happened
> since
> +	 * above. get_clear_flush will ultimately cmpxchg with 0 to ensure
> +	 * that we can't lose any dirty information.
> +	 */
>  	orig_pte = get_clear_flush(vma->vm_mm, addr, ptep, pgsize,
> ncontig);
> -	if (!pte_same(orig_pte, pte))
> -		changed = 1;
> 
>  	/* Make sure we don't lose the dirty state */
>  	if (pte_dirty(orig_pte))
> @@ -348,7 +376,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct
> *vma,
>  	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
>  		set_pte_at(vma->vm_mm, addr, ptep, pfn_pte(pfn,
> hugeprot));
> 
> -	return changed;
> +	return 1;
>  }
> 
>  void huge_ptep_set_wrprotect(struct mm_struct *mm,
> --
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
