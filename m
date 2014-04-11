From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 11 Apr 2014 11:44:39 +0200
Subject: [PATCH v4 3/5] sched: powerpc: create a dedicated topology table
In-Reply-To: <1397209481-28542-1-git-send-email-vincent.guittot@linaro.org>
References: <1397209481-28542-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1397209481-28542-4-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a dedicated topology table for handling asymetric feature of powerpc.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 31 +++++++++++++++++++++++--------
 include/linux/sched.h     |  2 --
 kernel/sched/core.c       |  6 ------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ac2621a..c9cade5 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -755,6 +755,28 @@ int setup_profiling_timer(unsigned int multiplier)
 	return 0;
 }
 
+#ifdef CONFIG_SCHED_SMT
+/* cpumask of CPUs with asymetric SMT dependancy */
+static const int powerpc_smt_flags(void)
+{
+	int flags = SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES;
+
+	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
+		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
+		flags |= SD_ASYM_PACKING;
+	}
+	return flags;
+}
+#endif
+
+static struct sched_domain_topology_level powerpc_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	cpumask_var_t old_mask;
@@ -779,15 +801,8 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 	dump_numa_cpu_topology();
 
-}
+	set_sched_topology(powerpc_topology);
 
-int arch_sd_sibling_asym_packing(void)
-{
-	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
-		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
-		return SD_ASYM_PACKING;
-	}
-	return 0;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3161701..7df3ca2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -872,8 +872,6 @@ enum cpu_idle_type {
 #define SD_OVERLAP		0x2000	/* sched_domains of this level overlap */
 #define SD_NUMA			0x4000	/* cross-node balancing */
 
-extern int __weak arch_sd_sibiling_asym_packing(void);
-
 #ifdef CONFIG_SCHED_SMT
 static inline const int cpu_smt_flags(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b15b994..3743a6c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5830,11 +5830,6 @@ static void init_sched_groups_power(int cpu, struct sched_domain *sd)
 	atomic_set(&sg->sgp->nr_busy_cpus, sg->group_weight);
 }
 
-int __weak arch_sd_sibling_asym_packing(void)
-{
-       return 0*SD_ASYM_PACKING;
-}
-
 /*
  * Initializers for schedule domains
  * Non-inlined to reduce accumulated stack pressure in build_sched_domains()
@@ -6015,7 +6010,6 @@ sd_init(struct sched_domain_topology_level *tl, int cpu)
 	if (sd->flags & SD_SHARE_CPUPOWER) {
 		sd->imbalance_pct = 110;
 		sd->smt_gain = 1178; /* ~15% */
-		sd->flags |= arch_sd_sibling_asym_packing();
 
 	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
 		sd->imbalance_pct = 117;
-- 
1.9.1
