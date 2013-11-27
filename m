From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Wed, 27 Nov 2013 13:04:24 +0530
Subject: [RFC PATCH 1/2] arm64: Add 48-bit PA support for 4KB page size
In-Reply-To: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
Message-ID: <1385537665-5909-2-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds support for 48-bit physical addresses in the ARMv8 based
SoCs. The VA_BITS is expanded to 48 enabling access to 128TB of kernel
space. The Linux will now be using 4 levels of page tables for address
translations for 4KB page size.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
---
 arch/arm64/include/asm/memory.h               |    6 +--
 arch/arm64/include/asm/page.h                 |    2 +-
 arch/arm64/include/asm/pgalloc.h              |   16 ++++++
 arch/arm64/include/asm/pgtable-4level-hwdef.h |   57 ++++++++++++++++++++
 arch/arm64/include/asm/pgtable-4level-types.h |   71 +++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |    7 ++-
 arch/arm64/include/asm/pgtable.h              |   41 +++++++++++++--
 arch/arm64/kernel/head.S                      |   33 +++++++++--
 arch/arm64/kernel/traps.c                     |    5 ++
 arch/arm64/mm/proc.S                          |    2 +-
 10 files changed, 220 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 3776217..91e92b4 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -41,11 +41,7 @@
  * The module space lives between the addresses given by TASK_SIZE
  * and PAGE_OFFSET - it must be within 128MB of the kernel text.
  */
-#ifdef CONFIG_ARM64_64K_PAGES
-#define VA_BITS			(42)
-#else
-#define VA_BITS			(39)
-#endif
+#define VA_BITS			(48)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
 #define MODULES_END		(PAGE_OFFSET)
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 46bf666..64faf71 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -36,7 +36,7 @@
 #ifdef CONFIG_ARM64_64K_PAGES
 #include <asm/pgtable-2level-types.h>
 #else
-#include <asm/pgtable-3level-types.h>
+#include <asm/pgtable-4level-types.h>
 #endif
 
 extern void __cpu_clear_user_page(void *p, unsigned long user);
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 9bea6e7..482816c 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -44,6 +44,22 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 	set_pud(pud, __pud(__pa(pmd) | PMD_TYPE_TABLE));
 }
 
+static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return (pud_t *)get_zeroed_page(GFP_KERNEL | __GFP_REPEAT);
+}
+
+static inline void pud_free(struct mm_struct *mm, pmd_t *pud)
+{
+	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
+	free_page((unsigned long)pud);
+}
+
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pud)
+{
+	set_pgd(pgd, __pgd(__pa(pud) | PMD_TYPE_TABLE));
+}
+
 #endif	/* CONFIG_ARM64_64K_PAGES */
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
diff --git a/arch/arm64/include/asm/pgtable-4level-hwdef.h b/arch/arm64/include/asm/pgtable-4level-hwdef.h
new file mode 100644
index 0000000..9d1e4d1
--- /dev/null
+++ b/arch/arm64/include/asm/pgtable-4level-hwdef.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2013 Cavium Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_PGTABLE_3LEVEL_HWDEF_H
+#define __ASM_PGTABLE_3LEVEL_HWDEF_H
+
+/*
+ * With 48-bit addressing and 4KB pages, there are 4 levels of page tables. 
+ * Each level has 512 entries of 8 bytes each, occupying a 4K page. The user
+ * and kernel address spaces are limited to 128TB each.
+ */
+#define PTRS_PER_PTE		512
+#define PTRS_PER_PMD		512
+#define PTRS_PER_PUD		512
+#define PTRS_PER_PGD		512
+
+/*
+ * PGDIR_SHIFT determines the size a top-level page table entry can map.
+ */
+#define PGDIR_SHIFT		39
+#define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_MASK		(~(PGDIR_SIZE-1))
+
+/*
+ * PUD_SHIFT determines the size a upper-level page table entry can map.
+ */
+#define PUD_SHIFT		30
+#define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
+#define PUD_MASK		(~(PUD_SIZE-1))
+
+/*
+ * PMD_SHIFT determines the size a middle-level page table entry can map.
+ */
+#define PMD_SHIFT		21
+#define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
+#define PMD_MASK		(~(PMD_SIZE-1))
+
+/*
+ * section address mask and size definitions.
+ */
+#define SECTION_SHIFT		21
+#define SECTION_SIZE		(_AC(1, UL) << SECTION_SHIFT)
+#define SECTION_MASK		(~(SECTION_SIZE-1))
+
+#endif
diff --git a/arch/arm64/include/asm/pgtable-4level-types.h b/arch/arm64/include/asm/pgtable-4level-types.h
new file mode 100644
index 0000000..f57f285
--- /dev/null
+++ b/arch/arm64/include/asm/pgtable-4level-types.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2013 Cavium Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_PGTABLE_4LEVEL_TYPES_H
+#define __ASM_PGTABLE_4LEVEL_TYPES_H
+
+typedef u64 pteval_t;
+typedef u64 pmdval_t;
+typedef u64 pudval_t;
+typedef u64 pgdval_t;
+
+#undef STRICT_MM_TYPECHECKS
+
+#ifdef STRICT_MM_TYPECHECKS
+
+/*
+ * These are used to make use of C type-checking..
+ */
+typedef struct { pteval_t pte; } pte_t;
+typedef struct { pmdval_t pmd; } pmd_t;
+typedef struct { pudval_t pud; } pud_t;
+typedef struct { pgdval_t pgd; } pgd_t;
+typedef struct { pteval_t pgprot; } pgprot_t;
+
+#define pte_val(x)      ((x).pte)
+#define pmd_val(x)      ((x).pmd)
+#define pud_val(x)      ((x).pud)
+#define pgd_val(x)	((x).pgd)
+#define pgprot_val(x)   ((x).pgprot)
+
+#define __pte(x)        ((pte_t) { (x) })
+#define __pmd(x)        ((pmd_t) { (x) })
+#define __pud(x)        ((pud_t) { (x) })
+#define __pgd(x)	((pgd_t) { (x) })
+#define __pgprot(x)     ((pgprot_t) { (x) })
+
+#else	/* !STRICT_MM_TYPECHECKS */
+
+typedef pteval_t pte_t;
+typedef pmdval_t pmd_t;
+typedef pudval_t pud_t;
+typedef pgdval_t pgd_t;
+typedef pteval_t pgprot_t;
+
+#define pte_val(x)	(x)
+#define pmd_val(x)	(x)
+#define pud_val(x)	(x)
+#define pgd_val(x)	(x)
+#define pgprot_val(x)	(x)
+
+#define __pte(x)	(x)
+#define __pmd(x)	(x)
+#define __pud(x)	(x)
+#define __pgd(x)	(x)
+#define __pgprot(x)	(x)
+
+#endif	/* STRICT_MM_TYPECHECKS */
+
+#endif	/* __ASM_PGTABLE_4LEVEL_TYPES_H */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 755f861..05fadaf 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -19,7 +19,7 @@
 #ifdef CONFIG_ARM64_64K_PAGES
 #include <asm/pgtable-2level-hwdef.h>
 #else
-#include <asm/pgtable-3level-hwdef.h>
+#include <asm/pgtable-4level-hwdef.h>
 #endif
 
 /*
@@ -100,9 +100,9 @@
 #define PTE_HYP			PTE_USER
 
 /*
- * 40-bit physical address supported.
+ * 48-bit physical address supported.
  */
-#define PHYS_MASK_SHIFT		(40)
+#define PHYS_MASK_SHIFT		(48)
 #define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
 
 /*
@@ -123,6 +123,7 @@
 #define TCR_TG0_64K		(UL(1) << 14)
 #define TCR_TG1_64K		(UL(1) << 30)
 #define TCR_IPS_40BIT		(UL(2) << 32)
+#define TCR_IPS_48BIT		(UL(5) << 32)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 17bd3af..57efd3d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -43,12 +43,14 @@
 #ifndef __ASSEMBLY__
 extern void __pte_error(const char *file, int line, unsigned long val);
 extern void __pmd_error(const char *file, int line, unsigned long val);
+extern void __pud_error(const char *file, int line, unsigned long val);
 extern void __pgd_error(const char *file, int line, unsigned long val);
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
 #ifndef CONFIG_ARM64_64K_PAGES
 #define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
 #endif
+#define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
 
 /*
@@ -299,6 +301,9 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 #ifndef CONFIG_ARM64_64K_PAGES
 
+/* Find an entry in the kernel page upper directory */
+#define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & 2))
 #define pud_present(pud)	(pud_val(pud))
@@ -329,13 +334,41 @@ static inline pmd_t *pud_page_vaddr(pud_t pud)
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
+#define pgd_none(pgd)		(!pgd_val(pgd))
+#define pgd_present(pgd)	(pgd_val(pgd))
+#define pgd_bad(pgd)		(!(pgd_val(pgd) & 2))
+
 /* Find an entry in the second-level page table.. */
 #ifndef CONFIG_ARM64_64K_PAGES
+
 #define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
-static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
+
+static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
+{
+	*pgdp = pgd;
+	dsb();
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
+static inline pmd_t *pmd_offset(pmd_t *pmd, unsigned long addr)
 {
-	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(addr);
+	return (pmd_t *)pud_page_vaddr(*pmd) + pmd_index(addr);
 }
+
+static inline pud_t *pud_offset(pud_t *pud, unsigned long addr)
+{
+	return (pud_t *)pgd_page_vaddr(*pud) + pud_index(addr);
+}
+
 #endif
 
 /* Find an entry in the third-level page table.. */
@@ -352,8 +385,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 
-#define SWAPPER_DIR_SIZE	(3 * PAGE_SIZE)
-#define IDMAP_DIR_SIZE		(2 * PAGE_SIZE)
+#define SWAPPER_DIR_SIZE	(4 * PAGE_SIZE)
+#define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
 
 /*
  * Encode and decode a swap entry:
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7009387..cc764e5 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -45,8 +45,10 @@
 #error KERNEL_RAM_VADDR must start at 0xXXX80000
 #endif
 
-#define SWAPPER_DIR_SIZE	(3 * PAGE_SIZE)
-#define IDMAP_DIR_SIZE		(2 * PAGE_SIZE)
+#define create_page_entry	create_pud_entry
+
+#define SWAPPER_DIR_SIZE	(4 * PAGE_SIZE)
+#define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
 
 	.globl	swapper_pg_dir
 	.equ	swapper_pg_dir, KERNEL_RAM_VADDR - SWAPPER_DIR_SIZE
@@ -376,6 +378,19 @@ ENDPROC(__calc_phys_offset)
 	str	\tmp2, [\pgd, \tmp1, lsl #3]
 	.endm
 
+/* Macro to populate the PUD for the corresponding block entry in the next
+ * level (tbl) for the given virtual address.
+ *
+ * Preserves:  pud, tbl, virt
+ * Corrupts:   tmp1, tmp2
+ */
+	.macro	create_pud_entry, pud, tbl, virt, tmp1, tmp2
+	lsr	\tmp1, \virt, #PUD_SHIFT
+	and	\tmp1, \tmp1, #PTRS_PER_PUD - 1 // PUD index
+	orr	\tmp2, \tbl, #3                 // PUD entry table type
+	str	\tmp2, [\pud, \tmp1, lsl #3]
+.endm
+
 /*
  * Macro to populate block entries in the page table for the start..end
  * virtual range (inclusive).
@@ -436,7 +451,9 @@ __create_page_tables:
 	add	x0, x25, #PAGE_SIZE		// section table address
 	adr	x3, __turn_mmu_on		// virtual/physical address
 	create_pgd_entry x25, x0, x3, x5, x6
-	create_block_map x0, x7, x3, x5, x5, idmap=1
+	add	x1, x0, #PAGE_SIZE
+	create_page_entry x0, x1, x3, x5, x6
+	create_block_map x1, x7, x3, x5, x5, idmap=1
 
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
@@ -444,9 +461,11 @@ __create_page_tables:
 	add	x0, x26, #PAGE_SIZE		// section table address
 	mov	x5, #PAGE_OFFSET
 	create_pgd_entry x26, x0, x5, x3, x6
+	add	x1, x0, #PAGE_SIZE
+	create_page_entry x0, x1, x3, x5, x6
 	ldr	x6, =KERNEL_END - 1
 	mov	x3, x24				// phys offset
-	create_block_map x0, x7, x3, x5, x6
+	create_block_map x1, x7, x3, x5, x6
 
 	/*
 	 * Map the FDT blob (maximum 2MB; must be within 512MB of
@@ -462,7 +481,7 @@ __create_page_tables:
 	add	x5, x5, x6			// __va(FDT blob)
 	add	x6, x5, #1 << 21		// 2MB for the FDT blob
 	sub	x6, x6, #1			// inclusive range
-	create_block_map x0, x7, x3, x5, x6
+	create_block_map x1, x7, x3, x5, x6
 1:
 #ifdef CONFIG_EARLY_PRINTK
 	/*
@@ -470,8 +489,10 @@ __create_page_tables:
 	 * later based earlyprintk kernel parameter.
 	 */
 	ldr	x5, =EARLYCON_IOBASE		// UART virtual address
-	add	x0, x26, #2 * PAGE_SIZE		// section table address
+	add	x0, x26, #PAGE_SIZE		// section table address
 	create_pgd_entry x26, x0, x5, x6, x7
+	add	x1, x0, #2 * PAGE_SIZE
+	create_page_entry x0, x1, x5, x6, x7
 #endif
 	ret
 ENDPROC(__create_page_tables)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7ffaddd..4565aa0 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -336,6 +336,11 @@ void __pmd_error(const char *file, int line, unsigned long val)
 	printk("%s:%d: bad pmd %016lx.\n", file, line, val);
 }
 
+void __pud_error(const char *file, int line, unsigned long val)
+{
+	printk("%s:%d: bad pud %016lx.\n", file, line, val);
+}
+
 void __pgd_error(const char *file, int line, unsigned long val)
 {
 	printk("%s:%d: bad pgd %016lx.\n", file, line, val);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 421b99f..2e0041e 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -146,7 +146,7 @@ ENTRY(__cpu_setup)
 	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
 	 * both user and kernel.
 	 */
-	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_FLAGS | TCR_IPS_40BIT | \
+	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_FLAGS | TCR_IPS_48BIT | \
 		      TCR_ASID16 | TCR_TBI0 | (1 << 31)
 #ifdef CONFIG_ARM64_64K_PAGES
 	orr	x10, x10, TCR_TG0_64K
-- 
1.7.1
