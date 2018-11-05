From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Nov 2018 15:26:28 -0700
Subject: [PATCH 1/3] coresight: etb10: Add support for CLAIM tag
In-Reply-To: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1541456790-28282-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following in the footstep of what was done for other CoreSight devices,
add CLAIM tag support to ETB10 in order to synchronise access to the
HW between the kernel and an external agent.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 824be0c5f592..105782ea64c7 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -136,6 +136,11 @@ static void __etb_enable_hw(struct etb_drvdata *drvdata)
 
 static int etb_enable_hw(struct etb_drvdata *drvdata)
 {
+	int rc = coresight_claim_device(drvdata->base);
+
+	if (rc)
+		return rc;
+
 	__etb_enable_hw(drvdata);
 	return 0;
 }
@@ -223,7 +228,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 	return 0;
 }
 
-static void etb_disable_hw(struct etb_drvdata *drvdata)
+static void __etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	u32 ffcr;
 
@@ -313,6 +318,13 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static void etb_disable_hw(struct etb_drvdata *drvdata)
+{
+	__etb_disable_hw(drvdata);
+	etb_dump_hw(drvdata);
+	coresight_disclaim_device(drvdata->base);
+}
+
 static void etb_disable(struct coresight_device *csdev)
 {
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -323,7 +335,6 @@ static void etb_disable(struct coresight_device *csdev)
 	/* Disable the ETB only if it needs to */
 	if (drvdata->mode != CS_MODE_DISABLED) {
 		etb_disable_hw(drvdata);
-		etb_dump_hw(drvdata);
 		drvdata->mode = CS_MODE_DISABLED;
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -402,7 +413,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
-	etb_disable_hw(drvdata);
+	__etb_disable_hw(drvdata);
 	CS_UNLOCK(drvdata->base);
 
 	/* unit is in words, not bytes */
@@ -510,7 +521,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 		handle->head = (cur * PAGE_SIZE) + offset;
 		to_read = buf->nr_pages << PAGE_SHIFT;
 	}
-	etb_enable_hw(drvdata);
+	__etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
 
 	return to_read;
@@ -534,9 +545,9 @@ static void etb_dump(struct etb_drvdata *drvdata)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->mode == CS_MODE_SYSFS) {
-		etb_disable_hw(drvdata);
+		__etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
-		etb_enable_hw(drvdata);
+		__etb_enable_hw(drvdata);
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-- 
2.7.4
