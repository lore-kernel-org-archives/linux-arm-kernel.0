From: mgorman@suse.de (Mel Gorman)
Date: Tue, 16 Oct 2012 09:39:27 +0100
Subject: [PATCH] mm: compaction: Correct the nr_strict_isolated check for CMA
Message-ID: <20121016083927.GG29125@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry reported that the "iron out" patch for isolate_freepages_block()
had problems due to the strict check being too strict with "mm: compaction:
Iron out isolate_freepages_block() and isolate_freepages_range() -fix1".
It's possible that more pages than necessary are isolated but the check
still fails and I missed that this fix was not picked up before RC1. This
same problem has been identified in 3.7-RC1 by Tony Prisk and should be
addressed by the following patch.

Signed-off-by: Mel Gorman <mgorman@suse.de>
Tested-by: Tony Prisk <linux@prisktech.co.nz>
---
 mm/compaction.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 2c4ce17..9eef558 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -346,7 +346,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	 * pages requested were isolated. If there were any failures, 0 is
 	 * returned and CMA will fail.
 	 */
-	if (strict && nr_strict_required != total_isolated)
+	if (strict && nr_strict_required > total_isolated)
 		total_isolated = 0;
 
 	if (locked)
