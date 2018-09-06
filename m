From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu,  6 Sep 2018 10:08:28 +0100
Subject: [PATCH v2 07/14] coresight: etb10: Handle errors enabling the device
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1536224915-31766-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the etb10 driver to return errors in enabling
the device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
 - Rebased to the coresight/next
---
 drivers/hwtracing/coresight/coresight-etb10.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 08fa660..824be0c 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -106,7 +106,7 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
 	return depth;
 }
 
-static void etb_enable_hw(struct etb_drvdata *drvdata)
+static void __etb_enable_hw(struct etb_drvdata *drvdata)
 {
 	int i;
 	u32 depth;
@@ -134,6 +134,12 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int etb_enable_hw(struct etb_drvdata *drvdata)
+{
+	__etb_enable_hw(drvdata);
+	return 0;
+}
+
 static int etb_enable_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
@@ -152,8 +158,9 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 	if (drvdata->mode == CS_MODE_SYSFS)
 		goto out;
 
-	drvdata->mode = CS_MODE_SYSFS;
-	etb_enable_hw(drvdata);
+	ret = etb_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -183,8 +190,9 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	if (ret)
 		goto out;
 
-	drvdata->mode = CS_MODE_PERF;
-	etb_enable_hw(drvdata);
+	ret = etb_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_PERF;
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-- 
2.7.4
