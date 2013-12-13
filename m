From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 13 Dec 2013 19:05:41 +0000
Subject: [RFC PATCH 1/6] mm: hugetlb: Introduce huge_pte_page and
 huge_pte_present
In-Reply-To: <1386961546-10061-1-git-send-email-steve.capper@linaro.org>
References: <1386961546-10061-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1386961546-10061-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce huge pte versions of pte_page and pte_present. This
allows ARM (without LPAE) to use alternative pte processing logic
for huge ptes.

Where these functions are not defined by architectural code they
fallback to the standard pte_page and pte_present functions.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 include/linux/hugetlb.h |  8 ++++++++
 mm/hugetlb.c            | 18 +++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9649ff0..857c298 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -355,6 +355,14 @@ static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 }
 #endif
 
+#ifndef huge_pte_page
+#define huge_pte_page(pte)	pte_page(pte)
+#endif
+
+#ifndef huge_pte_present
+#define huge_pte_present(pte)	pte_present(pte)
+#endif
+
 static inline struct hstate *page_hstate(struct page *page)
 {
 	return size_to_hstate(PAGE_SIZE << compound_order(page));
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dee6cf4..b725f21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2378,7 +2378,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			if (cow)
 				huge_ptep_set_wrprotect(src, addr, src_pte);
 			entry = huge_ptep_get(src_pte);
-			ptepage = pte_page(entry);
+			ptepage = huge_pte_page(entry);
 			get_page(ptepage);
 			page_dup_rmap(ptepage);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
@@ -2396,7 +2396,7 @@ static int is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (huge_pte_none(pte) || huge_pte_present(pte))
 		return 0;
 	swp = pte_to_swp_entry(pte);
 	if (non_swap_entry(swp) && is_migration_entry(swp))
@@ -2409,7 +2409,7 @@ static int is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (huge_pte_none(pte) || huge_pte_present(pte))
 		return 0;
 	swp = pte_to_swp_entry(pte);
 	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
@@ -2462,7 +2462,7 @@ again:
 			goto unlock;
 		}
 
-		page = pte_page(pte);
+		page = huge_pte_page(pte);
 		/*
 		 * If a reference page is supplied, it is because a specific
 		 * page is being unmapped, not a range. Ensure the page we
@@ -2612,7 +2612,7 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long mmun_start;	/* For mmu_notifiers */
 	unsigned long mmun_end;		/* For mmu_notifiers */
 
-	old_page = pte_page(pte);
+	old_page = huge_pte_page(pte);
 
 retry_avoidcopy:
 	/* If no-one else is actually using this page, avoid the copy
@@ -2963,7 +2963,7 @@ int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * Note that locking order is always pagecache_page -> page,
 	 * so no worry about deadlock.
 	 */
-	page = pte_page(entry);
+	page = huge_pte_page(entry);
 	get_page(page);
 	if (page != pagecache_page)
 		lock_page(page);
@@ -3075,7 +3075,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		}
 
 		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
-		page = pte_page(huge_ptep_get(pte));
+		page = huge_pte_page(huge_ptep_get(pte));
 same_page:
 		if (pages) {
 			pages[i] = mem_map_offset(page, pfn_offset);
@@ -3423,7 +3423,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 {
 	struct page *page;
 
-	page = pte_page(*(pte_t *)pmd);
+	page = huge_pte_page(*(pte_t *)pmd);
 	if (page)
 		page += ((address & ~PMD_MASK) >> PAGE_SHIFT);
 	return page;
@@ -3435,7 +3435,7 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
 {
 	struct page *page;
 
-	page = pte_page(*(pte_t *)pud);
+	page = huge_pte_page(*(pte_t *)pud);
 	if (page)
 		page += ((address & ~PUD_MASK) >> PAGE_SHIFT);
 	return page;
-- 
1.8.1.4
