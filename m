From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 20 Dec 2012 10:30:03 +0800
Subject: [PATCH] ARM: tegra30: fix power up sequence for boot_secondary
Message-ID: <1355970603-28531-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power up sequence is different on the cold boot CPU and the CPU
that resumed from the hotplug. For the cold boot CPU, it was been power
gated as default. To power up the cold boot CPU, the power should be
un-gated by un toggling the power gate register manually.

For the CPU that resumed from the hotplug, after un-halted the CPU. The
flow controller will un-gate the power of the CPU. No need to manually
control, just wait the power be resumed and continue the power up
sequence after the CPU power is ready.

Based on the work by:
Varun Wadekar <vwadekar@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/platsmp.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 6cedb3e..9bd4898 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -23,6 +23,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
+#include <asm/smp_plat.h>
 
 #include <mach/powergate.h>
 
@@ -36,6 +37,7 @@
 
 extern void tegra_secondary_startup(void);
 
+static cpumask_t tegra_cpu_init_mask;
 static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
 
 #define EVP_CPU_RESET_VECTOR \
@@ -50,6 +52,7 @@ static void __cpuinit tegra_secondary_init(unsigned int cpu)
 	 */
 	gic_secondary_init(0);
 
+	cpumask_set_cpu(cpu, &tegra_cpu_init_mask);
 }
 
 static int tegra20_power_up_cpu(unsigned int cpu)
@@ -72,7 +75,27 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 	if (pwrgateid < 0)
 		return pwrgateid;
 
-	/* If this is the first boot, toggle powergates directly. */
+	/*
+	 * If the CPU had booted and went through here after CPU
+	 * had been already un-gated by flow controller. Wait
+	 * for confirmation that the CPU is powered then remove
+	 * the IO clamps. On the cold boot entry, do not wait.
+	 */
+	if (cpumask_test_cpu(cpu, &tegra_cpu_init_mask)) {
+		timeout = jiffies + 5;
+		do {
+			if (!tegra_powergate_is_powered(pwrgateid))
+				goto remove_clamps;
+			udelay(10);
+		} while (time_before(jiffies, timeout));
+	}
+
+	/*
+	 * The power status of the cold boot CPU is power gating as
+	 * default. To power up the cold boot CPU, the power should
+	 * be un-gated by un-toggling the power gate register
+	 * manually.
+	 */
 	if (!tegra_powergate_is_powered(pwrgateid)) {
 		ret = tegra_powergate_power_on(pwrgateid);
 		if (ret)
@@ -87,6 +110,7 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 		}
 	}
 
+remove_clamps:
 	/* CPU partition is powered. Enable the CPU clock. */
 	tegra_enable_cpu_clock(cpu);
 	udelay(10);
@@ -105,6 +129,8 @@ static int __cpuinit tegra_boot_secondary(unsigned int cpu, struct task_struct *
 {
 	int status;
 
+	cpu = cpu_logical_map(cpu);
+
 	/*
 	 * Force the CPU into reset. The CPU must remain in reset when the
 	 * flow controller state is cleared (which will cause the flow
@@ -165,6 +191,9 @@ static void __init tegra_smp_init_cpus(void)
 
 static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 {
+	/* Always mark the boot CPU (CPU0) as initialized. */
+	cpumask_set_cpu(0, &tegra_cpu_init_mask);
+
 	tegra_cpu_reset_handler_init();
 	scu_enable(scu_base);
 }
-- 
1.7.0.4
