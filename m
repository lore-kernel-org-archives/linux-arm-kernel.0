From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Sep 2012 14:00:13 +0100
Subject: [PATCH 03/15] ARM: Section based HYP idmap
In-Reply-To: <20120915153449.21241.26746.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153449.21241.26746.stgit@ubuntu>
Message-ID: <20120918130012.GL32204@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:34:49PM +0100, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Add a HYP pgd to the core code (so it can benefit all Linux
> hypervisors).
> 
> Populate this pgd with an identity mapping of the code contained
> in the .hyp.idmap.text section
> 
> Offer a method to drop the this identity mapping through
> hyp_idmap_teardown and re-create it through hyp_idmap_setup.
> 
> Make all the above depend on CONFIG_ARM_VIRT_EXT
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

I didn't get CC'd on this -- please check your git send-email configuration.

> ---
>  arch/arm/include/asm/idmap.h                |    7 ++
>  arch/arm/include/asm/pgtable-3level-hwdef.h |    1 
>  arch/arm/kernel/vmlinux.lds.S               |    6 ++
>  arch/arm/mm/idmap.c                         |   88 +++++++++++++++++++++++----
>  4 files changed, 89 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
> index bf863ed..a1ab8d6 100644
> --- a/arch/arm/include/asm/idmap.h
> +++ b/arch/arm/include/asm/idmap.h
> @@ -11,4 +11,11 @@ extern pgd_t *idmap_pgd;
>  
>  void setup_mm_for_reboot(void);
>  
> +#ifdef CONFIG_ARM_VIRT_EXT
> +extern pgd_t *hyp_pgd;
> +
> +void hyp_idmap_teardown(void);
> +void hyp_idmap_setup(void);
> +#endif
> +
>  #endif	/* __ASM_IDMAP_H */
> diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
> index d795282..a2d404e 100644
> --- a/arch/arm/include/asm/pgtable-3level-hwdef.h
> +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
> @@ -44,6 +44,7 @@
>  #define PMD_SECT_XN		(_AT(pmdval_t, 1) << 54)
>  #define PMD_SECT_AP_WRITE	(_AT(pmdval_t, 0))
>  #define PMD_SECT_AP_READ	(_AT(pmdval_t, 0))
> +#define PMD_SECT_AP1		(_AT(pmdval_t, 1) << 6)
>  #define PMD_SECT_TEX(x)		(_AT(pmdval_t, 0))

If we're making an idmap for the hyp, shouldn't this just follow the
L_PTE_HYP_RDONLY bit (L_PTE2_READ?) from the previous patch except with PMD
in the name (the bit is identical)?

> diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> index ab88ed4..7a944af 100644
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -1,4 +1,6 @@
> +#include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/slab.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/idmap.h>
> @@ -59,11 +61,20 @@ static void idmap_add_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
>  	} while (pud++, addr = next, addr != end);
>  }
>  
> -static void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
> +static void identity_mapping_add(pgd_t *pgd, const char *text_start,
> +				 const char *text_end, unsigned long prot)
>  {
> -	unsigned long prot, next;
> +	unsigned long addr, end;
> +	unsigned long next;
> +
> +	addr = virt_to_phys(text_start);
> +	end = virt_to_phys(text_end);
> +
> +	pr_info("Setting up static %sidentity map for 0x%llx - 0x%llx\n",
> +		prot ? "HYP " : "",
> +		(long long)addr, (long long)end);
> +	prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
>  
> -	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
>  	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
>  		prot |= PMD_BIT4;
>  
> @@ -78,24 +89,77 @@ extern char  __idmap_text_start[], __idmap_text_end[];
>  
>  static int __init init_static_idmap(void)
>  {
> -	phys_addr_t idmap_start, idmap_end;
> -
>  	idmap_pgd = pgd_alloc(&init_mm);
>  	if (!idmap_pgd)
>  		return -ENOMEM;
>  
> -	/* Add an identity mapping for the physical address of the section. */
> -	idmap_start = virt_to_phys((void *)__idmap_text_start);
> -	idmap_end = virt_to_phys((void *)__idmap_text_end);
> -
> -	pr_info("Setting up static identity map for 0x%llx - 0x%llx\n",
> -		(long long)idmap_start, (long long)idmap_end);
> -	identity_mapping_add(idmap_pgd, idmap_start, idmap_end);
> +	identity_mapping_add(idmap_pgd, __idmap_text_start,
> +			     __idmap_text_end, 0);
>  
>  	return 0;
>  }
>  early_initcall(init_static_idmap);

I think it would be cleaner just to have a separate initcall for the hyp pgd
initialisation, leaving the print like it is. That way we also don't have to
infer the exception level from the prot, which is pretty fragile.

> +#ifdef CONFIG_ARM_VIRT_EXT
> +pgd_t *hyp_pgd;
> +EXPORT_SYMBOL_GPL(hyp_pgd);
> +
> +static void hyp_idmap_del_pmd(pgd_t *pgd, unsigned long addr)
> +{
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	pud = pud_offset(pgd, addr);
> +	pmd = pmd_offset(pud, addr);
> +	pud_clear(pud);
> +	clean_pmd_entry(pmd);
> +	pmd_free(NULL, (pmd_t *)((unsigned long)pmd & PAGE_MASK));
> +}
> +
> +extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
> +
> +/*
> + * This version actually frees the underlying pmds for all pgds in range and
> + * clear the pgds themselves afterwards.
> + */
> +void hyp_idmap_teardown(void)
> +{
> +	unsigned long addr, end;
> +	unsigned long next;
> +	pgd_t *pgd = hyp_pgd;
> +
> +	addr = virt_to_phys(__hyp_idmap_text_start);
> +	end = virt_to_phys(__hyp_idmap_text_end);
> +
> +	pgd += pgd_index(addr);
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (!pgd_none_or_clear_bad(pgd))
> +			hyp_idmap_del_pmd(pgd, addr);
> +	} while (pgd++, addr = next, addr < end);
> +}
> +EXPORT_SYMBOL_GPL(hyp_idmap_teardown);
> +
> +void hyp_idmap_setup(void)
> +{
> +	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
> +			     __hyp_idmap_text_end, PMD_SECT_AP1);
> +}
> +EXPORT_SYMBOL_GPL(hyp_idmap_setup);
> +
> +static int __init hyp_init_static_idmap(void)
> +{
> +	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
> +	if (!hyp_pgd)
> +		return -ENOMEM;
> +
> +	hyp_idmap_setup();
> +
> +	return 0;
> +}
> +early_initcall(hyp_init_static_idmap);
> +#endif

I'd rather the alloc/free functions for the hyp pgd were somewhere else,
like they are for standard pgds. Then we can just call them here without
having to encode knowledge of PGD size etc in the mapping code.

Will
