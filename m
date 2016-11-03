From: shijie.huang@arm.com (Huang Shijie)
Date: Thu, 3 Nov 2016 10:51:37 +0800
Subject: [PATCH 1/2] mm: hugetlb: rename some allocation functions
In-Reply-To: <1478141499-13825-1-git-send-email-shijie.huang@arm.com>
References: <1478141499-13825-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1478141499-13825-2-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a future patch, the __alloc_buddy_huge_page() will not necessarily
use the buddy allocator.

So this patch removes the "buddy" from these functions:
	__alloc_buddy_huge_page -> __alloc_huge_page
	__alloc_buddy_huge_page_no_mpol -> __alloc_huge_page_no_mpol
	__alloc_buddy_huge_page_with_mpol -> __alloc_huge_page_with_mpol

This patch makes preparation for the later patch.

Acked-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 mm/hugetlb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 32594f1..0bf4444 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1568,7 +1568,7 @@ static struct page *__hugetlb_alloc_buddy_huge_page(struct hstate *h,
  * For (2), we ignore 'vma' and 'addr' and use 'nid' exclusively. This
  * implies that memory policies will not be taken in to account.
  */
-static struct page *__alloc_buddy_huge_page(struct hstate *h,
+static struct page *__alloc_huge_page(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr, int nid)
 {
 	struct page *page;
@@ -1649,21 +1649,21 @@ static struct page *__alloc_buddy_huge_page(struct hstate *h,
  * anywhere.
  */
 static
-struct page *__alloc_buddy_huge_page_no_mpol(struct hstate *h, int nid)
+struct page *__alloc_huge_page_no_mpol(struct hstate *h, int nid)
 {
 	unsigned long addr = -1;
 
-	return __alloc_buddy_huge_page(h, NULL, addr, nid);
+	return __alloc_huge_page(h, NULL, addr, nid);
 }
 
 /*
  * Use the VMA's mpolicy to allocate a huge page from the buddy.
  */
 static
-struct page *__alloc_buddy_huge_page_with_mpol(struct hstate *h,
+struct page *__alloc_huge_page_with_mpol(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr)
 {
-	return __alloc_buddy_huge_page(h, vma, addr, NUMA_NO_NODE);
+	return __alloc_huge_page(h, vma, addr, NUMA_NO_NODE);
 }
 
 /*
@@ -1681,7 +1681,7 @@ struct page *alloc_huge_page_node(struct hstate *h, int nid)
 	spin_unlock(&hugetlb_lock);
 
 	if (!page)
-		page = __alloc_buddy_huge_page_no_mpol(h, nid);
+		page = __alloc_huge_page_no_mpol(h, nid);
 
 	return page;
 }
@@ -1711,7 +1711,7 @@ static int gather_surplus_pages(struct hstate *h, int delta)
 retry:
 	spin_unlock(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
-		page = __alloc_buddy_huge_page_no_mpol(h, NUMA_NO_NODE);
+		page = __alloc_huge_page_no_mpol(h, NUMA_NO_NODE);
 		if (!page) {
 			alloc_ok = false;
 			break;
@@ -1963,7 +1963,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
 	if (!page) {
 		spin_unlock(&hugetlb_lock);
-		page = __alloc_buddy_huge_page_with_mpol(h, vma, addr);
+		page = __alloc_huge_page_with_mpol(h, vma, addr);
 		if (!page)
 			goto out_uncharge_cgroup;
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
@@ -2221,7 +2221,7 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
 	 * First take pages out of surplus state.  Then make up the
 	 * remaining difference by allocating fresh huge pages.
 	 *
-	 * We might race with __alloc_buddy_huge_page() here and be unable
+	 * We might race with __alloc_huge_page() here and be unable
 	 * to convert a surplus huge page to a normal huge page. That is
 	 * not critical, though, it just means the overall size of the
 	 * pool might be one hugepage larger than it needs to be, but
@@ -2267,7 +2267,7 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
 	 * By placing pages into the surplus state independent of the
 	 * overcommit value, we are allowing the surplus pool size to
 	 * exceed overcommit. There are few sane options here. Since
-	 * __alloc_buddy_huge_page() is checking the global counter,
+	 * __alloc_huge_page() is checking the global counter,
 	 * though, we'll note that we're not allowed to exceed surplus
 	 * and won't grow the pool anywhere else. Not until one of the
 	 * sysctls are changed, or the surplus pages go out of use.
-- 
2.1.4
