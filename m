From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Nov 2015 11:33:06 -0700
Subject: [RESEND PATCH V4 14/26] coresight: etm3x: adding
 perf_get/set_config() API
In-Reply-To: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
References: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1448303598-11249-15-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a source operation to build a tracer's configuration from
a perf_event.  That way possibly complex parsing of the information
conveyed by the event doesn't have to be carried out every time
the configuration is needed.

Since event configuration can change between concurrent sessions,
the possibility of associating a tracer with a configuration is
also provided.  As such Perf can assign session configuration to
tracers as it see fit.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  1 +
 drivers/hwtracing/coresight/coresight-etm3x.c | 62 +++++++++++++++++++++++++++
 include/linux/coresight.h                     |  7 ++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 6c8921140f02..e252dd1522e5 100644
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
index a83c67d13b21..dd319ef0f1ac 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -31,6 +31,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/clk.h>
+#include <linux/perf_event.h>
 #include <asm/sections.h>
 
 #include "coresight-etm.h"
@@ -315,6 +316,40 @@ void etm_config_trace_mode(struct etm_drvdata *drvdata,
 	config->addr_type[1] = ETM_ADDR_TYPE_RANGE;
 }
 
+#define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN)
+
+static int etm_parse_event_config(struct etm_drvdata *drvdata,
+				  struct etm_config *config,
+				  struct perf_event *event)
+{
+	u32 mode = 0;
+	u64 event_config = event->attr.config;
+
+	if (event->attr.exclude_kernel)
+		mode = ETM_MODE_EXCL_KERN;
+
+	if (event->attr.exclude_user)
+		mode = ETM_MODE_EXCL_USER;
+
+	/*
+	 * By default the tracers are configured to trace the whole address
+	 * range.  Narrow the field only if requested by user space.
+	 */
+	if (mode)
+		etm_config_trace_mode(drvdata, config, mode);
+
+	/*
+	 * At this time only cycle accurate and timestamp options are
+	 * available.
+	 */
+	if (event_config & ~ETM3X_SUPPORTED_OPTIONS)
+		return -EINVAL;
+
+	config->ctrl = event_config;
+
+	return 0;
+}
+
 static void etm_enable_hw(void *info)
 {
 	int i;
@@ -428,6 +463,31 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
+static void *etm_get_config(struct coresight_device *csdev,
+			    struct perf_event *event)
+{
+	struct etm_config *config = NULL;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	config = kzalloc(sizeof(struct etm_config), GFP_KERNEL);
+	if (!config)
+		return config;
+
+	etm_set_default(config);
+
+	if (etm_parse_event_config(drvdata, config, event))
+		return ERR_PTR(-EINVAL);
+
+	return config;
+}
+
+static void etm_set_config(struct coresight_device *csdev, void *config)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	drvdata->config = config;
+}
+
 static int etm_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -568,6 +628,8 @@ static void etm_disable(struct coresight_device *csdev)
 static const struct coresight_ops_source etm_source_ops = {
 	.cpu_id		= etm_cpu_id,
 	.trace_id	= etm_trace_id,
+	.get_config	= etm_get_config,
+	.set_config	= etm_set_config,
 	.enable		= etm_enable,
 	.disable	= etm_disable,
 };
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 61dfb8d511ea..f2148bc2bcfe 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -206,13 +206,18 @@ struct coresight_ops_link {
  * @cpu_id:	returns the value of the CPU number this component
  *		is associated to.
  * @trace_id:	returns the value of the component's trace ID as known
-		to the HW.
+ *		to the HW.
+ * @get_config:	builds the ETM configuration after events' specifics.
+ * @set_config:	associate a tracer with a configuration.
  * @enable:	enables tracing for a source.
  * @disable:	disables tracing for a source.
  */
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
+	void *(*get_config)(struct coresight_device *csdev,
+			    struct perf_event *event);
+	void (*set_config)(struct coresight_device *csdev, void *config);
 	int (*enable)(struct coresight_device *csdev, u32 mode);
 	void (*disable)(struct coresight_device *csdev);
 };
-- 
1.9.1
