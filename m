From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 10 Aug 2017 18:09:03 +0100
Subject: [PATCH v6 6/9] arm64: hugetlb: Override huge_pte_clear() to support
 contiguous hugepages
In-Reply-To: <20170810170906.30772-1-punit.agrawal@arm.com>
References: <20170810170906.30772-1-punit.agrawal@arm.com>
Message-ID: <20170810170906.30772-7-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default huge_pte_clear() implementation does not clear contiguous
page table entries when it encounters contiguous hugepages that are
supported on arm64.

Fix this by overriding the default implementation to clear all the
entries associated with contiguous hugepages.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: David Woods <dwoods@mellanox.com>
---
 arch/arm64/include/asm/hugetlb.h |  6 +++++-
 arch/arm64/mm/hugetlbpage.c      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 793bd73b0d07..df8c0aea0917 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -18,7 +18,6 @@
 #ifndef __ASM_HUGETLB_H
 #define __ASM_HUGETLB_H
 
-#include <asm-generic/hugetlb.h>
 #include <asm/page.h>
 
 static inline pte_t huge_ptep_get(pte_t *ptep)
@@ -82,6 +81,11 @@ extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
 extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
 				  unsigned long addr, pte_t *ptep);
+extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, unsigned long sz);
+#define huge_pte_clear huge_pte_clear
+
+#include <asm-generic/hugetlb.h>
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static inline bool gigantic_page_supported(void) { return true; }
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 09e79785c019..b69430a04e87 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -68,6 +68,30 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	return CONT_PTES;
 }
 
+static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
+{
+	int contig_ptes = 0;
+
+	*pgsize = size;
+
+	switch (size) {
+	case PUD_SIZE:
+	case PMD_SIZE:
+		contig_ptes = 1;
+		break;
+	case CONT_PMD_SIZE:
+		*pgsize = PMD_SIZE;
+		contig_ptes = CONT_PMDS;
+		break;
+	case CONT_PTE_SIZE:
+		*pgsize = PAGE_SIZE;
+		contig_ptes = CONT_PTES;
+		break;
+	}
+
+	return contig_ptes;
+}
+
 /*
  * Changing some bits of contiguous entries requires us to follow a
  * Break-Before-Make approach, breaking the whole contiguous set
@@ -260,6 +284,18 @@ pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 	return entry;
 }
 
+void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
+		    pte_t *ptep, unsigned long sz)
+{
+	int i, ncontig;
+	size_t pgsize;
+
+	ncontig = num_contig_ptes(sz, &pgsize);
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
+		pte_clear(mm, addr, ptep);
+}
+
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep)
 {
-- 
2.13.2
