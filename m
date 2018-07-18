From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 18 Jul 2018 13:43:08 -0600
Subject: [PATCH] coresight: etm_perf: Rework alloc/free methods to avoid
 lockep warning
Message-ID: <1531942988-20901-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When enabling the lockdep mechanic and working with CPU-wide scenarios we
get the following console output:

[   54.632093] ======================================================
[   54.638207] WARNING: possible circular locking dependency detected
[   54.644322] 4.18.0-rc3-00042-g2d39e6356bb7-dirty #309 Not tainted
[   54.650350] ------------------------------------------------------
[   54.656464] perf/2862 is trying to acquire lock:
[   54.661031] 000000007e21d170 (&event->mmap_mutex){+.+.}, at: perf_event_set_output+0x98/0x138
[   54.669486]
[   54.669486] but task is already holding lock:
[   54.675256] 000000001080eb1b (&cpuctx_mutex){+.+.}, at: perf_event_ctx_lock_nested+0xf8/0x1f0
[   54.683704]
[   54.683704] which lock already depends on the new lock.
[   54.683704]
[   54.691797]
[   54.691797] the existing dependency chain (in reverse order) is:
[   54.699201]
[   54.699201] -> #3 (&cpuctx_mutex){+.+.}:
[   54.704556]        __mutex_lock+0x70/0x808
[   54.708608]        mutex_lock_nested+0x1c/0x28
[   54.713005]        perf_event_init_cpu+0x8c/0xd8
[   54.717574]        perf_event_init+0x194/0x1d4
[   54.721971]        start_kernel+0x2b8/0x42c
[   54.726107]
[   54.726107] -> #2 (pmus_lock){+.+.}:
[   54.731114]        __mutex_lock+0x70/0x808
[   54.735165]        mutex_lock_nested+0x1c/0x28
[   54.739560]        perf_event_init_cpu+0x30/0xd8
[   54.744129]        cpuhp_invoke_callback+0x84/0x248
[   54.748954]        _cpu_up+0xe8/0x1c8
[   54.752576]        do_cpu_up+0xa8/0xc8
[   54.756283]        cpu_up+0x10/0x18
[   54.759731]        smp_init+0xa0/0x114
[   54.763438]        kernel_init_freeable+0x120/0x288
[   54.768264]        kernel_init+0x10/0x108
[   54.772230]        ret_from_fork+0x10/0x18
[   54.776279]
[   54.776279] -> #1 (cpu_hotplug_lock.rw_sem){++++}:
[   54.782492]        cpus_read_lock+0x34/0xb0
[   54.786631]        etm_setup_aux+0x5c/0x308
[   54.790769]        rb_alloc_aux+0x1ec/0x300
[   54.794906]        perf_mmap+0x284/0x610
[   54.798787]        mmap_region+0x388/0x570
[   54.802838]        do_mmap+0x344/0x4f8
[   54.806544]        vm_mmap_pgoff+0xe4/0x110
[   54.810682]        ksys_mmap_pgoff+0xa8/0x240
[   54.814992]        sys_mmap+0x18/0x28
[   54.818613]        el0_svc_naked+0x30/0x34
[   54.822661]
[   54.822661] -> #0 (&event->mmap_mutex){+.+.}:
[   54.828445]        lock_acquire+0x48/0x68
[   54.832409]        __mutex_lock+0x70/0x808
[   54.836459]        mutex_lock_nested+0x1c/0x28
[   54.840855]        perf_event_set_output+0x98/0x138
[   54.845680]        _perf_ioctl+0x2a0/0x6a0
[   54.849731]        perf_ioctl+0x3c/0x68
[   54.853526]        do_vfs_ioctl+0xb8/0xa20
[   54.857577]        ksys_ioctl+0x80/0xb8
[   54.861370]        sys_ioctl+0xc/0x18
[   54.864990]        el0_svc_naked+0x30/0x34
[   54.869039]
[   54.869039] other info that might help us debug this:
[   54.869039]
[   54.876960] Chain exists of:
[   54.876960]   &event->mmap_mutex --> pmus_lock --> &cpuctx_mutex
[   54.876960]
[   54.887217]  Possible unsafe locking scenario:
[   54.887217]
[   54.893073]        CPU0                    CPU1
[   54.897552]        ----                    ----
[   54.902030]   lock(&cpuctx_mutex);
[   54.905396]                                lock(pmus_lock);
[   54.910911]                                lock(&cpuctx_mutex);
[   54.916770]   lock(&event->mmap_mutex);
[   54.920566]
[   54.920566]  *** DEADLOCK ***
[   54.920566]
[   54.926424] 1 lock held by perf/2862:
[   54.930042]  #0: 000000001080eb1b (&cpuctx_mutex){+.+.}, at: perf_event_ctx_lock_nested+0xf8/0x1f0

This is fixed by working with the cpu_present_mask, avoinding at the same
the need to use get/put_online_cpus() that triggers lockdep.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 39 +++++++++++++-----------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 677695635211..16b9c87d9d00 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -108,26 +108,32 @@ static int etm_event_init(struct perf_event *event)
 static void free_event_data(struct work_struct *work)
 {
 	int cpu;
+	void *snk_config;
 	cpumask_t *mask;
 	struct etm_event_data *event_data;
 	struct coresight_device *sink;
 
 	event_data = container_of(work, struct etm_event_data, work);
 	mask = &event_data->mask;
-	/*
-	 * First deal with the sink configuration.  See comment in
-	 * etm_setup_aux() about why we take the first available path.
-	 */
-	if (event_data->snk_config) {
-		cpu = cpumask_first(mask);
-		sink = coresight_get_sink(event_data->path[cpu]);
-		if (sink_ops(sink)->free_buffer)
-			sink_ops(sink)->free_buffer(event_data->snk_config);
-	}
+	snk_config = event_data->snk_config;
 
 	for_each_cpu(cpu, mask) {
-		if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
-			coresight_release_path(event_data->path[cpu]);
+		if (IS_ERR_OR_NULL(event_data->path[cpu]))
+			continue;
+
+		/*
+		 * Free sink configuration - there can only be one sink
+		 * per event.
+		 */
+		if (snk_config) {
+			sink = coresight_get_sink(event_data->path[cpu]);
+			if (sink_ops(sink)->free_buffer) {
+				sink_ops(sink)->free_buffer(snk_config);
+				snk_config = NULL;
+			}
+		}
+
+		coresight_release_path(event_data->path[cpu]);
 	}
 
 	kfree(event_data->path);
@@ -145,16 +151,13 @@ static void *alloc_event_data(int cpu)
 	if (!event_data)
 		return NULL;
 
-	/* Make sure nothing disappears under us */
-	get_online_cpus();
-	size = num_online_cpus();
-
 	mask = &event_data->mask;
+	size = num_present_cpus();
+
 	if (cpu != -1)
 		cpumask_set_cpu(cpu, mask);
 	else
-		cpumask_copy(mask, cpu_online_mask);
-	put_online_cpus();
+		cpumask_copy(mask, cpu_present_mask);
 
 	/*
 	 * Each CPU has a single path between source and destination.  As such
-- 
2.7.4
