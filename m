From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 14 Aug 2018 16:14:25 -0600
Subject: [PATCH 1/2] coresight: etb10: Refactor etb_drvdata::mode handling
Message-ID: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the etb_drvdata::mode from a locat_t to a simple u32,
as it is for the ETF and ETR drivers.  This streamlines the code and adds
commonality with the other drivers when dealing with similar operations.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 62 +++++++++++++++------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 9fd77fdc1244..69287163ce4e 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -5,7 +5,6 @@
  * Description: CoreSight Embedded Trace Buffer driver
  */
 
-#include <asm/local.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -72,8 +71,8 @@
  * @miscdev:	specifics to handle "/dev/xyz.etb" entry.
  * @spinlock:	only one at a time pls.
  * @reading:	synchronise user space access to etb buffer.
- * @mode:	this ETB is being used.
  * @buf:	area of memory where ETB buffer content gets sent.
+ * @mode:	this ETB is being used.
  * @buffer_depth: size of @buf.
  * @trigger_cntr: amount of words to store after a trigger.
  */
@@ -85,8 +84,8 @@ struct etb_drvdata {
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
 	local_t			reading;
-	local_t			mode;
 	u8			*buf;
+	u32			mode;
 	u32			buffer_depth;
 	u32			trigger_cntr;
 };
@@ -138,44 +137,48 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 {
 	int ret = 0;
-	u32 val;
 	unsigned long flags;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	/*
-	 * We don't have an internal state to clean up if we fail to setup
-	 * the perf buffer. So we can perform the step before we turn the
-	 * ETB on and leave without cleaning up.
-	 */
-	if (mode == CS_MODE_PERF) {
-		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
-		if (ret)
-			goto out;
-	}
+	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	val = local_cmpxchg(&drvdata->mode,
-			    CS_MODE_DISABLED, mode);
 	/*
 	 * When accessing from Perf, a HW buffer can be handled
 	 * by a single trace entity.  In sysFS mode many tracers
 	 * can be logging to the same HW buffer.
 	 */
-	if (val == CS_MODE_PERF)
-		return -EBUSY;
+	if (drvdata->mode == CS_MODE_PERF) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	/* Don't let perf disturb sysFS sessions */
-	if (val == CS_MODE_SYSFS && mode == CS_MODE_PERF)
-		return -EBUSY;
+	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_PERF) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	/* Nothing to do, the tracer is already enabled. */
-	if (val == CS_MODE_SYSFS)
+	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_SYSFS)
 		goto out;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	/*
+	 * We don't have an internal state to clean up if we fail to setup
+	 * the perf buffer. So we can perform the step before we turn the
+	 * ETB on and leave without cleaning up.
+	 */
+	if (mode == CS_MODE_PERF) {
+		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
+		if (ret)
+			goto out;
+	}
+
+	drvdata->mode = mode;
 	etb_enable_hw(drvdata);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
 	if (!ret)
 		dev_dbg(drvdata->dev, "ETB enabled\n");
 	return ret;
@@ -277,11 +280,14 @@ static void etb_disable(struct coresight_device *csdev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	etb_disable_hw(drvdata);
-	etb_dump_hw(drvdata);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	local_set(&drvdata->mode, CS_MODE_DISABLED);
+	/* Disable the ETB only if it needs to */
+	if (drvdata->mode != CS_MODE_DISABLED) {
+		etb_disable_hw(drvdata);
+		etb_dump_hw(drvdata);
+		drvdata->mode = CS_MODE_DISABLED;
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(drvdata->dev, "ETB disabled\n");
 }
@@ -488,7 +494,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
+	if (drvdata->mode == CS_MODE_SYSFS) {
 		etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
 		etb_enable_hw(drvdata);
-- 
2.7.4
