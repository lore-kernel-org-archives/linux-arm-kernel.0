From: steve.capper@arm.com (Steve Capper)
Date: Fri, 21 Sep 2018 16:34:05 +0100
Subject: [PATCH V2 2/2] arm64: hugetlb: Avoid unnecessary clearing in
 huge_ptep_set_access_flags
In-Reply-To: <20180921153405.10090-1-steve.capper@arm.com>
References: <20180921153405.10090-1-steve.capper@arm.com>
Message-ID: <20180921153405.10090-3-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For contiguous hugetlb, huge_ptep_set_access_flags performs a
get_clear_flush (which then flushes the TLBs) even when no change of ptes
is necessary.

Unfortunately, this behaviour can lead to back-to-back page faults being
generated when running with multiple threads that access the same
contiguous huge page.

Thread 1                     |  Thread 2
-----------------------------+------------------------------
hugetlb_fault                |
huge_ptep_set_access_flags   |
  -> invalidate pte range    | hugetlb_fault
continue processing          | wait for hugetlb_fault_mutex
release mutex and return     | huge_ptep_set_access_flags
                             |   -> invalidate pte range
hugetlb_fault
...

This patch changes huge_ptep_set_access_flags s.t. we first read the
contiguous range of ptes (whilst preserving dirty information); the pte
range is only then invalidated where necessary and this prevents further
spurious page faults.

Fixes: d8bdcff28764 ("arm64: hugetlb: Add break-before-make logic for contiguous entries")
Reported-by: Lei Zhang <zhang.lei@jp.fujitsu.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
Changed in v2: we just check dirty, young for the contiguous range and
writable for the first pte in the range.
---
 arch/arm64/mm/hugetlbpage.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f85be2f8b140..f58ea503ad01 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -323,11 +323,40 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	return get_clear_flush(mm, addr, ptep, pgsize, ncontig);
 }
 
+/*
+ * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
+ * and write permission.
+ *
+ * For a contiguous huge pte range we need to check whether or not write
+ * permission has to change only on the first pte in the set. Then for
+ * all the contiguous ptes we need to check whether or not there is a
+ * discrepancy between dirty or young.
+ */
+static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
+{
+	int i;
+
+	if (pte_write(pte) != pte_write(huge_ptep_get(ptep)))
+		return 1;
+
+	for (i = 0; i < ncontig; i++) {
+		pte_t orig_pte = huge_ptep_get(ptep + i);
+
+		if (pte_dirty(pte) != pte_dirty(orig_pte))
+			return 1;
+
+		if (pte_young(pte) != pte_young(orig_pte))
+			return 1;
+	}
+
+	return 0;
+}
+
 int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr, pte_t *ptep,
 			       pte_t pte, int dirty)
 {
-	int ncontig, i, changed = 0;
+	int ncontig, i;
 	size_t pgsize = 0;
 	unsigned long pfn = pte_pfn(pte), dpfn;
 	pgprot_t hugeprot;
@@ -339,9 +368,10 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
 	dpfn = pgsize >> PAGE_SHIFT;
 
+	if (!__cont_access_flags_changed(ptep, pte, ncontig))
+		return 0;
+
 	orig_pte = get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
-	if (!pte_same(orig_pte, pte))
-		changed = 1;
 
 	/* Make sure we don't lose the dirty or young state */
 	if (pte_dirty(orig_pte))
@@ -354,7 +384,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
 		set_pte_at(vma->vm_mm, addr, ptep, pfn_pte(pfn, hugeprot));
 
-	return changed;
+	return 1;
 }
 
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
-- 
2.11.0
