From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 14 Jan 2013 17:08:51 +0000
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130114170851.GA1967@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 07:20:38PM -0500, Nicolas Pitre wrote:
> From: Dave Martin <dave.martin@linaro.org>
> 
> This provides helper methods to coordinate between CPUs coming down
> and CPUs going up, as well as documentation on the used algorithms,
> so that cluster teardown and setup
> operations are not done for a cluster simultaneously.

[...]

In response to the incorrectness of the outer cache handling,
here's a supplementary patch:

>From b64f305c90e7ea585992df2d710f62ec6a7b5395 Mon Sep 17 00:00:00 2001
From: Dave Martin <dave.martin@linaro.org>
Date: Mon, 14 Jan 2013 16:25:47 +0000
Subject: [PATCH] ARM: b.L: Fix outer cache handling for coherency setup/exit helpers

This patch addresses the following issues:

  * When invalidating stale data from the cache before a read,
    outer caches must be invalidated _before_ inner caches, not
    after, otherwise stale data may be re-filled from outer to
    inner after the inner cache is flushed.

    We still retain an inner clean before touching the outer cache,
    to avoid stale data being rewritten from there into the outer
    cache after the outer cache is flushed.

  * All the sync_mem() calls synchronise either reads or writes,
    but not both.  This patch splits sync_mem() into separate
    functions for reads and writes, to avoid excessive inner
    flushes in the write case.

    The two functions are different from the original sync_mem(),
    to fix the above issues.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
NOTE: This patch is build-tested only.

 arch/arm/common/bL_entry.c |   57 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c
index 1ea4ec9..3e1a404 100644
--- a/arch/arm/common/bL_entry.c
+++ b/arch/arm/common/bL_entry.c
@@ -119,16 +119,47 @@ int bL_cpu_powered_up(void)
 
 struct bL_sync_struct bL_sync;
 
-static void __sync_range(volatile void *p, size_t size)
+/*
+ * Ensure preceding writes to *p by this CPU are visible to
+ * subsequent reads by other CPUs:
+ */
+static void __sync_range_w(volatile void *p, size_t size)
 {
 	char *_p = (char *)p;
 
 	__cpuc_flush_dcache_area(_p, size);
-	outer_flush_range(__pa(_p), __pa(_p + size));
+	outer_clean_range(__pa(_p), __pa(_p + size));
 	outer_sync();
 }
 
-#define sync_mem(ptr) __sync_range(ptr, sizeof *(ptr))
+/*
+ * Ensure preceding writes to *p by other CPUs are visible to
+ * subsequent reads by this CPU:
+ */
+static void __sync_range_r(volatile void *p, size_t size)
+{
+	char *_p = (char *)p;
+
+#ifdef CONFIG_OUTER_CACHE
+	if (outer_cache.flush_range) {
+		/*
+		 * Ensure ditry data migrated from other CPUs into our cache
+		 * are cleaned out safely before the outer cache is cleaned:
+		 */
+		__cpuc_flush_dcache_area(_p, size);
+
+		/* Clean and invalidate stale data for *p from outer ... */
+		outer_flush_range(__pa(_p), __pa(_p + size));
+		outer_sync();
+	}
+#endif
+
+	/* ... and inner cache: */
+	__cpuc_flush_dcache_area(_p, size);
+}
+
+#define sync_w(ptr) __sync_range_w(ptr, sizeof *(ptr))
+#define sync_r(ptr) __sync_range_r(ptr, sizeof *(ptr))
 
 /*
  * __bL_cpu_going_down: Indicates that the cpu is being torn down.
@@ -138,7 +169,7 @@ static void __sync_range(volatile void *p, size_t size)
 void __bL_cpu_going_down(unsigned int cpu, unsigned int cluster)
 {
 	bL_sync.clusters[cluster].cpus[cpu].cpu = CPU_GOING_DOWN;
-	sync_mem(&bL_sync.clusters[cluster].cpus[cpu].cpu);
+	sync_w(&bL_sync.clusters[cluster].cpus[cpu].cpu);
 }
 
 /*
@@ -151,7 +182,7 @@ void __bL_cpu_down(unsigned int cpu, unsigned int cluster)
 {
 	dsb();
 	bL_sync.clusters[cluster].cpus[cpu].cpu = CPU_DOWN;
-	sync_mem(&bL_sync.clusters[cluster].cpus[cpu].cpu);
+	sync_w(&bL_sync.clusters[cluster].cpus[cpu].cpu);
 	sev();
 }
 
@@ -167,7 +198,7 @@ void __bL_outbound_leave_critical(unsigned int cluster, int state)
 {
 	dsb();
 	bL_sync.clusters[cluster].cluster = state;
-	sync_mem(&bL_sync.clusters[cluster].cluster);
+	sync_w(&bL_sync.clusters[cluster].cluster);
 	sev();
 }
 
@@ -189,10 +220,10 @@ bool __bL_outbound_enter_critical(unsigned int cpu, unsigned int cluster)
 
 	/* Warn inbound CPUs that the cluster is being torn down: */
 	c->cluster = CLUSTER_GOING_DOWN;
-	sync_mem(&c->cluster);
+	sync_w(&c->cluster);
 
 	/* Back out if the inbound cluster is already in the critical region: */
-	sync_mem(&c->inbound);
+	sync_r(&c->inbound);
 	if (c->inbound == INBOUND_COMING_UP)
 		goto abort;
 
@@ -203,7 +234,7 @@ bool __bL_outbound_enter_critical(unsigned int cpu, unsigned int cluster)
 	 * If any CPU has been woken up again from the DOWN state, then we
 	 * shouldn't be taking the cluster down at all: abort in that case.
 	 */
-	sync_mem(&c->cpus);
+	sync_r(&c->cpus);
 	for (i = 0; i < BL_CPUS_PER_CLUSTER; i++) {
 		int cpustate;
 
@@ -216,7 +247,7 @@ bool __bL_outbound_enter_critical(unsigned int cpu, unsigned int cluster)
 				break;
 
 			wfe();
-			sync_mem(&c->cpus[i].cpu);
+			sync_r(&c->cpus[i].cpu);
 		}
 
 		switch (cpustate) {
@@ -239,7 +270,7 @@ abort:
 
 int __bL_cluster_state(unsigned int cluster)
 {
-	sync_mem(&bL_sync.clusters[cluster].cluster);
+	sync_r(&bL_sync.clusters[cluster].cluster);
 	return bL_sync.clusters[cluster].cluster;
 }
 
@@ -267,11 +298,11 @@ int __init bL_cluster_sync_init(void (*power_up_setup)(void))
 	for_each_online_cpu(i)
 		bL_sync.clusters[this_cluster].cpus[i].cpu = CPU_UP;
 	bL_sync.clusters[this_cluster].cluster = CLUSTER_UP;
-	sync_mem(&bL_sync);
+	sync_w(&bL_sync);
 
 	if (power_up_setup) {
 		bL_power_up_setup_phys = virt_to_phys(power_up_setup);
-		sync_mem(&bL_power_up_setup_phys);
+		sync_w(&bL_power_up_setup_phys);
 	}
 
 	return 0;
-- 
1.7.4.1
