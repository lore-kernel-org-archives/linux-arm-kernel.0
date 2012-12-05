From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 5 Dec 2012 18:01:55 +0800
Subject: [PATCH V2 6/6] ARM: tegra20: cpuidle: apply coupled cpuidle for
 powered-down mode
In-Reply-To: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
Message-ID: <1354701715-24150-9-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 config ARCH_TEGRA_3x_SOC
 	bool "Enable support for Tegra30 family"
+	select ARCH_NEEDS_CPU_IDLE_COUPLED
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_743622
 	select ARM_ERRATA_751472
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 5e8cbf5..f880350 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
+#include <linux/cpumask.h>
 #include <linux/clockchips.h>
 
 #include <asm/cpuidle.h>
@@ -30,14 +31,18 @@
 #include <asm/suspend.h>
 #include <asm/smp_plat.h>
 
+#include "irq.h"
 #include "pm.h"
 #include "sleep.h"
 #include "tegra_cpu_car.h"
 
 #ifdef CONFIG_PM_SLEEP
-static int tegra30_idle_lp2(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv,
-			    int index);
+static bool abort_flag;
+static atomic_t abort_barrier;
+static cpumask_t cpus_out_lp2;
+static int tegra30_idle_lp2_coupled(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv,
+				    int index);
 #endif
 
 static struct cpuidle_driver tegra_idle_driver = {
@@ -53,11 +58,12 @@ static struct cpuidle_driver tegra_idle_driver = {
 		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
 #ifdef CONFIG_PM_SLEEP
 		[1] = {
-			.enter			= tegra30_idle_lp2,
+			.enter			= tegra30_idle_lp2_coupled,
 			.exit_latency		= 2000,
 			.target_residency	= 2200,
 			.power_usage		= 0,
-			.flags			= CPUIDLE_FLAG_TIME_VALID,
+			.flags			= CPUIDLE_FLAG_TIME_VALID |
+						  CPUIDLE_FLAG_COUPLED,
 			.name			= "powered-down",
 			.desc			= "CPU power gated",
 		},
@@ -79,8 +85,8 @@ static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 	/* All CPUs entering LP2 is not working.
 	 * Don't let CPU0 enter LP2 when any secondary CPU is online.
 	 */
-	if (num_online_cpus() > 1 || !tegra_cpu_rail_off_ready()) {
-		cpu_do_idle();
+	if (num_online_cpus() > 1 && !tegra_cpu_rail_off_ready()) {
+//		cpu_do_idle();
 		return false;
 	}
 
@@ -94,6 +100,13 @@ static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 }
 
 #ifdef CONFIG_SMP
+static void tegra30_wake_up_secondary_cpus(u32 cpu)
+{
+//	if (!cpumask_test_cpu(cpu, &cpus_out_lp2))
+		arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+//		gic_raise_softirq(cpumask_of(cpu), 0);
+}                                       
+
 static bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv,
 					int index)
@@ -113,6 +126,11 @@ static bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
 	return true;
 }
 #else
+static inline void tegra30_wake_up_secondary_cpus(u32 cpu)
+{
+	return;
+}
+
 static inline bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
 					       struct cpuidle_driver *drv,
 					       int index)
@@ -121,36 +139,56 @@ static inline bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
 }
 #endif
 
-static int __cpuinit tegra30_idle_lp2(struct cpuidle_device *dev,
-				      struct cpuidle_driver *drv,
-				      int index)
+static int __cpuinit tegra30_idle_lp2_coupled(struct cpuidle_device *dev,
+					      struct cpuidle_driver *drv,
+					      int index)
 {
 	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
 	bool entered_lp2 = false;
-	bool last_cpu;
+int i;
+	abort_flag = tegra_pending_irq();
+	cpumask_clear(&cpus_out_lp2);
+	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
+//printk(KERN_EMERG "cpu %d in\n", cpu);
+	if (abort_flag)
+		return -EINTR;
 
 	local_fiq_disable();
 
-	last_cpu = tegra_set_cpu_in_lp2(cpu);
+	tegra_set_cpu_in_lp2(cpu);
 	cpu_pm_enter();
 
 	if (cpu == 0) {
-		if (last_cpu)
-			entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv,
-								     index);
-		else
-			cpu_do_idle();
+		while (num_online_cpus() > 1 && !tegra_cpu_rail_off_ready()) {
+			cpu_relax();
+			
+//			if (!cpumask_empty(&cpus_out_lp2))
+//				goto out;
+		}
+		entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv, index);
+
+out:
+//		if (!entered_lp2) {
+//			int i;
+			for_each_online_cpu(i)
+				if (i != cpu)
+					tegra30_wake_up_secondary_cpus(i);
+//		}
 	} else {
 		entered_lp2 = tegra30_cpu_core_power_down(dev, drv, index);
+		cpumask_set_cpu(cpu, &cpus_out_lp2);
 	}
 
+
 	cpu_pm_exit();
 	tegra_clear_cpu_in_lp2(cpu);
-
+//
+//
 	local_fiq_enable();
 
 	smp_rmb();
-
+//printk(KERN_EMERG "cpu %d out\n", cpu);
+cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
 	return (entered_lp2) ? index : 0;
 }
 #endif
@@ -175,6 +213,9 @@ int __init tegra30_cpuidle_init(void)
 	for_each_possible_cpu(cpu) {
 		dev = &per_cpu(tegra_idle_device, cpu);
 		dev->cpu = cpu;
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
+		dev->coupled_cpus = *cpu_online_mask;
+#endif
 
 		dev->state_count = drv->state_count;
 		ret = cpuidle_register_device(dev);
