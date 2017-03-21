From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 21 Mar 2017 18:04:21 +0000
Subject: [PATCH 7/7] arm64: hugetlb: Add break-before-make logic for
 contiguous entries
In-Reply-To: <20170321180421.18332-1-punit.agrawal@arm.com>
References: <20170321180421.18332-1-punit.agrawal@arm.com>
Message-ID: <20170321180421.18332-8-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@arm.com>

It has become apparent that one has to take special care when modifying
attributes of memory mappings that employ the contiguous bit.

Both the requirement and the architecturally correct "Break-Before-Make"
technique of updating contiguous entries can be found described in:
ARM DDI 0487A.k_iss10775, "Misprogramming of the Contiguous bit",
page D4-1762.

The huge pte accessors currently replace the attributes of contiguous
pte entries in place thus can, on certain platforms, lead to TLB
conflict aborts or even erroneous results returned from TLB lookups.

This patch adds a helper function get_clear_flush(.) that clears a
contiguous entry and returns the head pte (whilst taking care to
retain dirty bit information that could have been modified by DBM).
A tlb invalidate is performed to then ensure that there is no
possibility of multiple tlb entries being present for the same
region.

Cc: David Woods <dwoods@mellanox.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
(Fixed indentation and nuked stale comment)
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 73 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index ef85d0656039..a35c5c392198 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -68,6 +68,39 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	return CONT_PTES;
 }
 
+static pte_t get_clear_flush(struct mm_struct *mm,
+			     unsigned long addr,
+			     pte_t *ptep,
+			     unsigned long pgsize,
+			     unsigned long ncontig)
+{
+	unsigned long i, saddr = addr;
+	struct vm_area_struct vma = { .vm_mm = mm };
+	pte_t orig_pte = huge_ptep_get(ptep);
+
+	/*
+	 * If we already have a faulting entry then we don't need
+	 * to break before make (there won't be a tlb entry cached).
+	 */
+	if (!pte_present(orig_pte))
+		return orig_pte;
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
+		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
+
+		/*
+		 * If HW_AFDBM is enabled, then the HW could turn on the dirty
+		 * bit for any of the page in the set, so check them all.
+		 * All hugetlb entries are already young.
+		 */
+		if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+	}
+
+	flush_tlb_range(&vma, saddr, addr);
+	return orig_pte;
+}
+
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, pte_t pte)
 {
@@ -93,6 +126,8 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	dpfn = pgsize >> PAGE_SHIFT;
 	hugeprot = pte_pgprot(pte);
 
+	get_clear_flush(mm, addr, ptep, pgsize, ncontig);
+
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn) {
 		pr_debug("%s: set pte %p to 0x%llx\n", __func__, ptep,
 			 pte_val(pfn_pte(pfn, hugeprot)));
@@ -202,7 +237,7 @@ pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep)
 {
-	int ncontig, i;
+	int ncontig;
 	size_t pgsize;
 	pte_t orig_pte = huge_ptep_get(ptep);
 
@@ -210,17 +245,8 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 		return ptep_get_and_clear(mm, addr, ptep);
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
-		/*
-		 * If HW_AFDBM is enabled, then the HW could
-		 * turn on the dirty bit for any of the page
-		 * in the set, so check them all.
-		 */
-		if (pte_dirty(ptep_get_and_clear(mm, addr, ptep)))
-			orig_pte = pte_mkdirty(orig_pte);
-	}
 
-	return orig_pte;
+	return get_clear_flush(mm, addr, ptep, pgsize, ncontig);
 }
 
 int huge_ptep_set_access_flags(struct vm_area_struct *vma,
@@ -230,6 +256,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	int ncontig, i, changed = 0;
 	size_t pgsize = 0;
 	unsigned long pfn = pte_pfn(pte), dpfn;
+	pte_t orig_pte;
 	pgprot_t hugeprot;
 
 	if (!pte_cont(pte))
@@ -239,10 +266,12 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	dpfn = pgsize >> PAGE_SHIFT;
 	hugeprot = pte_pgprot(pte);
 
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn) {
-		changed |= ptep_set_access_flags(vma, addr, ptep,
-				pfn_pte(pfn, hugeprot), dirty);
-	}
+	orig_pte = get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	if (!pte_same(orig_pte, pte))
+		changed = 1;
+
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
+		set_pte_at(vma->vm_mm, addr, ptep, pfn_pte(pfn, hugeprot));
 
 	return changed;
 }
@@ -252,6 +281,9 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 {
 	int ncontig, i;
 	size_t pgsize;
+	pte_t pte = pte_wrprotect(huge_ptep_get(ptep)), orig_pte;
+	unsigned long pfn = pte_pfn(pte), dpfn;
+	pgprot_t hugeprot;
 
 	if (!pte_cont(*ptep)) {
 		ptep_set_wrprotect(mm, addr, ptep);
@@ -259,8 +291,15 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	}
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
-		ptep_set_wrprotect(mm, addr, ptep);
+	dpfn = pgsize >> PAGE_SHIFT;
+
+	orig_pte = get_clear_flush(mm, addr, ptep, pgsize, ncontig);
+	if (pte_dirty(orig_pte))
+		pte = pte_mkdirty(pte);
+
+	hugeprot = pte_pgprot(pte);
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
+		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
 }
 
 void huge_ptep_clear_flush(struct vm_area_struct *vma,
-- 
2.11.0
