From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Mar 2015 14:04:48 -0400
Subject: [PATCH RFC/RFT 1/6] MCPM: move the algorithmic complexity to the core
 code
In-Reply-To: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
References: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1426701893-25589-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All backends are reimplementing a variation of the same CPU reference
count handling. They are also responsible for driving the MCPM special
low-level locking. This is needless duplication, involving algorithmic
requirements that are not necessarily obvious to the uninitiated.
And from past code review experience, those were all initially
implemented badly.

After 3 years, it is time to refactor as much common code to the core
MCPM facility to make the backends as simple as possible.  To avoid a
flag day, the new scheme is introduced in parallel to the existing
backend interface.  When all backends are converted over, the
compatibility interface could be removed.

The new MCPM backend interface implements simpler methods addressing
very platform specific tasks performed under lock protection while
keeping the algorithmic complexity and race avoidance local to the
core code.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/mcpm_entry.c | 202 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/include/asm/mcpm.h  |  65 +++++++++++++-
 2 files changed, 233 insertions(+), 34 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 3c165fc2dc..5f8a52ac7e 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -55,22 +55,81 @@ bool mcpm_is_available(void)
 	return (platform_ops) ? true : false;
 }
 
+/*
+ * We can't use regular spinlocks. In the switcher case, it is possible
+ * for an outbound CPU to call power_down() after its inbound counterpart
+ * is already live using the same logical CPU number which trips lockdep
+ * debugging.
+ */
+static arch_spinlock_t mcpm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+
+static int mcpm_cpu_use_count[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
+
+static inline bool mcpm_cluster_unused(unsigned int cluster)
+{
+	int i, cnt;
+	for (i = 0, cnt = 0; i < MAX_CPUS_PER_CLUSTER; i++)
+		cnt |= mcpm_cpu_use_count[cluster][i];
+	return !cnt;
+}
+
 int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster)
 {
+	bool cpu_is_down, cluster_is_down;
+	int ret = 0;
+
 	if (!platform_ops)
 		return -EUNATCH; /* try not to shadow power_up errors */
 	might_sleep();
-	return platform_ops->power_up(cpu, cluster);
+
+	/* backward compatibility callback */
+	if (platform_ops->power_up)
+		return platform_ops->power_up(cpu, cluster);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+
+	/*
+	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
+	 * variant exists, we need to disable IRQs manually here.
+	 */
+	local_irq_disable();
+	arch_spin_lock(&mcpm_lock);
+
+	cpu_is_down = !mcpm_cpu_use_count[cluster][cpu];
+	cluster_is_down = mcpm_cluster_unused(cluster);
+
+	mcpm_cpu_use_count[cluster][cpu]++;
+	/*
+	 * The only possible values are:
+	 * 0 = CPU down
+	 * 1 = CPU (still) up
+	 * 2 = CPU requested to be up before it had a chance
+	 *     to actually make itself down.
+	 * Any other value is a bug.
+	 */
+	BUG_ON(mcpm_cpu_use_count[cluster][cpu] != 1 &&
+	       mcpm_cpu_use_count[cluster][cpu] != 2);
+
+	if (cluster_is_down)
+		ret = platform_ops->cluster_powerup(cluster);
+	if (cpu_is_down && !ret)
+		ret = platform_ops->cpu_powerup(cpu, cluster);
+
+	arch_spin_unlock(&mcpm_lock);
+	local_irq_enable();
+	return ret;
 }
 
 typedef void (*phys_reset_t)(unsigned long);
 
 void mcpm_cpu_power_down(void)
 {
+	unsigned int mpidr, cpu, cluster;
+	bool cpu_going_down, last_man;
 	phys_reset_t phys_reset;
 
-	if (WARN_ON_ONCE(!platform_ops || !platform_ops->power_down))
-		return;
+	if (WARN_ON_ONCE(!platform_ops))
+	       return;
 	BUG_ON(!irqs_disabled());
 
 	/*
@@ -79,28 +138,65 @@ void mcpm_cpu_power_down(void)
 	 */
 	setup_mm_for_reboot();
 
-	platform_ops->power_down();
+	/* backward compatibility callback */
+	if (platform_ops->power_down) {
+		platform_ops->power_down();
+		goto not_dead;
+	}
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+
+	__mcpm_cpu_going_down(cpu, cluster);
 
+	arch_spin_lock(&mcpm_lock);
+	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
+
+	mcpm_cpu_use_count[cluster][cpu]--;
+	BUG_ON(mcpm_cpu_use_count[cluster][cpu] != 0 &&
+	       mcpm_cpu_use_count[cluster][cpu] != 1);
+	cpu_going_down = !mcpm_cpu_use_count[cluster][cpu];
+	last_man = mcpm_cluster_unused(cluster);
+
+	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
+		platform_ops->cpu_powerdown_prepare(cpu, cluster);
+		platform_ops->cluster_powerdown_prepare(cluster);
+		arch_spin_unlock(&mcpm_lock);
+		platform_ops->cluster_cache_disable();
+		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
+	} else {
+		if (cpu_going_down)
+			platform_ops->cpu_powerdown_prepare(cpu, cluster);
+		arch_spin_unlock(&mcpm_lock);
+		/*
+		 * If cpu_going_down is false here, that means a power_up
+		 * request raced ahead of us.  Even if we do not want to
+		 * shut this CPU down, the caller still expects execution
+		 * to return through the system resume entry path, like
+		 * when the WFI is aborted due to a new IRQ or the like..
+		 * So let's continue with cache cleaning in all cases.
+		 */
+		platform_ops->cpu_cache_disable();
+	}
+
+	__mcpm_cpu_down(cpu, cluster);
+
+	/* Now we are prepared for power-down, do it: */
+	if (cpu_going_down)
+		wfi();
+
+not_dead:
 	/*
 	 * It is possible for a power_up request to happen concurrently
 	 * with a power_down request for the same CPU. In this case the
-	 * power_down method might not be able to actually enter a
-	 * powered down state with the WFI instruction if the power_up
-	 * method has removed the required reset condition.  The
-	 * power_down method is then allowed to return. We must perform
-	 * a re-entry in the kernel as if the power_up method just had
-	 * deasserted reset on the CPU.
-	 *
-	 * To simplify race issues, the platform specific implementation
-	 * must accommodate for the possibility of unordered calls to
-	 * power_down and power_up with a usage count. Therefore, if a
-	 * call to power_up is issued for a CPU that is not down, then
-	 * the next call to power_down must not attempt a full shutdown
-	 * but only do the minimum (normally disabling L1 cache and CPU
-	 * coherency) and return just as if a concurrent power_up request
-	 * had happened as described above.
+	 * CPU might not be able to actually enter a powered down state
+	 * with the WFI instruction if the power_up request has removed
+	 * the required reset condition.  We must perform a re-entry in
+	 * the kernel as if the power_up method just had deasserted reset
+	 * on the CPU.
 	 */
-
 	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
 	phys_reset(virt_to_phys(mcpm_entry_point));
 
@@ -125,26 +221,66 @@ int mcpm_wait_for_cpu_powerdown(unsigned int cpu, unsigned int cluster)
 
 void mcpm_cpu_suspend(u64 expected_residency)
 {
-	phys_reset_t phys_reset;
-
-	if (WARN_ON_ONCE(!platform_ops || !platform_ops->suspend))
+	if (WARN_ON_ONCE(!platform_ops))
 		return;
-	BUG_ON(!irqs_disabled());
 
-	/* Very similar to mcpm_cpu_power_down() */
-	setup_mm_for_reboot();
-	platform_ops->suspend(expected_residency);
-	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
-	phys_reset(virt_to_phys(mcpm_entry_point));
-	BUG();
+	/* backward compatibility callback */
+	if (platform_ops->suspend) {
+		phys_reset_t phys_reset;
+		BUG_ON(!irqs_disabled());
+		setup_mm_for_reboot();
+		platform_ops->suspend(expected_residency);
+		phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+		phys_reset(virt_to_phys(mcpm_entry_point));
+		BUG();
+	}
+
+	/* Some platforms might have to enable special resume modes, etc. */
+	if (platform_ops->cpu_suspend_prepare) {
+		unsigned int mpidr = read_cpuid_mpidr();
+		unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+		unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1); 
+		arch_spin_lock(&mcpm_lock);
+		platform_ops->cpu_suspend_prepare(cpu, cluster);
+		arch_spin_unlock(&mcpm_lock);
+	}
+	mcpm_cpu_power_down();
 }
 
 int mcpm_cpu_powered_up(void)
 {
+	unsigned int mpidr, cpu, cluster;
+	bool cpu_was_down, first_man;
+	unsigned long flags;
+
 	if (!platform_ops)
 		return -EUNATCH;
-	if (platform_ops->powered_up)
+
+	/* backward compatibility callback */
+	if (platform_ops->powered_up) {
 		platform_ops->powered_up();
+		return 0;
+	}
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	local_irq_save(flags);
+	arch_spin_lock(&mcpm_lock);
+
+	cpu_was_down = !mcpm_cpu_use_count[cluster][cpu];
+	first_man = mcpm_cluster_unused(cluster);
+
+	if (first_man && platform_ops->cluster_is_up)
+		platform_ops->cluster_is_up(cluster);
+	if (cpu_was_down)
+		mcpm_cpu_use_count[cluster][cpu] = 1;
+	if (platform_ops->cpu_is_up)
+		platform_ops->cpu_is_up(cpu, cluster);
+
+	arch_spin_unlock(&mcpm_lock);
+	local_irq_restore(flags);
+
 	return 0;
 }
 
@@ -334,8 +470,10 @@ int __init mcpm_sync_init(
 	}
 	mpidr = read_cpuid_mpidr();
 	this_cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-	for_each_online_cpu(i)
+	for_each_online_cpu(i) {
+		mcpm_cpu_use_count[this_cluster][i] = 1;
 		mcpm_sync.clusters[this_cluster].cpus[i].cpu = CPU_UP;
+	}
 	mcpm_sync.clusters[this_cluster].cluster = CLUSTER_UP;
 	sync_cache_w(&mcpm_sync);
 
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 3446f6a1d9..50b378f59e 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -171,12 +171,73 @@ void mcpm_cpu_suspend(u64 expected_residency);
 int mcpm_cpu_powered_up(void);
 
 /*
- * Platform specific methods used in the implementation of the above API.
+ * Platform specific callbacks used in the implementation of the above API.
+ *
+ * cpu_powerup:
+ * Make given CPU runable. Called with MCPM lock held and IRQs disabled.
+ * The given cluster is assumed to be set up (cluster_powerup would have
+ * been called beforehand). Must return 0 for success or negative error code.
+ *
+ * cluster_powerup:
+ * Set up power for given cluster. Called with MCPM lock held and IRQs
+ * disabled. Called before first cpu_powerup when cluster is down. Must
+ * return 0 for success or negative error code.
+ *
+ * cpu_suspend_prepare:
+ * Special suspend configuration. Called on target CPU with MCPM lock held
+ * and IRQs disabled. This callback is optional. If provided, it is called
+ * before cpu_powerdown_prepare.
+ *
+ * cpu_powerdown_prepare:
+ * Configure given CPU for power down. Called on target CPU with MCPM lock
+ * held and IRQs disabled. Power down must be effective only at the next WFI instruction.
+ *
+ * cluster_powerdown_prepare:
+ * Configure given cluster for power down. Called on one CPU from target
+ * cluster with MCPM lock held and IRQs disabled. A cpu_powerdown_prepare
+ * for each CPU in the cluster has happened when this occurs.
+ *
+ * cpu_cache_disable:
+ * Clean and disable CPU level cache for the calling CPU. Called on with IRQs
+ * disabled only. The CPU is no longer cache coherent with the rest of the
+ * system when this returns.
+ *
+ * cluster_cache_disable:
+ * Clean and disable the cluster wide cache as well as the CPU level cache
+ * for the calling CPU. No call to cpu_cache_disable will happen for this
+ * CPU. Called with IRQs disabled and only when all the other CPUs are done
+ * with their own cpu_cache_disable. The cluster is no longer cache coherent
+ * with the rest of the system when this returns.
+ *
+ * cpu_is_up:
+ * Called on given CPU after it has been powered up or resumed. The MCPM lock
+ * is held and IRQs disabled. This callback is optional.
+ *
+ * cluster_is_up:
+ * Called by the first CPU to be powered up or resumed in given cluster.
+ * The MCPM lock is held and IRQs disabled. This callback is optional. If
+ * provided, it is called before cpu_is_up for that CPU.
+ *
+ * wait_for_powerdown:
+ * Wait until given CPU is powered down. This is called in sleeping context.
+ * Some reasonable timeout must be considered. Must return 0 for success or
+ * negative error code.
  */
 struct mcpm_platform_ops {
+	int (*cpu_powerup)(unsigned int cpu, unsigned int cluster);
+	int (*cluster_powerup)(unsigned int cluster);
+	void (*cpu_suspend_prepare)(unsigned int cpu, unsigned int cluster);
+	void (*cpu_powerdown_prepare)(unsigned int cpu, unsigned int cluster);
+	void (*cluster_powerdown_prepare)(unsigned int cluster);
+	void (*cpu_cache_disable)(void);
+	void (*cluster_cache_disable)(void);
+	void (*cpu_is_up)(unsigned int cpu, unsigned int cluster);
+	void (*cluster_is_up)(unsigned int cluster);
+	int (*wait_for_powerdown)(unsigned int cpu, unsigned int cluster);
+
+	/* deprecated callbacks */
 	int (*power_up)(unsigned int cpu, unsigned int cluster);
 	void (*power_down)(void);
-	int (*wait_for_powerdown)(unsigned int cpu, unsigned int cluster);
 	void (*suspend)(u64);
 	void (*powered_up)(void);
 };
-- 
2.1.0
