From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 5 Dec 2016 17:17:10 +0800
Subject: [PATCH v3 3/4] mm: hugetlb: change the return type for some functions
In-Reply-To: <1480929431-22348-1-git-send-email-shijie.huang@arm.com>
References: <1480929431-22348-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1480929431-22348-4-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the return type to "struct page*" for
alloc_fresh_gigantic_page()/alloc_fresh_huge_page().

This patch makes preparation for later patch.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 mm/hugetlb.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b7c73a1..1395bef 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1148,7 +1148,7 @@ static struct page *alloc_fresh_gigantic_page_node(struct hstate *h,
 	return page;
 }
 
-static int alloc_fresh_gigantic_page(struct hstate *h,
+static struct page *alloc_fresh_gigantic_page(struct hstate *h,
 				nodemask_t *nodes_allowed, bool do_prep)
 {
 	struct page *page = NULL;
@@ -1157,10 +1157,10 @@ static int alloc_fresh_gigantic_page(struct hstate *h,
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
 		page = alloc_fresh_gigantic_page_node(h, node, do_prep);
 		if (page)
-			return 1;
+			return page;
 	}
 
-	return 0;
+	return NULL;
 }
 
 static inline bool gigantic_page_supported(void) { return true; }
@@ -1173,8 +1173,8 @@ static inline bool gigantic_page_supported(void) { return false; }
 static inline void free_gigantic_page(struct page *page, unsigned int order) { }
 static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
-static inline int alloc_fresh_gigantic_page(struct hstate *h,
-		nodemask_t *nodes_allowed, bool do_prep) { return 0; }
+static inline struct page *alloc_fresh_gigantic_page(struct hstate *h,
+		nodemask_t *nodes_allowed, bool do_prep) { return NULL; }
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
@@ -1387,26 +1387,24 @@ static struct page *alloc_fresh_huge_page_node(struct hstate *h, int nid)
 	return page;
 }
 
-static int alloc_fresh_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
+static struct page *alloc_fresh_huge_page(struct hstate *h,
+					nodemask_t *nodes_allowed)
 {
-	struct page *page;
+	struct page *page = NULL;
 	int nr_nodes, node;
-	int ret = 0;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
 		page = alloc_fresh_huge_page_node(h, node);
-		if (page) {
-			ret = 1;
+		if (page)
 			break;
-		}
 	}
 
-	if (ret)
+	if (page)
 		count_vm_event(HTLB_BUDDY_PGALLOC);
 	else
 		count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
 
-	return ret;
+	return page;
 }
 
 /*
@@ -2321,9 +2319,10 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
 		cond_resched();
 
 		if (hstate_is_gigantic(h))
-			ret = alloc_fresh_gigantic_page(h, nodes_allowed, true);
+			ret = !!alloc_fresh_gigantic_page(h, nodes_allowed,
+							true);
 		else
-			ret = alloc_fresh_huge_page(h, nodes_allowed);
+			ret = !!alloc_fresh_huge_page(h, nodes_allowed);
 		spin_lock(&hugetlb_lock);
 		if (!ret)
 			goto out;
-- 
2.5.5
