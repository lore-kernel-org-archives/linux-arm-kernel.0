From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  2 Jul 2018 16:33:30 -0600
Subject: [PATCH 6/6] coresight: Use PMU driver configuration for sink selection
In-Reply-To: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1530570810-28929-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the PMU driver configuration API to select a sink
for each event that is created (the old sysFS way of working is kept
around for backward compatibility).

By proceeding in this way a sink can be used by multiple sessions
without having to play games with entries in sysFS.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 128 ++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm-perf.h |  10 ++
 2 files changed, 126 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 0f5e03e4df22..37c8b97d0449 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/parser.h>
 #include <linux/perf_event.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -22,6 +23,8 @@
 static struct pmu etm_pmu;
 static bool etm_perf_up;
 
+#define CORESIGHT_DEVICE_MAX_NAME_LEN	256
+
 /**
  * struct etm_event_data - Coresight specifics associated to an event
  * @work:		Handle to free allocated memory outside IRQ context.
@@ -81,10 +84,29 @@ static int etm_addr_filters_alloc(struct perf_event *event)
 	return 0;
 }
 
+static int etm_drv_config_alloc(struct perf_event *event)
+{
+	char *sink;
+	int node = event->cpu == -1 ? -1 : cpu_to_node(event->cpu);
+
+	sink = kzalloc_node(CORESIGHT_DEVICE_MAX_NAME_LEN, GFP_KERNEL, node);
+	if (!sink)
+		return -ENOMEM;
+
+	if (event->parent)
+		memcpy(sink, event->parent->hw.addr_filters,
+		       CORESIGHT_DEVICE_MAX_NAME_LEN);
+
+	event->hw.drv_config = sink;
+
+	return 0;
+}
+
 static void etm_event_destroy(struct perf_event *event)
 {
 	kfree(event->hw.addr_filters);
 	event->hw.addr_filters = NULL;
+	kfree(event->hw.drv_config);
 }
 
 static int etm_event_init(struct perf_event *event)
@@ -100,6 +122,10 @@ static int etm_event_init(struct perf_event *event)
 	if (ret)
 		goto out;
 
+	ret = etm_drv_config_alloc(event);
+	if (ret)
+		goto out;
+
 	event->destroy = etm_event_destroy;
 out:
 	return ret;
@@ -181,6 +207,38 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
+static struct coresight_device *etm_event_get_sink(struct perf_event *event)
+{
+	/*
+	 * Try the preferred method first, i.e passing the sink information
+	 * using the ioctl() method.
+	 */
+	if (event->hw.drv_config) {
+		struct device *dev;
+		struct coresight_device *sink;
+
+		dev = bus_find_device_by_name(&coresight_bustype, NULL,
+					      (char *)event->hw.drv_config);
+		if (dev) {
+			sink = to_coresight_device(dev);
+			/* Put reference from 'bus_find_device()' */
+			put_device(dev);
+			return sink;
+		}
+	}
+
+	/*
+	 * No luck with the above method, so we are working with an older user
+	 * space.  See if a sink has been set using sysFS.  If this is the case
+	 * CPU-wide session will only be able to use a single sink.
+	 *
+	 * When operated from sysFS users are responsible to enable the sink
+	 * while from perf, the perf tools will do it based on the choice made
+	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
+	 */
+	return coresight_get_enabled_sink(true);
+}
+
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
@@ -194,18 +252,10 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
 
-	/*
-	 * In theory nothing prevent tracers in a trace session from being
-	 * associated with different sinks, nor having a sink per tracer.  But
-	 * until we have HW with this kind of topology we need to assume tracers
-	 * in a trace session are using the same sink.  Therefore go through
-	 * the coresight bus and pick the first enabled sink.
-	 *
-	 * When operated from sysFS users are responsible to enable the sink
-	 * while from perf, the perf tools will do it based on the choice made
-	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
-	 */
-	sink = coresight_get_enabled_sink(true);
+	perf_event_drv_config_sync(event);
+
+	/* First get the sink to use for this event */
+	sink = etm_event_get_sink(event);
 	if (!sink)
 		goto err;
 
@@ -442,6 +492,57 @@ static void etm_addr_filters_sync(struct perf_event *event)
 	filters->nr_filters = i;
 }
 
+static const match_table_t config_tokens = {
+	{ ETM_CFG_SINK,		"%u.%s" },
+	{ ETM_CFG_NONE,		NULL },
+};
+
+static void *etm_drv_config_validate(struct perf_event *event, char *cstr)
+{
+	char *str, *to_parse, *sink = NULL;
+	int token, ret = -EINVAL;
+	substring_t args[MAX_OPT_ARGS];
+
+	to_parse = kstrdup(cstr, GFP_KERNEL);
+	if (!to_parse)
+		return ERR_PTR(-ENOMEM);
+
+	while ((str = strsep(&to_parse, " ,\n")) != NULL) {
+		if (!*str)
+			continue;
+
+		token = match_token(str, config_tokens, args);
+		switch (token) {
+		case ETM_CFG_SINK:
+			sink = kstrdup(str, GFP_KERNEL);
+			if (!sink) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			break;
+		default:
+			goto out;
+		}
+	}
+
+out:
+	kfree(to_parse);
+	return sink ? sink : ERR_PTR(ret);
+}
+
+static void etm_drv_config_sync(struct perf_event *event)
+{
+	struct perf_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	memcpy(event->hw.drv_config, drv_config->drv_config,
+	       CORESIGHT_DEVICE_MAX_NAME_LEN);
+}
+
+static void etm_drv_config_free(void *drv_data)
+{
+	kfree(drv_data);
+}
+
 int etm_perf_symlink(struct coresight_device *csdev, bool link)
 {
 	char entry[sizeof("cpu9999999")];
@@ -486,6 +587,9 @@ static int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.drv_config_validate	= etm_drv_config_validate;
+	etm_pmu.drv_config_sync		= etm_drv_config_sync;
+	etm_pmu.drv_config_free		= etm_drv_config_free;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 4197df4faf5e..175895c8d635 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -42,6 +42,16 @@ struct etm_filters {
 	bool			ssstatus;
 };
 
+enum etm_config_elem_type {
+	ETM_CFG_NONE = -1,
+	ETM_CFG_SINK,
+};
+
+struct etm_config_elem {
+	struct list_head		entry;
+	enum etm_config_elem_type	type;
+	void				*config;
+};
 
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
-- 
2.7.4
