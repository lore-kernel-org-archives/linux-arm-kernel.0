From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:32 -0600
Subject: [RFC PATCH 18/20] coresight: etm3x: pushing down perf configuration
 to tracer
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-19-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The perf command line tool supports configuration for cycle
accurate and timestamps.  Configuration for those field is
found in the 'config' field of the event configuration
attributes.

Since the bit fields were organised to match,
the only thing that is needed is to make sure no extra
fields were set.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 12 +++++------
 drivers/hwtracing/coresight/coresight-etm3x.c    | 27 +++++++++++++++++++++++-
 include/linux/coresight.h                        |  3 ++-
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index de0198e72603..a662842f3327 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -122,7 +122,7 @@ out:
 	return ret;
 }
 
-static int etm_event_config_single_source(int source)
+static int etm_event_config_single_source(int source, struct perf_event *event)
 {
 	struct coresight_device *csdev;
 
@@ -134,10 +134,10 @@ static int etm_event_config_single_source(int source)
 	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
 		return -EINVAL;
 
-	return source_ops(csdev)->configure(csdev);
+	return source_ops(csdev)->configure(csdev, event);
 }
 
-static int etm_event_config_sources(int source)
+static int etm_event_config_sources(int source, struct perf_event *event)
 {
 	int cpu, ret;
 
@@ -147,13 +147,13 @@ static int etm_event_config_sources(int source)
 	/* source == -1 is for all CPUs. */
 	if (source != -1) {
 		/* configure one source */
-		ret = etm_event_config_single_source(source);
+		ret = etm_event_config_single_source(source, event);
 		goto out;
 	}
 
 	/* same process as above, but for all CPUs */
 	for_each_online_cpu(cpu) {
-		ret = etm_event_config_single_source(cpu);
+		ret = etm_event_config_single_source(cpu, event);
 		if (ret)
 			goto reset;
 	}
@@ -220,7 +220,7 @@ static int etm_event_init(struct perf_event *event)
 	if (ret)
 		goto out;
 
-	ret = etm_event_config_sources(event->cpu);
+	ret = etm_event_config_sources(event->cpu, event);
 
 	event->destroy = etm_event_destroy;
 out:
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 6a44ea330a4a..077b49714259 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -313,6 +313,25 @@ static void etm_power_down(struct coresight_device *csdev)
 	pm_runtime_put(csdev->dev.parent);
 }
 
+#define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN)
+
+static int etm_parse_event_config(struct etm_drvdata *drvdata,
+				  struct perf_event *event)
+{
+	u64 config = event->attr.config;
+
+	/*
+	 * At this time only cycle accurate and timestamp options are
+	 * available.  As such clear everything else that may have been
+	 * configured and set the ETM control register based on what was
+	 * requested.
+	 */
+	config &= ETM3X_SUPPORTED_OPTIONS;
+	drvdata->ctrl = config;
+
+	return 0;
+}
+
 /**
  * etm_configure_cpu - configure ETM registers
  * @csdev - the etm that needs to be configure.
@@ -334,6 +353,8 @@ static void etm_configure_cpu(void *info)
 	etm_set_prog(drvdata);
 
 	etmcr = etm_readl(drvdata, ETMCR);
+	/* Clear setting from a previous run if need be */
+	etmcr &= ~ETM3X_SUPPORTED_OPTIONS;
 	etmcr |= drvdata->port_size;
 	etmcr |= ETMCR_ETM_EN;
 	etm_writel(drvdata, drvdata->ctrl | etmcr, ETMCR);
@@ -379,10 +400,14 @@ static void etm_configure_cpu(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static int etm_configure(struct coresight_device *csdev)
+static int etm_configure(struct coresight_device *csdev,
+			 struct perf_event *event)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	if (etm_parse_event_config(drvdata, event))
+		return -EINVAL;
+
 	return smp_call_function_single(drvdata->cpu,
 					etm_configure_cpu, csdev, 1);
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index da76b2951f10..e1a14c84082f 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -237,7 +237,8 @@ struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
 	bool (*is_enabled)(struct coresight_device *csdev);
-	int (*configure)(struct coresight_device *csdev);
+	int (*configure)(struct coresight_device *csdev,
+			 struct perf_event *event);
 	int (*trace_enable)(struct coresight_device *csdev, bool enable);
 	int (*enable)(struct coresight_device *csdev);
 	void (*disable)(struct coresight_device *csdev);
-- 
1.9.1
