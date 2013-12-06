From: msalter@redhat.com (Mark Salter)
Date: Fri, 06 Dec 2013 12:20:49 -0500
Subject: [PATCH 4/4] arm64: add early_ioremap support
In-Reply-To: <20131205162800.GB1495@darko.cambridge.arm.com>
References: <1385606679-30446-1-git-send-email-msalter@redhat.com>
 <1385606679-30446-5-git-send-email-msalter@redhat.com>
 <20131205162800.GB1495@darko.cambridge.arm.com>
Message-ID: <1386350449.1861.196.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-12-05 at 16:28 +0000, Catalin Marinas wrote:
> On Thu, Nov 28, 2013 at 02:44:39AM +0000, Mark Salter wrote:
> > + * These 'compile-time allocated' memory buffers are
> > + * page-sized. Use set_fixmap(idx,phys) to associate
> > + * physical memory with fixmap indices.
> > + *
> > + */
> > +enum fixed_addresses {
> > +	FIX_EARLYCON,
> > +	__end_of_permanent_fixed_addresses,
> > +
> > +	/*
> > +	 * Temporary boot-time mappings, used by early_ioremap(),
> > +	 * before ioremap() is functional.
> > +	 */
> 
> How temporary are this mappings? The early console may not be disabled
> at run-time, so it still needs the mapping.

It varies by arch, but we have flexibility on arm64 because there is a
dedicated pmd which stays around forever. So, you see the FIX_EARLYCON
above is a "permanent" mapping which isn't really an early_ioremap
mapping. The earlyprintk code uses set_fixmap_io. I suppose this could
have been broken up into two patches, one fixmap, and one early_ioremap.
To answer your concern, the earlyprintk mapping doesn't go away. The
early_ioremap mappings should be temporary and there's a checker for
that which is run at late_initcall time.

> 
> > +#ifdef CONFIG_ARM64_64K_PAGES
> > +#define NR_FIX_BTMAPS		4
> > +#else
> > +#define NR_FIX_BTMAPS		64
> > +#endif
> > +#define FIX_BTMAPS_SLOTS	7
> > +#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> > +
> > +	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
> > +	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> > +	__end_of_fixed_addresses
> > +};
> > +
> > +#define FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
> > +#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
> > +
> > +#define FIXMAP_PAGE_NORMAL __pgprot(PROT_NORMAL | PTE_PXN | PTE_UXN)
> 
> I'll push a fix to change PROT_DEFAULT to (pgprot_default | PTE_DIRTY).

okay

> 
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index 3776217..4a6d7ec 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -50,6 +50,7 @@
> >  #define MODULES_END		(PAGE_OFFSET)
> >  #define MODULES_VADDR		(MODULES_END - SZ_64M)
> >  #define EARLYCON_IOBASE		(MODULES_VADDR - SZ_4M)
> > +#define FIXADDR_TOP		(MODULES_VADDR - SZ_2M - PAGE_SIZE)
> >  #define TASK_SIZE_64		(UL(1) << VA_BITS)
> 
> Can we remove EARLYCON_IOBASE?

Yes. I had it out in an earlier local patch, but it snuck back in.

> 
> > --- a/arch/arm64/mm/ioremap.c
> > +++ b/arch/arm64/mm/ioremap.c
> > @@ -25,6 +25,10 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/io.h>
> >  
> > +#include <asm/fixmap.h>
> > +#include <asm/tlbflush.h>
> > +#include <asm/pgalloc.h>
> > +
> >  static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
> >  				      pgprot_t prot, void *caller)
> >  {
> > @@ -98,3 +102,76 @@ void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
> >  				__builtin_return_address(0));
> >  }
> >  EXPORT_SYMBOL(ioremap_cache);
> > +
> > +#ifndef CONFIG_ARM64_64K_PAGES
> > +static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
> > +#endif
> > +
> > +static inline pmd_t * __init early_ioremap_pmd(unsigned long addr)
> > +{
> > +	pgd_t *pgd = pgd_offset_k(addr);
> > +	pud_t *pud = pud_offset(pgd, addr);
> > +	pmd_t *pmd = pmd_offset(pud, addr);
> > +
> > +	return pmd;
> > +}
> > +
> > +static inline pte_t * __init early_ioremap_pte(unsigned long addr)
> > +{
> > +	pmd_t *pmd = early_ioremap_pmd(addr);
> > +	return pte_offset_kernel(pmd, addr);
> > +}
> > +
> > +void __init early_ioremap_init(void)
> > +{
> > +	pmd_t *pmd;
> > +
> > +	pmd = early_ioremap_pmd(fix_to_virt(FIX_BTMAP_BEGIN));
> > +#ifndef CONFIG_ARM64_64K_PAGES
> > +	/* need to populate pmd for 4k pagesize only */
> > +	pmd_populate_kernel(&init_mm, pmd, bm_pte);
> > +#endif
> 
> Can we use some of the standard pmd_none() etc. checks which would be
> eliminated for 2-level page tables?
> 

Probably. I'll look into it.
