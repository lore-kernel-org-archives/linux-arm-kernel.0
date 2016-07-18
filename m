From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 18 Jul 2016 13:51:22 -0600
Subject: [PATCH 01/10] coresight: etm-perf: pass struct perf_event to
 source::enable/disable()
In-Reply-To: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
References: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1468871491-10997-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this commit [1] address range filter information is now found
in the struct hw_perf_event::addr_filters.  As such pass the event
itself to the coresight_source::enable/disable() functions so that
both event attribute and filter can be accessible for configuration.

[1] 'commit 375637bc5249 ("perf/core: Introduce address range filtering")'

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  4 ++--
 drivers/hwtracing/coresight/coresight-etm3x.c    | 14 ++++++++------
 drivers/hwtracing/coresight/coresight-etm4x.c    | 19 +++++++++++--------
 drivers/hwtracing/coresight/coresight-stm.c      |  7 ++++---
 drivers/hwtracing/coresight/coresight.c          |  2 +-
 include/linux/coresight.h                        |  5 +++--
 6 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8fbb1dd9e243..78a1bc0013a2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -283,7 +283,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	event->hw.state = 0;
 
 	/* Finally enable the tracer */
-	if (source_ops(csdev)->enable(csdev, &event->attr, CS_MODE_PERF))
+	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
 		goto fail_end_stop;
 
 out:
@@ -316,7 +316,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		return;
 
 	/* stop tracer */
-	source_ops(csdev)->disable(csdev);
+	source_ops(csdev)->disable(csdev, event);
 
 	/* tell the core */
 	event->hw.state = PERF_HES_STOPPED;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index d83ab82672e4..38828bd8d332 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -309,9 +309,10 @@ void etm_config_trace_mode(struct etm_config *config)
 #define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN)
 
 static int etm_parse_event_config(struct etm_drvdata *drvdata,
-				  struct perf_event_attr *attr)
+				  struct perf_event *event)
 {
 	struct etm_config *config = &drvdata->config;
+	struct perf_event_attr *attr = &event->attr;
 
 	if (!attr)
 		return -EINVAL;
@@ -457,7 +458,7 @@ static int etm_trace_id(struct coresight_device *csdev)
 }
 
 static int etm_enable_perf(struct coresight_device *csdev,
-			   struct perf_event_attr *attr)
+			   struct perf_event *event)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -465,7 +466,7 @@ static int etm_enable_perf(struct coresight_device *csdev,
 		return -EINVAL;
 
 	/* Configure the tracer based on the session's specifics */
-	etm_parse_event_config(drvdata, attr);
+	etm_parse_event_config(drvdata, event);
 	/* And enable it */
 	etm_enable_hw(drvdata);
 
@@ -503,7 +504,7 @@ err:
 }
 
 static int etm_enable(struct coresight_device *csdev,
-		      struct perf_event_attr *attr, u32 mode)
+		      struct perf_event *event, u32 mode)
 {
 	int ret;
 	u32 val;
@@ -520,7 +521,7 @@ static int etm_enable(struct coresight_device *csdev,
 		ret = etm_enable_sysfs(csdev);
 		break;
 	case CS_MODE_PERF:
-		ret = etm_enable_perf(csdev, attr);
+		ret = etm_enable_perf(csdev, event);
 		break;
 	default:
 		ret = -EINVAL;
@@ -600,7 +601,8 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	dev_info(drvdata->dev, "ETM tracing disabled\n");
 }
 
-static void etm_disable(struct coresight_device *csdev)
+static void etm_disable(struct coresight_device *csdev,
+			struct perf_event *event)
 {
 	u32 mode;
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 462f0dc15757..1fe1f0e86daf 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -193,9 +193,10 @@ static void etm4_enable_hw(void *info)
 }
 
 static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
-				   struct perf_event_attr *attr)
+				   struct perf_event *event)
 {
 	struct etmv4_config *config = &drvdata->config;
+	struct perf_event_attr *attr = &event->attr;
 
 	if (!attr)
 		return -EINVAL;
@@ -229,7 +230,7 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 }
 
 static int etm4_enable_perf(struct coresight_device *csdev,
-			    struct perf_event_attr *attr)
+			    struct perf_event *event)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -237,7 +238,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 		return -EINVAL;
 
 	/* Configure the tracer based on the session's specifics */
-	etm4_parse_event_config(drvdata, attr);
+	etm4_parse_event_config(drvdata, event);
 	/* And enable it */
 	etm4_enable_hw(drvdata);
 
@@ -272,7 +273,7 @@ err:
 }
 
 static int etm4_enable(struct coresight_device *csdev,
-		       struct perf_event_attr *attr, u32 mode)
+		       struct perf_event *event, u32 mode)
 {
 	int ret;
 	u32 val;
@@ -289,7 +290,7 @@ static int etm4_enable(struct coresight_device *csdev,
 		ret = etm4_enable_sysfs(csdev);
 		break;
 	case CS_MODE_PERF:
-		ret = etm4_enable_perf(csdev, attr);
+		ret = etm4_enable_perf(csdev, event);
 		break;
 	default:
 		ret = -EINVAL;
@@ -324,7 +325,8 @@ static void etm4_disable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
-static int etm4_disable_perf(struct coresight_device *csdev)
+static int etm4_disable_perf(struct coresight_device *csdev,
+			     struct perf_event *event)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -360,7 +362,8 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	dev_info(drvdata->dev, "ETM tracing disabled\n");
 }
 
-static void etm4_disable(struct coresight_device *csdev)
+static void etm4_disable(struct coresight_device *csdev,
+			 struct perf_event *event)
 {
 	u32 mode;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -379,7 +382,7 @@ static void etm4_disable(struct coresight_device *csdev)
 		etm4_disable_sysfs(csdev);
 		break;
 	case CS_MODE_PERF:
-		etm4_disable_perf(csdev);
+		etm4_disable_perf(csdev, event);
 		break;
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 73be58a11e4f..d8fee8fff3da 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -196,7 +196,7 @@ static void stm_enable_hw(struct stm_drvdata *drvdata)
 }
 
 static int stm_enable(struct coresight_device *csdev,
-		      struct perf_event_attr *attr, u32 mode)
+		      struct perf_event *event, u32 mode)
 {
 	u32 val;
 	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -258,7 +258,8 @@ static void stm_disable_hw(struct stm_drvdata *drvdata)
 		stm_hwevent_disable_hw(drvdata);
 }
 
-static void stm_disable(struct coresight_device *csdev)
+static void stm_disable(struct coresight_device *csdev,
+			struct perf_event *event)
 {
 	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -353,7 +354,7 @@ static void stm_generic_unlink(struct stm_data *stm_data,
 	if (!drvdata || !drvdata->csdev)
 		return;
 
-	stm_disable(drvdata->csdev);
+	stm_disable(drvdata->csdev, NULL);
 }
 
 static long stm_generic_set_options(struct stm_data *stm_data,
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 508532b3fcac..60dff8915822 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -257,7 +257,7 @@ static void coresight_disable_source(struct coresight_device *csdev)
 {
 	if (atomic_dec_return(csdev->refcnt) == 0) {
 		if (source_ops(csdev)->disable) {
-			source_ops(csdev)->disable(csdev);
+			source_ops(csdev)->disable(csdev, NULL);
 			csdev->enable = false;
 		}
 	}
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 385d62e64abb..2a5982c37dfb 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -232,8 +232,9 @@ struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
 	int (*enable)(struct coresight_device *csdev,
-		      struct perf_event_attr *attr,  u32 mode);
-	void (*disable)(struct coresight_device *csdev);
+		      struct perf_event *event,  u32 mode);
+	void (*disable)(struct coresight_device *csdev,
+			struct perf_event *event);
 };
 
 struct coresight_ops {
-- 
2.7.4
