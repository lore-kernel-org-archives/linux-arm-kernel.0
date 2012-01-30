From: bill4carson@gmail.com (bill4carson at gmail.com)
Date: Mon, 30 Jan 2012 15:57:12 +0800
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1327910238-18704-2-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bill Carson <bill4carson@gmail.com>

Why 2MB huge page is exported to user?

1M huge page only resides at pgd level, it does not need pte level stuff,
Point is that huge page based VMA mingles with 4K page based VMA at pgd level
no matter the page fault sequence of these two different VMA,
a pagefault at one VMA will contaminate the pgd entry of the other VMA.

example:

Create a 4K page based VMA and 1M page based VMA,

VMA_4K range is 0x40280000 ~ 0x40280400, pgd level index = 0x402
VMA_1M range is 0x40300000 ~ 0x40400000, pgd level index = 0x403

When page fault occurs at VMA_1M first, all we need to do is to allocate a 1M
page, and setup one pgd entry at index 0x403;

then at the occurrence of page fault for VMA_4K, both pgd entries at index
0x402 and 0x403 are configured according to current ARM 4K page pagetable
design, this will ruin the first VMA_1M page entry causing weird kernel oops;
we cannot prejudge the sequence of page fault for VMA_4K and VMA_1M;
Much of special cares need to to be taken to rule out such pagetable damages,
this work involves heavy hacking of current 4K pagetale management,
it is complex and prone to breakage.

The solution to this problem is to chose a page size that does not fall into
the 4k page pgd entries pair, and the best one is using 2MB huge page.

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/include/asm/hugetlb.h |  240 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/page.h    |   15 +++
 arch/arm/mm/hugetlb.c          |  187 +++++++++++++++++++++++++++++++
 3 files changed, 442 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlb.c

diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
new file mode 100644
index 0000000..d7ad0fc
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb.h
@@ -0,0 +1,240 @@
+/*
+ * hugetlb.h, ARM Huge Tlb Page support.
+ *
+ * Copyright (c) Bill Carson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#ifndef __ASM_HUGETLB_H
+#define __ASM_HUGETLB_H
+
+#include <asm/page.h>
+#include <asm/pgtable-2level.h>
+#include <asm/tlb.h>
+
+
+/* 2M and 16M hugepage linux ptes are stored in an array
+ *
+ * 2M hugepage
+ * ===========
+ * one linux pte caters to two HW ptes,
+ * so the maximum huge linux pte needed is 4096M/2M = 2048 entry pointers.
+ * Two 4K page is used to store these entry pointers(2048 * 4 = 8192 bytes)
+ * in a two-dimension array, huge_2m_pte[2][1024].
+ *
+ * How to find the hugepage linux pte corresponding to a specific address ?
+ * VA[31] is used as row index;
+ * VA[30:21] is used as column  index;
+ *
+ * 16M hugepage
+ * ============
+ * one linux pte caters for one HW pte,
+ * so maxium huge linux pte needed is 4096M/16M = 256 entry pointers,
+ * 256 * 4 = 1024 bytes spaces is allocated to store these linux pte;
+ * this is a simple one-dimension array huge_16m_pte[256].
+ *
+ * VA[31:24] is used to index this array;
+ */
+
+/* 2M hugepage */
+#define HUGEPAGE_2M_PTE_ARRAY_ROW(addr)  ((addr & 0x80000000) >> 31)
+#define HUGEPAGE_2M_PTE_ARRAY_COL(addr)  ((addr & 0x7fe00000) >> 21)
+/* 16M hugepage */
+#define HUGEPAGE_16M_PTE_ARRAY_INDEX(addr)  ((addr & 0xff000000) >> 24)
+
+#define ALIGN_16M_PMD_ENTRY(pmd) ((unsigned long)pmd & (~0x3f))
+
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					 unsigned long addr,
+					 unsigned long len)
+{
+	return 0;
+}
+
+static inline int prepare_hugepage_range(struct file *file,
+					 unsigned long addr,
+					 unsigned long len)
+{
+	struct hstate *h = hstate_file(file);
+	/* addr/len should be aligned with huge page size */
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (addr & ~huge_page_mask(h))
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline void hugetlb_prefault_arch_hook(struct mm_struct *mm)
+{
+}
+
+static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
+			unsigned long addr, unsigned long end,
+			unsigned long floor, unsigned long ceiling)
+{
+}
+
+static inline void set_hugepte_section(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	int col, row;
+	pte_t **huge_linuxpte = &mm->huge_2m_pte[0];
+
+	row = HUGEPAGE_2M_PTE_ARRAY_ROW(addr);
+	col = HUGEPAGE_2M_PTE_ARRAY_COL(addr);
+
+	/* an valid pte pointer is expected */
+	BUG_ON(huge_linuxpte[row] == 0);
+	BUG_ON(ptep != &huge_linuxpte[row][col]);
+
+	/* set linux pte first */
+	huge_linuxpte[row][col] = pte;
+
+	/* set hardware pte */
+	pgd = pgd_offset(mm, addr);
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
+
+	set_hugepte_at(mm, addr, pmd, pte);
+}
+
+static inline void set_hugepte_supersection(struct mm_struct *mm,
+			unsigned long addr, pte_t *ptep, pte_t pte)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	int index;
+	pte_t *huge_linuxpte = mm->huge_16m_pte;
+
+	index = HUGEPAGE_16M_PTE_ARRAY_INDEX(addr);
+
+	BUG_ON(huge_linuxpte == 0);
+	BUG_ON(ptep != &huge_linuxpte[index]);
+
+	/* set linux pte first */
+	huge_linuxpte[index] = pte;
+
+	/* set hardware pte */
+	addr &= SUPERSECTION_MASK;
+	pgd = pgd_offset(mm, addr);
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
+
+	set_hugepte_at(mm, addr, pmd, pte);
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	if (pte & L_PTE_HPAGE_2M)
+		set_hugepte_section(mm, addr, ptep, pte);
+	else
+		set_hugepte_supersection(mm, addr, ptep, pte);
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	pte_t pte = *ptep;
+	pte_t fake = (L_PTE_HUGEPAGE | L_PTE_YOUNG);
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	/* clear linux pte */
+	*ptep = 0;
+	pgd = pgd_offset(mm, addr);
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
+
+	if (pte & L_PTE_HPAGE_16M) {
+		pmd = (pmd_t *)ALIGN_16M_PMD_ENTRY(pmd);
+		fake |= L_PTE_HPAGE_16M;
+
+	} else
+		fake |= L_PTE_HPAGE_2M;
+
+	/* let set_hugepte_at clear HW entry */
+	set_hugepte_at(mm, addr, pmd, fake);
+	return pte;
+}
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep)
+{
+	if (*ptep & L_PTE_HPAGE_16M)
+		flush_tlb_page(vma, addr & SUPERSECTION_MASK);
+	else {
+		flush_tlb_page(vma, addr & SECTION_MASK);
+		flush_tlb_page(vma, (addr & SECTION_MASK)^0x100000);
+	}
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
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	pte_t old_pte = *ptep;
+	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(old_pte));
+}
+
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+	return *ptep;
+}
+
+static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+					     unsigned long addr,
+					     pte_t *ptep, pte_t pte,
+					     int dirty)
+{
+	int changed = !pte_same(huge_ptep_get(ptep), pte);
+	if (changed) {
+		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+		huge_ptep_clear_flush(vma, addr, &pte);
+	}
+
+	return changed;
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
+#endif /* __ASM_HUGETLB_H */
+
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 97b440c..3e6769a 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -15,6 +15,21 @@
 #define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
+#ifdef CONFIG_HUGEPAGE_SIZE_2MB
+/* we have 2MB hugepage for two 1MB section mapping */
+#define HPAGE_SHIFT		(SECTION_SHIFT + 1)
+#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#endif
+
+#ifdef CONFIG_HUGEPAGE_SIZE_16MB
+#define HPAGE_SHIFT		SUPERSECTION_SHIFT
+#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#endif
+
 #ifndef __ASSEMBLY__
 
 #ifndef CONFIG_MMU
diff --git a/arch/arm/mm/hugetlb.c b/arch/arm/mm/hugetlb.c
new file mode 100644
index 0000000..fe7d787
--- /dev/null
+++ b/arch/arm/mm/hugetlb.c
@@ -0,0 +1,187 @@
+/*
+ * hugetlb.c, ARM Huge Tlb Page support.
+ *
+ * Copyright (c) Bill Carson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#include <linux/hugetlb.h>
+
+pte_t *huge_pte_alloc_section(struct mm_struct *mm, unsigned long addr,
+		      unsigned long sz)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd = NULL;
+	int col, row;
+	pte_t **huge_linuxpte = &mm->huge_2m_pte[0];
+
+	/* check this mapping exist at pmd level */
+	pgd = pgd_offset(mm, addr);
+	if (pgd_present(*pgd)) {
+		pud = pud_offset(pgd, addr);
+		pmd = pmd_offset(pud, addr);
+		if (*pmd & PMD_TYPE_TABLE) {
+			printk(KERN_ERR "alloc huge pte for non huge mapping!\n");
+			BUG();
+		}
+	}
+
+	row = HUGEPAGE_2M_PTE_ARRAY_ROW(addr);
+	col = HUGEPAGE_2M_PTE_ARRAY_COL(addr);
+
+	if (huge_linuxpte[row] == 0)
+		huge_linuxpte[row] = (pte_t *) __get_free_page(PGALLOC_GFP);
+
+	return &huge_linuxpte[row][col];
+}
+
+pte_t *huge_pte_alloc_supersection(struct mm_struct *mm, unsigned long addr,
+		      unsigned long sz)
+{
+	pte_t *linuxpte_super = mm->huge_16m_pte;
+	size_t size = ((SUPERSECTION_MASK >> SUPERSECTION_SHIFT) + 1) *
+			sizeof(pte_t *);
+	int index ;
+
+	if (linuxpte_super == NULL) {
+		linuxpte_super = kzalloc(size, GFP_ATOMIC);
+		if (linuxpte_super == NULL) {
+			printk(KERN_ERR "Cannot allocate memory for pte\n");
+			return NULL;
+		}
+		mm->huge_16m_pte = linuxpte_super;
+	}
+
+	index = HUGEPAGE_16M_PTE_ARRAY_INDEX(addr);
+	return &linuxpte_super[index];
+}
+
+
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr,
+		      unsigned long sz)
+{
+	if (sz == (SECTION_SIZE*2))
+		return huge_pte_alloc_section(mm, addr, sz);
+	else
+		return huge_pte_alloc_supersection(mm, addr, sz);
+}
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd = NULL;
+
+	/* check this mapping exist at pmd level */
+	pgd = pgd_offset(mm, addr);
+	if (pgd_present(*pgd)) {
+		pud = pud_offset(pgd, addr);
+		pmd = pmd_offset(pud, addr);
+		if (!pmd_present(*pmd))
+			return NULL;
+	}
+
+	BUG_ON((*pmd & PMD_TYPE_MASK) != PMD_TYPE_SECT);
+
+	/* then return linux version pte addr */
+	if ((*pmd & PMD_SECT_SUPER) == 0) {
+		/* section */
+		int col, row;
+		pte_t **huge_linuxpte = &mm->huge_2m_pte[0];
+		row = HUGEPAGE_2M_PTE_ARRAY_ROW(addr);
+		col = HUGEPAGE_2M_PTE_ARRAY_COL(addr);
+
+		return huge_linuxpte[row] ? &huge_linuxpte[row][col] : NULL;
+	} else{
+		/* supersection */
+		pte_t *linuxpte_super = mm->huge_16m_pte;
+		int index ;
+		index = HUGEPAGE_16M_PTE_ARRAY_INDEX(addr);
+		return linuxpte_super ? &linuxpte_super[index] : NULL;
+	}
+
+}
+
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
+{
+	return 0;
+}
+
+struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
+				int write)
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
+	return  0;
+}
+
+struct page *
+follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+		pmd_t *pmd, int write)
+{
+	struct page *page = NULL;
+	unsigned long pfn;
+
+	BUG_ON((pmd_val(*pmd) & PMD_TYPE_MASK) != PMD_TYPE_SECT);
+	
+	if ((pmd_val(*pmd) & PMD_SECT_SUPER) == 0)
+		 pfn = (pmd_val(*pmd) & SECTION_MASK) >> PAGE_SHIFT;
+	else
+		 pfn = (pmd_val(*pmd) & SUPERSECTION_MASK) >> PAGE_SHIFT;
+
+	page = pfn_to_page(pfn);
+	return page;
+}
+
+static int __init add_huge_page_size(unsigned long long size)
+{
+	int shift = __ffs(size);
+
+	/* Check that it is a page size supported by the hardware and
+	 * that it fits within pagetable and slice limits. */
+	if (!is_power_of_2(size) ||
+	    ((shift != (SECTION_SHIFT+1)) && (shift != SUPERSECTION_SHIFT)))
+		return -EINVAL;
+
+	/* Return if huge page size has already been setup */
+	if (size_to_hstate(size))
+		return 0;
+
+	hugetlb_add_hstate(shift - PAGE_SHIFT);
+	return 0;
+}
+
+static int __init hugepage_setup_sz(char *str)
+{
+	unsigned long long size;
+
+	size = memparse(str, &str);
+	if (add_huge_page_size(size) != 0)
+		printk(KERN_WARNING "Invalid huge page size specified(%llu)\n",
+			 size);
+
+	return 1;
+}
+__setup("hugepagesz=", hugepage_setup_sz);
-- 
1.7.1
