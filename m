From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Jun 2015 13:48:00 +0100
Subject: [PATCH v3] ARM: early fixmap support for earlycon
In-Reply-To: <1433593888-7142-1-git-send-email-stefan@agner.ch>
References: <1433593888-7142-1-git-send-email-stefan@agner.ch>
Message-ID: <20150606124800.GR7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 06, 2015 at 02:31:28PM +0200, Stefan Agner wrote:
> Add early fixmap support, initially to support permanent, fixed
> mapping support for early console. A temporary, early pte is
> created which is migrated to a permanent mapping in paging_init.
> This is also needed since the attributes may change as the memory
> types are initialized. The 3MiB range of fixmap spans two pte
> tables, but currently only one pte is created for early fixmap
> support.
> 
> Re-add FIX_KMAP_BEGIN to the index calculation in highmem.c since
> the index for kmap does not start at zero anymore. This reverts
> 4221e2e6b316 ("ARM: 8031/1: fixmap: remove FIX_KMAP_BEGIN and
> FIX_KMAP_END") to some extent.
> 
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <lauraa@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v2:
> - Rebased and tested on rmk/for-next
> - Flush TLB's when clearing the temporary PMD in early_fixmap_shutdown
> 
> Changes since v1 (RFC):
> - Rebased and tested on v3.19-rc5
> - Spelling errors in comments and commit message
> - Added Rob's SOB
> 
>  arch/arm/Kconfig              |  3 ++
>  arch/arm/include/asm/fixmap.h | 13 +++++++-
>  arch/arm/kernel/setup.c       |  3 ++
>  arch/arm/mm/highmem.c         |  6 ++--
>  arch/arm/mm/mmu.c             | 78 +++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 96 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d0950ce..ef164a7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -186,6 +186,9 @@ config ARCH_HAS_ILOG2_U64
>  config ARCH_HAS_BANDGAP
>  	bool
>  
> +config FIX_EARLYCON_MEM
> +	def_bool y
> +
>  config GENERIC_HWEIGHT
>  	bool
>  	default y
> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
> index 0415eae..2d8b12b 100644
> --- a/arch/arm/include/asm/fixmap.h
> +++ b/arch/arm/include/asm/fixmap.h
> @@ -6,9 +6,13 @@
>  #define FIXADDR_TOP		(FIXADDR_END - PAGE_SIZE)
>  
>  #include <asm/kmap_types.h>
> +#include <asm/pgtable.h>
>  
>  enum fixed_addresses {
> -	FIX_KMAP_BEGIN,
> +	FIX_EARLYCON_MEM_BASE,
> +	__end_of_permanent_fixed_addresses,
> +
> +	FIX_KMAP_BEGIN = __end_of_permanent_fixed_addresses,
>  	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
>  
>  	/* Support writing RO kernel text via kprobes, jump labels, etc. */
> @@ -18,7 +22,14 @@ enum fixed_addresses {
>  	__end_of_fixed_addresses
>  };
>  
> +#define FIXMAP_PAGE_COMMON	(L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN | L_PTE_DIRTY)
> +
> +#define FIXMAP_PAGE_NORMAL	(FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
> +#define FIXMAP_PAGE_IO		(FIXMAP_PAGE_COMMON | L_PTE_MT_DEV_SHARED | L_PTE_SHARED)
> +#define FIXMAP_PAGE_NOCACHE	FIXMAP_PAGE_IO

I'm really not happy with this.  What are the expected semantics of the
set_fixmap_nocache() and set_fixmap_offset_nocache() ?  Are they there
for mapping a device, or are they there for mapping _memory_ ?

I would prefer that FIXMAP_PAGE_NOCACHE is _not_ provided until the
semantics of that can be clarified, as there is a difference between the
two on ARM.

> +
>  void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
> +void __init early_fixmap_init(void);
>  
>  #include <asm-generic/fixmap.h>
>  
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index e6d8c76..6f03beb 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -37,6 +37,7 @@
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/elf.h>
> +#include <asm/fixmap.h>
>  #include <asm/procinfo.h>
>  #include <asm/psci.h>
>  #include <asm/sections.h>
> @@ -953,6 +954,8 @@ void __init setup_arch(char **cmdline_p)
>  	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
>  	*cmdline_p = cmd_line;
>  
> +	early_fixmap_init();
> +
>  	parse_early_param();
>  
>  #ifdef CONFIG_MMU
> diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
> index b98895d..c7097f9 100644
> --- a/arch/arm/mm/highmem.c
> +++ b/arch/arm/mm/highmem.c
> @@ -78,7 +78,7 @@ void *kmap_atomic(struct page *page)
>  
>  	type = kmap_atomic_idx_push();
>  
> -	idx = type + KM_TYPE_NR * smp_processor_id();
> +	idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
>  	vaddr = __fix_to_virt(idx);
>  #ifdef CONFIG_DEBUG_HIGHMEM
>  	/*
> @@ -105,7 +105,7 @@ void __kunmap_atomic(void *kvaddr)
>  
>  	if (kvaddr >= (void *)FIXADDR_START) {
>  		type = kmap_atomic_idx();
> -		idx = type + KM_TYPE_NR * smp_processor_id();
> +		idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
>  
>  		if (cache_is_vivt())
>  			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
> @@ -135,7 +135,7 @@ void *kmap_atomic_pfn(unsigned long pfn)
>  		return page_address(page);
>  
>  	type = kmap_atomic_idx_push();
> -	idx = type + KM_TYPE_NR * smp_processor_id();
> +	idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
>  	vaddr = __fix_to_virt(idx);
>  #ifdef CONFIG_DEBUG_HIGHMEM
>  	BUG_ON(!pte_none(get_fixmap_pte(vaddr)));
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 6ca7d9a..d3e9702 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -357,6 +357,47 @@ const struct mem_type *get_mem_type(unsigned int type)
>  }
>  EXPORT_SYMBOL(get_mem_type);
>  
> +static pte_t *(*pte_offset_fixmap)(pmd_t *dir, unsigned long addr);
> +
> +static pte_t bm_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS]
> +	__aligned(PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE) __initdata;
> +
> +static pte_t * __init pte_offset_early_fixmap(pmd_t *dir, unsigned long addr)
> +{
> +	return &bm_pte[pte_index(addr)];
> +}
> +
> +static pte_t *pte_offset_late_fixmap(pmd_t *dir, unsigned long addr)
> +{
> +	return pte_offset_kernel(dir, addr);
> +}
> +
> +static inline pmd_t * __init fixmap_pmd(unsigned long addr)
> +{
> +	pgd_t *pgd = pgd_offset_k(addr);
> +	pud_t *pud = pud_offset(pgd, addr);
> +	pmd_t *pmd = pmd_offset(pud, addr);
> +
> +	return pmd;
> +}
> +
> +void __init early_fixmap_init(void)
> +{
> +	pmd_t *pmd;
> +
> +	/*
> +	 * The early fixmap range spans multiple pmds, for which
> +	 * we are not prepared:
> +	 */
> +	BUILD_BUG_ON((__fix_to_virt(__end_of_permanent_fixed_addresses) >> PMD_SHIFT)
> +		     != FIXADDR_TOP >> PMD_SHIFT);
> +
> +	pmd = fixmap_pmd(FIXADDR_TOP);
> +	pmd_populate_kernel(&init_mm, pmd, bm_pte);
> +
> +	pte_offset_fixmap = &pte_offset_early_fixmap;

Please don't use "address-of function" in the kernel, it's really not
necessary and is just plain confusing.  We don't use it elsewhere, so
there's no reason to be different.

> +}
> +
>  /*
>   * To avoid TLB flush broadcasts, this uses local_flush_tlb_kernel_range().
>   * As a result, this can only be called with preemption disabled, as under
> @@ -365,7 +406,7 @@ EXPORT_SYMBOL(get_mem_type);
>  void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>  {
>  	unsigned long vaddr = __fix_to_virt(idx);
> -	pte_t *pte = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
> +	pte_t *pte = pte_offset_fixmap(pmd_off_k(vaddr), vaddr);
>  
>  	/* Make sure fixmap region does not exceed available allocation. */
>  	BUILD_BUG_ON(FIXADDR_START + (__end_of_fixed_addresses * PAGE_SIZE) >
> @@ -855,7 +896,7 @@ static void __init create_mapping(struct map_desc *md)
>  	}
>  
>  	if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
> -	    md->virtual >= PAGE_OFFSET &&
> +	    md->virtual >= PAGE_OFFSET && md->virtual < FIXADDR_START &&
>  	    (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) {
>  		pr_warn("BUG: mapping for 0x%08llx at 0x%08lx out of vmalloc space\n",
>  			(long long)__pfn_to_phys((u64)md->pfn), md->virtual);
> @@ -1231,7 +1272,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
>  
>  	early_trap_init(vectors);
>  
> -	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
> +	for (addr = VMALLOC_START; addr < FIXADDR_START; addr += PMD_SIZE)
>  		pmd_clear(pmd_off_k(addr));

You introduce a bug here - we no logner clear the very top entry of the
page tables, which means it could contain anything - and means that the
subsequent creation of the L2 table in early_pte_alloc() can fail.

>  
>  	/*
> @@ -1483,6 +1524,36 @@ void __init early_paging_init(const struct machine_desc *mdesc)
>  
>  #endif
>  
> +static void __init early_fixmap_shutdown(void)
> +{
> +	int i;
> +	unsigned long va = fix_to_virt(__end_of_permanent_fixed_addresses - 1);
> +
> +	pte_offset_fixmap = &pte_offset_late_fixmap;

Again, please don't use "address-of function".

> +	pmd_clear(fixmap_pmd(va));
> +	local_flush_tlb_kernel_page(va);
> +
> +	for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
> +		pte_t *pte;
> +		struct map_desc map;
> +
> +		map.virtual = fix_to_virt(i);
> +		pte = pte_offset_early_fixmap(pmd_off_k(map.virtual), map.virtual);
> +
> +		/* Only i/o device mappings are supported ATM */
> +		if (pte_none(*pte) ||
> +		    (pte_val(*pte) & L_PTE_MT_MASK) != L_PTE_MT_DEV_SHARED)
> +			continue;
> +
> +		map.pfn = pte_pfn(*pte);
> +		map.type = MT_DEVICE;
> +		map.length = PAGE_SIZE;
> +
> +		create_mapping(&map);
> +	}
> +}
> +
> +
>  /*
>   * paging_init() sets up the page tables, initialises the zone memory
>   * maps, and sets up the zero page, bad page and bad page tables.
> @@ -1495,6 +1566,7 @@ void __init paging_init(const struct machine_desc *mdesc)
>  	prepare_page_table();
>  	map_lowmem();
>  	dma_contiguous_remap();
> +	early_fixmap_shutdown();
>  	devicemaps_init(mdesc);
>  	kmap_init();
>  	tcm_init();
> -- 
> 2.4.2
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
