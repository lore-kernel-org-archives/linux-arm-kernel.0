From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 May 2014 09:51:21 +0100
Subject: [PATCH] arm64: mm: Create gigabyte kernel logical mappings where
 possible
In-Reply-To: <1398857782-1525-1-git-send-email-steve.capper@linaro.org>
References: <1398857782-1525-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140502085119.GA456@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 12:36:22PM +0100, Steve Capper wrote:
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 4d29332..867e979 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -234,7 +234,20 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>  	pud = pud_offset(pgd, addr);
>  	do {
>  		next = pud_addr_end(addr, end);
> -		alloc_init_pmd(pud, addr, next, phys);
> +
> +		/*
> +		 * For 4K granule only, attempt to put down a 1GB block
> +		 */
> +		if ((PAGE_SHIFT == 12) &&
> +			((addr | next | phys) & ~PUD_MASK) == 0) {
> +			pud_t old_pud = *pud;
> +			set_pud(pud, __pud(phys | prot_sect_kernel));
> +
> +			if (!pud_none(old_pud))
> +				flush_tlb_all();

We could even free the original pmd here. I think a
memblock_free(pud_pfn(old_pud) << PAGE_SHIFT, PAGE_SIZE) should do
(untested, and you need to define pud_pfn).

-- 
Catalin
