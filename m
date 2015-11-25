From: zhongjiang@huawei.com (zhongjiang)
Date: Wed, 25 Nov 2015 21:41:12 +0800
Subject: [PATCH] arm64: calculate the various pages number to show
Message-ID: <1448458872-39897-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the interface to show the number of 4KB or 64KB page,
aims to statistics the number of different types of pages.

Signed-off-by: zhongjiang <zhongjiang@huawei.com>
---
 arch/arm64/include/asm/pgtable-types.h |   24 ++++++++++++++++++++++++
 arch/arm64/mm/mmu.c                    |   28 ++++++++++++++++++++++++++++
 arch/arm64/mm/pageattr.c               |   31 +++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
index 2b1bd7e..aa52546 100644
--- a/arch/arm64/include/asm/pgtable-types.h
+++ b/arch/arm64/include/asm/pgtable-types.h
@@ -86,6 +86,30 @@ typedef pteval_t pgprot_t;
 
 #endif /* STRICT_MM_TYPECHECKS */
 
+struct seq_file;
+extern void arch_report_meminfo(struct seq_file *m);
+
+enum pg_level {
+	PG_LEVEL_NONE,
+#ifdef CONFIG_ARM64_4K_PAGES
+	PG_LEVEL_4K,
+	PG_LEVEL_2M,
+	PG_LEVEL_1G,
+#else
+	PG_LEVEL_64K,
+	PG_LEVEL_512M,
+#endif
+	PG_LEVEL_NUM
+};
+
+#ifdef CONFIG_PROC_FS
+extern void update_page_count(int level, unsigned long pages);
+extern void split_page_count(int level);
+#else
+static inline void update_page_count(int level, unsigned long pages) {}
+static inline void split_page_count(int level) {}
+#endif
+
 #if CONFIG_PGTABLE_LEVELS == 2
 #include <asm-generic/pgtable-nopmd.h>
 #elif CONFIG_PGTABLE_LEVELS == 3
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0a7bee7..f9772d0 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -30,6 +30,7 @@
 #include <linux/stop_machine.h>
 #include <linux/bootmem.h>
 
+#include <asm/pgtable-types.h>
 #include <asm/cputype.h>
 #include <asm/fixmap.h>
 #include <asm/sections.h>
@@ -85,6 +86,11 @@ void split_pmd(pmd_t *pmd, pte_t *pte)
 		set_pte(pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte++, i++, i < PTRS_PER_PTE);
+#ifdef CONFIG_ARM64_4K_PAGES
+	split_page_count(PG_LEVEL_2M);
+#else
+	split_page_count(PG_LEVEL_512M);
+#endif
 }
 
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
@@ -93,6 +99,7 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  void *(*alloc)(unsigned long size))
 {
 	pte_t *pte;
+	unsigned long i = 0;
 
 	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
 		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
@@ -107,7 +114,13 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	do {
 		set_pte(pte, pfn_pte(pfn, prot));
 		pfn++;
+		i++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+#ifdef CONFIG_ARM64_4K_PAGES
+	update_page_count(PG_LEVEL_4K, i);
+#else
+	update_page_count(PG_LEVEL_64K, i);
+#endif
 }
 
 void split_pud(pud_t *old_pud, pmd_t *pmd)
@@ -120,6 +133,9 @@ void split_pud(pud_t *old_pud, pmd_t *pmd)
 		set_pmd(pmd, __pmd(addr | prot));
 		addr += PMD_SIZE;
 	} while (pmd++, i++, i < PTRS_PER_PMD);
+#ifdef CONFIG_ARM64_4K_PAGES
+	split_page_count(PG_LEVEL_1G);
+#endif
 }
 
 static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
@@ -129,6 +145,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 {
 	pmd_t *pmd;
 	unsigned long next;
+	unsigned long i = 0;
 
 	/*
 	 * Check for initial section mappings in the pgd/pud and remove them.
@@ -159,6 +176,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 			 * Check for previous table entries created during
 			 * boot (__create_page_tables) and flush them.
 			 */
+			i++;
 			if (!pmd_none(old_pmd)) {
 				flush_tlb_all();
 				if (pmd_table(old_pmd)) {
@@ -173,6 +191,11 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 		}
 		phys += next - addr;
 	} while (pmd++, addr = next, addr != end);
+#ifdef CONFIG_ARM64_4K_PAGES
+	update_page_count(PG_LEVEL_2M, i);
+#else
+	update_page_count(PG_LEVEL_512M, i);
+#endif
 }
 
 static inline bool use_1G_block(unsigned long addr, unsigned long next,
@@ -194,6 +217,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 {
 	pud_t *pud;
 	unsigned long next;
+	unsigned long i = 0;
 
 	if (pgd_none(*pgd)) {
 		pud = alloc(PTRS_PER_PUD * sizeof(pud_t));
@@ -220,6 +244,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 			 *
 			 * Look up the old pmd table and free it.
 			 */
+			i++;
 			if (!pud_none(old_pud)) {
 				flush_tlb_all();
 				if (pud_table(old_pud)) {
@@ -233,6 +258,9 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
+#ifdef CONFIG_ARM64_4K_PAGES
+	update_page_count(PG_LEVEL_1G, i);
+#endif
 }
 
 /*
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 7a5ff11..c1888b9 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -15,12 +15,43 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 
+#include <linux/seq_file.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 
 #include "mm.h"
 
+static unsigned long direct_pages_count[PG_LEVEL_NUM];
+
+void update_page_count(int level, unsigned long pages)
+{
+	direct_pages_count[level] += pages;
+}
+
+void split_page_count(int level)
+{
+	direct_pages_count[level]--;
+	direct_pages_count[level-1] += PTRS_PER_PTE;
+}
+
+void arch_report_meminfo(struct seq_file *m)
+{
+#ifdef CONFIG_ARM64_4K_PAGES
+	seq_printf(m, "DirectMap4k:     %8lu kB\n",
+			direct_pages_count[PG_LEVEL_4K] << 2);
+	seq_printf(m, "DirectMap2M:     %8lu kB\n",
+			direct_pages_count[PG_LEVEL_2M] << 11);
+	seq_printf(m, "DirectMap1G:     %8lu kB\n",
+			direct_pages_count[PG_LEVEL_1G] << 20);
+#else
+	seq_printf(m, "DirectMap64k:     %8lu kB\n",
+			direct_pages_count[PG_LEVEL_64K] << 6);
+	seq_printf(m, "DirectMap512M:     %8lu kB\n",
+			direct_pages_count[PG_LEVEL_512M] << 19);
+#endif
+}
+
 static int update_pte_range(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				pgprot_t clear, pgprot_t set)
-- 
1.7.7
