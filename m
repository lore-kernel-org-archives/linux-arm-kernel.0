From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 22 Feb 2012 17:48:52 +0100
Subject: [PATCHv23 11/16] mm: extract reclaim code from
 __alloc_pages_direct_reclaim()
In-Reply-To: <1329929337-16648-1-git-send-email-m.szyprowski@samsung.com>
References: <1329929337-16648-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1329929337-16648-12-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extracts common reclaim code from __alloc_pages_direct_reclaim()
function to separate function: __perform_reclaim() which can be later used
by alloc_contig_range().

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Michal Nazarewicz <mina86@mina86.com>
Acked-by: Mel Gorman <mel@csn.ul.ie>
Tested-by: Rob Clark <rob.clark@linaro.org>
Tested-by: Ohad Ben-Cohen <ohad@wizery.com>
Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Robert Nelson <robertcnelson@gmail.com>
---
 mm/page_alloc.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0aa8079..7a0d286 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2143,16 +2143,13 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 }
 #endif /* CONFIG_COMPACTION */
 
-/* The really slow allocator path where we enter direct reclaim */
-static inline struct page *
-__alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
-	struct zonelist *zonelist, enum zone_type high_zoneidx,
-	nodemask_t *nodemask, int alloc_flags, struct zone *preferred_zone,
-	int migratetype, unsigned long *did_some_progress)
+/* Perform direct synchronous page reclaim */
+static int
+__perform_reclaim(gfp_t gfp_mask, unsigned int order, struct zonelist *zonelist,
+		  nodemask_t *nodemask)
 {
-	struct page *page = NULL;
 	struct reclaim_state reclaim_state;
-	bool drained = false;
+	int progress;
 
 	cond_resched();
 
@@ -2163,7 +2160,7 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 	reclaim_state.reclaimed_slab = 0;
 	current->reclaim_state = &reclaim_state;
 
-	*did_some_progress = try_to_free_pages(zonelist, order, gfp_mask, nodemask);
+	progress = try_to_free_pages(zonelist, order, gfp_mask, nodemask);
 
 	current->reclaim_state = NULL;
 	lockdep_clear_current_reclaim_state();
@@ -2171,6 +2168,21 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 
 	cond_resched();
 
+	return progress;
+}
+
+/* The really slow allocator path where we enter direct reclaim */
+static inline struct page *
+__alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
+	struct zonelist *zonelist, enum zone_type high_zoneidx,
+	nodemask_t *nodemask, int alloc_flags, struct zone *preferred_zone,
+	int migratetype, unsigned long *did_some_progress)
+{
+	struct page *page = NULL;
+	bool drained = false;
+
+	*did_some_progress = __perform_reclaim(gfp_mask, order, zonelist,
+					       nodemask);
 	if (unlikely(!(*did_some_progress)))
 		return NULL;
 
-- 
1.7.1.569.g6f426
