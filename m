From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Jan 2012 10:00:44 +0100
Subject: [PATCH 02/15] mm: page_alloc: update migrate type of pages on pcp when
 isolating
In-Reply-To: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1327568457-27734-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Nazarewicz <mina86@mina86.com>

This commit changes set_migratetype_isolate() so that it updates
migrate type of pages on pcp list which is saved in their
page_private.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/page-isolation.h |    6 ++++++
 mm/page_alloc.c                |    1 +
 mm/page_isolation.c            |   24 ++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 051c1b1..8c02c2b 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -27,6 +27,12 @@ extern int
 test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn);
 
 /*
+ * Check all pages in pageblock, find the ones on pcp list, and set
+ * their page_private to MIGRATE_ISOLATE.
+ */
+extern void update_pcp_isolate_block(unsigned long pfn);
+
+/*
  * Internal funcs.Changes pageblock's migrate type.
  * Please use make_pagetype_isolated()/make_pagetype_movable().
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e1c5656..70709e7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5465,6 +5465,7 @@ out:
 	if (!ret) {
 		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 		move_freepages_block(zone, page, MIGRATE_ISOLATE);
+		update_pcp_isolate_block(pfn);
 	}
 
 	spin_unlock_irqrestore(&zone->lock, flags);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 4ae42bb..9ea2f6e 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -139,3 +139,27 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn)
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret ? 0 : -EBUSY;
 }
+
+/* must hold zone->lock */
+void update_pcp_isolate_block(unsigned long pfn)
+{
+	unsigned long end_pfn = pfn + pageblock_nr_pages;
+	struct page *page;
+
+	while (pfn < end_pfn) {
+		if (!pfn_valid_within(pfn)) {
+			++pfn;
+			continue;
+		}
+
+		page = pfn_to_page(pfn);
+		if (PageBuddy(page)) {
+			pfn += 1 << page_order(page);
+		} else if (page_count(page) == 0) {
+			set_page_private(page, MIGRATE_ISOLATE);
+			++pfn;
+		} else {
+			++pfn;
+		}
+	}
+}
-- 
1.7.1.569.g6f426
