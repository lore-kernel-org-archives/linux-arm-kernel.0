From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  5 Jun 2012 12:27:01 -0700
Subject: [PATCH][RFC] mm: Don't put CMA pages on per-cpu lists
Message-ID: <1338924421-7942-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when freeing 0 order pages, CMA pages are treated
the same as regular movable pages, which means they end up
on the per-cpu page list. This means that the CMA pages are
likely to be allocated for something other than contigous
memory. This increases the chance that the next alloc_contig_range
will fail because pages can't be migrated.

Given the size of the CMA region is typically limited, it is best to
optimize for success of alloc_contig_range as much as possible.
Do this by freeing CMA pages directly instead of putting them
on the per-cpu page lists.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 mm/page_alloc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e1c6f5..c9a6483 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1310,7 +1310,8 @@ void free_hot_cold_page(struct page *page, int cold)
 	 * excessively into the page allocator
 	 */
 	if (migratetype >= MIGRATE_PCPTYPES) {
-		if (unlikely(migratetype == MIGRATE_ISOLATE)) {
+		if (unlikely(migratetype == MIGRATE_ISOLATE)
+		   || is_migrate_cma(migratetype)) {
 			free_one_page(zone, page, 0, migratetype);
 			goto out;
 		}
-- 
1.7.8.3
