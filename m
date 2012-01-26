From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Jan 2012 10:00:53 +0100
Subject: [PATCH 11/15] mm: trigger page reclaim in alloc_contig_range() to
 stabilize watermarks
In-Reply-To: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1327568457-27734-12-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

alloc_contig_range() performs memory allocation so it also should keep
track on keeping the correct level of memory watermarks. This commit adds
a call to *_slowpath style reclaim to grab enough pages to make sure that
the final collection of contiguous pages from freelists will not starve
the system.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
CC: Michal Nazarewicz <mina86@mina86.com>
---
 mm/page_alloc.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e35d06b..05eaa82 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5613,6 +5613,34 @@ static int __alloc_contig_migrate_range(unsigned long start, unsigned long end)
 	return ret;
 }
 
+/*
+ * Trigger memory pressure bump to reclaim some pages in order to be able to
+ * allocate 'count' pages in single page units. Does similar work as
+ *__alloc_pages_slowpath() function.
+ */
+static int __reclaim_pages(struct zone *zone, gfp_t gfp_mask, int count)
+{
+	enum zone_type high_zoneidx = gfp_zone(gfp_mask);
+	struct zonelist *zonelist = node_zonelist(0, gfp_mask);
+	int did_some_progress = 0;
+	int order = 1;
+	unsigned long watermark;
+
+	/* Obey watermarks as if the page was being allocated */
+	watermark = low_wmark_pages(zone) + count;
+	while (!zone_watermark_ok(zone, 0, watermark, 0, 0)) {
+		wake_all_kswapd(order, zonelist, high_zoneidx, zone_idx(zone));
+
+		did_some_progress = __perform_reclaim(gfp_mask, order, zonelist,
+						      NULL);
+		if (!did_some_progress) {
+			/* Exhausted what can be done so it's blamo time */
+			out_of_memory(zonelist, gfp_mask, order, NULL);
+		}
+	}
+	return count;
+}
+
 /**
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
@@ -5707,6 +5735,14 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		goto done;
 	}
 
+	/*
+	 * Reclaim enough pages to make sure that contiguous allocation
+	 * will not starve the system.
+	 */
+	__reclaim_pages(page_zone(pfn_to_page(outer_start)),
+		        GFP_HIGHUSER_MOVABLE, end-start);
+
+	/* Grab isolated pages from freelists. */
 	outer_end = isolate_freepages_range(outer_start, end);
 	if (!outer_end) {
 		ret = -EBUSY;
-- 
1.7.1.569.g6f426
