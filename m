From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Mar 2017 11:19:56 +0000
Subject: [PATCH V2] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
In-Reply-To: <87efy6mjgj.fsf@e105922-lin.cambridge.arm.com>
References: <1487720205-14594-1-git-send-email-tbaicar@codeaurora.org>
 <87wpc7o7mo.fsf@e105922-lin.cambridge.arm.com>
 <874lz4oo80.fsf@e105922-lin.cambridge.arm.com>
 <fae5fa32-687b-4ebd-2d0c-b9df5837ba89@codeaurora.org>
 <87efy6mjgj.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20170315111955.GA29014@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

Adding David Woods since he seems to have added the arm64-specific
huge_pte_offset() code.

On Thu, Mar 09, 2017 at 05:46:36PM +0000, Punit Agrawal wrote:
> From d5ad3f428e629c80b0f93f2bbdf99b4cae28c9bc Mon Sep 17 00:00:00 2001
> From: Punit Agrawal <punit.agrawal@arm.com>
> Date: Thu, 9 Mar 2017 16:16:29 +0000
> Subject: [PATCH] arm64: hugetlb: Fix huge_pte_offset to return poisoned pmd
> 
> When memory failure is enabled, a poisoned hugepage PMD is marked as a
> swap entry. As pmd_present() only checks for VALID and PROT_NONE
> bits (turned off for swap entries), it causues huge_pte_offset() to
> return NULL for poisoned PMDs.
> 
> This behaviour of huge_pte_offset() leads to the error such as below
> when munmap is called on poisoned hugepages.
> 
> [  344.165544] mm/pgtable-generic.c:33: bad pmd 000000083af00074.
> 
> Fix huge_pte_offset() to return the poisoned PMD which is then
> appropriately handled by the generic layer code.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Steve Capper <steve.capper@arm.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index e25584d72396..9263f206353c 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -150,8 +150,17 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>         if (pud_huge(*pud))
>                 return (pte_t *)pud;
>         pmd = pmd_offset(pud, addr);
> +
> +       /*
> +        * In case of HW Poisoning, a hugepage pmd can contain
> +        * poisoned entries. Poisoned entries are marked as swap
> +        * entries.
> +        *
> +        * For pmds that are not present, check to see if it could be
> +        * a swap entry (!present and !none) before giving up.
> +        */
>         if (!pmd_present(*pmd))
> -               return NULL;
> +               return !pmd_none(*pmd) ? (pte_t *)pmd : NULL;

I'm not sure we need to return NULL here when pmd_none(). If we use
hugetlb at the pmd level we don't need to allocate a pmd page but just
fall back to hugetlb_no_page() in hugetlb_fault(). The problem is we
can't tell what kind of huge page we have when calling
huge_pte_offset(), so we always rely on huge_pte_alloc(). But there are
places where huge_pte_none() is checked explicitly and we would never
return it from huge_pte_get().

Can we improve the generic code to pass the huge page size to
huge_pte_offset()? Otherwise we make all kind of assumptions/guesses in
the arch code.

> 
>         if (pte_cont(pmd_pte(*pmd))) {
>                 pmd = pmd_offset(

Given that we can have huge pages at the pud level, we should address
that as well. The generic huge_pte_offset() doesn't need to since it
assumes huge pages at the pmd level only. If a pud is not present, you
can't dereference it to find the pmd, hence returning NULL.

Apart from hw poisoning, I think another use-case for non-present
pmd/pud entries is is_hugetlb_entry_migration() (see hugetlb_fault()),
so we need to fix this either way.

We have a discrepancy between the pud_present and pmd_present. The
latter was modified to fall back on pte_present because of THP which
does not support puds (last time I checked). So if a pud is poisoned,
huge_pte_offset thinks it is present and will try to get the pmd it
points to.

I think we can leave the pud_present() unchanged but fix the
huge_pte_offset() to check for pud_table() before dereferencing,
otherwise returning the actual value. And we need to figure out which
huge page size we have when the pud/pmd is 0.

-- 
Catalin
