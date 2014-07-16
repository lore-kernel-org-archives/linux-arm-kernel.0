From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Jul 2014 20:09:48 +0100
Subject: [PATCH v7 07/11] arm64: mm: Implement 4 levels of translation tables
In-Reply-To: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
References: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1405537792-23666-8-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jungseok Lee <jays.lee@samsung.com>

This patch implements 4 levels of translation tables since 3 levels
of page tables with 4KB pages cannot support 40-bit physical address
space described in [1] due to the following issue.

It is a restriction that kernel logical memory map with 4KB + 3 levels
(0xffffffc000000000-0xffffffffffffffff) cannot cover RAM region from
544GB to 1024GB in [1]. Specifically, ARM64 kernel fails to create
mapping for this region in map_mem function since __phys_to_virt for
this region reaches to address overflow.

If SoC design follows the document, [1], over 32GB RAM would be placed
from 544GB. Even 64GB system is supposed to use the region from 544GB
to 576GB for only 32GB RAM. Naturally, it would reach to enable 4 levels
of page tables to avoid hacking __virt_to_phys and __phys_to_virt.

However, it is recommended 4 levels of page table should be only enabled
if memory map is too sparse or there is about 512GB RAM.

References
----------
[1]: Principles of ARM Memory Maps, White Paper, Issue C

Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Steve Capper <steve.capper@linaro.org>
[catalin.marinas at arm.com: MEMBLOCK_INITIAL_LIMIT removed, same as PUD_SIZE]
[catalin.marinas at arm.com: early_ioremap_init() updated for 4 levels]
[catalin.marinas at arm.com: 4 page tables levels only if !KVM]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                     |  9 ++++++++
 arch/arm64/include/asm/page.h          | 13 ++++++++---
 arch/arm64/include/asm/pgalloc.h       | 20 ++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  6 +++--
 arch/arm64/include/asm/pgtable.h       | 40 ++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/tlb.h           |  9 ++++++++
 arch/arm64/kernel/head.S               | 42 +++++++++++++++++++++++++++-------
 arch/arm64/kernel/traps.c              |  5 ++++
 arch/arm64/mm/fault.c                  |  1 +
 arch/arm64/mm/ioremap.c                |  6 ++++-
 arch/arm64/mm/mmu.c                    | 14 +++++++++---
 11 files changed, 148 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4daf11f5b403..24cbe72c0da9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,12 +196,18 @@ config ARM64_VA_BITS_42
 	bool "42-bit"
 	depends on ARM64_64K_PAGES
 
+config ARM64_VA_BITS_48
+	bool "48-bit"
+	depends on !KVM
+	depends on ARM64_4K_PAGES
+
 endchoice
 
 config ARM64_VA_BITS
 	int
 	default 39 if ARM64_VA_BITS_39
 	default 42 if ARM64_VA_BITS_42
+	default 48 if ARM64_VA_BITS_48
 
 config ARM64_2_LEVELS
 	def_bool y if ARM64_64K_PAGES && ARM64_VA_BITS_42
@@ -209,6 +215,9 @@ config ARM64_2_LEVELS
 config ARM64_3_LEVELS
 	def_bool y if ARM64_4K_PAGES && ARM64_VA_BITS_39
 
+config ARM64_4_LEVELS
+	def_bool y if ARM64_4K_PAGES && ARM64_VA_BITS_48
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 6bf139188792..cf9afa0366b6 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -33,19 +33,26 @@
 
 /*
  * The idmap and swapper page tables need some space reserved in the kernel
- * image. Both require a pgd and a next level table to (section) map the
- * kernel. The the swapper also maaps the FDT (see __create_page_tables for
+ * image. Both require pgd, pud (4 levels only) and pmd tables to (section)
+ * map the kernel. The swapper also maps the FDT (see __create_page_tables for
  * more information).
  */
+#ifdef CONFIG_ARM64_4_LEVELS
+#define SWAPPER_DIR_SIZE	(3 * PAGE_SIZE)
+#define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
+#else
 #define SWAPPER_DIR_SIZE	(2 * PAGE_SIZE)
 #define IDMAP_DIR_SIZE		(2 * PAGE_SIZE)
+#endif
 
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_ARM64_2_LEVELS
 #include <asm/pgtable-2level-types.h>
-#else
+#elif defined(CONFIG_ARM64_3_LEVELS)
 #include <asm/pgtable-3level-types.h>
+#else
+#include <asm/pgtable-4level-types.h>
 #endif
 
 extern void __cpu_clear_user_page(void *p, unsigned long user);
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 48298376e46a..8d745fae4c2d 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -26,6 +26,26 @@
 
 #define check_pgt_cache()		do { } while (0)
 
+#ifdef CONFIG_ARM64_4_LEVELS
+
+static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return (pud_t *)get_zeroed_page(GFP_KERNEL | __GFP_REPEAT);
+}
+
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
+	free_page((unsigned long)pud);
+}
+
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
+{
+	set_pgd(pgd, __pgd(__pa(pud) | PUD_TYPE_TABLE));
+}
+
+#endif  /* CONFIG_ARM64_4_LEVELS */
+
 #ifndef CONFIG_ARM64_2_LEVELS
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index c7c603b489b8..fddcc3efa569 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -18,8 +18,10 @@
 
 #ifdef CONFIG_ARM64_2_LEVELS
 #include <asm/pgtable-2level-hwdef.h>
-#else
+#elif defined(CONFIG_ARM64_3_LEVELS)
 #include <asm/pgtable-3level-hwdef.h>
+#else
+#include <asm/pgtable-4level-hwdef.h>
 #endif
 
 /*
@@ -27,7 +29,7 @@
  *
  * Level 1 descriptor (PUD).
  */
-
+#define PUD_TYPE_TABLE		(_AT(pudval_t, 3) << 0)
 #define PUD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
 #define PUD_TYPE_MASK		(_AT(pgdval_t, 3) << 0)
 #define PUD_TYPE_SECT		(_AT(pgdval_t, 1) << 0)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6d5854972a77..d9b23efdaded 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -35,7 +35,11 @@
  * VMALLOC and SPARSEMEM_VMEMMAP ranges.
  */
 #define VMALLOC_START		(UL(0xffffffffffffffff) << VA_BITS)
+#ifndef CONFIG_ARM64_4_LEVELS
 #define VMALLOC_END		(PAGE_OFFSET - UL(0x400000000) - SZ_64K)
+#else
+#define VMALLOC_END		(PAGE_OFFSET - UL(0x40000000000) - SZ_64K)
+#endif
 
 #define vmemmap			((struct page *)(VMALLOC_END + SZ_64K))
 
@@ -44,12 +48,16 @@
 #ifndef __ASSEMBLY__
 extern void __pte_error(const char *file, int line, unsigned long val);
 extern void __pmd_error(const char *file, int line, unsigned long val);
+extern void __pud_error(const char *file, int line, unsigned long val);
 extern void __pgd_error(const char *file, int line, unsigned long val);
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
 #ifndef CONFIG_ARM64_2_LEVELS
 #define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
 #endif
+#ifdef CONFIG_ARM64_4_LEVELS
+#define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
+#endif
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
 
 #ifdef CONFIG_SMP
@@ -347,6 +355,30 @@ static inline pmd_t *pud_page_vaddr(pud_t pud)
 
 #endif	/* CONFIG_ARM64_2_LEVELS */
 
+#ifdef CONFIG_ARM64_4_LEVELS
+
+#define pgd_none(pgd)		(!pgd_val(pgd))
+#define pgd_bad(pgd)		(!(pgd_val(pgd) & 2))
+#define pgd_present(pgd)	(pgd_val(pgd))
+
+static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
+{
+	*pgdp = pgd;
+	dsb(ishst);
+}
+
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	set_pgd(pgdp, __pgd(0));
+}
+
+static inline pud_t *pgd_page_vaddr(pgd_t pgd)
+{
+	return __va(pgd_val(pgd) & PHYS_MASK & (s32)PAGE_MASK);
+}
+
+#endif  /* CONFIG_ARM64_4_LEVELS */
+
 /* to find an entry in a page-table-directory */
 #define pgd_index(addr)		(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 
@@ -355,6 +387,14 @@ static inline pmd_t *pud_page_vaddr(pud_t pud)
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
+#ifdef CONFIG_ARM64_4_LEVELS
+#define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+static inline pud_t *pud_offset(pgd_t *pgd, unsigned long addr)
+{
+	return (pud_t *)pgd_page_vaddr(*pgd) + pud_index(addr);
+}
+#endif
+
 /* Find an entry in the second-level page table.. */
 #ifndef CONFIG_ARM64_2_LEVELS
 #define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index bc19101edaeb..49dc8f03362f 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -100,6 +100,15 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 }
 #endif
 
+#ifdef CONFIG_ARM64_4_LEVELS
+static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
+				  unsigned long addr)
+{
+	tlb_add_flush(tlb, addr);
+	tlb_remove_page(tlb, virt_to_page(pudp));
+}
+#endif
+
 static inline void __tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, pmd_t *pmdp,
 						unsigned long address)
 {
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index fa3b7fb8a77a..847b99daad79 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -476,16 +476,42 @@ ENDPROC(__calc_phys_offset)
 	.quad	PAGE_OFFSET
 
 /*
- * Macro to populate the PGD for the corresponding block entry in the next
- * level (tbl) for the given virtual address.
+ * Macro to populate the PUD for the corresponding block entry in the next
+ * level (tbl) for the given virtual address in case of 4 levels.
  *
- * Preserves:	pgd, tbl, virt
- * Corrupts:	tmp1, tmp2
+ * Preserves:	pgd, virt
+ * Corrupts:	tbl, tmp1, tmp2
+ * Returns:	pud
  */
-	.macro	create_pgd_entry, pgd, tbl, virt, tmp1, tmp2
+	.macro	create_pud_entry, pgd, tbl, virt, pud, tmp1, tmp2
+#ifdef CONFIG_ARM64_4_LEVELS
+	add	\tbl, \tbl, #PAGE_SIZE		// bump tbl 1 page up.
+						// to make room for pud
+	add	\pud, \pgd, #PAGE_SIZE		// pgd points to pud which
+						// follows pgd
+	lsr	\tmp1, \virt, #PUD_SHIFT
+	and	\tmp1, \tmp1, #PTRS_PER_PUD - 1	// PUD index
+	orr	\tmp2, \tbl, #3			// PUD entry table type
+	str	\tmp2, [\pud, \tmp1, lsl #3]
+#else
+	mov	\pud, \tbl
+#endif
+	.endm
+
+/*
+ * Macro to populate the PGD (and possibily PUD) for the corresponding
+ * block entry in the next level (tbl) for the given virtual address.
+ *
+ * Preserves:	pgd, virt
+ * Corrupts:	tmp1, tmp2, tmp3
+ * Returns:	tbl -> page where block mappings can be placed
+ *	(changed to make room for pud with 4 levels, preserved otherwise)
+ */
+	.macro	create_pgd_entry, pgd, tbl, virt, tmp1, tmp2, tmp3
+	create_pud_entry \pgd, \tbl, \virt, \tmp3, \tmp1, \tmp2
 	lsr	\tmp1, \virt, #PGDIR_SHIFT
 	and	\tmp1, \tmp1, #PTRS_PER_PGD - 1	// PGD index
-	orr	\tmp2, \tbl, #3			// PGD entry table type
+	orr	\tmp2, \tmp3, #3		// PGD entry table type
 	str	\tmp2, [\pgd, \tmp1, lsl #3]
 	.endm
 
@@ -550,7 +576,7 @@ __create_page_tables:
 	add	x0, x25, #PAGE_SIZE		// section table address
 	ldr	x3, =KERNEL_START
 	add	x3, x3, x28			// __pa(KERNEL_START)
-	create_pgd_entry x25, x0, x3, x5, x6
+	create_pgd_entry x25, x0, x3, x1, x5, x6
 	ldr	x6, =KERNEL_END
 	mov	x5, x3				// __pa(KERNEL_START)
 	add	x6, x6, x28			// __pa(KERNEL_END)
@@ -561,7 +587,7 @@ __create_page_tables:
 	 */
 	add	x0, x26, #PAGE_SIZE		// section table address
 	mov	x5, #PAGE_OFFSET
-	create_pgd_entry x26, x0, x5, x3, x6
+	create_pgd_entry x26, x0, x5, x1, x3, x6
 	ldr	x6, =KERNEL_END
 	mov	x3, x24				// phys offset
 	create_block_map x0, x7, x3, x5, x6
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 506f7814e305..02cd3f023e9a 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -339,6 +339,11 @@ void __pmd_error(const char *file, int line, unsigned long val)
 	pr_crit("%s:%d: bad pmd %016lx.\n", file, line, val);
 }
 
+void __pud_error(const char *file, int line, unsigned long val)
+{
+	pr_crit("%s:%d: bad pud %016lx.\n", file, line, val);
+}
+
 void __pgd_error(const char *file, int line, unsigned long val)
 {
 	pr_crit("%s:%d: bad pgd %016lx.\n", file, line, val);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index bcc965e2cce1..41cb6d3d6075 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -62,6 +62,7 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 			break;
 
 		pud = pud_offset(pgd, addr);
+		printk(", *pud=%016llx", pud_val(*pud));
 		if (pud_none(*pud) || pud_bad(*pud))
 			break;
 
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 69000efa015e..fa324bd5a5c4 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -104,9 +104,12 @@ void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
 EXPORT_SYMBOL(ioremap_cache);
 
 static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
-#ifndef CONFIG_ARM64_64K_PAGES
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
 static pte_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #endif
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
+static pte_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
+#endif
 
 static inline pud_t * __init early_ioremap_pud(unsigned long addr)
 {
@@ -144,6 +147,7 @@ void __init early_ioremap_init(void)
 	unsigned long addr = fix_to_virt(FIX_BTMAP_BEGIN);
 
 	pgd = pgd_offset_k(addr);
+	pgd_populate(&init_mm, pgd, bm_pud);
 	pud = pud_offset(pgd, addr);
 	pud_populate(&init_mm, pud, bm_pmd);
 	pmd = pmd_offset(pud, addr);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c43f1dd19489..c55567283cde 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -32,6 +32,7 @@
 #include <asm/setup.h>
 #include <asm/sizes.h>
 #include <asm/tlb.h>
+#include <asm/memblock.h>
 #include <asm/mmu_context.h>
 
 #include "mm.h"
@@ -204,9 +205,16 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
 				  unsigned long end, unsigned long phys,
 				  int map_io)
 {
-	pud_t *pud = pud_offset(pgd, addr);
+	pud_t *pud;
 	unsigned long next;
 
+	if (pgd_none(*pgd)) {
+		pud = early_alloc(PTRS_PER_PUD * sizeof(pud_t));
+		pgd_populate(&init_mm, pgd, pud);
+	}
+	BUG_ON(pgd_bad(*pgd));
+
+	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
 
@@ -290,10 +298,10 @@ static void __init map_mem(void)
 	 * memory addressable from the initial direct kernel mapping.
 	 *
 	 * The initial direct kernel mapping, located at swapper_pg_dir,
-	 * gives us PGDIR_SIZE memory starting from PHYS_OFFSET (which must be
+	 * gives us PUD_SIZE memory starting from PHYS_OFFSET (which must be
 	 * aligned to 2MB as per Documentation/arm64/booting.txt).
 	 */
-	limit = PHYS_OFFSET + PGDIR_SIZE;
+	limit = PHYS_OFFSET + PUD_SIZE;
 	memblock_set_current_limit(limit);
 
 	/* map all the memory banks */
