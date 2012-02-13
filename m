From: bill4carson@gmail.com (Bill Carson)
Date: Mon, 13 Feb 2012 17:44:22 +0800
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/include/asm/hugetlb.h |  178 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/page.h    |   15 ++++
 arch/arm/mm/hugetlb.c          |  132 +++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlb.c

diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
new file mode 100644
index 0000000..3c34528
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb.h
@@ -0,0 +1,178 @@
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
+/* 2M and 16M hugepage linux ptes are stored in mmu_context_t->huge_linux_pte
+ *
+ * 2M hugepage
+ * ===========
+ * one huge linux pte caters to two HW ptes,
+ *
+ * 16M hugepage
+ * ============
+ * one huge linux pte caters for sixteen HW ptes,
+ *
+ * The number of huge linux ptes depends on PAGE_OFFSET configuration
+ * which is defined as following:
+ */
+#define HUGE_LINUX_PTE_COUNT	( PAGE_OFFSET >> HPAGE_SHIFT)
+#define HUGE_LINUX_PTE_SIZE		(HUGE_LINUX_PTE_COUNT * sizeof(pte_t *))
+#define HUGE_LINUX_PTE_INDEX(addr) (addr >> HPAGE_SHIFT)
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
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *linuxpte = mm->context.huge_linux_pte;
+
+	BUG_ON(linuxpte == NULL);
+	BUG_ON(HUGE_LINUX_PTE_INDEX(addr) >= HUGE_LINUX_PTE_COUNT);
+	BUG_ON(ptep != &linuxpte[HUGE_LINUX_PTE_INDEX(addr)]);
+
+	/* set huge linux pte first */
+	*ptep = pte;
+	
+	/* then set hardware pte */
+	addr &= HPAGE_MASK;
+	pgd = pgd_offset(mm, addr);
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
+	set_hugepte_at(mm, addr, pmd, pte);
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	pte_t pte = *ptep;
+	pte_t fake = L_PTE_YOUNG;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	/* clear linux pte */
+	*ptep = 0;
+
+	/* let set_hugepte_at clear HW entry */
+	addr &= HPAGE_MASK;
+	pgd = pgd_offset(mm, addr);
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
+	set_hugepte_at(mm, addr, pmd, fake);
+	return pte;
+}
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep)
+{
+	if (HPAGE_SHIFT == SUPERSECTION_SHIFT)
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
index 0000000..165bd8f
--- /dev/null
+++ b/arch/arm/mm/hugetlb.c
@@ -0,0 +1,132 @@
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
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr,
+		      unsigned long sz)
+{
+	pte_t *linuxpte = mm->context.huge_linux_pte;
+	int index;
+
+	if (linuxpte == NULL) {
+		linuxpte = kzalloc(HUGE_LINUX_PTE_SIZE, GFP_ATOMIC);
+		if (linuxpte == NULL) {
+			printk(KERN_ERR "Cannot allocate memory for huge linux pte\n");
+			return NULL;
+		}
+		mm->context.huge_linux_pte = linuxpte;
+	}
+	/* huge page mapping only cover user space address */
+	BUG_ON(HUGE_LINUX_PTE_INDEX(addr) >= HUGE_LINUX_PTE_COUNT);
+	index = HUGE_LINUX_PTE_INDEX(addr);
+	return &linuxpte[HUGE_LINUX_PTE_INDEX(addr)];
+}
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd = NULL;
+	pte_t *linuxpte = mm->context.huge_linux_pte;
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
+	BUG_ON(HUGE_LINUX_PTE_INDEX(addr) >= HUGE_LINUX_PTE_COUNT);
+	BUG_ON((*pmd & PMD_TYPE_MASK) != PMD_TYPE_SECT);
+	return &linuxpte[HUGE_LINUX_PTE_INDEX(addr)];
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
+	return  0; } struct page * follow_huge_pmd(struct mm_struct *mm, unsigned long address, pmd_t *pmd, int write)
+{
+	struct page *page = NULL;
+	unsigned long pfn;
+
+	BUG_ON((pmd_val(*pmd) & PMD_TYPE_MASK) != PMD_TYPE_SECT);
+	pfn = ((pmd_val(*pmd) & HPAGE_MASK) >> PAGE_SHIFT);
+	page = pfn_to_page(pfn);
+	return page;
+}
+
+static int __init add_huge_page_size(unsigned long long size)
+{
+	int shift = __ffs(size);
+	u32 mmfr3 = 0;
+
+	/* Check that it is a page size supported by the hardware and
+	 * that it fits within pagetable and slice limits. */
+	if (!is_power_of_2(size) || (shift != HPAGE_SHIFT))
+		return -EINVAL;
+
+	/* If user wants super-section support, then check if our cpu
+	 * has this feature supported in ID_MMFR3 */
+	if (shift == SUPERSECTION_SHIFT) {
+		__asm__("mrc p15, 0, %0, c0, c1, 7\n" : "=r" (mmfr3));
+		if (mmfr3 & 0xF0000000) {
+			printk("Super-Section is NOT supported by this CPU, mmfr3:0x%x\n", mmfr3);
+			return -EINVAL;
+		}
+	}
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
