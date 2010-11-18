From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Nov 2010 17:18:37 +0000
Subject: [PATCH 1/5] ARM: pgtable: switch order of Linux vs hardware page
	tables
In-Reply-To: <E1PIloA-0007qU-ME@rmk-PC.arm.linux.org.uk>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
	<E1PIloA-0007qU-ME@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTikVBSO6iW5n3j5k+2N=vCe_u_1zHn8-QY6mLyFn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2010 17:28, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This switches the ordering of the Linux vs hardware page tables in
> each page, thereby eliminating some of the arithmetic in the page
> table walks. ?As we now place the Linux page table at the beginning
> of the page, we can deal with the offset in the pgt by simply masking
> it away, along with the other control bits.
[...]
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -535,7 +535,7 @@ static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr, unsigned l
> ?{
> ? ? ? ?if (pmd_none(*pmd)) {
> ? ? ? ? ? ? ? ?pte_t *pte = early_alloc(2 * PTRS_PER_PTE * sizeof(pte_t));
> - ? ? ? ? ? ? ? __pmd_populate(pmd, __pa(pte) | prot);
> + ? ? ? ? ? ? ? __pmd_populate(pmd, __pa(pte), prot);

While you are here, can you change the early_alloc size to
PTE_HWTABLE_OFF+PTE_HWTABLE_SIZE? This way I don't need to patch this
in LPAE.

-- 
Catalin
