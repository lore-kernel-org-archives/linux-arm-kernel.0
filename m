From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:28 -0400
Subject: [PATCH 12/13] ARM: bL_switcher: remove assumptions between logical and
 physical CPUs
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-13-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to now, the logical CPU was somehow tied to the physical CPU number
within a cluster.  This causes problems when forcing the boot CPU to be
different from the first enumerated CPU in the device tree creating a
discrepancy between logical and physical CPU numbers.

Let's make the pairing completely independent from physical CPU numbers.

Let's keep only those logical CPUs with same initial CPU cluster to create
a uniform scheduler profile without having to modify any of the probed
topology and compute capacity data.  This has the potential to create
a non contiguous CPU numbering space when the switcher is active with
potential impact on buggy user space tools.  It is however better to fix
those tools rather than making the switcher code more intrusive.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c | 180 +++++++++++++++++++++++++-----------------
 1 file changed, 106 insertions(+), 74 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 2fe3911601..7bf2396cb0 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -54,21 +54,19 @@ static int read_mpidr(void)
 
 static void bL_do_switch(void *_unused)
 {
-	unsigned mpidr, cpuid, clusterid, ob_cluster, ib_cluster;
+	unsigned ib_mpidr, ib_cpu, ib_cluster;
 
 	pr_debug("%s\n", __func__);
 
-	mpidr = read_mpidr();
-	cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-	ob_cluster = clusterid;
-	ib_cluster = clusterid ^ 1;
+	ib_mpidr = cpu_logical_map(smp_processor_id());
+	ib_cpu = MPIDR_AFFINITY_LEVEL(ib_mpidr, 0);
+	ib_cluster = MPIDR_AFFINITY_LEVEL(ib_mpidr, 1);
 
 	/*
 	 * Our state has been saved at this point.  Let's release our
 	 * inbound CPU.
 	 */
-	mcpm_set_entry_vector(cpuid, ib_cluster, cpu_resume);
+	mcpm_set_entry_vector(ib_cpu, ib_cluster, cpu_resume);
 	sev();
 
 	/*
@@ -114,6 +112,7 @@ static int bL_switchpoint(unsigned long _arg)
  */
 
 static unsigned int bL_gic_id[MAX_CPUS_PER_CLUSTER][MAX_NR_CLUSTERS];
+static int bL_switcher_cpu_pairing[NR_CPUS];
 
 /*
  * bL_switch_to - Switch to a specific cluster for the current CPU
@@ -124,31 +123,38 @@ static unsigned int bL_gic_id[MAX_CPUS_PER_CLUSTER][MAX_NR_CLUSTERS];
  */
 static int bL_switch_to(unsigned int new_cluster_id)
 {
-	unsigned int mpidr, cpuid, clusterid, ob_cluster, ib_cluster, this_cpu;
+	unsigned int mpidr, this_cpu, that_cpu;
+	unsigned int ob_mpidr, ob_cpu, ob_cluster, ib_mpidr, ib_cpu, ib_cluster;
 	struct tick_device *tdev;
 	enum clock_event_mode tdev_mode;
 	int ret;
 
-	mpidr = read_mpidr();
-	cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-	ob_cluster = clusterid;
-	ib_cluster = clusterid ^ 1;
+	this_cpu = smp_processor_id();
+	ob_mpidr = read_mpidr();
+	ob_cpu = MPIDR_AFFINITY_LEVEL(ob_mpidr, 0);
+	ob_cluster = MPIDR_AFFINITY_LEVEL(ob_mpidr, 1);
+	BUG_ON(cpu_logical_map(this_cpu) != ob_mpidr);
 
-	if (new_cluster_id == clusterid)
+	if (new_cluster_id == ob_cluster)
 		return 0;
 
-	pr_debug("before switch: CPU %d in cluster %d\n", cpuid, clusterid);
+	that_cpu = bL_switcher_cpu_pairing[this_cpu];
+	ib_mpidr = cpu_logical_map(that_cpu);
+	ib_cpu = MPIDR_AFFINITY_LEVEL(ib_mpidr, 0);
+	ib_cluster = MPIDR_AFFINITY_LEVEL(ib_mpidr, 1);
+
+	pr_debug("before switch: CPU %d MPIDR %#x -> %#x\n",
+		 this_cpu, ob_mpidr, ib_mpidr);
 
 	/* Close the gate for our entry vectors */
-	mcpm_set_entry_vector(cpuid, ob_cluster, NULL);
-	mcpm_set_entry_vector(cpuid, ib_cluster, NULL);
+	mcpm_set_entry_vector(ob_cpu, ob_cluster, NULL);
+	mcpm_set_entry_vector(ib_cpu, ib_cluster, NULL);
 
 	/*
 	 * Let's wake up the inbound CPU now in case it requires some delay
 	 * to come online, but leave it gated in our entry vector code.
 	 */
-	ret = mcpm_cpu_power_up(cpuid, ib_cluster);
+	ret = mcpm_cpu_power_up(ib_cpu, ib_cluster);
 	if (ret) {
 		pr_err("%s: mcpm_cpu_power_up() returned %d\n", __func__, ret);
 		return ret;
@@ -161,10 +167,8 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	local_irq_disable();
 	local_fiq_disable();
 
-	this_cpu = smp_processor_id();
-
 	/* redirect GIC's SGIs to our counterpart */
-	gic_migrate_target(bL_gic_id[cpuid][ib_cluster]);
+	gic_migrate_target(bL_gic_id[ib_cpu][ib_cluster]);
 
 	/*
 	 * Raise a SGI on the inbound CPU to make sure it doesn't stall
@@ -187,11 +191,12 @@ static int bL_switch_to(unsigned int new_cluster_id)
 		panic("%s: cpu_pm_enter() returned %d\n", __func__, ret);
 
 	/*
-	 * Flip the cluster in the CPU logical map for this CPU.
+	 * Swap the physical CPUs in the logical map for this logical CPU.
 	 * This must be flushed to RAM as the resume code
 	 * needs to access it while the caches are still disabled.
 	 */
-	cpu_logical_map(this_cpu) ^= (1 << 8);
+	cpu_logical_map(this_cpu) = ib_mpidr;
+	cpu_logical_map(that_cpu) = ob_mpidr;
 	sync_cache_w(&cpu_logical_map(this_cpu));
 
 	/* Let's do the actual CPU switch. */
@@ -201,10 +206,8 @@ static int bL_switch_to(unsigned int new_cluster_id)
 
 	/* We are executing on the inbound CPU@this point */
 	mpidr = read_mpidr();
-	cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-	pr_debug("after switch: CPU %d in cluster %d\n", cpuid, clusterid);
-	BUG_ON(clusterid != ib_cluster);
+	pr_debug("after switch: CPU %d MPIDR %#x\n", this_cpu, mpidr);
+	BUG_ON(mpidr != ib_mpidr);
 
 	mcpm_cpu_powered_up();
 
@@ -231,7 +234,7 @@ struct bL_thread {
 	struct completion started;
 };
 
-static struct bL_thread bL_threads[MAX_CPUS_PER_CLUSTER];
+static struct bL_thread bL_threads[NR_CPUS];
 
 static int bL_switcher_thread(void *arg)
 {
@@ -284,7 +287,7 @@ int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id)
 {
 	struct bL_thread *t;
 
-	if (cpu >= MAX_CPUS_PER_CLUSTER) {
+	if (cpu >= ARRAY_SIZE(bL_threads)) {
 		pr_err("%s: cpu %d out of bounds\n", __func__, cpu);
 		return -EINVAL;
 	}
@@ -306,7 +309,7 @@ EXPORT_SYMBOL_GPL(bL_switch_request);
  */
 
 static unsigned int bL_switcher_active;
-static unsigned int bL_switcher_cpu_original_cluster[MAX_CPUS_PER_CLUSTER];
+static unsigned int bL_switcher_cpu_original_cluster[NR_CPUS];
 static cpumask_t bL_switcher_removed_logical_cpus;
 
 static void bL_switcher_restore_cpus(void)
@@ -319,52 +322,86 @@ static void bL_switcher_restore_cpus(void)
 
 static int bL_switcher_halve_cpus(void)
 {
-	int cpu, cluster, i, ret;
-	cpumask_t cluster_mask[2], common_mask;
-
-	cpumask_clear(&bL_switcher_removed_logical_cpus);
-	cpumask_clear(&cluster_mask[0]);
-	cpumask_clear(&cluster_mask[1]);
+	int i, j, cluster_0, gic_id, ret;
+	unsigned int cpu, cluster, mask;
+	cpumask_t available_cpus;
 
+	/* First pass to validate what we have */
+	mask = 0;
 	for_each_online_cpu(i) {
-		cpu = cpu_logical_map(i) & 0xff;
-		cluster = (cpu_logical_map(i) >> 8) & 0xff;
+		cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 0);
+		cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 1);
 		if (cluster >= 2) {
 			pr_err("%s: only dual cluster systems are supported\n", __func__);
 			return -EINVAL;
 		}
-		cpumask_set_cpu(cpu, &cluster_mask[cluster]);
+		if (WARN_ON(cpu >= MAX_CPUS_PER_CLUSTER))
+			return -EINVAL;
+		mask |= (1 << cluster);
 	}
-
-	if (!cpumask_and(&common_mask, &cluster_mask[0], &cluster_mask[1])) {
-		pr_err("%s: no common set of CPUs\n", __func__);
+	if (mask != 3) {
+		pr_err("%s: no CPU pairing possible\n", __func__);
 		return -EINVAL;
 	}
 
-	for_each_online_cpu(i) {
-		cpu = cpu_logical_map(i) & 0xff;
-		cluster = (cpu_logical_map(i) >> 8) & 0xff;
-
-		if (cpumask_test_cpu(cpu, &common_mask)) {
-			/* Let's take note of the GIC ID for this CPU */
-			int gic_id = gic_get_cpu_id(i);
-			if (gic_id < 0) {
-				pr_err("%s: bad GIC ID for CPU %d\n", __func__, i);
-				return -EINVAL;
-			}
-			bL_gic_id[cpu][cluster] = gic_id;
-			pr_info("GIC ID for CPU %u cluster %u is %u\n",
-				cpu, cluster, gic_id);
-
+	/*
+	 * Now let's do the pairing.  We match each CPU with another CPU
+	 * from a different cluster.  To get a uniform scheduling behavior
+	 * without fiddling with CPU topology and compute capacity data,
+	 * we'll use logical CPUs initially belonging to the same cluster.
+	 */
+	memset(bL_switcher_cpu_pairing, -1, sizeof(bL_switcher_cpu_pairing));
+	cpumask_copy(&available_cpus, cpu_online_mask);
+	cluster_0 = -1;
+	for_each_cpu(i, &available_cpus) {
+		int match = -1;
+		cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 1);
+		if (cluster_0 == -1)
+			cluster_0 = cluster;
+		if (cluster != cluster_0)
+			continue;
+		cpumask_clear_cpu(i, &available_cpus);
+		for_each_cpu(j, &available_cpus) {
+			cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(j), 1);
 			/*
-			 * We keep only those logical CPUs which number
-			 * is equal to their physical CPU number. This is
-			 * not perfect but good enough for now.
+			 * Let's remember the last match to create "odd"
+			 * pairings on purpose in order for other code not
+			 * to assume any relation between physical and
+			 * logical CPU numbers.
 			 */
-			if (cpu == i) {
-				bL_switcher_cpu_original_cluster[cpu] = cluster;
-				continue;
-			}
+			if (cluster != cluster_0)
+				match = j;
+		}
+		if (match != -1) {
+			bL_switcher_cpu_pairing[i] = match;
+			cpumask_clear_cpu(match, &available_cpus);
+			pr_info("CPU%d paired with CPU%d\n", i, match);
+		}
+	}
+
+	/*
+	 * Now we disable the unwanted CPUs i.e. everything that has no
+	 * pairing information (that includes the pairing counterparts).
+	 */
+	cpumask_clear(&bL_switcher_removed_logical_cpus);
+	for_each_online_cpu(i) {
+		cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 0);
+		cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 1);
+
+		/* Let's take note of the GIC ID for this CPU */
+		gic_id = gic_get_cpu_id(i);
+		if (gic_id < 0) {
+			pr_err("%s: bad GIC ID for CPU %d\n", __func__, i);
+			bL_switcher_restore_cpus();
+			return -EINVAL;
+		}
+		bL_gic_id[cpu][cluster] = gic_id;
+		pr_info("GIC ID for CPU %u cluster %u is %u\n",
+			cpu, cluster, gic_id);
+
+		if (bL_switcher_cpu_pairing[i] != -1) {
+			bL_switcher_cpu_original_cluster[i] = cluster;
+			continue;
 		}
 
 		ret = cpu_down(i);
@@ -415,7 +452,7 @@ static int bL_switcher_enable(void)
 
 static void bL_switcher_disable(void)
 {
-	unsigned int cpu, cluster, i;
+	unsigned int cpu, cluster;
 	struct bL_thread *t;
 	struct task_struct *task;
 
@@ -435,7 +472,6 @@ static void bL_switcher_disable(void)
 	 * possibility for interference from external requests.
 	 */
 	for_each_online_cpu(cpu) {
-		BUG_ON(cpu != (cpu_logical_map(cpu) & 0xff));
 		t = &bL_threads[cpu];
 		task = t->task;
 		t->task = NULL;
@@ -459,14 +495,10 @@ static void bL_switcher_disable(void)
 		/* If execution gets here, we're in trouble. */
 		pr_crit("%s: unable to restore original cluster for CPU %d\n",
 			__func__, cpu);
-		for_each_cpu(i, &bL_switcher_removed_logical_cpus) {
-			if ((cpu_logical_map(i) & 0xff) != cpu)
-				continue;
-			pr_crit("%s: CPU %d can't be restored\n",
-				__func__, i);
-			cpumask_clear_cpu(i, &bL_switcher_removed_logical_cpus);
-			break;
-		}
+		pr_crit("%s: CPU %d can't be restored\n",
+			__func__, bL_switcher_cpu_pairing[cpu]);
+		cpumask_clear_cpu(bL_switcher_cpu_pairing[cpu],
+				  &bL_switcher_removed_logical_cpus);
 	}
 
 	bL_switcher_restore_cpus();
-- 
1.8.1.2
