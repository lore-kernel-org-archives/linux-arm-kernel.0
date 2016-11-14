From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 14 Nov 2016 15:07:35 +0800
Subject: [PATCH v2 2/6] mm: hugetlb: add a new parameter for some functions
In-Reply-To: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1479107259-2011-3-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new parameter, the "no_init", for these functions:
   alloc_fresh_gigantic_page_node()
   alloc_fresh_gigantic_page()

The prep_new_huge_page() does some initialization for the new page.
But sometime, we do not need it to do so, such as in the surplus case
in later patch.

With this parameter, the prep_new_huge_page() can be called by needed:
   If the "no_init" is false, calls the prep_new_huge_page() in
   the alloc_fresh_gigantic_page_node();

This patch makes preparation for the later patches.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 mm/hugetlb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 496b703..db0177b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1127,27 +1127,29 @@ static struct page *alloc_gigantic_page(int nid, unsigned int order)
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
 static void prep_compound_gigantic_page(struct page *page, unsigned int order);
 
-static struct page *alloc_fresh_gigantic_page_node(struct hstate *h, int nid)
+static struct page *alloc_fresh_gigantic_page_node(struct hstate *h,
+					int nid, bool no_init)
 {
 	struct page *page;
 
 	page = alloc_gigantic_page(nid, huge_page_order(h));
 	if (page) {
 		prep_compound_gigantic_page(page, huge_page_order(h));
-		prep_new_huge_page(h, page, nid);
+		if (!no_init)
+			prep_new_huge_page(h, page, nid);
 	}
 
 	return page;
 }
 
 static int alloc_fresh_gigantic_page(struct hstate *h,
-				nodemask_t *nodes_allowed)
+				nodemask_t *nodes_allowed, bool no_init)
 {
 	struct page *page = NULL;
 	int nr_nodes, node;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		page = alloc_fresh_gigantic_page_node(h, node);
+		page = alloc_fresh_gigantic_page_node(h, node, no_init);
 		if (page)
 			return 1;
 	}
@@ -1166,7 +1168,7 @@ static inline void free_gigantic_page(struct page *page, unsigned int order) { }
 static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 static inline int alloc_fresh_gigantic_page(struct hstate *h,
-					nodemask_t *nodes_allowed) { return 0; }
+		nodemask_t *nodes_allowed, bool no_init) { return 0; }
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
@@ -2313,7 +2315,8 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
 		cond_resched();
 
 		if (hstate_is_gigantic(h))
-			ret = alloc_fresh_gigantic_page(h, nodes_allowed);
+			ret = alloc_fresh_gigantic_page(h, nodes_allowed,
+							false);
 		else
 			ret = alloc_fresh_huge_page(h, nodes_allowed);
 		spin_lock(&hugetlb_lock);
-- 
2.5.5
