From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 21 Jan 2015 17:36:06 -0800
Subject: [PATCHv8 2/2] arm64: add better page protections to arm64
In-Reply-To: <1421890566-29883-1-git-send-email-lauraa@codeaurora.org>
References: <1421890566-29883-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1421890566-29883-3-git-send-email-lauraa@codeaurora.org>
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

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/Kconfig.debug            |  23 ++++
 arch/arm64/include/asm/cacheflush.h |   5 +
 arch/arm64/kernel/vmlinux.lds.S     |  17 ++-
 arch/arm64/mm/init.c                |   1 +
 arch/arm64/mm/mm.h                  |   2 +
 arch/arm64/mm/mmu.c                 | 211 ++++++++++++++++++++++++++++++++----
 6 files changed, 233 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 5fdd6dc..4a87410 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -66,4 +66,27 @@ config DEBUG_SET_MODULE_RONX
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
index 7ae31a2..67d309c 100644
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
index 9965ec8..5d9d2dc 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -8,6 +8,7 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 
 #include "image.h"
 
@@ -49,6 +50,14 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 #define PECOFF_EDATA_PADDING
 #endif
 
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
@@ -71,6 +80,7 @@ SECTIONS
 		_text = .;
 		HEAD_TEXT
 	}
+	ALIGN_DEBUG_RO
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
@@ -87,19 +97,22 @@ SECTIONS
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
index bac492c..104a60b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -325,6 +325,7 @@ void __init mem_init(void)
 
 void free_initmem(void)
 {
+	fixup_init();
 	free_initmem_default(0);
 	free_alternatives_memory();
 }
diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
index 50c3351..ef47d99 100644
--- a/arch/arm64/mm/mm.h
+++ b/arch/arm64/mm/mm.h
@@ -1 +1,3 @@
 extern void __init bootmem_init(void);
+
+void fixup_init(void);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3286385..e83d30e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -26,6 +26,7 @@
 #include <linux/memblock.h>
 #include <linux/fs.h>
 #include <linux/io.h>
+#include <linux/stop_machine.h>
 
 #include <asm/cputype.h>
 #include <asm/fixmap.h>
@@ -133,21 +134,43 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 static void __init *early_alloc(unsigned long sz)
 {
 	void *ptr = __va(memblock_alloc(sz, sz));
+	BUG_ON(!ptr);
 	memset(ptr, 0, sz);
 	return ptr;
 }
 
-static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
+/*
+ * remap a PMD into pages
+ */
+static void split_pmd(pmd_t *pmd, pte_t *pte)
+{
+	unsigned long pfn = pmd_pfn(*pmd);
+	int i = 0;
+
+	do {
+		/*
+		 * Need to have the least restrictive permissions available
+		 * permissions will be fixed up later
+		 */
+		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
+		pfn++;
+	} while (pte++, i++, i < PTRS_PER_PTE);
+}
+
+static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
-				  pgprot_t prot)
+				  pgprot_t prot,
+				  void *(*alloc)(unsigned long size))
 {
 	pte_t *pte;
 
-	if (pmd_none(*pmd)) {
-		pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
+	if (pmd_none(*pmd) || pmd_bad(*pmd)) {
+		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
+		if (pmd_sect(*pmd))
+			split_pmd(pmd, pte);
 		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
+		flush_tlb_all();
 	}
-	BUG_ON(pmd_bad(*pmd));
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
@@ -156,9 +179,22 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
 
-static void __init alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
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
+static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 				  unsigned long addr, unsigned long end,
-				  phys_addr_t phys, pgprot_t prot)
+				  phys_addr_t phys, pgprot_t prot,
+				  void *(*alloc)(unsigned long size))
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -167,8 +203,16 @@ static void __init alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 	 * Check for initial section mappings in the pgd/pud and remove them.
 	 */
 	if (pud_none(*pud) || pud_bad(*pud)) {
-		pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
+		pmd = alloc(PTRS_PER_PMD * sizeof(pmd_t));
+		if (pud_sect(*pud)) {
+			/*
+			 * need to have the 1G of mappings continue to be
+			 * present
+			 */
+			split_pud(pud, pmd);
+		}
 		pud_populate(mm, pud, pmd);
+		flush_tlb_all();
 	}
 
 	pmd = pmd_offset(pud, addr);
@@ -187,21 +231,34 @@ static void __init alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 				flush_tlb_all();
 		} else {
 			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
-				       prot);
+				       prot, alloc);
 		}
 		phys += next - addr;
 	} while (pmd++, addr = next, addr != end);
 }
 
-static void __init alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
+static inline bool use_1G_block(unsigned long addr, unsigned long next,
+			unsigned long phys)
+{
+	if (PAGE_SHIFT != 12)
+		return false;
+
+	if (((addr | next | phys) & ~PUD_MASK) != 0)
+		return false;
+
+	return true;
+}
+
+static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 				  unsigned long addr, unsigned long end,
-				  phys_addr_t phys, pgprot_t prot)
+				  phys_addr_t phys, pgprot_t prot,
+				  void *(*alloc)(unsigned long size))
 {
 	pud_t *pud;
 	unsigned long next;
 
 	if (pgd_none(*pgd)) {
-		pud = early_alloc(PTRS_PER_PUD * sizeof(pud_t));
+		pud = alloc(PTRS_PER_PUD * sizeof(pud_t));
 		pgd_populate(mm, pgd, pud);
 	}
 	BUG_ON(pgd_bad(*pgd));
@@ -213,8 +270,7 @@ static void __init alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
-		if ((PAGE_SHIFT == 12) &&
-		    ((addr | next | phys) & ~PUD_MASK) == 0) {
+		if (use_1G_block(addr, next, phys)) {
 			pud_t old_pud = *pud;
 			set_pud(pud, __pud(phys |
 					   pgprot_val(mk_sect_prot(prot))));
@@ -232,7 +288,7 @@ static void __init alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 				flush_tlb_all();
 			}
 		} else {
-			alloc_init_pmd(mm, pud, addr, next, phys, prot);
+			alloc_init_pmd(mm, pud, addr, next, phys, prot, alloc);
 		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
@@ -242,9 +298,10 @@ static void __init alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
  * Create the page directory entries and any necessary page tables for the
  * mapping specified by 'md'.
  */
-static void __init __create_mapping(struct mm_struct *mm, pgd_t *pgd,
+static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 				    phys_addr_t phys, unsigned long virt,
-				    phys_addr_t size, pgprot_t prot)
+				    phys_addr_t size, pgprot_t prot,
+				    void *(*alloc)(unsigned long size))
 {
 	unsigned long addr, length, end, next;
 
@@ -254,13 +311,23 @@ static void __init __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 	end = addr + length;
 	do {
 		next = pgd_addr_end(addr, end);
-		alloc_init_pud(mm, pgd, addr, next, phys, prot);
+		alloc_init_pud(mm, pgd, addr, next, phys, prot, alloc);
 		phys += next - addr;
 	} while (pgd++, addr = next, addr != end);
 }
 
-static void __init create_mapping(phys_addr_t phys, unsigned long virt,
-				  phys_addr_t size)
+static void *late_alloc(unsigned long size)
+{
+	void *ptr;
+
+	BUG_ON(size > PAGE_SIZE);
+	ptr = (void *)__get_free_page(PGALLOC_GFP);
+	BUG_ON(!ptr);
+	return ptr;
+}
+
+static void __ref create_mapping(phys_addr_t phys, unsigned long virt,
+				  phys_addr_t size, pgprot_t prot)
 {
 	if (virt < VMALLOC_START) {
 		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
@@ -268,15 +335,71 @@ static void __init create_mapping(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 	__create_mapping(&init_mm, pgd_offset_k(virt & PAGE_MASK), phys, virt,
-			 size, PAGE_KERNEL_EXEC);
+			 size, prot, early_alloc);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot)
 {
-	__create_mapping(mm, pgd_offset(mm, virt), phys, virt, size, prot);
+	__create_mapping(mm, pgd_offset(mm, virt), phys, virt, size, prot,
+				early_alloc);
+}
+
+static void create_mapping_late(phys_addr_t phys, unsigned long virt,
+				  phys_addr_t size, pgprot_t prot)
+{
+	if (virt < VMALLOC_START) {
+		pr_warn("BUG: not creating mapping for %pa@0x%016lx - outside kernel range\n",
+			&phys, virt);
+		return;
+	}
+
+	return __create_mapping(&init_mm, pgd_offset_k(virt & PAGE_MASK),
+				phys, virt, size, prot, late_alloc);
+}
+
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
+			end - start, PAGE_KERNEL);
+	} else if (start >= kernel_x_end) {
+		create_mapping(start, __phys_to_virt(start),
+			end - start, PAGE_KERNEL);
+	} else {
+		if (start < kernel_x_start)
+			create_mapping(start, __phys_to_virt(start),
+				kernel_x_start - start,
+				PAGE_KERNEL);
+		create_mapping(kernel_x_start,
+				__phys_to_virt(kernel_x_start),
+				kernel_x_end - kernel_x_start,
+				PAGE_KERNEL_EXEC);
+		if (kernel_x_end < end)
+			create_mapping(kernel_x_end,
+				__phys_to_virt(kernel_x_end),
+				end - kernel_x_end,
+				PAGE_KERNEL);
+	}
+
+}
+#else
+static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
+{
+	create_mapping(start, __phys_to_virt(start), end - start,
+			PAGE_KERNEL_EXEC);
 }
+#endif
 
 static void __init map_mem(void)
 {
@@ -322,14 +445,53 @@ static void __init map_mem(void)
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
+				PAGE_KERNEL);
+	}
+
+	if (!IS_ALIGNED((unsigned long)__init_end, SECTION_SIZE)) {
+		unsigned long aligned_end = round_up(__pa(__init_end),
+							SECTION_SIZE);
+		create_mapping(__pa(__init_end), (unsigned long)__init_end,
+				aligned_end - __pa(__init_end),
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
+				PAGE_KERNEL_EXEC | PTE_RDONLY);
+
+}
+#endif
+
+void fixup_init(void)
+{
+	create_mapping_late(__pa(__init_begin), (unsigned long)__init_begin,
+			(unsigned long)__init_end - (unsigned long)__init_begin,
+			PAGE_KERNEL);
+}
+
 /*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps and sets up the zero page.
@@ -339,6 +501,7 @@ void __init paging_init(void)
 	void *zero_page;
 
 	map_mem();
+	fixup_executable();
 
 	/*
 	 * Finally flush the caches and tlb to ensure that we're in a
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
