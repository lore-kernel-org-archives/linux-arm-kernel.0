From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 3 Jan 2013 15:31:31 +0800
Subject: [PATCH V2] ARM: tegra30: fix power up sequence for boot_secondary
Message-ID: <1357198291-16500-1-git-send-email-josephl@nvidia.com>
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
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
v2:
* rewriting the commnet of power up sequence for cold boot & warm boot CPU
---
 arch/arm/mach-tegra/platsmp.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index cdf5faa..c60812c 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -24,6 +24,7 @@
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
@@ -72,7 +75,35 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 	if (pwrgateid < 0)
 		return pwrgateid;
 
-	/* If this is the first boot, toggle powergates directly. */
+	/*
+	 * The power up sequence of cold boot CPU and warm boot CPU
+	 * was different.
+	 *
+	 * For warm boot CPU that was resumed from CPU hotplug, the
+	 * power will be resumed automatically after un-halting the
+	 * flow controller of the warm boot CPU. We need to wait for
+	 * the confirmaiton that the CPU is powered then removing
+	 * the IO clamps.
+	 * For cold boot CPU, do not wait. After the cold boot CPU be
+	 * booted, it will run to tegra_secondary_init() and set
+	 * tegra_cpu_init_mask which influences what tegra30_power_up_cpu()
+	 * next time around.
+	 */
+	if (cpumask_test_cpu(cpu, &tegra_cpu_init_mask)) {
+		timeout = jiffies + 5*HZ;
+		do {
+			if (!tegra_powergate_is_powered(pwrgateid))
+				goto remove_clamps;
+			udelay(10);
+		} while (time_before(jiffies, timeout));
+	}
+
+	/*
+	 * The power status of the cold boot CPU is power gated as
+	 * default. To power up the cold boot CPU, the power should
+	 * be un-gated by un-toggling the power gate register
+	 * manually.
+	 */
 	if (!tegra_powergate_is_powered(pwrgateid)) {
 		ret = tegra_powergate_power_on(pwrgateid);
 		if (ret)
@@ -87,6 +118,7 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 		}
 	}
 
+remove_clamps:
 	/* CPU partition is powered. Enable the CPU clock. */
 	tegra_enable_cpu_clock(cpu);
 	udelay(10);
@@ -105,6 +137,8 @@ static int __cpuinit tegra_boot_secondary(unsigned int cpu, struct task_struct *
 {
 	int status;
 
+	cpu = cpu_logical_map(cpu);
+
 	/*
 	 * Force the CPU into reset. The CPU must remain in reset when the
 	 * flow controller state is cleared (which will cause the flow
@@ -165,6 +199,9 @@ static void __init tegra_smp_init_cpus(void)
 
 static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 {
+	/* Always mark the boot CPU (CPU0) as initialized. */
+	cpumask_set_cpu(0, &tegra_cpu_init_mask);
+
 	tegra_cpu_reset_handler_init();
 	scu_enable(scu_base);
 }
-- 
1.8.0.3
