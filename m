From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 5 Dec 2012 18:01:53 +0800
Subject: [PATCH V2 6/6] ARM: tegra20: cpuidle: apply coupled cpuidle for
 powered-down mode
In-Reply-To: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
Message-ID: <1354701715-24150-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "powered-down" cpuidle mode of Tegra20 needs the CPU0 be the last one
core to go into this mode before other core. The coupled cpuidle framework
can help to sync the MPCore to coupled state then go into "powered-down"
idle mode together. The driver can just assume the MPCore come into
"powered-down" mode at the same time. No need to take care if the CPU_0
goes into this mode along and only can put it into safe idle mode (WFI).

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* handling the case of SGI pending before go into "powered-down" idle mode
---
 arch/arm/mach-tegra/Kconfig           |    1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c |   48 ++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index e426d1b..e07241a 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -4,6 +4,7 @@ comment "NVIDIA Tegra options"
 
 config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
+	select ARCH_NEEDS_CPU_IDLE_COUPLED
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_742230
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index a83a53b..13e3ae4 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -33,13 +33,16 @@
 #include "pm.h"
 #include "sleep.h"
 #include "iomap.h"
+#include "irq.h"
 #include "tegra_cpu_car.h"
 #include "flowctrl.h"
 
 #ifdef CONFIG_PM_SLEEP
-static int tegra20_idle_lp2(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv,
-			    int index);
+static atomic_t abort_flag;
+static atomic_t abort_barrier;
+static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv,
+				    int index);
 #endif
 
 static struct cpuidle_driver tegra_idle_driver = {
@@ -55,11 +58,12 @@ static struct cpuidle_driver tegra_idle_driver = {
 		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
 #ifdef CONFIG_PM_SLEEP
 		[1] = {
-			.enter			= tegra20_idle_lp2,
+			.enter			= tegra20_idle_lp2_coupled,
 			.exit_latency		= 5000,
 			.target_residency	= 10000,
 			.power_usage		= 0,
-			.flags			= CPUIDLE_FLAG_TIME_VALID,
+			.flags			= CPUIDLE_FLAG_TIME_VALID |
+						  CPUIDLE_FLAG_COUPLED,
 			.name			= "powered-down",
 			.desc			= "CPU power gated",
 		},
@@ -178,28 +182,33 @@ static inline bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
 }
 #endif
 
-static int __cpuinit tegra20_idle_lp2(struct cpuidle_device *dev,
-				      struct cpuidle_driver *drv,
-				      int index)
+static int __cpuinit tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
+					      struct cpuidle_driver *drv,
+					      int index)
 {
 	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
 	bool entered_lp2 = false;
-	bool last_cpu;
+
+	if (tegra_pending_sgi())
+		atomic_inc(&abort_flag);
+
+	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
+
+	if (atomic_read(&abort_flag) > 0) {
+		cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
+		atomic_set(&abort_flag, 0);	/* clean flag for next coming */
+		return -EINTR;
+	}
 
 	local_fiq_disable();
 
-	last_cpu =  tegra_set_cpu_in_lp2(cpu);
+	tegra_set_cpu_in_lp2(cpu);
 	cpu_pm_enter();
 
-	if (cpu == 0) {
-		if (last_cpu)
-			entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv,
-								     index);
-		else
-			cpu_do_idle();
-	} else {
+	if (cpu == 0)
+		entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv, index);
+	else
 		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
-	}
 
 	cpu_pm_exit();
 	tegra_clear_cpu_in_lp2(cpu);
@@ -232,6 +241,9 @@ int __init tegra20_cpuidle_init(void)
 	for_each_possible_cpu(cpu) {
 		dev = &per_cpu(tegra_idle_device, cpu);
 		dev->cpu = cpu;
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
+		dev->coupled_cpus = *cpu_online_mask;
+#endif
 
 		dev->state_count = drv->state_count;
 		ret = cpuidle_register_device(dev);
-- 
1.7.0.4
