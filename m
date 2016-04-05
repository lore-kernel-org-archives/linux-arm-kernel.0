From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:49 -0600
Subject: [PATCH 08/11] coresight: etm4x: implementing the perf PMU API
In-Reply-To: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
References: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1459878832-15219-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a set of API allowing the Perf core to treat ETMv4
tracers like other PMUs.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |  5 +-
 drivers/hwtracing/coresight/coresight-etm4x.c | 85 +++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 637ca978cd05..1d0e32c7dbe4 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for CoreSight drivers.
 #
-obj-$(CONFIG_CORESIGHT) += coresight.o
+obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
 obj-$(CONFIG_OF) += of_coresight.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
@@ -9,8 +9,7 @@ obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
 					   coresight-replicator.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
-					coresight-etm3x-sysfs.o \
-					coresight-etm-perf.o
+					coresight-etm3x-sysfs.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
 					coresight-etm4x-sysfs.o
 obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 88b8bc0f6549..6396b28993da 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -31,12 +31,14 @@
 #include <linux/amba/bus.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 #include <linux/pm_runtime.h>
 #include <linux/perf_event.h>
 #include <asm/sections.h>
 #include <asm/local.h>
 
 #include "coresight-etm4x.h"
+#include "coresight-etm-perf.h"
 
 static int boot_enable;
 module_param_named(boot_enable, boot_enable, int, S_IRUGO);
@@ -44,6 +46,7 @@ module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 /* The number of ETMv4 currently registered */
 static int etm4_count;
 static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
+static void etm4_set_default(struct etmv4_config *config);
 
 static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 {
@@ -189,6 +192,58 @@ static void etm4_enable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
 }
 
+static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
+				   struct perf_event_attr *attr)
+{
+	struct etmv4_config *config = &drvdata->config;
+
+	if (!attr)
+		return -EINVAL;
+
+	/* Clear configuration from previous run */
+	memset(config, 0, sizeof(struct etmv4_config));
+
+	if (attr->exclude_kernel)
+		config->mode = ETM_MODE_EXCL_KERN;
+
+	if (attr->exclude_user)
+		config->mode = ETM_MODE_EXCL_USER;
+
+	/* Always start from the default config */
+	etm4_set_default(config);
+
+	/*
+	 * By default the tracers are configured to trace the whole address
+	 * range.  Narrow the field only if requested by user space.
+	 */
+	if (config->mode)
+		etm4_config_trace_mode(config);
+
+	/* Go from generic option to ETMv4 specifics */
+	if (attr->config & BIT(ETM_OPT_CYCACC))
+		config->cfg |= ETMv4_MODE_CYCACC;
+	if (attr->config & BIT(ETM_OPT_TS))
+		config->cfg |= ETMv4_MODE_TIMESTAMP;
+
+	return 0;
+}
+
+static int etm4_enable_perf(struct coresight_device *csdev,
+			    struct perf_event_attr *attr)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
+		return -EINVAL;
+
+	/* Configure the tracer based on the session's specifics */
+	etm4_parse_event_config(drvdata, attr);
+	/* And enable it */
+	etm4_enable_hw(drvdata);
+
+	return 0;
+}
+
 static int etm4_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -233,6 +288,9 @@ static int etm4_enable(struct coresight_device *csdev,
 	case CS_MODE_SYSFS:
 		ret = etm4_enable_sysfs(csdev);
 		break;
+	case CS_MODE_PERF:
+		ret = etm4_enable_perf(csdev, attr);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -266,6 +324,17 @@ static void etm4_disable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
+static int etm4_disable_perf(struct coresight_device *csdev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
+		return -EINVAL;
+
+	etm4_disable_hw(drvdata);
+	return 0;
+}
+
 static void etm4_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -309,6 +378,9 @@ static void etm4_disable(struct coresight_device *csdev)
 	case CS_MODE_SYSFS:
 		etm4_disable_sysfs(csdev);
 		break;
+	case CS_MODE_PERF:
+		etm4_disable_perf(csdev);
+		break;
 	}
 
 	if (mode)
@@ -708,8 +780,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
-	pm_runtime_put(&adev->dev);
-
 	desc->type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
 	desc->ops = &etm4_cs_ops;
@@ -719,9 +789,16 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->csdev = coresight_register(desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
-		goto err_coresight_register;
+		goto err_arch_supported;
 	}
 
+	ret = etm_perf_symlink(drvdata->csdev, true);
+	if (ret) {
+		coresight_unregister(drvdata->csdev);
+		goto err_arch_supported;
+	}
+
+	pm_runtime_put(&adev->dev);
 	dev_info(dev, "%s initialized\n", (char *)id->data);
 
 	if (boot_enable) {
@@ -732,8 +809,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 
 err_arch_supported:
-	pm_runtime_put(&adev->dev);
-err_coresight_register:
 	if (--etm4_count == 0)
 		unregister_hotcpu_notifier(&etm4_cpu_notifier);
 	return ret;
-- 
2.1.4
