From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 22 May 2017 15:39:49 +0100
Subject: [PATCH v3 02/11] arm64: hugetlb: Refactor find_num_contig
In-Reply-To: <20170522143958.12867-1-punit.agrawal@arm.com>
References: <20170522143958.12867-1-punit.agrawal@arm.com>
Message-ID: <20170522143958.12867-4-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@arm.com>

As we regularly check for contiguous pte's in the huge accessors, remove
this extra check from find_num_contig.

Cc: David Woods <dwoods@mellanox.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0389e2ed51f1..804710dd7463 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -42,15 +42,13 @@ int pud_huge(pud_t pud)
 }
 
 static int find_num_contig(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep, pte_t pte, size_t *pgsize)
+			   pte_t *ptep, size_t *pgsize)
 {
 	pgd_t *pgd = pgd_offset(mm, addr);
 	pud_t *pud;
 	pmd_t *pmd;
 
 	*pgsize = PAGE_SIZE;
-	if (!pte_cont(pte))
-		return 1;
 	pud = pud_offset(pgd, addr);
 	pmd = pmd_offset(pud, addr);
 	if ((pte_t *)pmd == ptep) {
@@ -65,7 +63,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 {
 	size_t pgsize;
 	int i;
-	int ncontig = find_num_contig(mm, addr, ptep, pte, &pgsize);
+	int ncontig;
 	unsigned long pfn;
 	pgprot_t hugeprot;
 
@@ -75,11 +73,12 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	 */
 	WARN_ON(!pte_present(pte));
 
-	if (ncontig == 1) {
+	if (!pte_cont(pte)) {
 		set_pte_at(mm, addr, ptep, pte);
 		return;
 	}
 
+	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 	pfn = pte_pfn(pte);
 	hugeprot = __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
 	for (i = 0; i < ncontig; i++) {
@@ -195,7 +194,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 		bool is_dirty = false;
 
 		cpte = huge_pte_offset(mm, addr);
-		ncontig = find_num_contig(mm, addr, cpte, *cpte, &pgsize);
+		ncontig = find_num_contig(mm, addr, cpte, &pgsize);
 		/* save the 1st pte to return */
 		pte = ptep_get_and_clear(mm, addr, cpte);
 		for (i = 1, addr += pgsize; i < ncontig; ++i, addr += pgsize) {
@@ -235,7 +234,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 		cpte = huge_pte_offset(vma->vm_mm, addr);
 		pfn = pte_pfn(*cpte);
 		ncontig = find_num_contig(vma->vm_mm, addr, cpte,
-					  *cpte, &pgsize);
+					  &pgsize);
 		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize) {
 			changed |= ptep_set_access_flags(vma, addr, cpte,
 							pfn_pte(pfn,
@@ -258,7 +257,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 		size_t pgsize = 0;
 
 		cpte = huge_pte_offset(mm, addr);
-		ncontig = find_num_contig(mm, addr, cpte, *cpte, &pgsize);
+		ncontig = find_num_contig(mm, addr, cpte, &pgsize);
 		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize)
 			ptep_set_wrprotect(mm, addr, cpte);
 	} else {
@@ -276,7 +275,7 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
 
 		cpte = huge_pte_offset(vma->vm_mm, addr);
 		ncontig = find_num_contig(vma->vm_mm, addr, cpte,
-					  *cpte, &pgsize);
+					  &pgsize);
 		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize)
 			ptep_clear_flush(vma, addr, cpte);
 	} else {
-- 
2.11.0
