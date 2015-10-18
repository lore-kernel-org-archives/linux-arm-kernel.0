From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:29 -0600
Subject: [PATCH V2 12/30] coresight: etm3x: adding perf_get/set_config() API
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-13-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a source operation to build a tracer configuration from
a perf_event.  That way possibly complex parsing of the information
coveyed by the event doesn't have to be carried out every time
the configuration is needed.

Since event configuration can change between concurrent sessions,
the possibility of associating a tracer with a configuration is
also provided.  As such Perf can assign session configuration to
tracers as it sees fit.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 70 +++++++++++++++++++++++++--
 include/linux/coresight.h                     |  5 ++
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 8a133d761f6a..0994bf0a8334 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -31,6 +31,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/clk.h>
+#include <linux/perf_event.h>
 #include <asm/sections.h>
 
 #include "coresight-etm.h"
@@ -312,6 +313,40 @@ void etm_config_trace_mode(struct etm_drvdata *drvdata,
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
@@ -425,6 +460,31 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
+static void *perf_etm_get_config(struct coresight_device *csdev,
+				 struct perf_event *event)
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
+static void perf_etm_set_config(struct coresight_device *csdev, void *config)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	drvdata->config = config;
+}
+
 static int sysfs_etm_enable(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -523,10 +583,12 @@ static void sysfs_etm_disable(struct coresight_device *csdev)
 }
 
 static const struct coresight_ops_source etm_source_ops = {
-	.cpu_id		= etm_cpu_id,
-	.trace_id	= etm_trace_id,
-	.sysfs_enable	= sysfs_etm_enable,
-	.sysfs_disable	= sysfs_etm_disable,
+	.cpu_id			= etm_cpu_id,
+	.trace_id		= etm_trace_id,
+	.perf_get_config	= perf_etm_get_config,
+	.perf_set_config	= perf_etm_set_config,
+	.sysfs_enable		= sysfs_etm_enable,
+	.sysfs_disable		= sysfs_etm_disable,
 };
 
 static const struct coresight_ops etm_cs_ops = {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f9210df15f03..32463da877eb 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -209,12 +209,17 @@ struct coresight_ops_link {
  *			is associated to.
  * @trace_id:		returns the value of the component's trace ID as known
 			to the HW.
+ * @perf_get_config:	builds the ETM configuration after event' specifics.
+ * @perf_set_config:	associate a tracer with a configuration..
  * @sysfs_enable:	enables tracing for a source, from sysFS.
  * @sysfs_disable:	disables tracing for a source, from sysFS.
  */
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
+	void *(*perf_get_config)(struct coresight_device *csdev,
+				 struct perf_event *event);
+	void (*perf_set_config)(struct coresight_device *csdev, void *config);
 	int (*sysfs_enable)(struct coresight_device *csdev);
 	void (*sysfs_disable)(struct coresight_device *csdev);
 };
-- 
1.9.1
