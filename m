From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 14 Jun 2013 10:04:04 -0700
Subject: [PATCHv2] arm: fix pmd flushing in map_init_section
In-Reply-To: <1371229044-3970-1-git-send-email-mark.rutland@arm.com>
References: <20130614165417.GP3245@lvm>
 <1371229044-3970-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20130614170404.GQ3245@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 05:57:24PM +0100, Mark Rutland wrote:
> In e651eab0af: "ARM: 7677/1: LPAE: Fix mapping in alloc_init_section for
> unaligned addresses", the pmd flushing was broken when split out to
> map_init_section. At the end of the final iteration of the while loop,
> pmd will point at the pmd_t immediately after the pmds we updated, and
> thus flush_pmd_entry(pmd) won't flush the newly modified pmds. This has
> been observed to prevent an 11MPCore system from booting.
> 
> This patch fixes this by remembering the address of the first pmd we
> update and using this as the argument to flush_pmd_entry.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: R Sricharan <r.sricharan@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <cdall@cs.columbia.edu>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: stable at vger.kernel.org
> ---
> Since v1:
> * Take the incremented value of pmd for !LPAE.
> * Comment why only one cache flush is necessary.
> 
>  arch/arm/mm/mmu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index e0d8565..1c66f51 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -620,6 +620,7 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
>  			unsigned long end, phys_addr_t phys,
>  			const struct mem_type *type)
>  {
> +	pmd_t *p;
>  #ifndef CONFIG_ARM_LPAE
>  	/*
>  	 * In classic MMU format, puds and pmds are folded in to
> @@ -633,12 +634,18 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
>  	if (addr & SECTION_SIZE)
>  		pmd++;
>  #endif
> +	p = pmd;
> +
>  	do {
>  		*pmd = __pmd(phys | type->prot_sect);
>  		phys += SECTION_SIZE;
>  	} while (pmd++, addr += SECTION_SIZE, addr != end);
>  
> -	flush_pmd_entry(pmd);
> +	/*
> +	 * We expect a minimum cache line of 8 bytes, so this will flush both
> +	 * pmd entries with classic tables, and will be a nop for LPAE systems.
> +	 */
> +	flush_pmd_entry(p);
>  }
>  
>  static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
> -- 

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
