From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 14 Aug 2018 16:14:26 -0600
Subject: [PATCH 2/2] coresight: etb10: Splitting function etb_enable()
In-Reply-To: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
References: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1534284866-2523-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up until now the relative simplicity of enabling the ETB made it
possible to accommodate processing for both sysFS and perf methods.
But work on claimtags and CPU-wide trace scenarios is adding some
complexity, making the current code messy and hard to maintain.

As such follow what has been done for ETF and ETR components and split
function etb_enable() so that processing for both API can be done
cleanly.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 73 +++++++++++++++++++--------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 69287163ce4e..08fa660098f8 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -134,7 +134,7 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
+static int etb_enable_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -142,48 +142,79 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/*
-	 * When accessing from Perf, a HW buffer can be handled
-	 * by a single trace entity.  In sysFS mode many tracers
-	 * can be logging to the same HW buffer.
-	 */
+	/* Don't messup with perf sessions. */
 	if (drvdata->mode == CS_MODE_PERF) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	/* Don't let perf disturb sysFS sessions */
-	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_PERF) {
-		ret = -EBUSY;
+	/* Nothing to do, the tracer is already enabled. */
+	if (drvdata->mode == CS_MODE_SYSFS)
 		goto out;
-	}
 
-	/* Nothing to do, the tracer is already enabled. */
-	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_SYSFS)
+	drvdata->mode = CS_MODE_SYSFS;
+	etb_enable_hw(drvdata);
+
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
+
+static int etb_enable_perf(struct coresight_device *csdev, void *data)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* No need to continue if the component is already in use. */
+	if (drvdata->mode != CS_MODE_DISABLED) {
+		ret = -EBUSY;
 		goto out;
+	}
 
 	/*
 	 * We don't have an internal state to clean up if we fail to setup
 	 * the perf buffer. So we can perform the step before we turn the
 	 * ETB on and leave without cleaning up.
 	 */
-	if (mode == CS_MODE_PERF) {
-		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
-		if (ret)
-			goto out;
-	}
+	ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
+	if (ret)
+		goto out;
 
-	drvdata->mode = mode;
+	drvdata->mode = CS_MODE_PERF;
 	etb_enable_hw(drvdata);
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-	if (!ret)
-		dev_dbg(drvdata->dev, "ETB enabled\n");
 	return ret;
 }
 
+static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
+{
+	int ret;
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	switch (mode) {
+	case CS_MODE_SYSFS:
+		ret = etb_enable_sysfs(csdev);
+		break;
+	case CS_MODE_PERF:
+		ret = etb_enable_perf(csdev, data);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		return ret;
+
+	dev_dbg(drvdata->dev, "ETB enabled\n");
+	return 0;
+}
+
 static void etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	u32 ffcr;
-- 
2.7.4
