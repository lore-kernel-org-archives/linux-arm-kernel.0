From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 17 May 2017 16:23:34 +0100
Subject: [PATCH v2 1/3] arm64: hugetlb: Fix huge_pte_offset to return poisoned
 page table entries
In-Reply-To: <20170517152336.6052-1-punit.agrawal@arm.com>
References: <20170517152336.6052-1-punit.agrawal@arm.com>
Message-ID: <20170517152336.6052-2-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When memory failure is enabled, a poisoned hugepage pte is marked as a
swap entry. huge_pte_offset() does not return the poisoned page table
entries when it encounters PUD/PMD hugepages.

This behaviour of huge_pte_offset() leads to error such as below when
munmap is called on poisoned hugepages.

[  344.165544] mm/pgtable-generic.c:33: bad pmd 000000083af00074.

Fix huge_pte_offset() to return the poisoned pte which is then
appropriately handled by the generic layer code.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Woods <dwoods@mellanox.com>
---
 arch/arm64/include/asm/pgtable.h |  2 +-
 arch/arm64/mm/hugetlbpage.c      | 29 ++++++++++-------------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c213fdbd056c..6eae342ced6b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -441,7 +441,7 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
-#define pud_present(pud)	(pud_val(pud))
+#define pud_present(pud)	pte_present(pud_pte(pud))
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 7514a000e361..69b8200b1cfd 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -136,36 +136,27 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
-	pmd_t *pmd = NULL;
-	pte_t *pte = NULL;
+	pmd_t *pmd;
 
 	pgd = pgd_offset(mm, addr);
 	pr_debug("%s: addr:0x%lx pgd:%p\n", __func__, addr, pgd);
 	if (!pgd_present(*pgd))
 		return NULL;
+
 	pud = pud_offset(pgd, addr);
-	if (!pud_present(*pud))
+	if (pud_none(*pud))
 		return NULL;
-
-	if (pud_huge(*pud))
+	/* swap or huge page */
+	if (!pud_present(*pud) || pud_huge(*pud))
 		return (pte_t *)pud;
+	/* table; check the next level */
+
 	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
+	if (pmd_none(*pmd))
 		return NULL;
-
-	if (pte_cont(pmd_pte(*pmd))) {
-		pmd = pmd_offset(
-			pud, (addr & CONT_PMD_MASK));
-		return (pte_t *)pmd;
-	}
-	if (pmd_huge(*pmd))
+	if (!pmd_present(*pmd) || pmd_huge(*pmd))
 		return (pte_t *)pmd;
-	pte = pte_offset_kernel(pmd, addr);
-	if (pte_present(*pte) && pte_cont(*pte)) {
-		pte = pte_offset_kernel(
-			pmd, (addr & CONT_PTE_MASK));
-		return pte;
-	}
+
 	return NULL;
 }
 
-- 
2.11.0
