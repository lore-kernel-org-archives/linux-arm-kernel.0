From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Sep 2018 14:52:25 +0100
Subject: [PATCH] arm64: fix erroneous warnings in page freeing functions
In-Reply-To: <20180905163857.7933-1-mark.rutland@arm.com>
References: <20180905163857.7933-1-mark.rutland@arm.com>
Message-ID: <20180906135225.GB5212@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 05:38:57PM +0100, Mark Rutland wrote:
> In pmd_free_pte_page() and pud_free_pmd_page() we try to warn if they
> hit a present non-table entry. In both cases we'll warn for non-present
> entries, as the VM_WARN_ON() only checks the entry is not a table entry.
> 
> This has been observed to result in warnings when booting a v4.19-rc2
> kernel under qemu.
> 
> Fix this by bailing out earlier for non-present entries.
> 
> Fixes: ec28bb9c9b0826d7 ("arm64: Implement page table free interfaces")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 65f86271f02b..8080c9f489c3 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -985,8 +985,9 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>  
>  	pmd = READ_ONCE(*pmdp);
>  
> -	/* No-op for empty entry and WARN_ON for valid entry */
> -	if (!pmd_present(pmd) || !pmd_table(pmd)) {
> +	if (!pmd_present(pmd))
> +		return 1;
> +	if (!pmd_table(pmd)) {

It's a pity this can't be written as:

	if (!pmd_present(pmd) || VM_WARN_ON(!pmd_table(pmd)))
		return 1;

and I suspect the fact that you can't do that with VM_WARN_ON actually
contributed to the bug in the first place.

Anywho, thanks for fixing it. I'll queue this up as a fix.

Will
