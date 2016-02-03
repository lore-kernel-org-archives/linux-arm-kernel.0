From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  3 Feb 2016 11:39:13 -0700
Subject: [PATCH V9 15/18] coresight: etb10: adding operation mode for
 sink->enable()
In-Reply-To: <1454524756-10628-1-git-send-email-mathieu.poirier@linaro.org>
References: <1454524756-10628-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1454524756-10628-16-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an operation mode to the sink->enable() API in order
to prevent simultaneous access from different callers.

TPIU and TMC won't be supplemented with the AUX area
API immediately and as such ignore the new mode.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 30 ++++++++++++++++++++-------
 drivers/hwtracing/coresight/coresight-priv.h  |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c   |  2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  2 +-
 drivers/hwtracing/coresight/coresight.c       | 10 ++++-----
 include/linux/coresight.h                     |  2 +-
 6 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 162c9ccc8c33..79099f95ba3f 100644
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
 
@@ -133,16 +133,31 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
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
 }
@@ -243,9 +258,10 @@ static void etb_disable(struct coresight_device *csdev)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	etb_disable_hw(drvdata);
 	etb_dump_hw(drvdata);
-	drvdata->enable = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+	local_set(&drvdata->mode, CS_MODE_DISABLED);
+
 	dev_info(drvdata->dev, "ETB disabled\n");
 }
 
@@ -263,7 +279,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
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
index b526396d80b6..ac91b0b40ec2 100644
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
index 0d8fce651ff7..71582f6dfd4c 100644
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
index 95cccb179763..6ec2b66af9ee 100644
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
index 6801dd64ee5d..9fa92dcdd2ea 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -186,7 +186,7 @@ struct coresight_device {
  * @disable:	disables the sink.
  */
 struct coresight_ops_sink {
-	int (*enable)(struct coresight_device *csdev);
+	int (*enable)(struct coresight_device *csdev, u32 mode);
 	void (*disable)(struct coresight_device *csdev);
 };
 
-- 
2.1.4
