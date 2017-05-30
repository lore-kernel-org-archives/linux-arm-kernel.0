From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 May 2017 12:16:39 +0100
Subject: [PATCH] arm64: fault: Print info about page table structure when
 dumping pte
In-Reply-To: <1496139047-4677-1-git-send-email-will.deacon@arm.com>
References: <1496139047-4677-1-git-send-email-will.deacon@arm.com>
Message-ID: <20170530111639.GB11653@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 11:10:47AM +0100, Will Deacon wrote:
> Whilst debugging a remote crash, I noticed that show_pte is unhelpful
> when it comes to describing the structure of the page table being walked.
> This is easily fixed by printing out the page table (swapper vs user),
> page size and virtual address size when displaying the PGD address.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 37b95dff0b07..ee6085a922b6 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -89,7 +89,9 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
>  	if (!mm)
>  		mm = &init_mm;
>  
> -	pr_alert("pgd = %p\n", mm->pgd);
> +	pr_alert("%s pgtable: %luk pages, %u-bit VAs, pgd = %p\n",
> +		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
> +		 VA_BITS, mm->pgd);

I take it this will go with Kristina's fix [1] to dump the correct page
table?

Otherwise, this would be more misleading than presently.

Assuming that is the case, this looks very useful to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  	pgd = pgd_offset(mm, addr);
>  	pr_alert("[%08lx] *pgd=%016llx", addr, pgd_val(*pgd));
>  
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
