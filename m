From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:31 -0600
Subject: [PATCH V2 14/30] coresight: etm3x: implementing perf_start/stop() API
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-15-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an API to deal with runtime PM (and anything else)
that might be required by a tracer before and after it is
to be used by the Perf framework.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 12 ++++++++++++
 include/linux/coresight.h                     |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index f565554744fe..9b4c0359ca29 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -459,6 +459,16 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
+static int perf_etm_start(struct coresight_device *csdev)
+{
+	return pm_runtime_get_sync(csdev->dev.parent);
+}
+
+static int perf_etm_stop(struct coresight_device *csdev)
+{
+	return pm_runtime_put(csdev->dev.parent);
+}
+
 static void *perf_etm_get_config(struct coresight_device *csdev,
 				 struct perf_event *event)
 {
@@ -625,6 +635,8 @@ static void sysfs_etm_disable(struct coresight_device *csdev)
 static const struct coresight_ops_source etm_source_ops = {
 	.cpu_id			= etm_cpu_id,
 	.trace_id		= etm_trace_id,
+	.perf_start		= perf_etm_start,
+	.perf_stop		= perf_etm_stop,
 	.perf_get_config	= perf_etm_get_config,
 	.perf_set_config	= perf_etm_set_config,
 	.perf_enable		= perf_etm_enable,
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index b853d722346b..0601da01eeb2 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -209,6 +209,9 @@ struct coresight_ops_link {
  *			is associated to.
  * @trace_id:		returns the value of the component's trace ID as known
 			to the HW.
+ * @perf_start:		operations to be done before a tracer can be used.
+ * @perf_stop:		operations to be done when a tracer is
+ *			no longer needed.
  * @perf_get_config:	builds the ETM configuration after event' specifics.
  * @perf_set_config:	associate a tracer with a configuration..
  * @perf_enable:	enables tracing for a source, from Perf.
@@ -219,6 +222,8 @@ struct coresight_ops_link {
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
+	int (*perf_start)(struct coresight_device *csdev);
+	int (*perf_stop)(struct coresight_device *csdev);
 	void *(*perf_get_config)(struct coresight_device *csdev,
 				 struct perf_event *event);
 	void (*perf_set_config)(struct coresight_device *csdev, void *config);
-- 
1.9.1
