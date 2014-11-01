From: axel.lin@ingics.com (Axel Lin)
Date: Sat, 01 Nov 2014 13:33:13 +0800
Subject: [PATCH] soc: ti: knav_qmss_queue: Use list_for_each_entry_safe to
 prevent use after free
Message-ID: <1414819993.23500.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

list_for_each_entry_safe() is necessary if list objects are deleted from
the list while traversing it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6f22d56..9b8dd67 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1306,14 +1306,14 @@ static void knav_free_queue_ranges(struct knav_device *kdev)
 static void knav_queue_free_regions(struct knav_device *kdev)
 {
 	struct knav_region *region;
-	struct knav_pool *pool;
+	struct knav_pool *pool, *tmp;
 	unsigned size;
 
 	for (;;) {
 		region = first_region(kdev);
 		if (!region)
 			break;
-		list_for_each_entry(pool, &region->pools, region_inst)
+		list_for_each_entry_safe(pool, tmp, &region->pools, region_inst)
 			knav_pool_destroy(pool);
 
 		size = region->virt_end - region->virt_start;
-- 
1.9.1
