From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  6 Apr 2015 13:24:13 -0700
Subject: [PATCH v4] ARM: smp: Only expose /sys/.../cpuX/online if hotpluggable
Message-ID: <1428351853-5844-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writes to /sys/.../cpuX/online fail if we determine the platform
doesn't support hotplug for that CPU. Furthermore, if the cpu_die
op isn't specified the system hangs when we try to offline a CPU
and it comes right back online unexpectedly. Let's figure this
stuff out before we make the sysfs nodes so that the online file
doesn't even exist if it isn't (at least sometimes) possible to
hotplug the CPU.

Add a new 'cpu_can_disable' op and repoint all 'cpu_disable'
implementations at it because all implementers use the op to
indicate if a CPU can be hotplugged or not in a static fashion.
With PSCI we may need to add a 'cpu_disable' op so that the
secure OS can be migrated off the CPU we're trying to hotplug.
In this case, the 'cpu_can_disable' op will indicate that all
CPUs are hotpluggable by returning true, but the 'cpu_disable' op
will make a PSCI migration call and occasionally fail, denying
the hotplug of a CPU. This shouldn't be any worse than x86 where
we may indicate that all CPUs are hotpluggable but occasionally
we can't offline a CPU due to check_irq_vectors_for_cpu_disable()
failing to find a CPU to move vectors to.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: <linux-sh@vger.kernel.org>
Cc: Tyler Baker <tyler.baker@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes since v3:
 * Return bool instead of int from 'cpu_can_disable' op

Changes since v2:
 * Left cpu_disable op in place
 * Split out shmobile function deletion

 arch/arm/common/mcpm_platsmp.c       | 12 ++++--------
 arch/arm/include/asm/smp.h           | 10 ++++++++++
 arch/arm/kernel/setup.c              |  2 +-
 arch/arm/kernel/smp.c                | 15 ++++++++++++++-
 arch/arm/mach-shmobile/common.h      |  2 +-
 arch/arm/mach-shmobile/platsmp.c     |  4 ++--
 arch/arm/mach-shmobile/smp-r8a7790.c |  2 +-
 arch/arm/mach-shmobile/smp-r8a7791.c |  2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c  |  2 +-
 9 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
index 92e54d7c6f46..2b25b6038f66 100644
--- a/arch/arm/common/mcpm_platsmp.c
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -65,14 +65,10 @@ static int mcpm_cpu_kill(unsigned int cpu)
 	return !mcpm_wait_for_cpu_powerdown(pcpu, pcluster);
 }
 
-static int mcpm_cpu_disable(unsigned int cpu)
+static bool mcpm_cpu_can_disable(unsigned int cpu)
 {
-	/*
-	 * We assume all CPUs may be shut down.
-	 * This would be the hook to use for eventual Secure
-	 * OS migration requests as described in the PSCI spec.
-	 */
-	return 0;
+	/* We assume all CPUs may be shut down. */
+	return true;
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
index 18f5a554134f..e15856a1a380 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -104,6 +104,7 @@ struct smp_operations {
 #ifdef CONFIG_HOTPLUG_CPU
 	int  (*cpu_kill)(unsigned int cpu);
 	void (*cpu_die)(unsigned int cpu);
+	bool  (*cpu_can_disable)(unsigned int cpu);
 	int  (*cpu_disable)(unsigned int cpu);
 #endif
 #endif
@@ -123,4 +124,13 @@ struct of_cpu_method {
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
index 6c777e908a24..955d45d0f70c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -992,7 +992,7 @@ static int __init topology_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
-		cpuinfo->cpu.hotpluggable = 1;
+		cpuinfo->cpu.hotpluggable = platform_can_hotplug_cpu(cpu);
 		register_cpu(&cpuinfo->cpu, cpu);
 	}
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 86ef244c5a24..f747fdf1cc91 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -168,13 +168,26 @@ static int platform_cpu_disable(unsigned int cpu)
 	if (smp_ops.cpu_disable)
 		return smp_ops.cpu_disable(cpu);
 
+	return 0;
+}
+
+int platform_can_hotplug_cpu(unsigned int cpu)
+{
+	/* cpu_die must be specified to support hotplug */
+	if (!smp_ops.cpu_die)
+		return 0;
+
+	if (smp_ops.cpu_can_disable)
+		return smp_ops.cpu_can_disable(cpu);
+
 	/*
 	 * By default, allow disabling all CPUs except the first one,
 	 * since this is special on a lot of platforms, e.g. because
 	 * of clock tick interrupts.
 	 */
-	return cpu == 0 ? -EPERM : 0;
+	return cpu != 0;
 }
+
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index afc60bad6fd6..f2c4bf437ea7 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -13,7 +13,7 @@ extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
-extern int shmobile_smp_cpu_disable(unsigned int cpu);
+extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
 extern void shmobile_invalidate_start(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 3923e09e966d..b23378f3d7e1 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -31,8 +31,8 @@ void shmobile_smp_hook(unsigned int cpu, unsigned long fn, unsigned long arg)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-int shmobile_smp_cpu_disable(unsigned int cpu)
+bool shmobile_smp_cpu_can_disable(unsigned int cpu)
 {
-	return 0; /* Hotplug of any CPU is supported */
+	return true; /* Hotplug of any CPU is supported */
 }
 #endif
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 930f45cbc08a..947e437cab68 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -64,7 +64,7 @@ struct smp_operations r8a7790_smp_ops __initdata = {
 	.smp_prepare_cpus	= r8a7790_smp_prepare_cpus,
 	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
 	.cpu_die		= shmobile_smp_apmu_cpu_die,
 	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
 #endif
diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index 5e2d1db79afa..b2508c0d276b 100644
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
index 2106d6b76a06..ae7c764fd6b4 100644
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
