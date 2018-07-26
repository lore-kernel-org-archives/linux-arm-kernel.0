From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 26 Jul 2018 13:54:43 +0100
Subject: [PATCH v3 05/13] coresight: perf: Allow tracing on hotplugged CPUs
In-Reply-To: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1532609691-16863-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment, if there is no CPU specified for a given
event, we use cpu_online_mask and try to build path for
each of the CPUs in the mask. This could prevent any CPU
that is turned online later to be used for the tracing.

This patch changes to use the cpu_present_mask and tries
to build path for as much CPUs as possible ignoring the
failures in building path for some of the CPUs. If ever
we try to trace on those CPUs, we fail the operation.

Based on a patch from Mathieu Poirier.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 46 +++++++++++++++---------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6beb662..afe7e7f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -127,11 +127,9 @@ static void free_event_data(struct work_struct *work)
 
 	event_data = container_of(work, struct etm_event_data, work);
 	mask = &event_data->mask;
-	/*
-	 * First deal with the sink configuration.  See comment in
-	 * etm_setup_aux() about why we take the first available path.
-	 */
-	if (event_data->snk_config) {
+
+	/* Free the sink buffers, if there are any */
+	if (event_data->snk_config && !WARN_ON(cpumask_empty(mask))) {
 		cpu = cpumask_first(mask);
 		sink = coresight_get_sink(etm_event_cpu_path(event_data, cpu));
 		if (sink_ops(sink)->free_buffer)
@@ -166,7 +164,7 @@ static void *alloc_event_data(int cpu)
 	if (cpu != -1)
 		cpumask_set_cpu(cpu, mask);
 	else
-		cpumask_copy(mask, cpu_online_mask);
+		cpumask_copy(mask, cpu_present_mask);
 
 	/*
 	 * Each CPU has a single path between source and destination.  As such
@@ -218,19 +216,32 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
 	 */
 	sink = coresight_get_enabled_sink(true);
-	if (!sink)
+	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
 	mask = &event_data->mask;
 
-	/* Setup the path for each CPU in a trace session */
+	/*
+	 * Setup the path for each CPU in a trace session. We try to build
+	 * trace path for each CPU in the mask. If we don't find an ETM
+	 * for the CPU or fail to build a path, we clear the CPU from the
+	 * mask and continue with the rest. If ever we try to trace on those
+	 * CPUs, we can handle it and fail the session.
+	 */
 	for_each_cpu(cpu, mask) {
 		struct list_head *path;
 		struct coresight_device *csdev;
 
 		csdev = per_cpu(csdev_src, cpu);
-		if (!csdev)
-			goto err;
+		/*
+		 * If there is no ETM associated with this CPU clear it from
+		 * the mask and continue with the rest. If ever we try to trace
+		 * on this CPU, we handle it accordingly.
+		 */
+		if (!csdev) {
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
 
 		/*
 		 * Building a path doesn't enable it, it simply builds a
@@ -238,17 +249,20 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 		 * referenced later when the path is actually needed.
 		 */
 		path = coresight_build_path(csdev, sink);
-		if (IS_ERR(path))
-			goto err;
+		if (IS_ERR(path)) {
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
 
 		*etm_event_cpu_path_ptr(event_data, cpu) = path;
 	}
 
-	if (!sink_ops(sink)->alloc_buffer)
-		goto err;
-
+	/* If we don't have any CPUs ready for tracing, abort */
 	cpu = cpumask_first(mask);
-	/* Get the AUX specific data from the sink buffer */
+	if (cpu >= nr_cpu_ids)
+		goto err;
+
+	/* Allocate the sink buffer for this session */
 	event_data->snk_config =
 			sink_ops(sink)->alloc_buffer(sink, cpu, pages,
 						     nr_pages, overwrite);
-- 
2.7.4
