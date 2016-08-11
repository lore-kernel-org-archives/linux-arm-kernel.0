From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 11 Aug 2016 10:21:04 -0600
Subject: [PATCH V5 9/9] coresight: etm-perf: incorporating sink definition
 from cmd line
In-Reply-To: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
References: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1470932464-726-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that PMU specific configuration is available as part of the event,
lookup the sink identified by users from the perf command line and build
a path from source to sink.

With this functionality it is no longer required to select a sink in a
separate step (from sysFS) before a perf trace session can be started.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 139 ++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f8c7a8733b23..eab038805cbe 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/parser.h>
 #include <linux/perf_event.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -71,11 +72,25 @@ static const struct attribute_group *etm_pmu_attr_groups[] = {
 
 static void etm_event_read(struct perf_event *event) {}
 
+static void etm_event_destroy(struct perf_event *event)
+{
+	void *sink;
+
+	sink = perf_event_drv_configs_set(event, NULL);
+	kfree(sink);
+}
+
 static int etm_event_init(struct perf_event *event)
 {
+	struct hw_perf_event *hw_event = &event->hw;
+
 	if (event->attr.type != etm_pmu.type)
 		return -ENOENT;
 
+	event->destroy = etm_event_destroy;
+	raw_spin_lock_init(&hw_event->drv_configs_lock);
+	hw_event->drv_configs = NULL;
+
 	return 0;
 }
 
@@ -159,6 +174,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
 	int cpu;
+	char *cmdl_sink;
 	cpumask_t *mask;
 	struct coresight_device *sink;
 	struct etm_event_data *event_data = NULL;
@@ -171,6 +187,14 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 
 	mask = &event_data->mask;
 
+	/*
+	 * If a sink was specified from the perf cmdline it will be part of
+	 * the event's drv_configs.
+	 */
+	cmdl_sink = (char *)perf_event_drv_configs_get(event);
+	if (IS_ERR(cmdl_sink))
+		cmdl_sink = NULL;
+
 	/* Setup the path for each CPU in a trace session */
 	for_each_cpu(cpu, mask) {
 		struct coresight_device *csdev;
@@ -184,7 +208,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		 * list of devices from source to sink that can be
 		 * referenced later when the path is actually needed.
 		 */
-		event_data->path[cpu] = coresight_build_path(csdev, NULL);
+		event_data->path[cpu] = coresight_build_path(csdev, cmdl_sink);
 		if (!event_data->path[cpu])
 			goto err;
 	}
@@ -342,6 +366,118 @@ static void etm_event_del(struct perf_event *event, int mode)
 	etm_event_stop(event, PERF_EF_UPDATE);
 }
 
+enum {
+	ETM_TOKEN_SINK_CPU,
+	ETM_TOKEN_SINK,
+	ETM_TOKEN_ERR,
+};
+
+static const match_table_t drv_cfg_tokens = {
+	{ETM_TOKEN_SINK_CPU, "sink=cpu%d:%s"},
+	{ETM_TOKEN_SINK, "sink=%s"},
+	{ETM_TOKEN_ERR, NULL},
+};
+
+/**
+ * etm_parse_drv_configs - parse configuration string
+ *
+ * Returns: ERR_PTR() upon error,  NULL if the config string CPU is different
+ *	    from the event's CPU and the address of a valid string if one has
+ *	    been found.
+ */
+static char *etm_parse_drv_configs(int event_cpu, char *config_str)
+{
+	char *sink = NULL, *config = config_str;
+	int cpu, token;
+	substring_t args[MAX_OPT_ARGS];
+
+	/* See above declared @drv_cfg_tokens for the usable formats */
+	token = match_token(config, drv_cfg_tokens, args);
+	switch (token) {
+	case ETM_TOKEN_SINK:
+		/* Simply return the sink that was specified */
+		sink = match_strdup(&args[0]);
+		break;
+	case ETM_TOKEN_SINK_CPU:
+		/*
+		 * We have a sink and a CPU, so we need to make sure the
+		 * given CPU matches the event's CPU.  If not this sink is
+		 * destined to another tracer.  This isn't an error hence not
+		 * setting @ret.
+		 */
+
+		/* Get the cpu */
+		if (match_int(&args[0], &cpu)) {
+			sink = ERR_PTR(-EINVAL);
+			goto out;
+		}
+
+		/* This sink configuration is meant for another CPU */
+		if (event_cpu != cpu)
+			goto out;
+
+		sink = match_strdup(&args[1]);
+		break;
+	default:
+		sink = ERR_PTR(-EINVAL);
+	}
+
+out:
+	return sink;
+}
+
+static int
+etm_set_drv_configs(struct perf_event *event,
+		    struct list_head *drv_configs)
+{
+	char *config, *sink;
+	int len;
+	struct perf_drv_config *drv_config;
+	void *old_sink;
+
+	list_for_each_entry(drv_config, drv_configs, entry) {
+		/* ETM HW configuration needs a sink specification */
+		if (!drv_config->option)
+			return -EINVAL;
+
+		len = strlen(drv_config->config) + strlen("=") +
+		      strlen(drv_config->option) + 1;
+
+		config = kmalloc(len, GFP_KERNEL);
+		if (!config)
+			return -ENOMEM;
+
+		/* Reconstruct user configuration */
+		snprintf(config, len, "%s=%s",
+			 drv_config->config, drv_config->option);
+
+		sink = etm_parse_drv_configs(event->cpu, config);
+		kfree(config);
+
+		/* No need to continue if the parse encountered and error */
+		if (IS_ERR(sink))
+			return PTR_ERR(sink);
+
+		/* A valid sink was found */
+		if (sink)
+			goto found;
+	}
+
+	/*
+	 * A sink wasn't found, which isn't automatically an error.  Other
+	 * options on the cmd line may still need to be parsed.
+	 */
+	return 0;
+
+found:
+	/* Record the sink that was found */
+	old_sink = perf_event_drv_configs_set(event, sink);
+	/* And get rid of whatever we had before */
+	kfree(old_sink);
+
+	return 0;
+}
+
 int etm_perf_symlink(struct coresight_device *csdev, bool link)
 {
 	char entry[sizeof("cpu9999999")];
@@ -383,6 +519,7 @@ static int __init etm_perf_init(void)
 	etm_pmu.stop		= etm_event_stop;
 	etm_pmu.add		= etm_event_add;
 	etm_pmu.del		= etm_event_del;
+	etm_pmu.set_drv_configs	= etm_set_drv_configs;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
-- 
2.7.4
