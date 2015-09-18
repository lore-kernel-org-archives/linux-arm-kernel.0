From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:30 -0600
Subject: [RFC PATCH 16/20] coresight: etm-perf: implementing trace related APIs
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-17-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the API that connect trace control, i.e initiation
and termination, to the Perf core.  That way trace collection can
be started when the process it is associated to is executed by
a CPU, and stopped when yanked away.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 97 ++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 3aeb4215bb22..edacf4b1d0bc 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -30,6 +30,7 @@
 
 static struct pmu etm_pmu;
 
+static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
 
@@ -248,6 +249,98 @@ static void etm_free_aux(void *data)
 	kfree(data);
 }
 
+static void etm_event_stop(struct perf_event *event, int mode)
+{
+	int cpu = smp_processor_id();
+	struct coresight_device *src = per_cpu(csdev_src, cpu);
+	struct coresight_device *sink = per_cpu(csdev_sink, cpu);
+
+	if (event->hw.state == PERF_HES_STOPPED)
+		return;
+
+	if (!src || !sink)
+		return;
+
+	/* stop tracer */
+	if (source_ops(src)->trace_enable(src, false))
+		return;
+
+	/* tell the core */
+	event->hw.state = PERF_HES_STOPPED;
+
+
+	if (mode & PERF_EF_UPDATE) {
+		struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
+
+		if (WARN_ON_ONCE(handle->event != event))
+			return;
+
+		/* update trace information */
+		sink_ops(sink)->update_buffer(sink, handle);
+	}
+}
+
+static void etm_event_start(struct perf_event *event, int flags)
+{
+	int cpu = smp_processor_id();
+	struct coresight_device *csdev = per_cpu(csdev_src, cpu);
+
+	if (!csdev)
+		goto fail;
+
+	/* tell the perf core the event is alive */
+	event->hw.state = 0;
+
+	if (source_ops(csdev)->trace_enable(csdev, true))
+		goto fail;
+
+	return;
+
+fail:
+	event->hw.state = PERF_HES_STOPPED;
+}
+
+static void etm_event_del(struct perf_event *event, int mode)
+{
+	int cpu = smp_processor_id();
+	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
+	struct coresight_device *csdev = per_cpu(csdev_sink, cpu);
+
+	if (!csdev)
+		return;
+
+	etm_event_stop(event, PERF_EF_UPDATE);
+	sink_ops(csdev)->unset_buffer(csdev, handle);
+}
+
+static int etm_event_add(struct perf_event *event, int mode)
+{
+	int ret, cpu = smp_processor_id();
+	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
+	struct hw_perf_event *hwc = &event->hw;
+	struct coresight_device *csdev = per_cpu(csdev_sink, cpu);
+
+	if (!csdev)
+		return -EINVAL;
+
+	if (handle->event)
+		return -EBUSY;
+
+	ret = sink_ops(csdev)->set_buffer(csdev, event, handle);
+	if (ret)
+		return ret;
+
+	if (mode & PERF_EF_START) {
+		etm_event_start(event, 0);
+		if (hwc->state & PERF_HES_STOPPED) {
+			etm_event_del(event, 0);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
 static int __init etm_perf_init(void)
 {
 	etm_pmu.capabilities	= PERF_PMU_CAP_EXCLUSIVE;
@@ -258,6 +351,10 @@ static int __init etm_perf_init(void)
 	etm_pmu.event_init	= etm_event_init;
 	etm_pmu.setup_aux	= etm_setup_aux;
 	etm_pmu.free_aux	= etm_free_aux;
+	etm_pmu.stop		= etm_event_stop;
+	etm_pmu.start		= etm_event_start;
+	etm_pmu.del		= etm_event_del;
+	etm_pmu.add		= etm_event_add;
 
 	return perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 }
-- 
1.9.1
