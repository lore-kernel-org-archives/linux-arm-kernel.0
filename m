From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu,  3 Dec 2015 14:04:53 -0700
Subject: [PATCH V6 17/26] coresight: adding operation mode for sink->enable()
In-Reply-To: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
References: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1449176702-13213-18-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an operation mode to sink->enable() API in order
to prevent simultaneous access from different callers.

TPIU and TMC won't be supplemented with the AUX area
API immediately and as such ignore the new mode.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 31 +++++++++++++++++++++------
 drivers/hwtracing/coresight/coresight-priv.h  |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c   |  2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  2 +-
 drivers/hwtracing/coresight/coresight.c       | 10 ++++-----
 include/linux/coresight.h                     |  2 +-
 6 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 09e306361e4f..dc4d707b28aa 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -73,9 +73,9 @@
  * @miscdev:	specifics to handle "/dev/xyz.etb" entry.
  * @spinlock:	only one at a time pls.
  * @reading:	synchronise user space access to etb buffer.
+ * @mode:	this ETB is being used.
  * @buf:	area of memory where ETB buffer content gets sent.
  * @buffer_depth: size of @buf.
- * @enable:	this ETB is being used.
  * @trigger_cntr: amount of words to store after a trigger.
  */
 struct etb_drvdata {
@@ -86,9 +86,9 @@ struct etb_drvdata {
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
 	local_t			reading;
+	local_t			mode;
 	u8			*buf;
 	u32			buffer_depth;
-	bool			enable;
 	u32			trigger_cntr;
 };
 
@@ -133,18 +133,34 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int etb_enable(struct coresight_device *csdev)
+static int etb_enable(struct coresight_device *csdev, u32 mode)
 {
-	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	u32 val;
 	unsigned long flags;
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	val = local_cmpxchg(&drvdata->mode,
+			    CS_MODE_DISABLED, mode);
+	/*
+	 * When accessing from Perf, a HW buffer can be handled
+	 * by a single trace entity.  In sysFS mode many tracers
+	 * can be logging to the same HW buffer.
+	 */
+	if (val == CS_MODE_PERF)
+		return -EBUSY;
+
+	/* Nothing to do, the tracer is already enabled. */
+	if (val == CS_MODE_SYSFS)
+		goto out;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	etb_enable_hw(drvdata);
-	drvdata->enable = true;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+out:
 	dev_info(drvdata->dev, "ETB enabled\n");
 	return 0;
+
 }
 
 static void etb_disable_hw(struct etb_drvdata *drvdata)
@@ -243,9 +259,10 @@ static void etb_disable(struct coresight_device *csdev)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	etb_disable_hw(drvdata);
 	etb_dump_hw(drvdata);
-	drvdata->enable = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+	local_set(&drvdata->mode, CS_MODE_DISABLED);
+
 	dev_info(drvdata->dev, "ETB disabled\n");
 }
 
@@ -263,7 +280,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->enable) {
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
 		etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
 		etb_enable_hw(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 932f34a84d96..333eddaed339 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -62,7 +62,7 @@ static inline void CS_UNLOCK(void __iomem *addr)
 }
 
 void coresight_disable_path(struct list_head *path);
-int coresight_enable_path(struct list_head *path);
+int coresight_enable_path(struct list_head *path, u32 mode);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct list_head *coresight_build_path(struct coresight_device *csdev);
 void coresight_release_path(struct list_head *path);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 5e2a71767870..d7e83da7a621 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -265,7 +265,7 @@ static int tmc_enable(struct tmc_drvdata *drvdata, enum tmc_mode mode)
 	return 0;
 }
 
-static int tmc_enable_sink(struct coresight_device *csdev)
+static int tmc_enable_sink(struct coresight_device *csdev, u32 mode)
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index e19b86e61c38..0a09135382f6 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -70,7 +70,7 @@ static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int tpiu_enable(struct coresight_device *csdev)
+static int tpiu_enable(struct coresight_device *csdev, u32 mode)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index c02da2edfd80..428bcd446eaf 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -121,13 +121,13 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 	return 0;
 }
 
-static int coresight_enable_sink(struct coresight_device *csdev)
+static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
 
 	if (!csdev->enable) {
 		if (sink_ops(csdev)->enable) {
-			ret = sink_ops(csdev)->enable(csdev);
+			ret = sink_ops(csdev)->enable(csdev, mode);
 			if (ret)
 				return ret;
 		}
@@ -283,7 +283,7 @@ void coresight_disable_path(struct list_head *path)
 	}
 }
 
-int coresight_enable_path(struct list_head *path)
+int coresight_enable_path(struct list_head *path, u32 mode)
 {
 
 	int ret = 0;
@@ -296,7 +296,7 @@ int coresight_enable_path(struct list_head *path)
 		switch (csdev->type) {
 		case CORESIGHT_DEV_TYPE_SINK:
 		case CORESIGHT_DEV_TYPE_LINKSINK:
-			ret = coresight_enable_sink(csdev);
+			ret = coresight_enable_sink(csdev, mode);
 			if (ret)
 				goto err;
 			break;
@@ -454,7 +454,7 @@ int coresight_enable(struct coresight_device *csdev)
 		goto out;
 	}
 
-	ret = coresight_enable_path(path);
+	ret = coresight_enable_path(path, CS_MODE_SYSFS);
 	if (ret)
 		goto err_path;
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index da242dfebdbd..2b94994d2c02 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -185,7 +185,7 @@ struct coresight_device {
  * @disable:	disables the sink.
  */
 struct coresight_ops_sink {
-	int (*enable)(struct coresight_device *csdev);
+	int (*enable)(struct coresight_device *csdev, u32 mode);
 	void (*disable)(struct coresight_device *csdev);
 };
 
-- 
2.1.4
