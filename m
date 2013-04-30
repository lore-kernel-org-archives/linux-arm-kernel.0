From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Apr 2013 17:48:14 +0100
Subject: [RFC PATCH 3/9] mm: hugetlb: Copy general hugetlb code from
 x86 to mm.
In-Reply-To: <1367339448-21727-4-git-send-email-steve.capper@linaro.org>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
 <1367339448-21727-4-git-send-email-steve.capper@linaro.org>
Message-ID: <20130430164814.GK29766@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 05:30:42PM +0100, Steve Capper wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 41179b0..e1dc5ae 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
...
> +pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
> +{
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd = NULL;
> +
> +	pgd = pgd_offset(mm, addr);
> +	if (pgd_present(*pgd)) {
> +		pud = pud_offset(pgd, addr);
> +		if (pud_present(*pud)) {
> +			if (pud_large(*pud))

That's more of a question for the x86 guys - can we replace pud_large()
here with pud_huge()? It looks like the former simply checks for present
and huge, so pud_huge() would be enough. This saves an additional
definition.

-- 
Catalin
