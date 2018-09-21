From: steve.capper@arm.com (Steve Capper)
Date: Fri, 21 Sep 2018 16:34:04 +0100
Subject: [PATCH V2 1/2] arm64: hugetlb: Fix handling of young ptes
In-Reply-To: <20180921153405.10090-1-steve.capper@arm.com>
References: <20180921153405.10090-1-steve.capper@arm.com>
Message-ID: <20180921153405.10090-2-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the contiguous bit hugetlb break-before-make code we assume that all
hugetlb pages are young.

In fact, remove_migration_pte is able to place an old hugetlb pte so
this assumption is not valid.

This patch fixes the contiguous hugetlb scanning code to preserve young
ptes.

Fixes: d8bdcff28764 ("arm64: hugetlb: Add break-before-make logic for contiguous entries")
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 192b3ba07075..f85be2f8b140 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -117,11 +117,14 @@ static pte_t get_clear_flush(struct mm_struct *mm,
 
 		/*
 		 * If HW_AFDBM is enabled, then the HW could turn on
-		 * the dirty bit for any page in the set, so check
-		 * them all.  All hugetlb entries are already young.
+		 * the dirty or accessed bit for any page in the set,
+		 * so check them all.
 		 */
 		if (pte_dirty(pte))
 			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
 	}
 
 	if (valid) {
@@ -340,10 +343,13 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (!pte_same(orig_pte, pte))
 		changed = 1;
 
-	/* Make sure we don't lose the dirty state */
+	/* Make sure we don't lose the dirty or young state */
 	if (pte_dirty(orig_pte))
 		pte = pte_mkdirty(pte);
 
+	if (pte_young(orig_pte))
+		pte = pte_mkyoung(pte);
+
 	hugeprot = pte_pgprot(pte);
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
 		set_pte_at(vma->vm_mm, addr, ptep, pfn_pte(pfn, hugeprot));
-- 
2.11.0
