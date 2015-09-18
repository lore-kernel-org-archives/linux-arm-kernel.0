From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:29 -0600
Subject: [RFC PATCH 15/20] coresight: etm-perf: implementing 'setup_aux()' API
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-16-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before trace can be collected the PMU needs to get a handle
on the mmpap'ed memory that was granted.  Since the collection
of traces can be done by sink buffers of various types,
representation of the memory layout is done at the sink level
rather than the tracer PMU driver.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index a21171a3e929..3aeb4215bb22 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -227,6 +227,27 @@ out:
 	return ret;
 }
 
+static void *etm_setup_aux(int cpu, void **pages,
+			      int nr_pages, bool overwrite)
+{
+	struct coresight_device *csdev;
+
+	if (cpu == -1)
+		cpu = smp_processor_id();
+
+	csdev = per_cpu(csdev_sink, cpu);
+	if (!csdev)
+		return NULL;
+
+	return sink_ops(csdev)->setup_aux(csdev, cpu, pages,
+					  nr_pages, overwrite);
+}
+
+static void etm_free_aux(void *data)
+{
+	kfree(data);
+}
+
 static int __init etm_perf_init(void)
 {
 	etm_pmu.capabilities	= PERF_PMU_CAP_EXCLUSIVE;
@@ -235,6 +256,8 @@ static int __init etm_perf_init(void)
 	etm_pmu.task_ctx_nr	= perf_sw_context;
 	etm_pmu.read		= etm_event_read;
 	etm_pmu.event_init	= etm_event_init;
+	etm_pmu.setup_aux	= etm_setup_aux;
+	etm_pmu.free_aux	= etm_free_aux;
 
 	return perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 }
-- 
1.9.1
