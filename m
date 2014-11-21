From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 21 Nov 2014 13:50:45 -0800
Subject: [PATCHv6] arm64: add better page protections to arm64
In-Reply-To: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
References: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1416606645-25633-9-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add page protections for arm64 similar to those in arm.
This is for security reasons to prevent certain classes
of exploits. The current method:

- Map all memory as either RWX or RW. We round to the nearest
  section to avoid creating page tables before everything is mapped
- Once everything is mapped, if either end of the RWX section should
  not be X, we split the PMD and remap as necessary
- When initmem is to be freed, we change the permissions back to
  RW (using stop machine if necessary to flush the TLB)
- If CONFIG_DEBUG_RODATA is set, the read only sections are set
  read only.

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
v6: Adjusted the macros in vmlinux.lds.S. Changed the create_mapping functions
to take an allocation parameter and dropped the __ref from everything. Fix
pointed out by Steve Capper in split_pud. Introduction of adjust_exec_mem
for fixing up ioremap_exec as needed.
---
 arch/arm64/Kconfig.debug            |  23 +++
 arch/arm64/include/asm/cacheflush.h |   5 +
 arch/arm64/kernel/vmlinux.lds.S     |  18 ++-
 arch/arm64/mm/init.c                |   1 +
 arch/arm64/mm/ioremap.c             |   9 +-
 arch/arm64/mm/mm.h                  |   4 +
 arch/arm64/mm/mmu.c                 | 311 +++++++++++++++++++++++++++++++-----
 7 files changed, 325 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 0a12933..867fe6f1 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -54,4 +54,27 @@ config DEBUG_SET_MODULE_RONX
           against certain classes of kernel exploits.
           If in doubt, say "N".
 
+config DEBUG_RODATA
+	bool "Make kernel text and rodata read-only"
+	help
+	  If this is set, kernel text and rodata will be made read-only. This
+	  is to help catch accidental or malicious attempts to change the
+	  kernel's executable code. Additionally splits rodata from kernel
+	  text so it can be made explicitly non-executable.
+
+          If in doubt, say Y
+
+config DEBUG_ALIGN_RODATA
+	depends on DEBUG_RODATA && !ARM64_64K_PAGES
+	bool "Align linker sections up to SECTION_SIZE"
+	help
+	  If this option is enabled, sections that may potentially be marked as
+	  read only or non-executable will be aligned up to the section size of
+	  the kernel. This prevents sections from being split into pages and
+	  avoids a potential TLB penalty. The downside is an increase in
+	  alignment and potentially wasted space. Turn on this option if
+	  performance is more important than memory pressure.
+
+	  If in doubt, say N
+
 endmenu
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 689b637..81a5e4d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -152,4 +152,9 @@ int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
+
+#ifdef CONFIG_DEBUG_RODATA
+void mark_rodata_ro(void);
+#endif
+
 #endif
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index edf8715..6b132f9 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -8,6 +8,7 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 
 #include "image.h"
 
@@ -32,6 +33,15 @@ jiffies = jiffies_64;
 	*(.hyp.text)					\
 	VMLINUX_SYMBOL(__hyp_text_end) = .;
 
+
+#ifdef CONFIG_DEBUG_ALIGN_RODATA
+#define ALIGN_DEBUG_RO			. = ALIGN(1<<SECTION_SHIFT);
+#define ALIGN_DEBUG_RO_MIN(min)		ALIGN_DEBUG_RO
+#else
+#define ALIGN_DEBUG_RO
+#define ALIGN_DEBUG_RO_MIN(min)		. = ALIGN(min);
+#endif
+
 SECTIONS
 {
 	/*
@@ -54,6 +64,7 @@ SECTIONS
 		_text = .;
 		HEAD_TEXT
 	}
+	ALIGN_DEBUG_RO
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
@@ -70,19 +81,22 @@ SECTIONS
 		*(.got)			/* Global offset table		*/
 	}
 
+	ALIGN_DEBUG_RO
 	RO_DATA(PAGE_SIZE)
 	EXCEPTION_TABLE(8)
 	NOTES
+	ALIGN_DEBUG_RO
 	_etext = .;			/* End of text and rodata section */
 
-	. = ALIGN(PAGE_SIZE);
+	ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
 	__init_begin = .;
 
 	INIT_TEXT_SECTION(8)
 	.exit.text : {
 		ARM_EXIT_KEEP(EXIT_TEXT)
 	}
-	. = ALIGN(16);
+
+	ALIGN_DEBUG_RO_MIN(16)
 	.init.data : {
 		INIT_DATA
 		INIT_SETUP(16)
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 494297c..61f44c7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -324,6 +324,7 @@ void __init mem_init(void)
 
 void free_initmem(void)
 {
+	fixup_init();
 	free_initmem_default(0);
 }
 
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index b998441..265dc2d 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -29,6 +29,8 @@
 #include <asm/tlbflush.h>
 #include <asm/pgalloc.h>
 
+#include "mm.h"
+
 static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
 				      pgprot_t prot, void *caller)
 {
@@ -106,8 +108,11 @@ EXPORT_SYMBOL(ioremap_cache);
 void __iomem *ioremap_exec(phys_addr_t phys_addr, size_t size)
 {
 	/* For normal memory we already have a cacheable mapping. */
-	if (pfn_valid(__phys_to_pfn(phys_addr)))
-		return (void __iomem *)__phys_to_virt(phys_addr);
+	if (pfn_valid(__phys_to_pfn(phys_addr))) {
+		unsigned long val = __phys_to_virt(phys_addr);
+		adjust_exec_mem(val, val + size);
+		return (void __iomem *)val;
+	}
 
 	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL_EXEC),
 				__builtin_return_address(0));
diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
index d519f4f..b4eda23 100644
--- a/arch/arm64/mm/mm.h
+++ b/arch/arm64/mm/mm.h
@@ -1,2 +1,6 @@
 extern void __init bootmem_init(void);
 extern void __init arm64_swiotlb_init(void);
+
+void fixup_init(void);
+void adjust_exec_mem(unsigned long start, unsigned long end);
+
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6032f3e..cc84d9c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -26,6 +26,7 @@
 #include <linux/memblock.h>
 #include <linux/fs.h>
 #include <linux/io.h>
+#include <linux/stop_machine.h>
 
 #include <asm/cputype.h>
 #include <asm/fixmap.h>
@@ -137,17 +138,50 @@ static void __init *early_alloc(unsigned long sz)
 	return ptr;
 }
 
-static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
+/*
+ * remap a PMD into pages
+ */
+static noinline void split_pmd(pmd_t *pmd,
+				void *(*alloc)(unsigned long size))
+{
+	pte_t *pte, *start_pte;
+	unsigned long pfn;
+	int i = 0;
+
+	start_pte = pte = alloc(PTRS_PER_PTE*sizeof(pte_t));
+	BUG_ON(!pte);
+
+	pfn = pmd_pfn(*pmd);
+
+	do {
+		/*
+		 * Need to have the least restrictive permissions available
+		 * permissions will be fixed up later
+		 */
+		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
+		pfn++;
+	} while (pte++, i++, i < PTRS_PER_PTE);
+
+
+	__pmd_populate(pmd, __pa(start_pte), PMD_TYPE_TABLE);
+	flush_tlb_all();
+}
+
+static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
-				  pgprot_t prot)
+				  pgprot_t prot,
+				  void *(*alloc)(unsigned long size))
 {
 	pte_t *pte;
 
 	if (pmd_none(*pmd)) {
-		pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
+		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
+		BUG_ON(!pte);
 		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
 	}
-	BUG_ON(pmd_bad(*pmd));
+
+	if (pmd_bad(*pmd))
+		split_pmd(pmd, alloc);
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
@@ -156,29 +190,41 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
 
-static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
+void split_pud(pud_t *old_pud, pmd_t *pmd)
+{
+	unsigned long addr = pud_pfn(*old_pud) << PAGE_SHIFT;
+	pgprot_t prot = __pgprot(pud_val(*old_pud) ^ addr);
+	int i = 0;
+
+	do {
+		set_pmd(pmd, __pmd(addr | prot));
+		addr += PMD_SIZE;
+	} while (pmd++, i++, i < PTRS_PER_PMD);
+}
+
+static void alloc_init_pmd(pud_t *pud, unsigned long addr,
 				  unsigned long end, phys_addr_t phys,
-				  int map_io)
+				  pgprot_t sect_prot, pgprot_t pte_prot,
+				  void *(*alloc)(unsigned long size))
 {
 	pmd_t *pmd;
 	unsigned long next;
-	pmdval_t prot_sect;
-	pgprot_t prot_pte;
-
-	if (map_io) {
-		prot_sect = PROT_SECT_DEVICE_nGnRE;
-		prot_pte = __pgprot(PROT_DEVICE_nGnRE);
-	} else {
-		prot_sect = PROT_SECT_NORMAL_EXEC;
-		prot_pte = PAGE_KERNEL_EXEC;
-	}
 
 	/*
 	 * Check for initial section mappings in the pgd/pud and remove them.
 	 */
 	if (pud_none(*pud) || pud_bad(*pud)) {
-		pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
+		pmd = alloc(PTRS_PER_PMD * sizeof(pmd_t));
+		BUG_ON(!pmd);
+		if (pud_sect(*pud)) {
+			/*
+			 * need to have the 1G of mappings continue to be
+			 * present
+			 */
+			split_pud(pud, pmd);
+		}
 		pud_populate(&init_mm, pud, pmd);
+		flush_tlb_all();
 	}
 
 	pmd = pmd_offset(pud, addr);
@@ -186,8 +232,8 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
 		next = pmd_addr_end(addr, end);
 		/* try section mapping first */
 		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
-			pmd_t old_pmd =*pmd;
-			set_pmd(pmd, __pmd(phys | prot_sect));
+			pmd_t old_pmd = *pmd;
+			set_pmd(pmd, __pmd(phys | sect_prot));
 			/*
 			 * Check for previous table entries created during
 			 * boot (__create_page_tables) and flush them.
@@ -196,21 +242,42 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
 				flush_tlb_all();
 		} else {
 			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
-				       prot_pte);
+					pte_prot, alloc);
 		}
 		phys += next - addr;
 	} while (pmd++, addr = next, addr != end);
 }
 
-static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
-				  unsigned long end, phys_addr_t phys,
-				  int map_io)
+static inline bool use_1G_block(unsigned long addr, unsigned long next,
+			unsigned long phys, pgprot_t sect_prot,
+			pgprot_t pte_prot)
+{
+	if (PAGE_SHIFT != 12)
+		return false;
+
+	if (((addr | next | phys) & ~PUD_MASK) != 0)
+		return false;
+
+	/*
+	 * The assumption here is that if the memory is anything other
+	 * than normal we should not be using a block type
+	 */
+	return ((sect_prot & PMD_ATTRINDX_MASK) ==
+				PMD_ATTRINDX(MT_NORMAL)) &&
+			((pte_prot & PTE_ATTRINDX_MASK) ==
+				PTE_ATTRINDX(MT_NORMAL));
+}
+
+static void alloc_init_pud(pgd_t *pgd, unsigned long addr,
+				  unsigned long end, unsigned long phys,
+				  pgprot_t sect_prot, pgprot_t pte_prot,
+				  void *(*alloc)(unsigned long size))
 {
 	pud_t *pud;
 	unsigned long next;
 
 	if (pgd_none(*pgd)) {
-		pud = early_alloc(PTRS_PER_PUD * sizeof(pud_t));
+		pud = alloc(PTRS_PER_PUD * sizeof(pud_t));
 		pgd_populate(&init_mm, pgd, pud);
 	}
 	BUG_ON(pgd_bad(*pgd));
@@ -222,10 +289,9 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
-		if (!map_io && (PAGE_SHIFT == 12) &&
-		    ((addr | next | phys) & ~PUD_MASK) == 0) {
+		if (use_1G_block(addr, next, phys, sect_prot, pte_prot)) {
 			pud_t old_pud = *pud;
-			set_pud(pud, __pud(phys | PROT_SECT_NORMAL_EXEC));
+			set_pud(pud, __pud(phys | sect_prot));
 
 			/*
 			 * If we have an old value for a pud, it will
@@ -240,7 +306,8 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
 				flush_tlb_all();
 			}
 		} else {
-			alloc_init_pmd(pud, addr, next, phys, map_io);
+			alloc_init_pmd(pud, addr, next, phys, sect_prot,
+					pte_prot, alloc);
 		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
@@ -250,9 +317,11 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
  * Create the page directory entries and any necessary page tables for the
  * mapping specified by 'md'.
  */
-static void __init __create_mapping(pgd_t *pgd, phys_addr_t phys,
-				    unsigned long virt, phys_addr_t size,
-				    int map_io)
+static void __create_mapping(pgd_t *pgd, phys_addr_t phys,
+				  unsigned long virt,
+				  phys_addr_t size,
+				  pgprot_t sect_prot, pgprot_t pte_prot,
+				  void *(*alloc)(unsigned long size))
 {
 	unsigned long addr, length, end, next;
 
@@ -262,32 +331,109 @@ static void __init __create_mapping(pgd_t *pgd, phys_addr_t phys,
 	end = addr + length;
 	do {
 		next = pgd_addr_end(addr, end);
-		alloc_init_pud(pgd, addr, next, phys, map_io);
+		alloc_init_pud(pgd, addr, next, phys, sect_prot, pte_prot,
+				alloc);
 		phys += next - addr;
 	} while (pgd++, addr = next, addr != end);
 }
 
-static void __init create_mapping(phys_addr_t phys, unsigned long virt,
-				  phys_addr_t size)
+void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
+{
+	pgprot_t sect_prot = PROT_SECT_NORMAL_EXEC;
+	pgprot_t pte_prot = PAGE_KERNEL_EXEC;
+
+	if ((addr >> PGDIR_SHIFT) >= ARRAY_SIZE(idmap_pg_dir)) {
+		pr_warn("BUG: not creating id mapping for %pa\n", &addr);
+		return;
+	}
+
+	if (map_io) {
+		sect_prot = PROT_SECT_DEVICE_nGnRE;
+		pte_prot = __pgprot(PROT_DEVICE_nGnRE);
+	}
+
+	__create_mapping(&idmap_pg_dir[pgd_index(addr)],
+			 addr, addr, size, sect_prot, pte_prot, early_alloc);
+}
+
+static void *late_alloc(unsigned long size)
+{
+	BUG_ON(size > PAGE_SIZE);
+	return (void *)__get_free_page(PGALLOC_GFP);
+}
+
+static void __ref create_mapping(phys_addr_t phys, unsigned long virt,
+				  phys_addr_t size,
+				  pgprot_t sect_prot, pgprot_t pte_prot)
 {
 	if (virt < VMALLOC_START) {
 		pr_warn("BUG: not creating mapping for %pa@0x%016lx - outside kernel range\n",
 			&phys, virt);
 		return;
 	}
-	__create_mapping(pgd_offset_k(virt & PAGE_MASK), phys, virt, size, 0);
+
+	return __create_mapping(pgd_offset_k(virt & PAGE_MASK), phys, virt,
+				size, sect_prot, pte_prot, early_alloc);
 }
 
-void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
+static void create_mapping_late(phys_addr_t phys, unsigned long virt,
+				  phys_addr_t size,
+				  pgprot_t sect_prot, pgprot_t pte_prot)
 {
-	if ((addr >> PGDIR_SHIFT) >= ARRAY_SIZE(idmap_pg_dir)) {
-		pr_warn("BUG: not creating id mapping for %pa\n", &addr);
+	if (virt < VMALLOC_START) {
+		pr_warn("BUG: not creating mapping for %pa@0x%016lx - outside kernel range\n",
+			&phys, virt);
 		return;
 	}
-	__create_mapping(&idmap_pg_dir[pgd_index(addr)],
-			 addr, addr, size, map_io);
+
+	return __create_mapping(pgd_offset_k(virt & PAGE_MASK), phys, virt,
+				size, sect_prot, pte_prot, late_alloc);
 }
 
+#ifdef CONFIG_DEBUG_RODATA
+static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
+{
+	/*
+	 * Set up the executable regions using the existing section mappings
+	 * for now. This will get more fine grained later once all memory
+	 * is mapped
+	 */
+	unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
+	unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
+
+	if (end < kernel_x_start) {
+		create_mapping(start, __phys_to_virt(start),
+			end - start, PROT_SECT_NORMAL, PAGE_KERNEL);
+	} else if (start >= kernel_x_end) {
+		create_mapping(start, __phys_to_virt(start),
+			end - start, PROT_SECT_NORMAL, PAGE_KERNEL);
+	} else {
+		if (start < kernel_x_start)
+			create_mapping(start, __phys_to_virt(start),
+				kernel_x_start - start,
+				PROT_SECT_NORMAL,
+				PAGE_KERNEL);
+		create_mapping(kernel_x_start,
+				__phys_to_virt(kernel_x_start),
+				kernel_x_end - kernel_x_start,
+				PROT_SECT_NORMAL_EXEC, PAGE_KERNEL_EXEC);
+		if (kernel_x_end < end)
+			create_mapping(kernel_x_end,
+				__phys_to_virt(kernel_x_end),
+				end - kernel_x_end,
+				PROT_SECT_NORMAL,
+				PAGE_KERNEL);
+	}
+
+}
+#else
+static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
+{
+	create_mapping(start, __phys_to_virt(start), end - start,
+			PROT_SECT_NORMAL_EXEC, PAGE_KERNEL_EXEC);
+}
+#endif
+
 static void __init map_mem(void)
 {
 	struct memblock_region *reg;
@@ -332,14 +478,94 @@ static void __init map_mem(void)
 			memblock_set_current_limit(limit);
 		}
 #endif
-
-		create_mapping(start, __phys_to_virt(start), end - start);
+		__map_memblock(start, end);
 	}
 
 	/* Limit no longer required. */
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 }
 
+void __init fixup_executable(void)
+{
+#ifdef CONFIG_DEBUG_RODATA
+	/* now that we are actually fully mapped, make the start/end more fine grained */
+	if (!IS_ALIGNED((unsigned long)_stext, SECTION_SIZE)) {
+		unsigned long aligned_start = round_down(__pa(_stext),
+							SECTION_SIZE);
+
+		create_mapping(aligned_start, __phys_to_virt(aligned_start),
+				__pa(_stext) - aligned_start,
+				PROT_SECT_NORMAL,
+				PAGE_KERNEL);
+	}
+
+	if (!IS_ALIGNED((unsigned long)__init_end, SECTION_SIZE)) {
+		unsigned long aligned_end = round_up(__pa(__init_end),
+							SECTION_SIZE);
+		create_mapping(__pa(__init_end), (unsigned long)__init_end,
+				aligned_end - __pa(__init_end),
+				PROT_SECT_NORMAL,
+				PAGE_KERNEL);
+	}
+#endif
+}
+
+#ifdef CONFIG_DEBUG_RODATA
+void mark_rodata_ro(void)
+{
+	create_mapping_late(__pa(_stext), (unsigned long)_stext,
+				(unsigned long)_etext - (unsigned long)_stext,
+				PROT_SECT_NORMAL_EXEC | PMD_SECT_RDONLY,
+				PAGE_KERNEL_EXEC | PTE_RDONLY);
+
+}
+#endif
+
+struct flush_addr {
+	unsigned long start;
+	unsigned long end;
+};
+
+static int __flush_mappings(void *val)
+{
+	struct flush_addr *data = val;
+
+	flush_tlb_kernel_range(data->start, data->end);
+	return 0;
+}
+
+static void adjust_mem(unsigned long vstart, unsigned long vend,
+			phys_addr_t phys,
+			pgprot_t sect_prot, pgprot_t pte_prot)
+{
+	struct flush_addr f;
+
+	create_mapping_late(phys, vstart, vend - vstart,
+			sect_prot, pte_prot);
+
+	if (!IS_ALIGNED(vstart, SECTION_SIZE) || !IS_ALIGNED(vend, SECTION_SIZE)) {
+		f.start = vstart;
+		f.end = vend;
+		stop_machine(__flush_mappings, &f, NULL);
+	}
+
+}
+
+void fixup_init(void)
+{
+	adjust_mem((unsigned long)__init_begin, (unsigned long)__init_end,
+			__pa(__init_begin),
+			PROT_SECT_NORMAL,
+			PAGE_KERNEL);
+}
+
+void adjust_exec_mem(unsigned long start, unsigned long end)
+{
+	adjust_mem(start, end, __pa(start),
+			PROT_SECT_NORMAL_EXEC,
+			PAGE_KERNEL_EXEC);
+}
+
 /*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps and sets up the zero page.
@@ -349,6 +575,7 @@ void __init paging_init(void)
 	void *zero_page;
 
 	map_mem();
+	fixup_executable();
 
 	/*
 	 * Finally flush the caches and tlb to ensure that we're in a
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
