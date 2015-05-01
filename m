From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 01 May 2015 12:06:30 -0400
Subject: [PATCH 3/5] ARM: MCPM: make internal helpers private to the core code
In-Reply-To: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1430496392-15956-4-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This concerns the following helpers:

	__mcpm_cpu_going_down()
	__mcpm_cpu_down()
	__mcpm_outbound_enter_critical()
	__mcpm_outbound_leave_critical()
	__mcpm_cluster_state()

They are and should only be used by the core code now.  Therefore their
declarations are removed from mcpm.h and their definitions are made
static, hence the need to move them before their users which accounts
for the bulk of this patch.

This left the mcpm_sync_struct definition at an odd location, therefore
it is moved as well with some comment clarifications.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/mcpm_entry.c | 229 ++++++++++++++++++++++---------------------
 arch/arm/include/asm/mcpm.h  |  52 +++++-----
 2 files changed, 138 insertions(+), 143 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 0908f96278..c5fe2e33e6 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -20,6 +20,121 @@
 #include <asm/cputype.h>
 #include <asm/suspend.h>
 
+
+struct sync_struct mcpm_sync;
+
+/*
+ * __mcpm_cpu_going_down: Indicates that the cpu is being torn down.
+ *    This must be called at the point of committing to teardown of a CPU.
+ *    The CPU cache (SCTRL.C bit) is expected to still be active.
+ */
+static void __mcpm_cpu_going_down(unsigned int cpu, unsigned int cluster)
+{
+	mcpm_sync.clusters[cluster].cpus[cpu].cpu = CPU_GOING_DOWN;
+	sync_cache_w(&mcpm_sync.clusters[cluster].cpus[cpu].cpu);
+}
+
+/*
+ * __mcpm_cpu_down: Indicates that cpu teardown is complete and that the
+ *    cluster can be torn down without disrupting this CPU.
+ *    To avoid deadlocks, this must be called before a CPU is powered down.
+ *    The CPU cache (SCTRL.C bit) is expected to be off.
+ *    However L2 cache might or might not be active.
+ */
+static void __mcpm_cpu_down(unsigned int cpu, unsigned int cluster)
+{
+	dmb();
+	mcpm_sync.clusters[cluster].cpus[cpu].cpu = CPU_DOWN;
+	sync_cache_w(&mcpm_sync.clusters[cluster].cpus[cpu].cpu);
+	sev();
+}
+
+/*
+ * __mcpm_outbound_leave_critical: Leave the cluster teardown critical section.
+ * @state: the final state of the cluster:
+ *     CLUSTER_UP: no destructive teardown was done and the cluster has been
+ *         restored to the previous state (CPU cache still active); or
+ *     CLUSTER_DOWN: the cluster has been torn-down, ready for power-off
+ *         (CPU cache disabled, L2 cache either enabled or disabled).
+ */
+static void __mcpm_outbound_leave_critical(unsigned int cluster, int state)
+{
+	dmb();
+	mcpm_sync.clusters[cluster].cluster = state;
+	sync_cache_w(&mcpm_sync.clusters[cluster].cluster);
+	sev();
+}
+
+/*
+ * __mcpm_outbound_enter_critical: Enter the cluster teardown critical section.
+ * This function should be called by the last man, after local CPU teardown
+ * is complete.  CPU cache expected to be active.
+ *
+ * Returns:
+ *     false: the critical section was not entered because an inbound CPU was
+ *         observed, or the cluster is already being set up;
+ *     true: the critical section was entered: it is now safe to tear down the
+ *         cluster.
+ */
+static bool __mcpm_outbound_enter_critical(unsigned int cpu, unsigned int cluster)
+{
+	unsigned int i;
+	struct mcpm_sync_struct *c = &mcpm_sync.clusters[cluster];
+
+	/* Warn inbound CPUs that the cluster is being torn down: */
+	c->cluster = CLUSTER_GOING_DOWN;
+	sync_cache_w(&c->cluster);
+
+	/* Back out if the inbound cluster is already in the critical region: */
+	sync_cache_r(&c->inbound);
+	if (c->inbound == INBOUND_COMING_UP)
+		goto abort;
+
+	/*
+	 * Wait for all CPUs to get out of the GOING_DOWN state, so that local
+	 * teardown is complete on each CPU before tearing down the cluster.
+	 *
+	 * If any CPU has been woken up again from the DOWN state, then we
+	 * shouldn't be taking the cluster down at all: abort in that case.
+	 */
+	sync_cache_r(&c->cpus);
+	for (i = 0; i < MAX_CPUS_PER_CLUSTER; i++) {
+		int cpustate;
+
+		if (i == cpu)
+			continue;
+
+		while (1) {
+			cpustate = c->cpus[i].cpu;
+			if (cpustate != CPU_GOING_DOWN)
+				break;
+
+			wfe();
+			sync_cache_r(&c->cpus[i].cpu);
+		}
+
+		switch (cpustate) {
+		case CPU_DOWN:
+			continue;
+
+		default:
+			goto abort;
+		}
+	}
+
+	return true;
+
+abort:
+	__mcpm_outbound_leave_critical(cluster, CLUSTER_UP);
+	return false;
+}
+
+static int __mcpm_cluster_state(unsigned int cluster)
+{
+	sync_cache_r(&mcpm_sync.clusters[cluster].cluster);
+	return mcpm_sync.clusters[cluster].cluster;
+}
+
 extern unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
 
 void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
@@ -299,120 +414,6 @@ int __init mcpm_loopback(void (*cache_disable)(void))
 
 #endif
 
-struct sync_struct mcpm_sync;
-
-/*
- * __mcpm_cpu_going_down: Indicates that the cpu is being torn down.
- *    This must be called at the point of committing to teardown of a CPU.
- *    The CPU cache (SCTRL.C bit) is expected to still be active.
- */
-void __mcpm_cpu_going_down(unsigned int cpu, unsigned int cluster)
-{
-	mcpm_sync.clusters[cluster].cpus[cpu].cpu = CPU_GOING_DOWN;
-	sync_cache_w(&mcpm_sync.clusters[cluster].cpus[cpu].cpu);
-}
-
-/*
- * __mcpm_cpu_down: Indicates that cpu teardown is complete and that the
- *    cluster can be torn down without disrupting this CPU.
- *    To avoid deadlocks, this must be called before a CPU is powered down.
- *    The CPU cache (SCTRL.C bit) is expected to be off.
- *    However L2 cache might or might not be active.
- */
-void __mcpm_cpu_down(unsigned int cpu, unsigned int cluster)
-{
-	dmb();
-	mcpm_sync.clusters[cluster].cpus[cpu].cpu = CPU_DOWN;
-	sync_cache_w(&mcpm_sync.clusters[cluster].cpus[cpu].cpu);
-	sev();
-}
-
-/*
- * __mcpm_outbound_leave_critical: Leave the cluster teardown critical section.
- * @state: the final state of the cluster:
- *     CLUSTER_UP: no destructive teardown was done and the cluster has been
- *         restored to the previous state (CPU cache still active); or
- *     CLUSTER_DOWN: the cluster has been torn-down, ready for power-off
- *         (CPU cache disabled, L2 cache either enabled or disabled).
- */
-void __mcpm_outbound_leave_critical(unsigned int cluster, int state)
-{
-	dmb();
-	mcpm_sync.clusters[cluster].cluster = state;
-	sync_cache_w(&mcpm_sync.clusters[cluster].cluster);
-	sev();
-}
-
-/*
- * __mcpm_outbound_enter_critical: Enter the cluster teardown critical section.
- * This function should be called by the last man, after local CPU teardown
- * is complete.  CPU cache expected to be active.
- *
- * Returns:
- *     false: the critical section was not entered because an inbound CPU was
- *         observed, or the cluster is already being set up;
- *     true: the critical section was entered: it is now safe to tear down the
- *         cluster.
- */
-bool __mcpm_outbound_enter_critical(unsigned int cpu, unsigned int cluster)
-{
-	unsigned int i;
-	struct mcpm_sync_struct *c = &mcpm_sync.clusters[cluster];
-
-	/* Warn inbound CPUs that the cluster is being torn down: */
-	c->cluster = CLUSTER_GOING_DOWN;
-	sync_cache_w(&c->cluster);
-
-	/* Back out if the inbound cluster is already in the critical region: */
-	sync_cache_r(&c->inbound);
-	if (c->inbound == INBOUND_COMING_UP)
-		goto abort;
-
-	/*
-	 * Wait for all CPUs to get out of the GOING_DOWN state, so that local
-	 * teardown is complete on each CPU before tearing down the cluster.
-	 *
-	 * If any CPU has been woken up again from the DOWN state, then we
-	 * shouldn't be taking the cluster down at all: abort in that case.
-	 */
-	sync_cache_r(&c->cpus);
-	for (i = 0; i < MAX_CPUS_PER_CLUSTER; i++) {
-		int cpustate;
-
-		if (i == cpu)
-			continue;
-
-		while (1) {
-			cpustate = c->cpus[i].cpu;
-			if (cpustate != CPU_GOING_DOWN)
-				break;
-
-			wfe();
-			sync_cache_r(&c->cpus[i].cpu);
-		}
-
-		switch (cpustate) {
-		case CPU_DOWN:
-			continue;
-
-		default:
-			goto abort;
-		}
-	}
-
-	return true;
-
-abort:
-	__mcpm_outbound_leave_critical(cluster, CLUSTER_UP);
-	return false;
-}
-
-int __mcpm_cluster_state(unsigned int cluster)
-{
-	sync_cache_r(&mcpm_sync.clusters[cluster].cluster);
-	return mcpm_sync.clusters[cluster].cluster;
-}
-
 extern unsigned long mcpm_power_up_setup_phys;
 
 int __init mcpm_sync_init(
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index e2118c941d..6a40d5f8db 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -245,35 +245,6 @@ struct mcpm_platform_ops {
  */
 int __init mcpm_platform_register(const struct mcpm_platform_ops *ops);
 
-/* Synchronisation structures for coordinating safe cluster setup/teardown: */
-
-/*
- * When modifying this structure, make sure you update the MCPM_SYNC_ defines
- * to match.
- */
-struct mcpm_sync_struct {
-	/* individual CPU states */
-	struct {
-		s8 cpu __aligned(__CACHE_WRITEBACK_GRANULE);
-	} cpus[MAX_CPUS_PER_CLUSTER];
-
-	/* cluster state */
-	s8 cluster __aligned(__CACHE_WRITEBACK_GRANULE);
-
-	/* inbound-side state */
-	s8 inbound __aligned(__CACHE_WRITEBACK_GRANULE);
-};
-
-struct sync_struct {
-	struct mcpm_sync_struct clusters[MAX_NR_CLUSTERS];
-};
-
-void __mcpm_cpu_going_down(unsigned int cpu, unsigned int cluster);
-void __mcpm_cpu_down(unsigned int cpu, unsigned int cluster);
-void __mcpm_outbound_leave_critical(unsigned int cluster, int state);
-bool __mcpm_outbound_enter_critical(unsigned int this_cpu, unsigned int cluster);
-int __mcpm_cluster_state(unsigned int cluster);
-
 /**
  * mcpm_sync_init - Initialize the cluster synchronization support
  *
@@ -312,6 +283,29 @@ int __init mcpm_loopback(void (*cache_disable)(void));
 
 void __init mcpm_smp_set_ops(void);
 
+/*
+ * Synchronisation structures for coordinating safe cluster setup/teardown.
+ * This is private to the MCPM core code and shared between C and assembly.
+ * When modifying this structure, make sure you update the MCPM_SYNC_ defines
+ * to match.
+ */
+struct mcpm_sync_struct {
+	/* individual CPU states */
+	struct {
+		s8 cpu __aligned(__CACHE_WRITEBACK_GRANULE);
+	} cpus[MAX_CPUS_PER_CLUSTER];
+
+	/* cluster state */
+	s8 cluster __aligned(__CACHE_WRITEBACK_GRANULE);
+
+	/* inbound-side state */
+	s8 inbound __aligned(__CACHE_WRITEBACK_GRANULE);
+};
+
+struct sync_struct {
+	struct mcpm_sync_struct clusters[MAX_NR_CLUSTERS];
+};
+
 #else
 
 /* 
-- 
2.1.0
