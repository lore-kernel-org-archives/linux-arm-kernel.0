From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 20 Nov 2014 12:04:01 +0000
Subject: [PATCHv5 7/7] arm64: add better page protections to arm64
In-Reply-To: <1416272105-14787-8-git-send-email-lauraa@codeaurora.org>
References: <1416272105-14787-1-git-send-email-lauraa@codeaurora.org>
 <1416272105-14787-8-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141120120400.GA30398@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 04:55:05PM -0800, Laura Abbott wrote:
> Add page protections for arm64 similar to those in arm.
> This is for security reasons to prevent certain classes
> of exploits. The current method:
> 
> - Map all memory as either RWX or RW. We round to the nearest
>   section to avoid creating page tables before everything is mapped
> - Once everything is mapped, if either end of the RWX section should
>   not be X, we split the PMD and remap as necessary
> - When initmem is to be freed, we change the permissions back to
>   RW (using stop machine if necessary to flush the TLB)
> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
>   read only.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Hi Laura,
Some comments inline.

> ---
> v5:
>  -Dropped map_io from the alloc_init_* functions
>  -Fixed a bug in split_pud and cleaned it up per suggestions from Steve
>  -Aligned _etext up to SECTION_SIZE of DEBUG_ALIGN_RODATA is enabled to ensure
>   that the section mapping is actually kept and we don't leak any RWX regions
>  -Dropped some old ioremap code that somehow snuck in from the last rebase
>  -Fixed create_id_mapping to use the early mapping since efi_idmap_init is
>   called early
> ---
>  arch/arm64/Kconfig.debug            |  23 +++
>  arch/arm64/include/asm/cacheflush.h |   4 +
>  arch/arm64/kernel/vmlinux.lds.S     |  20 +++
>  arch/arm64/mm/init.c                |   1 +
>  arch/arm64/mm/mm.h                  |   2 +
>  arch/arm64/mm/mmu.c                 | 289 +++++++++++++++++++++++++++++++-----
>  6 files changed, 298 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 0a12933..867fe6f1 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -54,4 +54,27 @@ config DEBUG_SET_MODULE_RONX
>            against certain classes of kernel exploits.
>            If in doubt, say "N".
>  
> +config DEBUG_RODATA
> +	bool "Make kernel text and rodata read-only"
> +	help
> +	  If this is set, kernel text and rodata will be made read-only. This
> +	  is to help catch accidental or malicious attempts to change the
> +	  kernel's executable code. Additionally splits rodata from kernel
> +	  text so it can be made explicitly non-executable.
> +
> +          If in doubt, say Y
> +
> +config DEBUG_ALIGN_RODATA
> +	depends on DEBUG_RODATA && !ARM64_64K_PAGES
> +	bool "Align linker sections up to SECTION_SIZE"
> +	help
> +	  If this option is enabled, sections that may potentially be marked as
> +	  read only or non-executable will be aligned up to the section size of
> +	  the kernel. This prevents sections from being split into pages and
> +	  avoids a potential TLB penalty. The downside is an increase in
> +	  alignment and potentially wasted space. Turn on this option if
> +	  performance is more important than memory pressure.
> +
> +	  If in doubt, say N
> +
>  endmenu
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 689b637..0014207 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -152,4 +152,8 @@ int set_memory_ro(unsigned long addr, int numpages);
>  int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
> +
> +#ifdef CONFIG_DEBUG_RODATA
> +void mark_rodata_ro(void);
> +#endif
>  #endif
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 2d7e20a..405820d 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -8,6 +8,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
>  #include <asm/page.h>
> +#include <asm/pgtable.h>
>  
>  #include "image.h"
>  
> @@ -54,6 +55,9 @@ SECTIONS
>  		_text = .;
>  		HEAD_TEXT
>  	}
> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
> +	. = ALIGN(1<<SECTION_SHIFT);
> +#endif

For 64K pages, SECTION_SHIFT will be 29, will that large an alignment
cause any issues?

>  	.text : {			/* Real text segment		*/
>  		_stext = .;		/* Text and read-only data	*/
>  			*(.latehead.text)
> @@ -71,19 +75,35 @@ SECTIONS
>  		*(.got)			/* Global offset table		*/
>  	}
>  
> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
> +	. = ALIGN(1<<SECTION_SHIFT);
> +#endif
>  	RO_DATA(PAGE_SIZE)
>  	EXCEPTION_TABLE(8)
>  	NOTES
> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
> +	. = ALIGN(1<<SECTION_SHIFT);
> +#endif
>  	_etext = .;			/* End of text and rodata section */
>  
> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
> +	. = ALIGN(1<<SECTION_SHIFT);
> +#else
>  	. = ALIGN(PAGE_SIZE);
> +#endif
>  	__init_begin = .;
>  
>  	INIT_TEXT_SECTION(8)
>  	.exit.text : {
>  		ARM_EXIT_KEEP(EXIT_TEXT)
>  	}
> +
> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
> +	. = ALIGN(1<<SECTION_SHIFT);
> +	__init_data_begin = .;
> +#else
>  	. = ALIGN(16);
> +#endif
>  	.init.data : {
>  		INIT_DATA
>  		INIT_SETUP(16)
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 494297c..61f44c7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -324,6 +324,7 @@ void __init mem_init(void)
>  
>  void free_initmem(void)
>  {
> +	fixup_init();
>  	free_initmem_default(0);
>  }
>  
> diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
> index d519f4f..82347d8 100644
> --- a/arch/arm64/mm/mm.h
> +++ b/arch/arm64/mm/mm.h
> @@ -1,2 +1,4 @@
>  extern void __init bootmem_init(void);
>  extern void __init arm64_swiotlb_init(void);
> +
> +void fixup_init(void);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6032f3e..dafde8e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -26,6 +26,7 @@
>  #include <linux/memblock.h>
>  #include <linux/fs.h>
>  #include <linux/io.h>
> +#include <linux/stop_machine.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/fixmap.h>
> @@ -137,17 +138,55 @@ static void __init *early_alloc(unsigned long sz)
>  	return ptr;
>  }
>  
> -static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
> +/*
> + * remap a PMD into pages
> + */
> +static noinline void __ref split_pmd(pmd_t *pmd, bool early)
> +{
> +	pte_t *pte, *start_pte;
> +	unsigned long pfn;
> +	int i = 0;
> +
> +	if (early)
> +		start_pte = pte = early_alloc(PTRS_PER_PTE*sizeof(pte_t));
> +	else
> +		start_pte = pte = (pte_t *)__get_free_page(PGALLOC_GFP);
> +
> +	BUG_ON(!pte);
> +
> +	pfn = pmd_pfn(*pmd);
> +
> +	do {
> +		/*
> +		 * Need to have the least restrictive permissions available
> +		 * permissions will be fixed up later
> +		 */
> +		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
> +		pfn++;
> +	} while (pte++, i++, i < PTRS_PER_PTE);
> +
> +
> +	__pmd_populate(pmd, __pa(start_pte), PMD_TYPE_TABLE);
> +	flush_tlb_all();
> +}
> +
> +static void __ref alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  				  unsigned long end, unsigned long pfn,
> -				  pgprot_t prot)
> +				  pgprot_t prot, bool early)
>  {
>  	pte_t *pte;
>  
>  	if (pmd_none(*pmd)) {
> -		pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
> +		if (early)
> +			pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
> +		else
> +			pte = (pte_t *)__get_free_page(PGALLOC_GFP);
> +		BUG_ON(!pte);
>  		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
>  	}
> -	BUG_ON(pmd_bad(*pmd));
> +
> +	if (pmd_bad(*pmd))
> +		split_pmd(pmd, early);
>  
>  	pte = pte_offset_kernel(pmd, addr);
>  	do {
> @@ -156,29 +195,44 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
>  }
>  
> -static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
> +void __ref split_pud(pud_t *old_pud, pmd_t *pmd)
> +{
> +	unsigned long addr = pud_pfn(*old_pud) << PAGE_SHIFT;
> +	pgprot_t prot = __pgprot(pud_val(*old_pud) ^ pud_pfn(*old_pud));

I don't think this is quite right, the page frame number is the PA
shifted right, so that can't be XOR'ed directly with the pud. The
following should work though:
	pgprot_t prot = __pgprot(pud_val(*old_pud) ^ addr);

> +	int i = 0;
> +
> +	do {
> +		set_pmd(pmd, __pmd(addr | prot));
> +		addr += PMD_SIZE;
> +	} while (pmd++, i++, i < PTRS_PER_PMD);
> +}
> +
> +static void __ref alloc_init_pmd(pud_t *pud, unsigned long addr,
>  				  unsigned long end, phys_addr_t phys,
> -				  int map_io)
> +				  pgprot_t sect_prot, pgprot_t pte_prot,
> +				  bool early)
>  {
>  	pmd_t *pmd;
>  	unsigned long next;
> -	pmdval_t prot_sect;
> -	pgprot_t prot_pte;
> -
> -	if (map_io) {
> -		prot_sect = PROT_SECT_DEVICE_nGnRE;
> -		prot_pte = __pgprot(PROT_DEVICE_nGnRE);
> -	} else {
> -		prot_sect = PROT_SECT_NORMAL_EXEC;
> -		prot_pte = PAGE_KERNEL_EXEC;
> -	}
>  
>  	/*
>  	 * Check for initial section mappings in the pgd/pud and remove them.
>  	 */
>  	if (pud_none(*pud) || pud_bad(*pud)) {
> -		pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
> +		if (early)
> +			pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
> +		else
> +			pmd = pmd_alloc_one(&init_mm, addr);
> +		BUG_ON(!pmd);
> +		if (pud_sect(*pud)) {
> +			/*
> +			 * need to have the 1G of mappings continue to be
> +			 * present
> +			 */
> +			split_pud(pud, pmd);
> +		}
>  		pud_populate(&init_mm, pud, pmd);
> +		flush_tlb_all();
>  	}
>  
>  	pmd = pmd_offset(pud, addr);
> @@ -186,8 +240,8 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>  		next = pmd_addr_end(addr, end);
>  		/* try section mapping first */
>  		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
> -			pmd_t old_pmd =*pmd;
> -			set_pmd(pmd, __pmd(phys | prot_sect));
> +			pmd_t old_pmd = *pmd;
> +			set_pmd(pmd, __pmd(phys | sect_prot));
>  			/*
>  			 * Check for previous table entries created during
>  			 * boot (__create_page_tables) and flush them.
> @@ -196,15 +250,39 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>  				flush_tlb_all();
>  		} else {
>  			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
> -				       prot_pte);
> +					pte_prot, early);
>  		}
>  		phys += next - addr;
>  	} while (pmd++, addr = next, addr != end);
>  }
>  
> -static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
> -				  unsigned long end, phys_addr_t phys,
> -				  int map_io)
> +static inline bool use_1G_block(unsigned long addr, unsigned long next,
> +			unsigned long phys, pgprot_t sect_prot,
> +			pgprot_t pte_prot, bool early)
> +{
> +	if (!early)
> +		return false;
> +
> +	if (PAGE_SHIFT != 12)
> +		return false;
> +
> +	if (((addr | next | phys) & ~PUD_MASK) != 0)
> +		return false;
> +
> +	/*
> +	 * The assumption here is that if the memory is anything other
> +	 * than normal we should not be using a block type
> +	 */
> +	return ((sect_prot & PMD_ATTRINDX_MASK) ==
> +				PMD_ATTRINDX(MT_NORMAL)) &&
> +			((pte_prot & PTE_ATTRINDX_MASK) ==
> +				PTE_ATTRINDX(MT_NORMAL));

Do we need this check for memory type?
A block mapping for device memory is perfectly valid (just unlikely!).

> +}
> +
> +static void __ref alloc_init_pud(pgd_t *pgd, unsigned long addr,
> +				  unsigned long end, unsigned long phys,
> +				  pgprot_t sect_prot, pgprot_t pte_prot,
> +				  bool early)
>  {
>  	pud_t *pud;
>  	unsigned long next;
> @@ -222,10 +300,9 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>  		/*
>  		 * For 4K granule only, attempt to put down a 1GB block
>  		 */
> -		if (!map_io && (PAGE_SHIFT == 12) &&
> -		    ((addr | next | phys) & ~PUD_MASK) == 0) {
> +		if (use_1G_block(addr, next, phys, sect_prot, pte_prot, early)) {
>  			pud_t old_pud = *pud;
> -			set_pud(pud, __pud(phys | PROT_SECT_NORMAL_EXEC));
> +			set_pud(pud, __pud(phys | sect_prot));
>  
>  			/*
>  			 * If we have an old value for a pud, it will
> @@ -240,7 +317,8 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>  				flush_tlb_all();
>  			}
>  		} else {
> -			alloc_init_pmd(pud, addr, next, phys, map_io);
> +			alloc_init_pmd(pud, addr, next, phys, sect_prot,
> +					pte_prot, early);
>  		}
>  		phys += next - addr;
>  	} while (pud++, addr = next, addr != end);
> @@ -250,9 +328,11 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>   * Create the page directory entries and any necessary page tables for the
>   * mapping specified by 'md'.
>   */
> -static void __init __create_mapping(pgd_t *pgd, phys_addr_t phys,
> -				    unsigned long virt, phys_addr_t size,
> -				    int map_io)
> +static void __ref __create_mapping(pgd_t *pgd, phys_addr_t phys,
> +				  unsigned long virt,
> +				  phys_addr_t size,
> +				  pgprot_t sect_prot, pgprot_t pte_prot,
> +				  bool early)
>  {
>  	unsigned long addr, length, end, next;
>  
> @@ -262,31 +342,102 @@ static void __init __create_mapping(pgd_t *pgd, phys_addr_t phys,
>  	end = addr + length;
>  	do {
>  		next = pgd_addr_end(addr, end);
> -		alloc_init_pud(pgd, addr, next, phys, map_io);
> +		alloc_init_pud(pgd, addr, next, phys, sect_prot, pte_prot,
> +				early);
>  		phys += next - addr;
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> -static void __init create_mapping(phys_addr_t phys, unsigned long virt,
> -				  phys_addr_t size)
> +void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
> +{
> +	pgprot_t sect_prot = PROT_SECT_NORMAL_EXEC;
> +	pgprot_t pte_prot = PAGE_KERNEL_EXEC;
> +
> +	if ((addr >> PGDIR_SHIFT) >= ARRAY_SIZE(idmap_pg_dir)) {
> +		pr_warn("BUG: not creating id mapping for %pa\n", &addr);
> +		return;
> +	}
> +
> +	if (map_io) {
> +		sect_prot = PROT_SECT_DEVICE_nGnRE;
> +		pte_prot = __pgprot(PROT_DEVICE_nGnRE);
> +	}
> +
> +	__create_mapping(&idmap_pg_dir[pgd_index(addr)],
> +			 addr, addr, size, sect_prot, pte_prot, true);
> +}
> +
> +static void __ref create_mapping(phys_addr_t phys, unsigned long virt,
> +				  phys_addr_t size,
> +				  pgprot_t sect_prot, pgprot_t pte_prot)
>  {
>  	if (virt < VMALLOC_START) {
>  		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
>  			&phys, virt);
>  		return;
>  	}
> -	__create_mapping(pgd_offset_k(virt & PAGE_MASK), phys, virt, size, 0);
> +
> +	return __create_mapping(pgd_offset_k(virt & PAGE_MASK), phys, virt,
> +				size, sect_prot, pte_prot, true);
>  }
>  
> -void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
> +static void __ref create_mapping_late(phys_addr_t phys, unsigned long virt,
> +				  phys_addr_t size,
> +				  pgprot_t sect_prot, pgprot_t pte_prot)
>  {
> -	if ((addr >> PGDIR_SHIFT) >= ARRAY_SIZE(idmap_pg_dir)) {
> -		pr_warn("BUG: not creating id mapping for %pa\n", &addr);
> +	if (virt < VMALLOC_START) {
> +		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
> +			&phys, virt);
>  		return;
>  	}
> -	__create_mapping(&idmap_pg_dir[pgd_index(addr)],
> -			 addr, addr, size, map_io);
> +
> +	return __create_mapping(pgd_offset_k(virt & PAGE_MASK), phys, virt,
> +				size, sect_prot, pte_prot, false);
> +}
> +
> +#ifdef CONFIG_DEBUG_RODATA
> +static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
> +{
> +	/*
> +	 * Set up the executable regions using the existing section mappings
> +	 * for now. This will get more fine grained later once all memory
> +	 * is mapped
> +	 */
> +	unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> +	unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
> +
> +	if (end < kernel_x_start) {
> +		create_mapping(start, __phys_to_virt(start),
> +			end - start, PROT_SECT_NORMAL, PAGE_KERNEL);
> +	} else if (start >= kernel_x_end) {
> +		create_mapping(start, __phys_to_virt(start),
> +			end - start, PROT_SECT_NORMAL, PAGE_KERNEL);
> +	} else {
> +		if (start < kernel_x_start)
> +			create_mapping(start, __phys_to_virt(start),
> +				kernel_x_start - start,
> +				PROT_SECT_NORMAL,
> +				PAGE_KERNEL);
> +		create_mapping(kernel_x_start,
> +				__phys_to_virt(kernel_x_start),
> +				kernel_x_end - kernel_x_start,
> +				PROT_SECT_NORMAL_EXEC, PAGE_KERNEL_EXEC);
> +		if (kernel_x_end < end)
> +			create_mapping(kernel_x_end,
> +				__phys_to_virt(kernel_x_end),
> +				end - kernel_x_end,
> +				PROT_SECT_NORMAL,
> +				PAGE_KERNEL);
> +	}
> +
>  }
> +#else
> +static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
> +{
> +	create_mapping(start, __phys_to_virt(start), end - start,
> +			PROT_SECT_NORMAL_EXEC, PAGE_KERNEL_EXEC);
> +}
> +#endif
>  
>  static void __init map_mem(void)
>  {
> @@ -332,14 +483,69 @@ static void __init map_mem(void)
>  			memblock_set_current_limit(limit);
>  		}
>  #endif
> -
> -		create_mapping(start, __phys_to_virt(start), end - start);
> +		__map_memblock(start, end);
>  	}
>  
>  	/* Limit no longer required. */
>  	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
>  }
>  
> +void __init fixup_executable(void)
> +{
> +#ifdef CONFIG_DEBUG_RODATA
> +	/* now that we are actually fully mapped, make the start/end more fine grained */
> +	if (!IS_ALIGNED((unsigned long)_stext, SECTION_SIZE)) {
> +		unsigned long aligned_start = round_down(__pa(_stext),
> +							SECTION_SIZE);
> +
> +		create_mapping(aligned_start, __phys_to_virt(aligned_start),
> +				__pa(_stext) - aligned_start,
> +				PROT_SECT_NORMAL,
> +				PAGE_KERNEL);
> +	}
> +
> +	if (!IS_ALIGNED((unsigned long)__init_end, SECTION_SIZE)) {
> +		unsigned long aligned_end = round_up(__pa(__init_end),
> +							SECTION_SIZE);
> +		create_mapping(__pa(__init_end), (unsigned long)__init_end,
> +				aligned_end - __pa(__init_end),
> +				PROT_SECT_NORMAL,
> +				PAGE_KERNEL);
> +	}
> +#endif
> +}
> +
> +#ifdef CONFIG_DEBUG_RODATA
> +void mark_rodata_ro(void)
> +{
> +	create_mapping_late(__pa(_stext), (unsigned long)_stext,
> +				(unsigned long)_etext - (unsigned long)_stext,
> +				PROT_SECT_NORMAL_EXEC | PMD_SECT_RDONLY,
> +				PAGE_KERNEL_EXEC | PTE_RDONLY);
> +
> +}
> +#endif
> +
> +static int __flush_mappings(void *unused)
> +{
> +	flush_tlb_kernel_range((unsigned long)__init_begin,
> +				(unsigned long)__init_end);
> +	return 0;
> +}
> +
> +void __ref fixup_init(void)
> +{
> +	phys_addr_t start = __pa(__init_begin);
> +	phys_addr_t end = __pa(__init_end);
> +
> +	create_mapping_late(start, (unsigned long)__init_begin,
> +			end - start,
> +			PROT_SECT_NORMAL,
> +			PAGE_KERNEL);
> +	if (!IS_ALIGNED(start, SECTION_SIZE) || !IS_ALIGNED(end, SECTION_SIZE))
> +		stop_machine(__flush_mappings, NULL, NULL);
> +}
> +
>  /*
>   * paging_init() sets up the page tables, initialises the zone memory
>   * maps and sets up the zero page.
> @@ -349,6 +555,7 @@ void __init paging_init(void)
>  	void *zero_page;
>  
>  	map_mem();
> +	fixup_executable();
>  
>  	/*
>  	 * Finally flush the caches and tlb to ensure that we're in a
> -- 
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> 


Cheers,
-- 
Steve
