From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Feb 2013 13:12:32 +0000
Subject: [PATCH V6] ARM: LPAE: Fix mapping in alloc_init_section for
 unaligned addresses
In-Reply-To: <1360574009-12429-1-git-send-email-r.sricharan@ti.com>
References: <1360574009-12429-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20130211131230.GA5676@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 09:13:29AM +0000, R Sricharan wrote:
> +static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
> +				      unsigned long end, phys_addr_t phys,
> +				      const struct mem_type *type)
> +{
> +	pmd_t *pmd = pmd_offset(pud, addr);
> +	unsigned long next;
> +
> +	do {
>  		/*
> -		 * No need to loop; pte's aren't interested in the
> -		 * individual L1 entries.
> +		 * With LPAE, we must loop over to map
> +		 * all the pmds for the given range.
>  		 */
> -		alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
> -	}
> +		next = pmd_addr_end(addr, end);
> +
> +		/*
> +		 * Try a section mapping - end, addr and phys must all be
> +		 * aligned to a section boundary.
> +		 */

Should this read "next, addr and phys" instead of "end..."?

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
