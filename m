From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Jul 2014 20:09:49 +0100
Subject: [PATCH v7 08/11] arm64: Convert bool ARM64_x_LEVELS to int
 ARM64_PGTABLE_LEVELS
In-Reply-To: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
References: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1405537792-23666-9-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than having several Kconfig options, define int
ARM64_PGTABLE_LEVELS which will be also useful in converting some of the
pgtable macros.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                     | 13 +++++--------
 arch/arm64/include/asm/page.h          |  6 +++---
 arch/arm64/include/asm/pgalloc.h       |  8 ++++----
 arch/arm64/include/asm/pgtable-hwdef.h |  4 ++--
 arch/arm64/include/asm/pgtable.h       | 18 +++++++++---------
 arch/arm64/include/asm/tlb.h           |  4 ++--
 arch/arm64/kernel/head.S               |  2 +-
 7 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 24cbe72c0da9..9fe62025776b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -209,14 +209,11 @@ config ARM64_VA_BITS
 	default 42 if ARM64_VA_BITS_42
 	default 48 if ARM64_VA_BITS_48
 
-config ARM64_2_LEVELS
-	def_bool y if ARM64_64K_PAGES && ARM64_VA_BITS_42
-
-config ARM64_3_LEVELS
-	def_bool y if ARM64_4K_PAGES && ARM64_VA_BITS_39
-
-config ARM64_4_LEVELS
-	def_bool y if ARM64_4K_PAGES && ARM64_VA_BITS_48
+config ARM64_PGTABLE_LEVELS
+	int
+	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
+	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
+	default 4 if ARM64_4K_PAGES && ARM64_VA_BITS_48
 
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index cf9afa0366b6..a998ff478777 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -37,7 +37,7 @@
  * map the kernel. The swapper also maps the FDT (see __create_page_tables for
  * more information).
  */
-#ifdef CONFIG_ARM64_4_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS == 4
 #define SWAPPER_DIR_SIZE	(3 * PAGE_SIZE)
 #define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
 #else
@@ -47,9 +47,9 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_ARM64_2_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS == 2
 #include <asm/pgtable-2level-types.h>
-#elif defined(CONFIG_ARM64_3_LEVELS)
+#elif CONFIG_ARM64_PGTABLE_LEVELS == 3
 #include <asm/pgtable-3level-types.h>
 #else
 #include <asm/pgtable-4level-types.h>
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 8d745fae4c2d..ffef62debe82 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -26,7 +26,7 @@
 
 #define check_pgt_cache()		do { } while (0)
 
-#ifdef CONFIG_ARM64_4_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
@@ -44,9 +44,9 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 	set_pgd(pgd, __pgd(__pa(pud) | PUD_TYPE_TABLE));
 }
 
-#endif  /* CONFIG_ARM64_4_LEVELS */
+#endif  /* CONFIG_ARM64_PGTABLE_LEVELS > 3 */
 
-#ifndef CONFIG_ARM64_2_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
@@ -64,7 +64,7 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 	set_pud(pud, __pud(__pa(pmd) | PMD_TYPE_TABLE));
 }
 
-#endif	/* CONFIG_ARM64_2_LEVELS */
+#endif	/* CONFIG_ARM64_PGTABLE_LEVELS > 2 */
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index fddcc3efa569..d453e8bfef06 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -16,9 +16,9 @@
 #ifndef __ASM_PGTABLE_HWDEF_H
 #define __ASM_PGTABLE_HWDEF_H
 
-#ifdef CONFIG_ARM64_2_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS == 2
 #include <asm/pgtable-2level-hwdef.h>
-#elif defined(CONFIG_ARM64_3_LEVELS)
+#elif CONFIG_ARM64_PGTABLE_LEVELS == 3
 #include <asm/pgtable-3level-hwdef.h>
 #else
 #include <asm/pgtable-4level-hwdef.h>
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d9b23efdaded..9f862e6e9286 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -35,7 +35,7 @@
  * VMALLOC and SPARSEMEM_VMEMMAP ranges.
  */
 #define VMALLOC_START		(UL(0xffffffffffffffff) << VA_BITS)
-#ifndef CONFIG_ARM64_4_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS != 4
 #define VMALLOC_END		(PAGE_OFFSET - UL(0x400000000) - SZ_64K)
 #else
 #define VMALLOC_END		(PAGE_OFFSET - UL(0x40000000000) - SZ_64K)
@@ -52,10 +52,10 @@ extern void __pud_error(const char *file, int line, unsigned long val);
 extern void __pgd_error(const char *file, int line, unsigned long val);
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
-#ifndef CONFIG_ARM64_2_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
 #define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
 #endif
-#ifdef CONFIG_ARM64_4_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
 #define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
 #endif
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
@@ -331,7 +331,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
  */
 #define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
 
-#ifndef CONFIG_ARM64_2_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
 
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & 2))
@@ -353,9 +353,9 @@ static inline pmd_t *pud_page_vaddr(pud_t pud)
 	return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
 }
 
-#endif	/* CONFIG_ARM64_2_LEVELS */
+#endif	/* CONFIG_ARM64_PGTABLE_LEVELS > 2 */
 
-#ifdef CONFIG_ARM64_4_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
 
 #define pgd_none(pgd)		(!pgd_val(pgd))
 #define pgd_bad(pgd)		(!(pgd_val(pgd) & 2))
@@ -377,7 +377,7 @@ static inline pud_t *pgd_page_vaddr(pgd_t pgd)
 	return __va(pgd_val(pgd) & PHYS_MASK & (s32)PAGE_MASK);
 }
 
-#endif  /* CONFIG_ARM64_4_LEVELS */
+#endif  /* CONFIG_ARM64_PGTABLE_LEVELS > 3 */
 
 /* to find an entry in a page-table-directory */
 #define pgd_index(addr)		(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
@@ -387,7 +387,7 @@ static inline pud_t *pgd_page_vaddr(pgd_t pgd)
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
-#ifdef CONFIG_ARM64_4_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
 #define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
 static inline pud_t *pud_offset(pgd_t *pgd, unsigned long addr)
 {
@@ -396,7 +396,7 @@ static inline pud_t *pud_offset(pgd_t *pgd, unsigned long addr)
 #endif
 
 /* Find an entry in the second-level page table.. */
-#ifndef CONFIG_ARM64_2_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
 #define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 49dc8f03362f..62731ef9749a 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -91,7 +91,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	tlb_remove_page(tlb, pte);
 }
 
-#ifndef CONFIG_ARM64_2_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
@@ -100,7 +100,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 }
 #endif
 
-#ifdef CONFIG_ARM64_4_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 847b99daad79..019f81d9f1d5 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -484,7 +484,7 @@ ENDPROC(__calc_phys_offset)
  * Returns:	pud
  */
 	.macro	create_pud_entry, pgd, tbl, virt, pud, tmp1, tmp2
-#ifdef CONFIG_ARM64_4_LEVELS
+#if CONFIG_ARM64_PGTABLE_LEVELS == 4
 	add	\tbl, \tbl, #PAGE_SIZE		// bump tbl 1 page up.
 						// to make room for pud
 	add	\pud, \pgd, #PAGE_SIZE		// pgd points to pud which
