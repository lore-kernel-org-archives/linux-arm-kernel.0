From: zhongjiang@huawei.com (zhongjiang)
Date: Fri, 4 Dec 2015 19:43:17 +0800
Subject: [PATCH] arm64: add a function to show the different types of pagetable
Message-ID: <1449229397-39900-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch is mainly to show  pagetable number of different level in the direct
mapping. pagetable is created from pud to pte in arm64 , resulting in different
resluts with x86. For instance, The kernel of two-level pages will produce three
types of pagetable.

It can also be used to detect whether there is a large page spliting and merging.
Large page will significantly reduce the TLB miss, and improve the system
performance.

Signed-off-by: zhongjiang <zhongjiang@huawei.com>
---
 arch/arm64/include/asm/pgtable-types.h |   19 +++++++++++++++++
 arch/arm64/mm/mmu.c                    |   12 +++++++++++
 arch/arm64/mm/pageattr.c               |   35 ++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
index 2b1bd7e..a0f58d0 100644
--- a/arch/arm64/include/asm/pgtable-types.h
+++ b/arch/arm64/include/asm/pgtable-types.h
@@ -86,6 +86,25 @@ typedef pteval_t pgprot_t;
 
 #endif /* STRICT_MM_TYPECHECKS */
 
+struct seq_file;
+extern void arch_report_meminfo(struct seq_file *m);
+
+enum pg_level {
+	PG_LEVEL_NONE,
+	PG_LEVEL_PTE,
+	PG_LEVEL_PMD,
+	PG_LEVEL_PUD,
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
index 0a7bee7..77aef0b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -30,6 +30,7 @@
 #include <linux/stop_machine.h>
 #include <linux/bootmem.h>
 
+#include <asm/pgtable-types.h>
 #include <asm/cputype.h>
 #include <asm/fixmap.h>
 #include <asm/sections.h>
@@ -85,6 +86,7 @@ void split_pmd(pmd_t *pmd, pte_t *pte)
 		set_pte(pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte++, i++, i < PTRS_PER_PTE);
+	split_page_count(PG_LEVEL_PMD);
 }
 
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
@@ -93,6 +95,7 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  void *(*alloc)(unsigned long size))
 {
 	pte_t *pte;
+	unsigned long i = 0;
 
 	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
 		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
@@ -107,7 +110,9 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	do {
 		set_pte(pte, pfn_pte(pfn, prot));
 		pfn++;
+		i++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	update_page_count(PG_LEVEL_PTE, i);
 }
 
 void split_pud(pud_t *old_pud, pmd_t *pmd)
@@ -120,6 +125,7 @@ void split_pud(pud_t *old_pud, pmd_t *pmd)
 		set_pmd(pmd, __pmd(addr | prot));
 		addr += PMD_SIZE;
 	} while (pmd++, i++, i < PTRS_PER_PMD);
+	split_page_count(PG_LEVEL_PUD);
 }
 
 static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
@@ -129,6 +135,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 {
 	pmd_t *pmd;
 	unsigned long next;
+	unsigned long i = 0;
 
 	/*
 	 * Check for initial section mappings in the pgd/pud and remove them.
@@ -159,6 +166,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 			 * Check for previous table entries created during
 			 * boot (__create_page_tables) and flush them.
 			 */
+			i++;
 			if (!pmd_none(old_pmd)) {
 				flush_tlb_all();
 				if (pmd_table(old_pmd)) {
@@ -173,6 +181,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 		}
 		phys += next - addr;
 	} while (pmd++, addr = next, addr != end);
+	update_page_count(PG_LEVEL_PMD, i);
 }
 
 static inline bool use_1G_block(unsigned long addr, unsigned long next,
@@ -194,6 +203,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 {
 	pud_t *pud;
 	unsigned long next;
+	unsigned long i = 0;
 
 	if (pgd_none(*pgd)) {
 		pud = alloc(PTRS_PER_PUD * sizeof(pud_t));
@@ -220,6 +230,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 			 *
 			 * Look up the old pmd table and free it.
 			 */
+			i++;
 			if (!pud_none(old_pud)) {
 				flush_tlb_all();
 				if (pud_table(old_pud)) {
@@ -233,6 +244,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
+	update_page_count(PG_LEVEL_PUD, i);
 }
 
 /*
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 7a5ff11..a8257a2 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -15,12 +15,47 @@
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
+
+	seq_printf(m, "DirectMap%ldk:     %8lu kB\n", PAGE_SIZE / SZ_1K,
+			direct_pages_count[PG_LEVEL_PTE] * PAGE_SIZE / SZ_1K);
+
+#if CONFIG_PGTABLE_LEVELS == 2
+	seq_printf(m, "DirectMap%ldM:     %8lu kB\n", PMD_SIZE / SZ_1M,
+			direct_pages_count[PG_LEVEL_PMD] * PMD_SIZE / SZ_1K);
+
+#endif
+
+#if CONFIG_PGTABLE_LEVELS > 2
+	seq_printf(m, "DirectMap%ldM:     %8lu kB\n", PMD_SIZE / SZ_1M,
+			direct_pages_count[PG_LEVEL_PMD] * PMD_SIZE / SZ_1K);
+	seq_printf(m, "DirectMap%ldG:     %8lu kB\n", PUD_SIZE / SZ_1G,
+			direct_pages_count[PG_LEVEL_PUD] * PUD_SIZE  / SZ_1K);
+
+#endif
+}
+
 static int update_pte_range(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				pgprot_t clear, pgprot_t set)
-- 
1.7.7
