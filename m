From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu,  4 Aug 2016 10:53:24 -0600
Subject: [PATCH V4 6/6] coresight: etm-perf: incorporating sink definition
 from cmd line
In-Reply-To: <1470329604-14356-1-git-send-email-mathieu.poirier@linaro.org>
References: <1470329604-14356-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1470329604-14356-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that PMU specific configuration is available as part of the event,
lookup the sink identified by users from the perf command line and build
a path from source to sink.

With this functionality it is no longer required to select a sink in a
separate step (from sysFS) before a perf trace session can be started.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 101 ++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f8c7a8733b23..5658a7411a66 100644
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
@@ -71,11 +72,20 @@ static const struct attribute_group *etm_pmu_attr_groups[] = {
 
 static void etm_event_read(struct perf_event *event) {}
 
+static void etm_event_destroy(struct perf_event *event)
+{
+	kfree(event->hw.drv_configs);
+	event->hw.drv_configs = NULL;
+}
+
 static int etm_event_init(struct perf_event *event)
 {
 	if (event->attr.type != etm_pmu.type)
 		return -ENOENT;
 
+	event->destroy = etm_event_destroy;
+	event->hw.drv_configs = NULL;
+
 	return 0;
 }
 
@@ -159,6 +169,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
 	int cpu;
+	char *cmdl_sink;
 	cpumask_t *mask;
 	struct coresight_device *sink;
 	struct etm_event_data *event_data = NULL;
@@ -171,6 +182,12 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 
 	mask = &event_data->mask;
 
+	/*
+	 * If a sink was specified from the perf cmdline it will be part of
+	 * the event's drv_configs.
+	 */
+	cmdl_sink = (char *)event->hw.drv_configs;
+
 	/* Setup the path for each CPU in a trace session */
 	for_each_cpu(cpu, mask) {
 		struct coresight_device *csdev;
@@ -184,7 +201,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		 * list of devices from source to sink that can be
 		 * referenced later when the path is actually needed.
 		 */
-		event_data->path[cpu] = coresight_build_path(csdev, NULL);
+		event_data->path[cpu] = coresight_build_path(csdev, cmdl_sink);
 		if (!event_data->path[cpu])
 			goto err;
 	}
@@ -342,6 +359,87 @@ static void etm_event_del(struct perf_event *event, int mode)
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
+static int etm_set_drv_configs(struct perf_event *event, void __user *arg)
+{
+	char *config, *sink = NULL;
+	int cpu = -1, token, ret = 0;
+	substring_t args[MAX_OPT_ARGS];
+
+	/* Only one sink per event */
+	if (event->hw.drv_configs != NULL) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Make user supplied input usable */
+	config = strndup_user(arg, PAGE_SIZE);
+	if (IS_ERR(config)) {
+		ret = PTR_ERR(config);
+		goto err;
+	}
+
+	/* See above declared @drv_cfg_tokens for the usable formats */
+	token = match_token(config, drv_cfg_tokens, args);
+	switch (token) {
+	case ETM_TOKEN_SINK:
+		/* Just a sink has been specified */
+		sink = match_strdup(&args[0]);
+		if (IS_ERR(sink)) {
+			ret = PTR_ERR(sink);
+			goto err;
+		}
+		break;
+	case ETM_TOKEN_SINK_CPU:
+		/* We have a sink and a CPU */
+
+		/* First get the cpu */
+		if (match_int(&args[0], &cpu)) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		/* Then the sink */
+		sink = match_strdup(&args[1]);
+		if (IS_ERR(sink)) {
+			ret = PTR_ERR(sink);
+			goto err;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * If the CPUs don't match the sink is destined to another path.  This
+	 * isn't as an error hence not setting @ret.
+	 */
+	if (event->cpu != cpu)
+		goto err;
+
+	/* We have a valid configuration */
+	event->hw.drv_configs = sink;
+
+out:
+	return ret;
+
+err:
+	kfree(sink);
+	goto out;
+}
+
 int etm_perf_symlink(struct coresight_device *csdev, bool link)
 {
 	char entry[sizeof("cpu9999999")];
@@ -383,6 +481,7 @@ static int __init etm_perf_init(void)
 	etm_pmu.stop		= etm_event_stop;
 	etm_pmu.add		= etm_event_add;
 	etm_pmu.del		= etm_event_del;
+	etm_pmu.set_drv_configs	= etm_set_drv_configs;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
-- 
2.7.4
