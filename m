From: steve.capper@arm.com (Steve Capper)
Date: Fri,  8 Feb 2013 15:01:20 +0000
Subject: [PATCH 3/6] ARM: mm: HugeTLB support for LPAE systems.
In-Reply-To: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
References: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Message-ID: <1360335683-7755-4-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds support for hugetlbfs based on the x86 implementation.
It allows mapping of 2MB sections (see Documentation/vm/hugetlbpage.txt
for usage). The 64K pages configuration is not supported (section size
is 512MB in this case).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[steve.capper at arm.com: symbolic constants replace numbers in places.
Split up into multiple files, to simplify future non-LPAE support,
removed huge_pmd_share code, as this is very rarely executed].
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig                      |    4 ++
 arch/arm/include/asm/hugetlb-3level.h |   61 ++++++++++++++++++++
 arch/arm/include/asm/hugetlb.h        |   83 +++++++++++++++++++++++++++
 arch/arm/include/asm/pgtable-3level.h |   13 +++++
 arch/arm/mm/Makefile                  |    1 +
 arch/arm/mm/dma-mapping.c             |    2 +-
 arch/arm/mm/fsr-3level.c              |    2 +-
 arch/arm/mm/hugetlbpage.c             |  100 +++++++++++++++++++++++++++++++++
 8 files changed, 264 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-3level.h
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlbpage.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..9a80544 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1778,6 +1778,10 @@ config HW_PERF_EVENTS
 	  Enable hardware performance counter support for perf events. If
 	  disabled, perf events will use software events only.
 
+config SYS_SUPPORTS_HUGETLBFS
+       def_bool y
+       depends on ARM_LPAE
+
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
new file mode 100644
index 0000000..4868064
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb-3level.h
@@ -0,0 +1,61 @@
+/*
+ * arch/arm/include/asm/hugetlb-3level.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * Based on arch/x86/include/asm/hugetlb.h.
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _ASM_ARM_HUGETLB_3LEVEL_H
+#define _ASM_ARM_HUGETLB_3LEVEL_H
+
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+	return *ptep;
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	set_pte_at(mm, addr, ptep, pte);
+}
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep)
+{
+	ptep_clear_flush(vma, addr, ptep);
+}
+
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	ptep_set_wrprotect(mm, addr, ptep);
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	return ptep_get_and_clear(mm, addr, ptep);
+}
+
+static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+					     unsigned long addr, pte_t *ptep,
+					     pte_t pte, int dirty)
+{
+	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+}
+
+#endif /* _ASM_ARM_HUGETLB_3LEVEL_H */
diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
new file mode 100644
index 0000000..7af9cf6
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb.h
@@ -0,0 +1,83 @@
+/*
+ * arch/arm/include/asm/hugetlb.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * Based on arch/x86/include/asm/hugetlb.h
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _ASM_ARM_HUGETLB_H
+#define _ASM_ARM_HUGETLB_H
+
+#include <asm/page.h>
+
+#include <asm/hugetlb-3level.h>
+
+static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
+					  unsigned long addr, unsigned long end,
+					  unsigned long floor,
+					  unsigned long ceiling)
+{
+	free_pgd_range(tlb, addr, end, floor, ceiling);
+}
+
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					 unsigned long addr, unsigned long len)
+{
+	return 0;
+}
+
+static inline int prepare_hugepage_range(struct file *file,
+					 unsigned long addr, unsigned long len)
+{
+	struct hstate *h = hstate_file(file);
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (addr & ~huge_page_mask(h))
+		return -EINVAL;
+	return 0;
+}
+
+static inline void hugetlb_prefault_arch_hook(struct mm_struct *mm)
+{
+}
+
+static inline int huge_pte_none(pte_t pte)
+{
+	return pte_none(pte);
+}
+
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+	return pte_wrprotect(pte);
+}
+
+static inline int arch_prepare_hugepage(struct page *page)
+{
+	return 0;
+}
+
+static inline void arch_release_hugepage(struct page *page)
+{
+}
+
+static inline void arch_clear_hugepage_flags(struct page *page)
+{
+	clear_bit(PG_dcache_clean, &page->flags);
+}
+
+#endif /* _ASM_ARM_HUGETLB_H */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 2b73b0f..d89be57 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -62,6 +62,14 @@
 #define USER_PTRS_PER_PGD	(PAGE_OFFSET / PGDIR_SIZE)
 
 /*
+ * Hugetlb definitions.
+ */
+#define HPAGE_SHIFT		PMD_SHIFT
+#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+
+/*
  * "Linux" PTE definitions for LPAE.
  *
  * These bits overlap with the hardware bits but the naming is preserved for
@@ -167,6 +175,11 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,__pte(pte_val(pte)|(ext)))
 
+#define pte_huge(pte)		((pte_val(pte) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
+
+#define pte_mkhuge(pte)		(__pte((pte_val(pte) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT))
+
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_PGTABLE_3LEVEL_H */
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 8a9c4cb..a33b139 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MODULES)		+= proc-syms.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
+obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 
 obj-$(CONFIG_CPU_ABRT_NOMMU)	+= abort-nommu.o
 obj-$(CONFIG_CPU_ABRT_EV4)	+= abort-ev4.o
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 076c26d..74a0ff5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -239,7 +239,7 @@ static void __dma_free_buffer(struct page *page, size_t size)
 
 #ifdef CONFIG_MMU
 #ifdef CONFIG_HUGETLB_PAGE
-#error ARM Coherent DMA allocator does not (yet) support huge TLB
+#warning ARM Coherent DMA allocator does not (yet) support huge TLB
 #endif
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
index 05a4e94..e115fc7 100644
--- a/arch/arm/mm/fsr-3level.c
+++ b/arch/arm/mm/fsr-3level.c
@@ -13,7 +13,7 @@ static struct fsr_info fsr_info[] = {
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 access flag fault"	},
 	{ do_bad,		SIGBUS,  0,		"reserved permission fault"	},
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"level 1 permission fault"	},
-	{ do_sect_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
+	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
 	{ do_bad,		SIGBUS,  0,		"synchronous external abort"	},
 	{ do_bad,		SIGBUS,  0,		"asynchronous external abort"	},
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
new file mode 100644
index 0000000..93b78be
--- /dev/null
+++ b/arch/arm/mm/hugetlbpage.c
@@ -0,0 +1,100 @@
+/*
+ * arch/arm/mm/hugetlbpage.c
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * Based on arch/x86/include/asm/hugetlb.h and Bill Carson's patches
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <linux/pagemap.h>
+#include <linux/err.h>
+#include <linux/sysctl.h>
+#include <asm/mman.h>
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
+
+/*
+ * On ARM, huge pages are backed by pmd's rather than pte's, so we do a lot
+ * of type casting from pmd_t * to pte_t *.
+ */
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd = NULL;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_present(*pgd)) {
+		pud = pud_offset(pgd, addr);
+		if (pud_present(*pud))
+			pmd = pmd_offset(pud, addr);
+	}
+
+	return (pte_t *)pmd;
+}
+
+struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
+			      int write)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+int pmd_huge(pmd_t pmd)
+{
+	return (pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT;
+}
+
+int pud_huge(pud_t pud)
+{
+	return 0;
+}
+
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
+{
+	return 0;
+}
+
+pte_t *huge_pte_alloc(struct mm_struct *mm,
+			unsigned long addr, unsigned long sz)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pte_t *pte = NULL;
+
+	pgd = pgd_offset(mm, addr);
+	pud = pud_alloc(mm, pgd, addr);
+	if (pud)
+		pte = (pte_t *)pmd_alloc(mm, pud, addr);
+
+	return pte;
+}
+
+struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+			     pmd_t *pmd, int write)
+{
+	struct page *page;
+	unsigned long pfn;
+
+	pfn = ((pmd_val(*pmd) & HPAGE_MASK) >> PAGE_SHIFT);
+	page = pfn_to_page(pfn);
+	return page;
+}
-- 
1.7.9.5
