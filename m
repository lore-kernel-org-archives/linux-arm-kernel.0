From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 12 Apr 2017 15:04:57 +0100
Subject: [PATCH 1/3] arm64: hugetlb: Fix huge_pte_offset to return poisoned
 page table entries
In-Reply-To: <20170412140459.21824-1-punit.agrawal@arm.com>
References: <20170412140459.21824-1-punit.agrawal@arm.com>
Message-ID: <20170412140459.21824-2-punit.agrawal@arm.com>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: David Woods <dwoods@mellanox.com>
---
 arch/arm64/mm/hugetlbpage.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 7514a000e361..5f1832165d69 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -143,15 +143,24 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 	pr_debug("%s: addr:0x%lx pgd:%p\n", __func__, addr, pgd);
 	if (!pgd_present(*pgd))
 		return NULL;
-	pud = pud_offset(pgd, addr);
-	if (!pud_present(*pud))
-		return NULL;
 
-	if (pud_huge(*pud))
+	pud = pud_offset(pgd, addr);
+	/*
+	 * In case of HW Poisoning, a hugepage pud/pmd can contain
+	 * poisoned entries. Poisoned entries are marked as swap
+	 * entries.
+	 *
+	 * For puds/pmds that are not present, check to see if it
+	 * could be a swap entry (!present and !none).
+	 */
+	if ((!pte_present(pud_pte(*pud)) && !pud_none(*pud)) || pud_huge(*pud))
 		return (pte_t *)pud;
+
 	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
+	if (pmd_none(*pmd))
 		return NULL;
+	if (!pmd_present(*pmd) && !pmd_none(*pmd))
+		return (pte_t *)pmd;
 
 	if (pte_cont(pmd_pte(*pmd))) {
 		pmd = pmd_offset(
@@ -160,6 +169,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 	}
 	if (pmd_huge(*pmd))
 		return (pte_t *)pmd;
+
 	pte = pte_offset_kernel(pmd, addr);
 	if (pte_present(*pte) && pte_cont(*pte)) {
 		pte = pte_offset_kernel(
-- 
2.11.0
