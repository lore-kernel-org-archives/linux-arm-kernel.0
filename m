From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  3 Feb 2016 11:39:11 -0700
Subject: [PATCH V9 13/18] coresight: etm3x: implementing perf_enable/disable()
 API
In-Reply-To: <1454524756-10628-1-git-send-email-mathieu.poirier@linaro.org>
References: <1454524756-10628-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1454524756-10628-14-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That way traces can be enabled and disabled automatically
from the Perf subystem using the PMU abstraction.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  1 +
 drivers/hwtracing/coresight/coresight-etm3x.c | 95 +++++++++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-etm4x.c |  4 +-
 drivers/hwtracing/coresight/coresight.c       |  2 +-
 include/linux/coresight.h                     |  6 +-
 5 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index c85935f3525a..db0541031c72 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -4,6 +4,7 @@
 menuconfig CORESIGHT
 	bool "CoreSight Tracing Support"
 	select ARM_AMBA
+	select PERF_EVENTS
 	help
 	  This framework provides a kernel interface for the CoreSight debug
 	  and trace drivers to register themselves with. It's intended to build
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index c82d545e68ef..a9b820ec16aa 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -31,6 +31,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/clk.h>
+#include <linux/perf_event.h>
 #include <asm/sections.h>
 
 #include "coresight-etm.h"
@@ -297,6 +298,47 @@ void etm_config_trace_mode(struct etm_config *config)
 	config->addr_type[1] = ETM_ADDR_TYPE_RANGE;
 }
 
+#define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN)
+
+static int etm_parse_event_config(struct etm_drvdata *drvdata,
+				  struct perf_event_attr *attr)
+{
+	struct etm_config *config = &drvdata->config;
+
+	if (!attr)
+		return -EINVAL;
+
+	/* Clear configuration from previous run */
+	memset(config, 0, sizeof(struct etm_config));
+
+	if (attr->exclude_kernel)
+		config->mode = ETM_MODE_EXCL_KERN;
+
+	if (attr->exclude_user)
+		config->mode = ETM_MODE_EXCL_USER;
+
+	/* Always start from the default config */
+	etm_set_default(config);
+
+	/*
+	 * By default the tracers are configured to trace the whole address
+	 * range.  Narrow the field only if requested by user space.
+	 */
+	if (config->mode)
+		etm_config_trace_mode(config);
+
+	/*
+	 * At this time only cycle accurate and timestamp options are
+	 * available.
+	 */
+	if (attr->config & ~ETM3X_SUPPORTED_OPTIONS)
+		return -EINVAL;
+
+	config->ctrl = attr->config;
+
+	return 0;
+}
+
 static void etm_enable_hw(void *info)
 {
 	int i;
@@ -316,8 +358,10 @@ static void etm_enable_hw(void *info)
 	etm_set_prog(drvdata);
 
 	etmcr = etm_readl(drvdata, ETMCR);
-	etmcr &= (ETMCR_PWD_DWN | ETMCR_ETM_PRG);
+	/* Clear setting from a previous run if need be */
+	etmcr &= ~ETM3X_SUPPORTED_OPTIONS;
 	etmcr |= drvdata->port_size;
+	etmcr |= ETMCR_ETM_EN;
 	etm_writel(drvdata, config->ctrl | etmcr, ETMCR);
 	etm_writel(drvdata, config->trigger_event, ETMTRIGGER);
 	etm_writel(drvdata, config->startstop_ctrl, ETMTSSCR);
@@ -357,9 +401,6 @@ static void etm_enable_hw(void *info)
 	/* No VMID comparator value selected */
 	etm_writel(drvdata, 0x0, ETMVMIDCVR);
 
-	/* Ensures trace output is enabled from this ETM */
-	etm_writel(drvdata, config->ctrl | ETMCR_ETM_EN | etmcr, ETMCR);
-
 	etm_clr_prog(drvdata);
 	CS_LOCK(drvdata->base);
 
@@ -407,6 +448,22 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
+static int etm_enable_perf(struct coresight_device *csdev,
+			   struct perf_event_attr *attr)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
+		return -EINVAL;
+
+	/* Configure the tracer based on the session's specifics */
+	etm_parse_event_config(drvdata, attr);
+	/* And enable it */
+	etm_enable_hw(drvdata);
+
+	return 0;
+}
+
 static int etm_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -437,7 +494,8 @@ err:
 	return ret;
 }
 
-static int etm_enable(struct coresight_device *csdev, u32 mode)
+static int etm_enable(struct coresight_device *csdev,
+		      struct perf_event_attr *attr, u32 mode)
 {
 	int ret;
 	u32 val;
@@ -453,6 +511,9 @@ static int etm_enable(struct coresight_device *csdev, u32 mode)
 	case CS_MODE_SYSFS:
 		ret = etm_enable_sysfs(csdev);
 		break;
+	case CS_MODE_PERF:
+		ret = etm_enable_perf(csdev, attr);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -485,6 +546,27 @@ static void etm_disable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
+static void etm_disable_perf(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
+		return;
+
+	CS_UNLOCK(drvdata->base);
+
+	/* Setting the prog bit disables tracing immediately */
+	etm_set_prog(drvdata);
+
+	/*
+	 * There is no way to know when the tracer will be used again so
+	 * power down the tracer.
+	 */
+	etm_set_pwrdwn(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
 static void etm_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -528,6 +610,9 @@ static void etm_disable(struct coresight_device *csdev)
 	case CS_MODE_SYSFS:
 		etm_disable_sysfs(csdev);
 		break;
+	case CS_MODE_PERF:
+		etm_disable_perf(csdev);
+		break;
 	default:
 		WARN_ON_ONCE(mode);
 		return;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 0026092fec7f..d0169ba7fbf2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -32,6 +32,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
+#include <linux/perf_event.h>
 #include <asm/sections.h>
 
 #include "coresight-etm4x.h"
@@ -187,7 +188,8 @@ static void etm4_enable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
 }
 
-static int etm4_enable(struct coresight_device *csdev, u32 mode)
+static int etm4_enable(struct coresight_device *csdev,
+		       struct perf_event_attr *attr, u32 mode)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index b20afb709141..95cccb179763 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -234,7 +234,7 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 
 	if (!csdev->enable) {
 		if (source_ops(csdev)->enable) {
-			ret = source_ops(csdev)->enable(csdev, mode);
+			ret = source_ops(csdev)->enable(csdev, NULL, mode);
 			if (ret)
 				return ret;
 		}
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 61dfb8d511ea..6801dd64ee5d 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -14,6 +14,7 @@
 #define _LINUX_CORESIGHT_H
 
 #include <linux/device.h>
+#include <linux/perf_event.h>
 #include <linux/sched.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
@@ -206,14 +207,15 @@ struct coresight_ops_link {
  * @cpu_id:	returns the value of the CPU number this component
  *		is associated to.
  * @trace_id:	returns the value of the component's trace ID as known
-		to the HW.
+ *		to the HW.
  * @enable:	enables tracing for a source.
  * @disable:	disables tracing for a source.
  */
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
-	int (*enable)(struct coresight_device *csdev, u32 mode);
+	int (*enable)(struct coresight_device *csdev,
+		      struct perf_event_attr *attr,  u32 mode);
 	void (*disable)(struct coresight_device *csdev);
 };
 
-- 
2.1.4
