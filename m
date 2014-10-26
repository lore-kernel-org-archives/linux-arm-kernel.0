From: axel.lin@ingics.com (Axel Lin)
Date: Sun, 26 Oct 2014 17:37:44 +0800
Subject: [PATCH 1/3] soc: ti: Use list_first_entry_or_null() at appropriate
 places
Message-ID: <1414316264.4290.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use list_first_entry_or_null() for first_region() and first_queue_range().

list_first_entry() expects the list is not empty, so first_region() and
first_queue_range() never return NULL.
Thus use list_first_entry_or_null() instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/soc/ti/knav_qmss.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index bc9dcc8..51da234 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -348,15 +348,15 @@ struct knav_range_info {
 	list_for_each_entry(region, &kdev->regions, list)
 
 #define first_region(kdev)					\
-	list_first_entry(&kdev->regions, \
-			struct knav_region, list)
+	list_first_entry_or_null(&kdev->regions, \
+				 struct knav_region, list)
 
 #define for_each_queue_range(kdev, range)			\
 	list_for_each_entry(range, &kdev->queue_ranges, list)
 
 #define first_queue_range(kdev)					\
-	list_first_entry(&kdev->queue_ranges, \
-			struct knav_range_info, list)
+	list_first_entry_or_null(&kdev->queue_ranges, \
+				 struct knav_range_info, list)
 
 #define for_each_pool(kdev, pool)				\
 	list_for_each_entry(pool, &kdev->pools, list)
-- 
1.9.1
