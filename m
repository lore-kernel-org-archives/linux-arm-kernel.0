From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:47 -0600
Subject: [PATCH 06/11] coresight: etm4x: moving etm_drvdata::enable to atomic
 field
In-Reply-To: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
References: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1459878832-15219-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similarly to ETMv3, moving etmv4_drvdata::enable to an atomic
type that gives the 'mode' of a tracer and prevents multiple,
simultanious access by different subsystems.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 69 +++++++++++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h |  5 +-
 2 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 92524fe1aa6c..9f51a8f47650 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/perf_event.h>
 #include <asm/sections.h>
+#include <asm/local.h>
 
 #include "coresight-etm4x.h"
 
@@ -76,7 +77,7 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	unsigned long flags;
 	int trace_id = -1;
 
-	if (!drvdata->enable)
+	if (!local_read(&drvdata->mode))
 		return drvdata->trcid;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
@@ -188,8 +189,7 @@ static void etm4_enable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
 }
 
-static int etm4_enable(struct coresight_device *csdev,
-		       struct perf_event_attr *attr, u32 mode)
+static int etm4_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
@@ -204,18 +204,46 @@ static int etm4_enable(struct coresight_device *csdev,
 				       etm4_enable_hw, drvdata, 1);
 	if (ret)
 		goto err;
-	drvdata->enable = true;
-	drvdata->sticky_enable = true;
 
+	drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
 	dev_info(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
+
 err:
 	spin_unlock(&drvdata->spinlock);
 	return ret;
 }
 
+static int etm4_enable(struct coresight_device *csdev,
+		       struct perf_event_attr *attr, u32 mode)
+{
+	int ret;
+	u32 val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+
+	/* Someone is already using the tracer */
+	if (val)
+		return -EBUSY;
+
+	switch (mode) {
+	case CS_MODE_SYSFS:
+		ret = etm4_enable_sysfs(csdev);
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
 static void etm4_disable_hw(void *info)
 {
 	u32 control;
@@ -238,7 +266,7 @@ static void etm4_disable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
-static void etm4_disable(struct coresight_device *csdev)
+static void etm4_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -256,7 +284,6 @@ static void etm4_disable(struct coresight_device *csdev)
 	 * ensures that register writes occur when cpu is powered.
 	 */
 	smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
-	drvdata->enable = false;
 
 	spin_unlock(&drvdata->spinlock);
 	put_online_cpus();
@@ -264,6 +291,30 @@ static void etm4_disable(struct coresight_device *csdev)
 	dev_info(drvdata->dev, "ETM tracing disabled\n");
 }
 
+static void etm4_disable(struct coresight_device *csdev)
+{
+	u32 mode;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
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
+		etm4_disable_sysfs(csdev);
+		break;
+	}
+
+	if (mode)
+		local_set(&drvdata->mode, CS_MODE_DISABLED);
+}
+
 static const struct coresight_ops_source etm4_source_ops = {
 	.cpu_id		= etm4_cpu_id,
 	.trace_id	= etm4_trace_id,
@@ -531,7 +582,7 @@ static int etm4_cpu_callback(struct notifier_block *nfb, unsigned long action,
 			etmdrvdata[cpu]->os_unlock = true;
 		}
 
-		if (etmdrvdata[cpu]->enable)
+		if (local_read(&etmdrvdata[cpu]->mode))
 			etm4_enable_hw(etmdrvdata[cpu]);
 		spin_unlock(&etmdrvdata[cpu]->spinlock);
 		break;
@@ -544,7 +595,7 @@ static int etm4_cpu_callback(struct notifier_block *nfb, unsigned long action,
 
 	case CPU_DYING:
 		spin_lock(&etmdrvdata[cpu]->spinlock);
-		if (etmdrvdata[cpu]->enable)
+		if (local_read(&etmdrvdata[cpu]->mode))
 			etm4_disable_hw(etmdrvdata[cpu]);
 		spin_unlock(&etmdrvdata[cpu]->spinlock);
 		break;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 6ff499bfb2f2..f7748ae63451 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -13,6 +13,7 @@
 #ifndef _CORESIGHT_CORESIGHT_ETM_H
 #define _CORESIGHT_CORESIGHT_ETM_H
 
+#include <asm/local.h>
 #include <linux/spinlock.h>
 #include "coresight-priv.h"
 
@@ -290,6 +291,7 @@ struct etmv4_config {
  * @dev:        The device entity associated to this component.
  * @csdev:      Component vitals needed by the framework.
  * @spinlock:   Only one at a time pls.
+ * @mode:	This tracer's mode, i.e sysFS, Perf or disabled.
  * @cpu:        The cpu this component is affined to.
  * @arch:       ETM version number.
  * @nr_pe:	The number of processing entity available for tracing.
@@ -316,7 +318,6 @@ struct etmv4_config {
  *		supported for the corresponding Exception level.
  * @ns_ex_level:In non-secure state, indicates whether instruction tracing is
  *		supported for the corresponding Exception level.
- * @enable:	Is this ETM currently tracing.
  * @sticky_enable: true if ETM base configuration has been done.
  * @boot_enable:True if we should start tracing at boot time.
  * @os_unlock:  True if access to management registers is allowed.
@@ -346,6 +347,7 @@ struct etmv4_drvdata {
 	struct device			*dev;
 	struct coresight_device		*csdev;
 	spinlock_t			spinlock;
+	local_t				mode;
 	int				cpu;
 	u8				arch;
 	u8				nr_pe;
@@ -368,7 +370,6 @@ struct etmv4_drvdata {
 	u8				ccitmin;
 	u8				s_ex_level;
 	u8				ns_ex_level;
-	bool				enable;
 	bool				sticky_enable;
 	bool				boot_enable;
 	bool				os_unlock;
-- 
2.1.4
