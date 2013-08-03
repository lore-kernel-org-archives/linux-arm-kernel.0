From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Aug 2013 21:53:28 -0400 (EDT)
Subject: [PATCH v2 2/6] ARM: mm: Introduce virt_to_idmap() with an arch
 hook
In-Reply-To: <1375289086-5315-3-git-send-email-santosh.shilimkar@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <1375289086-5315-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.LFD.2.03.1308022153080.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Jul 2013, Santosh Shilimkar wrote:

> On some PAE systems (e.g. TI Keystone), memory is above the
> 32-bit addressable limit, and the interconnect provides an
> aliased view of parts of physical memory in the 32-bit addressable
> space.  This alias is strictly for boot time usage, and is not
> otherwise usable because of coherency limitations. On such systems,
> the idmap mechanism needs to take this aliased mapping into account.
> 
> This patch introduces virt_to_idmap() and a arch function pointer which
> can be populated by platform which needs it. Also populate necessary
> idmap spots with now available virt_to_idmap(). Avoided #ifdef approach
> to be compatible with multi-platform builds.
> 
> Most architecture won't touch it and in that case virt_to_idmap()
> fall-back to existing virt_to_phys() macro.
> 
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Nicolas Pitre <nico@linaro.org>



> ---
>  arch/arm/include/asm/memory.h |   16 ++++++++++++++++
>  arch/arm/kernel/smp.c         |    2 +-
>  arch/arm/mm/idmap.c           |    5 +++--
>  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index c133bd9..d9b96c65 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -173,6 +173,7 @@
>   */
>  #define __PV_BITS_31_24	0x81000000
>  
> +extern phys_addr_t (*arch_virt_to_idmap) (unsigned long x);
>  extern unsigned long __pv_phys_offset;
>  #define PHYS_OFFSET __pv_phys_offset
>  
> @@ -259,6 +260,21 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
>  
>  /*
> + * These are for systems that have a hardware interconnect supported alias of
> + * physical memory for idmap purposes.  Most cases should leave these
> + * untouched.
> + */
> +static inline phys_addr_t __virt_to_idmap(unsigned long x)
> +{
> +	if (arch_virt_to_idmap)
> +		return arch_virt_to_idmap(x);
> +	else
> +		return __virt_to_phys(x);
> +}
> +
> +#define virt_to_idmap(x)	__virt_to_idmap((unsigned long)(x))
> +
> +/*
>   * Virtual <-> DMA view memory address translations
>   * Again, these are *only* valid on the kernel direct mapped RAM
>   * memory.  Use of these is *deprecated* (and that doesn't mean
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index c2b4f8f..d36523d 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -81,7 +81,7 @@ void __init smp_set_ops(struct smp_operations *ops)
>  
>  static unsigned long get_arch_pgd(pgd_t *pgd)
>  {
> -	phys_addr_t pgdir = virt_to_phys(pgd);
> +	phys_addr_t pgdir = virt_to_idmap(pgd);
>  	BUG_ON(pgdir & ARCH_PGD_MASK);
>  	return pgdir >> ARCH_PGD_SHIFT;
>  }
> diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> index 83cb3ac..c0a1e48 100644
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -10,6 +10,7 @@
>  #include <asm/system_info.h>
>  
>  pgd_t *idmap_pgd;
> +phys_addr_t (*arch_virt_to_idmap) (unsigned long x);
>  
>  #ifdef CONFIG_ARM_LPAE
>  static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
> @@ -67,8 +68,8 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
>  	unsigned long addr, end;
>  	unsigned long next;
>  
> -	addr = virt_to_phys(text_start);
> -	end = virt_to_phys(text_end);
> +	addr = virt_to_idmap(text_start);
> +	end = virt_to_idmap(text_end);
>  
>  	prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
>  
> -- 
> 1.7.9.5
> 
