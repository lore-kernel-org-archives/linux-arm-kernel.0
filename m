From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 22 Feb 2013 14:24:27 +0800
Subject: [PATCH 3/3] ARM: tegra: refactor tegra{20,30}_boot_secondary
In-Reply-To: <1361514267-12111-1-git-send-email-josephl@nvidia.com>
References: <1361514267-12111-1-git-send-email-josephl@nvidia.com>
Message-ID: <1361514267-12111-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi Doyu <hdoyu@nvidia.com>

"tegra_boot_secondary()" has many condition branches for some Tegra
SoC generations in a single function so that it's not easy to compile
a kernel only for a single SoC if one wants with some reason, debug
purpose(?). This patch provides SoC specific version of
boot_secondary(), tegra{20,30}_boot_secondary(). This could allow
any combination of SoC to be built. Those boot_secondary functions can
be preparation when we ntroduce chip specific function pointers in the
future without having chip dependent branches around.

Also removed unused definition/prototpye.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
[josephl: remove the Tegra114 part of the original patch]
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/platsmp.c | 93 ++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index e78d52d..41971ac 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -35,13 +35,8 @@
 #include "common.h"
 #include "iomap.h"
 
-extern void tegra_secondary_startup(void);
-
 static cpumask_t tegra_cpu_init_mask;
 
-#define EVP_CPU_RESET_VECTOR \
-	(IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
-
 static void __cpuinit tegra_secondary_init(unsigned int cpu)
 {
 	/*
@@ -54,26 +49,48 @@ static void __cpuinit tegra_secondary_init(unsigned int cpu)
 	cpumask_set_cpu(cpu, &tegra_cpu_init_mask);
 }
 
-static int tegra20_power_up_cpu(unsigned int cpu)
+
+static int tegra20_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	/* Enable the CPU clock. */
-	tegra_enable_cpu_clock(cpu);
+	cpu = cpu_logical_map(cpu);
 
-	/* Clear flow controller CSR. */
-	flowctrl_write_cpu_csr(cpu, 0);
+	/*
+	 * Force the CPU into reset. The CPU must remain in reset when
+	 * the flow controller state is cleared (which will cause the
+	 * flow controller to stop driving reset if the CPU has been
+	 * power-gated via the flow controller). This will have no
+	 * effect on first boot of the CPU since it should already be
+	 * in reset.
+	 */
+	tegra_put_cpu_in_reset(cpu);
 
+	/*
+	 * Unhalt the CPU. If the flow controller was used to
+	 * power-gate the CPU this will cause the flow controller to
+	 * stop driving reset. The CPU will remain in reset because the
+	 * clock and reset block is now driving reset.
+	 */
+	flowctrl_write_cpu_halt(cpu, 0);
+
+	tegra_enable_cpu_clock(cpu);
+	flowctrl_write_cpu_csr(cpu, 0); /* Clear flow controller CSR. */
+	tegra_cpu_out_of_reset(cpu);
 	return 0;
 }
 
-static int tegra30_power_up_cpu(unsigned int cpu)
+static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int ret, pwrgateid;
 	unsigned long timeout;
 
+	cpu = cpu_logical_map(cpu);
 	pwrgateid = tegra_cpu_powergate_id(cpu);
 	if (pwrgateid < 0)
 		return pwrgateid;
 
+	tegra_put_cpu_in_reset(cpu);
+	flowctrl_write_cpu_halt(cpu, 0);
+
 	/*
 	 * The power up sequence of cold boot CPU and warm boot CPU
 	 * was different.
@@ -85,7 +102,7 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 	 * the IO clamps.
 	 * For cold boot CPU, do not wait. After the cold boot CPU be
 	 * booted, it will run to tegra_secondary_init() and set
-	 * tegra_cpu_init_mask which influences what tegra30_power_up_cpu()
+	 * tegra_cpu_init_mask which influences what tegra30_boot_secondary()
 	 * next time around.
 	 */
 	if (cpumask_test_cpu(cpu, &tegra_cpu_init_mask)) {
@@ -129,54 +146,20 @@ remove_clamps:
 
 	udelay(10);
 
-	/* Clear flow controller CSR. */
-	flowctrl_write_cpu_csr(cpu, 0);
-
+	flowctrl_write_cpu_csr(cpu, 0); /* Clear flow controller CSR. */
+	tegra_cpu_out_of_reset(cpu);
 	return 0;
 }
 
-static int __cpuinit tegra_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit tegra_boot_secondary(unsigned int cpu,
+					  struct task_struct *idle)
 {
-	int status;
-
-	cpu = cpu_logical_map(cpu);
-
-	/*
-	 * Force the CPU into reset. The CPU must remain in reset when the
-	 * flow controller state is cleared (which will cause the flow
-	 * controller to stop driving reset if the CPU has been power-gated
-	 * via the flow controller). This will have no effect on first boot
-	 * of the CPU since it should already be in reset.
-	 */
-	tegra_put_cpu_in_reset(cpu);
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_chip_id == TEGRA20)
+		return tegra20_boot_secondary(cpu, idle);
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_chip_id == TEGRA30)
+		return tegra30_boot_secondary(cpu, idle);
 
-	/*
-	 * Unhalt the CPU. If the flow controller was used to power-gate the
-	 * CPU this will cause the flow controller to stop driving reset.
-	 * The CPU will remain in reset because the clock and reset block
-	 * is now driving reset.
-	 */
-	flowctrl_write_cpu_halt(cpu, 0);
-
-	switch (tegra_chip_id) {
-	case TEGRA20:
-		status = tegra20_power_up_cpu(cpu);
-		break;
-	case TEGRA30:
-		status = tegra30_power_up_cpu(cpu);
-		break;
-	default:
-		status = -EINVAL;
-		break;
-	}
-
-	if (status)
-		goto done;
-
-	/* Take the CPU out of reset. */
-	tegra_cpu_out_of_reset(cpu);
-done:
-	return status;
+	return -EINVAL;
 }
 
 static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
-- 
1.8.1.1
