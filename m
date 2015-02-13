From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Feb 2015 10:06:39 -0800
Subject: [PATCH v2] ARM: smp: Only expose /sys/.../cpuX/online if hotpluggable
Message-ID: <1423850799-4028-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writes to /sys/.../cpuX/online fail if we determine the platform
doesn't support hotplug for that CPU. Furthermore, if the cpu_die
op isn't specified the system hangs when we try to offline a CPU
and it comes right back online unexpectedly. Let's figure this
stuff out before we make the sysfs nodes so that the online file
doesn't even exist if it isn't (at least sometimes) possible to
hotplug the CPU.

We re-purpose the cpu_disable smp op here and rename it to
cpu_can_disable because all users use the op to indicate if a CPU
can be hotplugged or not in a static fashion.  With PSCI we may
need to reintroduce the cpu_disable op so that the secure OS can
be migrated off the CPU we're trying to hotplug. We'll need to
indicate that all CPUs are hotpluggable in that case but this
shouldn't be any worse than something like x86 where we indicate
that all CPUs are hotpluggable but occasionally we can't offline
a CPU due to check_irq_vectors_for_cpu_disable().

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: <linux-sh@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/common/mcpm_platsmp.c       | 12 ++++--------
 arch/arm/include/asm/smp.h           | 11 ++++++++++-
 arch/arm/kernel/setup.c              |  2 +-
 arch/arm/kernel/smp.c                | 18 +++++++++---------
 arch/arm/mach-shmobile/common.h      |  2 +-
 arch/arm/mach-shmobile/platsmp.c     |  4 ++--
 arch/arm/mach-shmobile/smp-r8a7779.c |  7 -------
 arch/arm/mach-shmobile/smp-r8a7790.c |  2 +-
 arch/arm/mach-shmobile/smp-r8a7791.c |  2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c  |  2 +-
 10 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
index 92e54d7c6f46..dc91ed04c25a 100644
--- a/arch/arm/common/mcpm_platsmp.c
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -65,14 +65,10 @@ static int mcpm_cpu_kill(unsigned int cpu)
 	return !mcpm_wait_for_cpu_powerdown(pcpu, pcluster);
 }
 
-static int mcpm_cpu_disable(unsigned int cpu)
+static int mcpm_cpu_can_disable(unsigned int cpu)
 {
-	/*
-	 * We assume all CPUs may be shut down.
-	 * This would be the hook to use for eventual Secure
-	 * OS migration requests as described in the PSCI spec.
-	 */
-	return 0;
+	/* We assume all CPUs may be shut down. */
+	return 1;
 }
 
 static void mcpm_cpu_die(unsigned int cpu)
@@ -92,7 +88,7 @@ static struct smp_operations __initdata mcpm_smp_ops = {
 	.smp_secondary_init	= mcpm_secondary_init,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= mcpm_cpu_kill,
-	.cpu_disable		= mcpm_cpu_disable,
+	.cpu_can_disable	= mcpm_cpu_can_disable,
 	.cpu_die		= mcpm_cpu_die,
 #endif
 };
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 18f5a554134f..835a643f2a8e 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -104,7 +104,7 @@ struct smp_operations {
 #ifdef CONFIG_HOTPLUG_CPU
 	int  (*cpu_kill)(unsigned int cpu);
 	void (*cpu_die)(unsigned int cpu);
-	int  (*cpu_disable)(unsigned int cpu);
+	int  (*cpu_can_disable)(unsigned int cpu);
 #endif
 #endif
 };
@@ -123,4 +123,13 @@ struct of_cpu_method {
  */
 extern void smp_set_ops(struct smp_operations *);
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern int platform_can_hotplug_cpu(unsigned int cpu);
+#else
+static inline int platform_can_hotplug_cpu(unsigned int cpu)
+{
+	return 0;
+}
+#endif
+
 #endif /* ifndef __ASM_ARM_SMP_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 715ae19bc7c8..c61c09defc78 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -974,7 +974,7 @@ static int __init topology_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
-		cpuinfo->cpu.hotpluggable = 1;
+		cpuinfo->cpu.hotpluggable = platform_can_hotplug_cpu(cpu);
 		register_cpu(&cpuinfo->cpu, cpu);
 	}
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index fe0386c751b2..160aa14c4a75 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -174,29 +174,29 @@ static int platform_cpu_kill(unsigned int cpu)
 	return 1;
 }
 
-static int platform_cpu_disable(unsigned int cpu)
+int platform_can_hotplug_cpu(unsigned int cpu)
 {
-	if (smp_ops.cpu_disable)
-		return smp_ops.cpu_disable(cpu);
+	/* cpu_die must be specified to support hotplug */
+	if (!smp_ops.cpu_die)
+		return 0;
+
+	if (smp_ops.cpu_can_disable)
+		return smp_ops.cpu_can_disable(cpu);
 
 	/*
 	 * By default, allow disabling all CPUs except the first one,
 	 * since this is special on a lot of platforms, e.g. because
 	 * of clock tick interrupts.
 	 */
-	return cpu == 0 ? -EPERM : 0;
+	return cpu == 0 ? 0 : 1;
 }
+
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
 int __cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
-	int ret;
-
-	ret = platform_cpu_disable(cpu);
-	if (ret)
-		return ret;
 
 	/*
 	 * Take this CPU offline.  Once we clear this, we can't return,
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 309025efd4cf..e124df267edc 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -13,7 +13,7 @@ extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
-extern int shmobile_smp_cpu_disable(unsigned int cpu);
+extern int shmobile_smp_cpu_can_disable(unsigned int cpu);
 extern void shmobile_invalidate_start(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 3923e09e966d..a614cef18db1 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -31,8 +31,8 @@ void shmobile_smp_hook(unsigned int cpu, unsigned long fn, unsigned long arg)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-int shmobile_smp_cpu_disable(unsigned int cpu)
+int shmobile_smp_cpu_can_disable(unsigned int cpu)
 {
-	return 0; /* Hotplug of any CPU is supported */
+	return 1; /* Hotplug of any CPU is supported */
 }
 #endif
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 3f761f839043..b45206f93ddf 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -124,19 +124,12 @@ static int r8a7779_cpu_kill(unsigned int cpu)
 
 	return 0;
 }
-
-static int r8a7779_cpu_disable(unsigned int cpu)
-{
-	/* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
-	return cpu == 0 ? -EPERM : 0;
-}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 struct smp_operations r8a7779_smp_ops  __initdata = {
 	.smp_prepare_cpus	= r8a7779_smp_prepare_cpus,
 	.smp_boot_secondary	= r8a7779_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= r8a7779_cpu_disable,
 	.cpu_die		= shmobile_smp_scu_cpu_die,
 	.cpu_kill		= r8a7779_cpu_kill,
 #endif
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 9c3da1345b8b..67b86c434fb8 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -63,7 +63,7 @@ struct smp_operations r8a7790_smp_ops __initdata = {
 	.smp_prepare_cpus	= r8a7790_smp_prepare_cpus,
 	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
 	.cpu_die		= shmobile_smp_apmu_cpu_die,
 	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
 #endif
diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index 7e49e0a52e32..24b7f12e20bb 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -58,7 +58,7 @@ struct smp_operations r8a7791_smp_ops __initdata = {
 	.smp_prepare_cpus	= r8a7791_smp_prepare_cpus,
 	.smp_boot_secondary	= r8a7791_smp_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
 	.cpu_die		= shmobile_smp_apmu_cpu_die,
 	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
 #endif
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index c16dbfe9836c..4dddbd3844dd 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -68,7 +68,7 @@ struct smp_operations sh73a0_smp_ops __initdata = {
 	.smp_prepare_cpus	= sh73a0_smp_prepare_cpus,
 	.smp_boot_secondary	= sh73a0_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
 	.cpu_die		= shmobile_smp_scu_cpu_die,
 	.cpu_kill		= shmobile_smp_scu_cpu_kill,
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
