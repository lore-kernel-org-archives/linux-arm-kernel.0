From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Feb 2013 17:55:09 +0000
Subject: [RFC PATCH] ARM: mm: Fix alloc_init_section bug on LPAE
In-Reply-To: <1359160318-27068-1-git-send-email-chris@cloudcar.com>
References: <1359160318-27068-1-git-send-email-chris@cloudcar.com>
Message-ID: <20130201175509.GK5151@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 12:31:58AM +0000, Christoffer Dall wrote:
> When using LPAE the call to alloc_init_pte is passed then end address
> for the entire 1st level page table region, and the code unluckily ends
> up going over the bounds of the single allocated PTE, which is sad.
> 
> This caused LPAE boot on omap5 to crash.
> 
> There may be some hidden mystery in the boot code that I'm unaware of
> or it may be assumed that all mappings are always mappable as sections
> on LPAE and therefore omap5 just does something bad, in which case this
> patch isn't the right fix, but I'd be happy to be told the reason.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jeremy C. Andrus <jeremya@cs.columbia.edu>
> Signed-off-by: Christoffer Dall <chris@cloudcar.com>
> ---
>  arch/arm/mm/mmu.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index ce328c7..1cecc99 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -603,11 +603,13 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
>  
>  		flush_pmd_entry(p);
>  	} else {
> -		/*
> -		 * No need to loop; pte's aren't interested in the
> -		 * individual L1 entries.
> -		 */
> -		alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
> +		unsigned long next;
> +
> +		do {
> +			next = pmd_addr_end(addr, end);
> +			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys), type);
> +			phys += next - addr;
> +		} while (pmd++, addr = next, addr != end);

I now noticed your patch (I'm a bit behind with the list). It looks to
me like it should work since next == end with the classic MMU, so we
only go through the loop once.

-- 
Catalin
