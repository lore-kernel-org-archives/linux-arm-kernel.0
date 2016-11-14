From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 14 Nov 2016 15:07:38 +0800
Subject: [PATCH v2 5/6] mm: hugetlb: add a new function to allocate a new
 gigantic page
In-Reply-To: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1479107259-2011-6-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are three ways we can allocate a new gigantic page:

1. When the NUMA is not enabled, use alloc_gigantic_page() to get
   the gigantic page.

2. The NUMA is enabled, but the vma is NULL.
   There is no memory policy we can refer to.
   So create a @nodes_allowed, initialize it with init_nodemask_of_mempolicy()
   or init_nodemask_of_node(). Then use alloc_fresh_gigantic_page() to get
   the gigantic page.

3. The NUMA is enabled, and the vma is valid.
   We can follow the memory policy of the @vma.

   Get @nodes_mask by huge_nodemask(), and use alloc_fresh_gigantic_page()
   to get the gigantic page.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 mm/hugetlb.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6995087..58a59f0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1502,6 +1502,73 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 
 /*
  * There are 3 ways this can get called:
+ *
+ * 1. When the NUMA is not enabled, use alloc_gigantic_page() to get
+ *    the gigantic page.
+ *
+ * 2. The NUMA is enabled, but the vma is NULL.
+ *    Create a @nodes_allowed, use alloc_fresh_gigantic_page() to get
+ *    the gigantic page.
+ *
+ * 3. The NUMA is enabled, and the vma is valid.
+ *    Use the @vma's memory policy.
+ *    Get @nodes_mask by huge_nodemask(), and use alloc_fresh_gigantic_page()
+ *    to get the gigantic page.
+ */
+static struct page *__hugetlb_alloc_gigantic_page(struct hstate *h,
+		struct vm_area_struct *vma, unsigned long addr, int nid)
+{
+	struct page *page;
+	nodemask_t *nodes_mask;
+
+	/* Not NUMA */
+	if (!IS_ENABLED(CONFIG_NUMA)) {
+		if (nid == NUMA_NO_NODE)
+			nid = numa_mem_id();
+
+		page = alloc_gigantic_page(nid, huge_page_order(h));
+		if (page)
+			prep_compound_gigantic_page(page, huge_page_order(h));
+
+		return page;
+	}
+
+	/* NUMA && !vma */
+	if (!vma) {
+		NODEMASK_ALLOC(nodemask_t, nodes_allowed,
+				GFP_KERNEL | __GFP_NORETRY);
+
+		if (nid == NUMA_NO_NODE) {
+			if (!init_nodemask_of_mempolicy(nodes_allowed)) {
+				NODEMASK_FREE(nodes_allowed);
+				nodes_allowed = &node_states[N_MEMORY];
+			}
+		} else if (nodes_allowed) {
+			init_nodemask_of_node(nodes_allowed, nid);
+		} else {
+			nodes_allowed = &node_states[N_MEMORY];
+		}
+
+		page = alloc_fresh_gigantic_page(h, nodes_allowed, true);
+
+		if (nodes_allowed != &node_states[N_MEMORY])
+			NODEMASK_FREE(nodes_allowed);
+
+		return page;
+	}
+
+	/* NUMA && vma */
+	nodes_mask = huge_nodemask(vma, addr);
+	if (nodes_mask) {
+		page = alloc_fresh_gigantic_page(h, nodes_mask, true);
+		if (page)
+			return page;
+	}
+	return NULL;
+}
+
+/*
+ * There are 3 ways this can get called:
  * 1. With vma+addr: we use the VMA's memory policy
  * 2. With !vma, but nid=NUMA_NO_NODE:  We try to allocate a huge
  *    page from any node, and let the buddy allocator itself figure
-- 
2.5.5
