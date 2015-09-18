From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:28 -0600
Subject: [RFC PATCH 14/20] coresight: etm-perf: implementing 'event_init()' API
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-15-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enhancing skeleton PMU with event initialisation.

The function makes sure tracers aren't already enabled
before going through with the powe up and configuration
sequences.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 176 +++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 759b8d69b4e6..a21171a3e929 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -30,6 +30,9 @@
 
 static struct pmu etm_pmu;
 
+static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
+static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
+
 /* ETMCR is 'config' */
 PMU_FORMAT_ATTR(cycacc,		"config:12");
 PMU_FORMAT_ATTR(timestamp,	"config:28");
@@ -52,6 +55,178 @@ static const struct attribute_group *etm_pmu_attr_groups[] = {
 
 static void etm_event_read(struct perf_event *event) {}
 
+static int etm_event_power_single_source(int source, bool power)
+{
+	int ret = 0;
+	LIST_HEAD(path);
+	LIST_HEAD(sinks);
+	struct coresight_device *csdev;
+
+	csdev = per_cpu(csdev_src, source);
+
+	if (!csdev)
+		return -EINVAL;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
+		return -EINVAL;
+
+	if (power) {
+		ret = source_ops(csdev)->poweron(csdev);
+		if (ret)
+			goto out;
+
+		ret = coresight_build_paths(csdev, &path, &sinks, true);
+		if (ret) {
+			dev_dbg(&csdev->dev, "creating path(s) failed\n");
+			source_ops(csdev)->poweroff(csdev);
+		}
+
+		/* Everything is good, record first enabled sink buffer */
+		per_cpu(csdev_sink, source) =
+			list_first_entry(&sinks,
+					 struct coresight_device, sinks);
+	} else {
+		source_ops(csdev)->poweroff(csdev);
+		ret = coresight_build_paths(csdev, &path, NULL, false);
+		if (ret)
+			dev_dbg(&csdev->dev, "releasing path(s) failed\n");
+	}
+
+out:
+	return ret;
+}
+
+static int etm_event_power_sources(int source, bool power)
+{
+	int cpu, ret;
+
+	if (source < -1 || source >= nr_cpu_ids)
+		return -EINVAL;
+
+	/* source == -1 is for all CPUs. */
+	if (source != -1) {
+		/* power up/down one source */
+		ret = etm_event_power_single_source(source, power);
+		goto out;
+	}
+
+	/* same process as above, but for all CPUs */
+	for_each_online_cpu(cpu) {
+		ret = etm_event_power_single_source(cpu, power);
+		if (ret)
+			break;
+	}
+
+out:
+	return ret;
+}
+
+static int etm_event_config_single_source(int source)
+{
+	struct coresight_device *csdev;
+
+	csdev = per_cpu(csdev_src, source);
+
+	if (!csdev)
+		return -EINVAL;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
+		return -EINVAL;
+
+	return source_ops(csdev)->configure(csdev);
+}
+
+static int etm_event_config_sources(int source)
+{
+	int cpu, ret;
+
+	if (source < -1 || source >= nr_cpu_ids)
+		return -EINVAL;
+
+	/* source == -1 is for all CPUs. */
+	if (source != -1) {
+		/* configure one source */
+		ret = etm_event_config_single_source(source);
+		goto out;
+	}
+
+	/* same process as above, but for all CPUs */
+	for_each_online_cpu(cpu) {
+		ret = etm_event_config_single_source(cpu);
+		if (ret)
+			goto reset;
+	}
+
+out:
+	return ret;
+reset:
+	for_each_online_cpu(cpu)
+		etm_event_power_sources(cpu, false);
+	goto out;
+}
+
+static bool etm_event_source_single_enabled(int source)
+{
+	struct coresight_device *csdev = per_cpu(csdev_src, source);
+
+	if (!csdev)
+		return true;
+
+	return source_ops(csdev)->is_enabled(csdev);
+}
+
+static bool etm_event_source_enabled(int source)
+{
+	int cpu;
+
+	if (source != -1)
+		return etm_event_source_single_enabled(source);
+
+	for_each_online_cpu(cpu) {
+		if (etm_event_source_single_enabled(cpu))
+			return true;
+	}
+
+	return false;
+}
+
+static void etm_event_destroy(struct perf_event *event)
+{
+	/* switching off the source will also tear down the path */
+	etm_event_power_sources(event->cpu, false);
+}
+
+static int etm_event_init(struct perf_event *event)
+{
+	int ret;
+
+	if (event->attr.type != etm_pmu.type)
+		return -ENOENT;
+
+	if (event->cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	/* only one session at a time */
+	if (etm_event_source_enabled(event->cpu))
+		return -EBUSY;
+
+	/*
+	 * Make sure CPUs don't disappear between the
+	 * power up sequence and configuration.
+	 */
+	get_online_cpus();
+	ret = etm_event_power_sources(event->cpu, true);
+	if (ret)
+		goto out;
+
+	ret = etm_event_config_sources(event->cpu);
+
+	event->destroy = etm_event_destroy;
+out:
+	put_online_cpus();
+	return ret;
+}
+
 static int __init etm_perf_init(void)
 {
 	etm_pmu.capabilities	= PERF_PMU_CAP_EXCLUSIVE;
@@ -59,6 +234,7 @@ static int __init etm_perf_init(void)
 	etm_pmu.attr_groups	= etm_pmu_attr_groups;
 	etm_pmu.task_ctx_nr	= perf_sw_context;
 	etm_pmu.read		= etm_event_read;
+	etm_pmu.event_init	= etm_event_init;
 
 	return perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 }
-- 
1.9.1
