From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Wed, 27 Nov 2013 13:04:25 +0530
Subject: [RFC PATCH 2/2] arm64: Add 48-bit PA support for 64KB page size
In-Reply-To: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
Message-ID: <1385537665-5909-3-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

Extend the 48-bit physical address support to 64KB page size. The
VA_BITS will be 48 and 3 levels of page tables are used for address
translations.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
---
 arch/arm64/include/asm/page.h                 |    2 +-
 arch/arm64/include/asm/pgalloc.h              |    4 +-
 arch/arm64/include/asm/pgtable-3level-hwdef.h |   34 +++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |    2 +-
 arch/arm64/include/asm/pgtable.h              |   29 +++++++++++---------
 arch/arm64/include/asm/tlb.h                  |    2 -
 arch/arm64/kernel/head.S                      |   24 +++++++++++++++++
 arch/arm64/kernel/traps.c                     |    2 +
 8 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 64faf71..82fd5ab 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -34,7 +34,7 @@
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_ARM64_64K_PAGES
-#include <asm/pgtable-2level-types.h>
+#include <asm/pgtable-3level-types.h>
 #else
 #include <asm/pgtable-4level-types.h>
 #endif
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 482816c..b287c32 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -26,8 +26,6 @@
 
 #define check_pgt_cache()		do { } while (0)
 
-#ifndef CONFIG_ARM64_64K_PAGES
-
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	return (pmd_t *)get_zeroed_page(GFP_KERNEL | __GFP_REPEAT);
@@ -44,6 +42,8 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 	set_pud(pud, __pud(__pa(pmd) | PMD_TYPE_TABLE));
 }
 
+#ifndef CONFIG_ARM64_64K_PAGES
+
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	return (pud_t *)get_zeroed_page(GFP_KERNEL | __GFP_REPEAT);
diff --git a/arch/arm64/include/asm/pgtable-3level-hwdef.h b/arch/arm64/include/asm/pgtable-3level-hwdef.h
index 3dbf941..fb9c1da 100644
--- a/arch/arm64/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-3level-hwdef.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_PGTABLE_3LEVEL_HWDEF_H
 #define __ASM_PGTABLE_3LEVEL_HWDEF_H
 
+#ifndef CONFIG_ARM64_64K_PAGES
 /*
  * With LPAE and 4KB pages, there are 3 levels of page tables. Each level has
  * 512 entries of 8 bytes each, occupying a 4K page. The first level table
@@ -47,4 +48,37 @@
 #define SECTION_SIZE		(_AC(1, UL) << SECTION_SHIFT)
 #define SECTION_MASK		(~(SECTION_SIZE-1))
 
+#else /* !CONFIG_ARM64_64K_PAGES */
+
+/*
+ * With 64KB pages, there are 3 levels of page tables. Each level has
+ * entries of 8 bytes each, occupying a 64K page. The first level table
+ * has 64 entries and rest of them have 8192 entries.
+ */
+#define PTRS_PER_PTE		8192
+#define PTRS_PER_PMD		8192
+#define PTRS_PER_PGD		64
+
+/*
+ * PGDIR_SHIFT determines the size a top-level page table entry can map.
+ */
+#define PGDIR_SHIFT		42
+#define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_MASK		(~(PGDIR_SIZE-1))
+
+/*
+ * PMD_SHIFT determines the size a middle-level page table entry can map.
+ */
+#define PMD_SHIFT		29
+#define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
+#define PMD_MASK		(~(PMD_SIZE-1))
+
+/*
+ * section address mask and size definitions.
+ */
+#define SECTION_SHIFT		29
+#define SECTION_SIZE		(_AC(1, UL) << SECTION_SHIFT)
+#define SECTION_MASK		(~(SECTION_SIZE-1))
+
+#endif /* CONFIG_ARM64_64K_PAGES */
 #endif
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 05fadaf..d552814 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -17,7 +17,7 @@
 #define __ASM_PGTABLE_HWDEF_H
 
 #ifdef CONFIG_ARM64_64K_PAGES
-#include <asm/pgtable-2level-hwdef.h>
+#include <asm/pgtable-3level-hwdef.h>
 #else
 #include <asm/pgtable-4level-hwdef.h>
 #endif
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 57efd3d..8feb6c7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -47,10 +47,10 @@ extern void __pud_error(const char *file, int line, unsigned long val);
 extern void __pgd_error(const char *file, int line, unsigned long val);
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
-#ifndef CONFIG_ARM64_64K_PAGES
 #define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
-#endif
+#ifndef CONFIG_ARM64_64K_PAGES
 #define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
+#endif
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
 
 /*
@@ -299,8 +299,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
  */
 #define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
 
-#ifndef CONFIG_ARM64_64K_PAGES
-
 /* Find an entry in the kernel page upper directory */
 #define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
 
@@ -324,8 +322,6 @@ static inline pmd_t *pud_page_vaddr(pud_t pud)
 	return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
 }
 
-#endif	/* CONFIG_ARM64_64K_PAGES */
-
 /* to find an entry in a page-table-directory */
 #define pgd_index(addr)		(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 
@@ -338,11 +334,8 @@ static inline pmd_t *pud_page_vaddr(pud_t pud)
 #define pgd_present(pgd)	(pgd_val(pgd))
 #define pgd_bad(pgd)		(!(pgd_val(pgd) & 2))
 
-/* Find an entry in the second-level page table.. */
 #ifndef CONFIG_ARM64_64K_PAGES
 
-#define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
-
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	*pgdp = pgd;
@@ -359,16 +352,26 @@ static inline pud_t *pgd_page_vaddr(pgd_t pgd)
 	return __va(pgd_val(pgd) & PHYS_MASK & (s32)PAGE_MASK);
 }
 
+static inline pud_t *pud_offset(pud_t *pud, unsigned long addr)
+{
+	return (pud_t *)pgd_page_vaddr(*pud) + pud_index(addr);
+}
+
+#endif
+
+/* Find an entry in the second-level page table.. */
+#define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+
+#ifndef CONFIG_ARM64_64K_PAGES
 static inline pmd_t *pmd_offset(pmd_t *pmd, unsigned long addr)
 {
 	return (pmd_t *)pud_page_vaddr(*pmd) + pmd_index(addr);
 }
-
-static inline pud_t *pud_offset(pud_t *pud, unsigned long addr)
+#else
+static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 {
-	return (pud_t *)pgd_page_vaddr(*pud) + pud_index(addr);
+	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(addr);
 }
-
 #endif
 
 /* Find an entry in the third-level page table.. */
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 717031a..61a265f 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -175,14 +175,12 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	tlb_remove_page(tlb, pte);
 }
 
-#ifndef CONFIG_ARM64_64K_PAGES
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
 	tlb_add_flush(tlb, addr);
 	tlb_remove_page(tlb, virt_to_page(pmdp));
 }
-#endif
 
 #define pte_free_tlb(tlb, ptep, addr)	__pte_free_tlb(tlb, ptep, addr)
 #define pmd_free_tlb(tlb, pmdp, addr)	__pmd_free_tlb(tlb, pmdp, addr)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cc764e5..2c67b79 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -45,7 +45,11 @@
 #error KERNEL_RAM_VADDR must start at 0xXXX80000
 #endif
 
+#ifdef CONFIG_ARM64_64K_PAGES
+#define create_page_entry	create_pmd_entry
+#else
 #define create_page_entry	create_pud_entry
+#endif
 
 #define SWAPPER_DIR_SIZE	(4 * PAGE_SIZE)
 #define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
@@ -391,6 +395,22 @@ ENDPROC(__calc_phys_offset)
 	str	\tmp2, [\pud, \tmp1, lsl #3]
 .endm
 
+#ifdef CONFIG_ARM64_64K_PAGES
+/*
+ * Macro to populate the PMD for the corresponding block entry in the next
+ * level (tbl) for the given virtual address.
+ *
+ * Preserves:   pmd, tbl, virt
+ * Corrupts:    tmp1, tmp2
+ */
+	.macro	create_pmd_entry, pud, tbl, virt, tmp1, tmp2
+	lsr	\tmp1, \virt, #PMD_SHIFT
+	and	\tmp1, \tmp1, #PTRS_PER_PMD - 1 // PMD index
+	orr	\tmp2, \tbl, #3                 // PMD entry table type
+	str	\tmp2, [\pud, \tmp1, lsl #3]
+	.endm
+#endif
+
 /*
  * Macro to populate block entries in the page table for the start..end
  * virtual range (inclusive).
@@ -489,7 +509,11 @@ __create_page_tables:
 	 * later based earlyprintk kernel parameter.
 	 */
 	ldr	x5, =EARLYCON_IOBASE		// UART virtual address
+#ifndef CONFIG_ARM64_64K_PAGES
 	add	x0, x26, #PAGE_SIZE		// section table address
+#else
+	add	x0, x26, #2 * PAGE_SIZE		// section table address
+#endif
 	create_pgd_entry x26, x0, x5, x6, x7
 	add	x1, x0, #2 * PAGE_SIZE
 	create_page_entry x0, x1, x5, x6, x7
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4565aa0..ea63941 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -336,10 +336,12 @@ void __pmd_error(const char *file, int line, unsigned long val)
 	printk("%s:%d: bad pmd %016lx.\n", file, line, val);
 }
 
+#ifndef CONFIG_ARM64_64K_PAGES
 void __pud_error(const char *file, int line, unsigned long val)
 {
 	printk("%s:%d: bad pud %016lx.\n", file, line, val);
 }
+#endif
 
 void __pgd_error(const char *file, int line, unsigned long val)
 {
-- 
1.7.1
