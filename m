From: mashimiao.fnst@cn.fujitsu.com (Ma Shimiao)
Date: Tue, 12 Dec 2017 17:29:35 +0800
Subject: [PATCH] divers/soc/ti: fix max dup length for kstrndup
Message-ID: <20171212092935.20211-1-mashimiao.fnst@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If source string longer than max, kstrndup will alloc max+1 space.
So, we should make sure the result will not over limit.

Signed-off-by: Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 39225de9d7f1..77d6b5c03aae 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -225,7 +225,7 @@ static struct knav_queue *__knav_queue_open(struct knav_queue_inst *inst,
 	if (!knav_queue_is_busy(inst)) {
 		struct knav_range_info *range = inst->range;
 
-		inst->name = kstrndup(name, KNAV_NAME_SIZE, GFP_KERNEL);
+		inst->name = kstrndup(name, KNAV_NAME_SIZE - 1, GFP_KERNEL);
 		if (range->ops && range->ops->open_queue)
 			ret = range->ops->open_queue(range, inst, flags);
 
@@ -779,7 +779,7 @@ void *knav_pool_create(const char *name,
 		goto err;
 	}
 
-	pool->name = kstrndup(name, KNAV_NAME_SIZE, GFP_KERNEL);
+	pool->name = kstrndup(name, KNAV_NAME_SIZE - 1, GFP_KERNEL);
 	pool->kdev = kdev;
 	pool->dev = kdev->dev;
 
-- 
2.13.6
