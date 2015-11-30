From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 29 Nov 2015 19:14:29 -0700
Subject: [PATCH V5 08/26] coresight: etm3x: adding operation mode for
 etm_enable()
In-Reply-To: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
References: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1448849687-5724-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a new mode to source API enable() in order to
distinguish where the request comes from.  That way it is
possible to perform different operations based on where
the request was issued from.

The ETM4x driver is also modified to keep in sync with the
new interface.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h        |  5 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  4 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      | 69 +++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.c      |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h       |  6 ++
 drivers/hwtracing/coresight/coresight.c            |  6 +-
 include/linux/coresight.h                          |  2 +-
 7 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 9317510d555f..a8663780a908 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -13,6 +13,7 @@
 #ifndef _CORESIGHT_CORESIGHT_ETM_H
 #define _CORESIGHT_CORESIGHT_ETM_H
 
+#include <asm/local.h>
 #include <linux/spinlock.h>
 #include "coresight-priv.h"
 
@@ -214,7 +215,7 @@ struct etm_config {
  * @port_size:	port size as reported by ETMCR bit 4-6 and 21.
  * @arch:	ETM/PTM version number.
  * @use_cpu14:	true if management registers need to be accessed via CP14.
- * @enable:	is this ETM/PTM currently tracing.
+ * @mode:	this tracer's mode, i.e sysFS, Perf or disabled.
  * @sticky_enable: true if ETM base configuration has been done.
  * @boot_enable:true if we should start tracing at boot time.
  * @os_unlock:	true if access to management registers is allowed.
@@ -238,7 +239,7 @@ struct etm_drvdata {
 	int				port_size;
 	u8				arch;
 	bool				use_cp14;
-	bool				enable;
+	local_t				mode;
 	bool				sticky_enable;
 	bool				boot_enable;
 	bool				os_unlock;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 410d29e2b90c..6da50d94ec6f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -811,7 +811,7 @@ static ssize_t cntr_val_show(struct device *dev,
 	if (WARN_ON_ONCE(!config))
 		return -EINVAL;
 
-	if (!drvdata->enable) {
+	if (!local_read(&drvdata->mode)) {
 		spin_lock(&drvdata->spinlock);
 		for (i = 0; i < drvdata->nr_cntr; i++)
 			ret += sprintf(buf, "counter %d: %x\n",
@@ -1072,7 +1072,7 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	if (WARN_ON_ONCE(!config))
 		return -EINVAL;
 
-	if (!drvdata->enable) {
+	if (!local_read(&drvdata->mode)) {
 		val = config->seq_curr_state;
 		goto out;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index f3c9846d0f7f..0035953a1102 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -327,7 +327,7 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
 	if (!drvdata)
 		goto out;
 
-	if (!drvdata->enable)
+	if (!local_read(&drvdata->mode))
 		return drvdata->traceid;
 
 	pm_runtime_get_sync(drvdata->dev);
@@ -353,7 +353,7 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
-static int etm_enable(struct coresight_device *csdev)
+static int etm_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
@@ -372,22 +372,49 @@ static int etm_enable(struct coresight_device *csdev)
 			goto err;
 	}
 
-	drvdata->enable = true;
 	drvdata->sticky_enable = true;
-
 	spin_unlock(&drvdata->spinlock);
 
 	dev_info(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
+
 err:
 	spin_unlock(&drvdata->spinlock);
 	return ret;
 }
 
+static int etm_enable(struct coresight_device *csdev, u32 mode)
+{
+	int ret;
+	u32 val;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+
+	/* Someone is already using the tracer */
+	if (val)
+		return -EBUSY;
+
+	switch (mode) {
+	case CS_MODE_SYSFS:
+		ret = etm_enable_sysfs(csdev);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	/* The tracer didn't start */
+	if (ret)
+		local_set(&drvdata->mode, CS_MODE_DISABLED);
+
+	return ret;
+}
+
 static void etm_disable_hw(void *info)
 {
 	int i;
 	struct etm_drvdata *drvdata = info;
+	struct etm_config *config = get_etm_config(drvdata);
 
 	if (WARN_ON_ONCE(!config))
 		return;
@@ -413,7 +440,7 @@ static void etm_disable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
-static void etm_disable(struct coresight_device *csdev)
+static void etm_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etm_config *config = get_etm_config(drvdata);
@@ -432,7 +459,6 @@ static void etm_disable(struct coresight_device *csdev)
 	 * ensures that register writes occur when cpu is powered.
 	 */
 	smp_call_function_single(drvdata->cpu, etm_disable_hw, drvdata, 1);
-	drvdata->enable = false;
 	kfree(config);
 
 	spin_unlock(&drvdata->spinlock);
@@ -441,6 +467,33 @@ static void etm_disable(struct coresight_device *csdev)
 	dev_info(drvdata->dev, "ETM tracing disabled\n");
 }
 
+static void etm_disable(struct coresight_device *csdev)
+{
+	u32 mode;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	/*
+	 * For as long as the tracer isn't disabled another entity can't
+	 * change its status.  As such we can read the status here without
+	 * fearing it will change under us.
+	 */
+	mode = local_read(&drvdata->mode);
+
+	switch (mode) {
+	case CS_MODE_DISABLED:
+		break;
+	case CS_MODE_SYSFS:
+		etm_disable_sysfs(csdev);
+		break;
+	default:
+		WARN_ON_ONCE(mode);
+		return;
+	}
+
+	if (mode)
+		local_set(&drvdata->mode, CS_MODE_DISABLED);
+}
+
 static const struct coresight_ops_source etm_source_ops = {
 	.cpu_id		= etm_cpu_id,
 	.trace_id	= etm_trace_id,
@@ -468,7 +521,7 @@ static int etm_cpu_callback(struct notifier_block *nfb, unsigned long action,
 			etmdrvdata[cpu]->os_unlock = true;
 		}
 
-		if (etmdrvdata[cpu]->enable)
+		if (local_read(&etmdrvdata[cpu]->mode))
 			etm_enable_hw(etmdrvdata[cpu]);
 		spin_unlock(&etmdrvdata[cpu]->spinlock);
 		break;
@@ -481,7 +534,7 @@ static int etm_cpu_callback(struct notifier_block *nfb, unsigned long action,
 
 	case CPU_DYING:
 		spin_lock(&etmdrvdata[cpu]->spinlock);
-		if (etmdrvdata[cpu]->enable)
+		if (local_read(&etmdrvdata[cpu]->mode))
 			etm_disable_hw(etmdrvdata[cpu]);
 		spin_unlock(&etmdrvdata[cpu]->spinlock);
 		break;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 1c6e32dd6e49..4ab291b3a6c8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -180,7 +180,7 @@ static void etm4_enable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
 }
 
-static int etm4_enable(struct coresight_device *csdev)
+static int etm4_enable(struct coresight_device *csdev, u32 mode)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 7b193a34d709..2dc59a5c5b1e 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -34,6 +34,12 @@
 #define TIMEOUT_US		100
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
 
+enum cs_mode {
+	CS_MODE_DISABLED,
+	CS_MODE_SYSFS,
+	CS_MODE_PERF,
+};
+
 static inline void CS_LOCK(void __iomem *addr)
 {
 	do {
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e63e42410ad2..4e326d792100 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -222,7 +222,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	csdev->enable = false;
 }
 
-static int coresight_enable_source(struct coresight_device *csdev)
+static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
 
@@ -234,7 +234,7 @@ static int coresight_enable_source(struct coresight_device *csdev)
 
 	if (!csdev->enable) {
 		if (source_ops(csdev)->enable) {
-			ret = source_ops(csdev)->enable(csdev);
+			ret = source_ops(csdev)->enable(csdev, mode);
 			if (ret)
 				return ret;
 		}
@@ -443,7 +443,7 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto err_path;
 
-	ret = coresight_enable_source(csdev);
+	ret = coresight_enable_source(csdev, CS_MODE_SYSFS);
 	if (ret)
 		goto err_source;
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 851ecb22397e..61dfb8d511ea 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -213,7 +213,7 @@ struct coresight_ops_link {
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
-	int (*enable)(struct coresight_device *csdev);
+	int (*enable)(struct coresight_device *csdev, u32 mode);
 	void (*disable)(struct coresight_device *csdev);
 };
 
-- 
2.1.4
