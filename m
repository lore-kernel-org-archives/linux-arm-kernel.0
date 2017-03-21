From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 21 Mar 2017 18:04:20 +0000
Subject: [PATCH 6/7] arm64: hugetlb: Spring clean huge pte accessors
In-Reply-To: <20170321180421.18332-1-punit.agrawal@arm.com>
References: <20170321180421.18332-1-punit.agrawal@arm.com>
Message-ID: <20170321180421.18332-7-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@arm.com>

This patch aims to re-structure the huge pte accessors without affecting
their functionality. Control flow is changed to reduce indentation and
expanded use is made of post for loop variable modification.

It is then much easier to add break-before-make semantics in a subsequent
patch.

Cc: David Woods <dwoods@mellanox.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 121 ++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 66 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index c868c80a9d6b..ef85d0656039 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -74,7 +74,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	size_t pgsize;
 	int i;
 	int ncontig;
-	unsigned long pfn;
+	unsigned long pfn, dpfn;
 	pgprot_t hugeprot;
 
 	/*
@@ -90,14 +90,13 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 	pfn = pte_pfn(pte);
+	dpfn = pgsize >> PAGE_SHIFT;
 	hugeprot = pte_pgprot(pte);
-	for (i = 0; i < ncontig; i++) {
+
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn) {
 		pr_debug("%s: set pte %p to 0x%llx\n", __func__, ptep,
 			 pte_val(pfn_pte(pfn, hugeprot)));
 		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
-		ptep++;
-		pfn += pgsize >> PAGE_SHIFT;
-		addr += pgsize;
 	}
 }
 
@@ -203,91 +202,81 @@ pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep)
 {
-	pte_t pte;
-
-	if (pte_cont(*ptep)) {
-		int ncontig, i;
-		size_t pgsize;
-		bool is_dirty = false;
-
-		ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-		/* save the 1st pte to return */
-		pte = ptep_get_and_clear(mm, addr, ptep);
-		for (i = 1, addr += pgsize; i < ncontig; ++i, addr += pgsize) {
-			/*
-			 * If HW_AFDBM is enabled, then the HW could
-			 * turn on the dirty bit for any of the page
-			 * in the set, so check them all.
-			 */
-			++ptep;
-			if (pte_dirty(ptep_get_and_clear(mm, addr, ptep)))
-				is_dirty = true;
-		}
-		if (is_dirty)
-			return pte_mkdirty(pte);
-		else
-			return pte;
-	} else {
+	int ncontig, i;
+	size_t pgsize;
+	pte_t orig_pte = huge_ptep_get(ptep);
+
+	if (!pte_cont(orig_pte))
 		return ptep_get_and_clear(mm, addr, ptep);
+
+	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
+		/*
+		 * If HW_AFDBM is enabled, then the HW could
+		 * turn on the dirty bit for any of the page
+		 * in the set, so check them all.
+		 */
+		if (pte_dirty(ptep_get_and_clear(mm, addr, ptep)))
+			orig_pte = pte_mkdirty(orig_pte);
 	}
+
+	return orig_pte;
 }
 
 int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr, pte_t *ptep,
 			       pte_t pte, int dirty)
 {
-	if (pte_cont(pte)) {
-		int ncontig, i, changed = 0;
-		size_t pgsize = 0;
-		unsigned long pfn = pte_pfn(pte);
-		/* Select all bits except the pfn */
-		pgprot_t hugeprot = pte_pgprot(pte);
-
-		pfn = pte_pfn(pte);
-		ncontig = find_num_contig(vma->vm_mm, addr, ptep,
-					  &pgsize);
-		for (i = 0; i < ncontig; ++i, ++ptep, addr += pgsize) {
-			changed |= ptep_set_access_flags(vma, addr, ptep,
-							pfn_pte(pfn,
-								hugeprot),
-							dirty);
-			pfn += pgsize >> PAGE_SHIFT;
-		}
-		return changed;
-	} else {
+	int ncontig, i, changed = 0;
+	size_t pgsize = 0;
+	unsigned long pfn = pte_pfn(pte), dpfn;
+	pgprot_t hugeprot;
+
+	if (!pte_cont(pte))
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+
+	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
+	dpfn = pgsize >> PAGE_SHIFT;
+	hugeprot = pte_pgprot(pte);
+
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn) {
+		changed |= ptep_set_access_flags(vma, addr, ptep,
+				pfn_pte(pfn, hugeprot), dirty);
 	}
+
+	return changed;
 }
 
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     unsigned long addr, pte_t *ptep)
 {
-	if (pte_cont(*ptep)) {
-		int ncontig, i;
-		size_t pgsize = 0;
-
-		ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-		for (i = 0; i < ncontig; ++i, ++ptep, addr += pgsize)
-			ptep_set_wrprotect(mm, addr, ptep);
-	} else {
+	int ncontig, i;
+	size_t pgsize;
+
+	if (!pte_cont(*ptep)) {
 		ptep_set_wrprotect(mm, addr, ptep);
+		return;
 	}
+
+	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+		ptep_set_wrprotect(mm, addr, ptep);
 }
 
 void huge_ptep_clear_flush(struct vm_area_struct *vma,
 			   unsigned long addr, pte_t *ptep)
 {
-	if (pte_cont(*ptep)) {
-		int ncontig, i;
-		size_t pgsize = 0;
-
-		ncontig = find_num_contig(vma->vm_mm, addr, ptep,
-					  &pgsize);
-		for (i = 0; i < ncontig; ++i, ++ptep, addr += pgsize)
-			ptep_clear_flush(vma, addr, ptep);
-	} else {
+	int ncontig, i;
+	size_t pgsize;
+
+	if (!pte_cont(*ptep)) {
 		ptep_clear_flush(vma, addr, ptep);
+		return;
 	}
+
+	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+		ptep_clear_flush(vma, addr, ptep);
 }
 
 static __init int setup_hugepagesz(char *opt)
-- 
2.11.0
