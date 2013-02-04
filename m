From: r.sricharan@ti.com (R Sricharan)
Date: Mon, 4 Feb 2013 10:10:08 +0530
Subject: [PATCH v4] ARM: LPAE: Fix mapping in alloc_init_pte for unaligned
 addresses
In-Reply-To: <20130201174246.GJ5151@arm.com>
References: <1359472036-7613-1-git-send-email-r.sricharan@ti.com>
 <20130201162631.GG5151@arm.com>
 <CANOGCgOp=kSatDu8fL7grk+bXLQ2pgKAEvEK6LoG8Ba4mqUH=w@mail.gmail.com>
 <20130201163722.GH5151@arm.com>
 <CANOGCgMbzEWpJQE8PH2nS9_wa0DP_14E4=whGgKxWGJ_HpwomQ@mail.gmail.com>
 <20130201174246.GJ5151@arm.com>
Message-ID: <510F3BA8.8070700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

[ snip..]
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 9f06102..47154f3 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -581,34 +581,36 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
>   				      const struct mem_type *type)
>   {
>   	pmd_t *pmd = pmd_offset(pud, addr);
> +	unsigned long next;
>
> -	/*
> -	 * Try a section mapping - end, addr and phys must all be aligned
> -	 * to a section boundary.  Note that PMDs refer to the individual
> -	 * L1 entries, whereas PGDs refer to a group of L1 entries making
> -	 * up one logical pointer to an L2 table.
> -	 */
> -	if (type->prot_sect && ((addr | end | phys) & ~SECTION_MASK) == 0) {
> -		pmd_t *p = pmd;
> +	do {
> +		next = pmd_addr_end(addr, end);
> +
> +		/*
> +		 * Try a section mapping - next, addr and phys must all be
> +		 * aligned to a section boundary.  Note that PMDs refer to the
> +		 * individual L1 entries, whereas PGDs refer to a group of L1
> +		 * entries making up one logical pointer to an L2 table.
> +		 */
> +		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
> +			pmd_t *p = pmd;
>
    There is a  need to do page mappings even when all the addresses
    are aligned. This was added with CMA, which required the initial
    mappings to be set with 2 level tables.

>   #ifndef CONFIG_ARM_LPAE
> -		if (addr & SECTION_SIZE)
> -			pmd++;
> +			if (addr & SECTION_SIZE)
> +				pmd++;
>   #endif
> +			do {
> +				*pmd = __pmd(phys | type->prot_sect);
> +				phys += SECTION_SIZE;
> +			} while (pmd++, addr += SECTION_SIZE, addr != next);
>
> -		do {
> -			*pmd = __pmd(phys | type->prot_sect);
> -			phys += SECTION_SIZE;
> -		} while (pmd++, addr += SECTION_SIZE, addr != end);
> -
> -		flush_pmd_entry(p);
> -	} else {
> -		/*
> -		 * No need to loop; pte's aren't interested in the
> -		 * individual L1 entries.
> -		 */
> -		alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
> -	}
> +			flush_pmd_entry(p);
> +		} else {
> +			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys), type);
> +			phys += next - addr;
> +			pmd++;
> +		}
> +	} while (addr = next, addr != end);
>   }
>
>   static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>
  I did a similar kind of patch in my V1 [1].
  I should be using PMD_MASK instead of SECTION_MASK there, and
  updated it in the next version.

  [1] https://patchwork.kernel.org/patch/1272991/


Regards,
  Sricharan
