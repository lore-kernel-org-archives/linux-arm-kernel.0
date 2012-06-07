From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  7 Jun 2012 17:09:22 +0100
Subject: [PATCH v7 05/12] ARM: SoC: convert Tegra to SoC descriptor
In-Reply-To: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339085369-26073-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Tegra to use the SoC descriptor to provide its SMP
and CPU hotplug operations.

Tested on Harmony.

Cc: Colin Cross <ccross@android.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/board-dt-tegra20.c |    2 ++
 arch/arm/mach-tegra/board-dt-tegra30.c |    2 ++
 arch/arm/mach-tegra/board-harmony.c    |    2 ++
 arch/arm/mach-tegra/board-paz00.c      |    2 ++
 arch/arm/mach-tegra/board-seaboard.c   |    4 ++++
 arch/arm/mach-tegra/board-trimslice.c  |    2 ++
 arch/arm/mach-tegra/common.c           |    8 ++++++++
 arch/arm/mach-tegra/common.h           |   11 +++++++++++
 arch/arm/mach-tegra/hotplug.c          |    6 +++---
 arch/arm/mach-tegra/platsmp.c          |   22 ++++++++++++++++++----
 10 files changed, 54 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-tegra/common.h

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index eb7249d..2aae548 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -45,6 +45,7 @@
 #include "board-harmony.h"
 #include "clock.h"
 #include "devices.h"
+#include "common.h"
 
 struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
@@ -105,6 +106,7 @@ static const char *tegra20_dt_board_compat[] = {
 
 DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
 	.map_io		= tegra_map_common_io,
+	.soc		= &tegra_soc_desc,
 	.init_early	= tegra20_init_early,
 	.init_irq	= tegra_dt_init_irq,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 4f76fa7..df88870 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -35,6 +35,7 @@
 
 #include "board.h"
 #include "clock.h"
+#include "common.h"
 
 static struct of_device_id tegra_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
@@ -84,6 +85,7 @@ static const char *tegra30_dt_board_compat[] = {
 };
 
 DT_MACHINE_START(TEGRA30_DT, "NVIDIA Tegra30 (Flattened Device Tree)")
+	.soc		= &tegra_soc_desc,
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra30_init_early,
 	.init_irq	= tegra_dt_init_irq,
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index e65e837..20424e5 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -45,6 +45,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -185,6 +186,7 @@ static void __init tegra_harmony_init(void)
 
 MACHINE_START(HARMONY, "harmony")
 	.atag_offset	= 0x100,
+	.soc		= &tegra_soc_desc,
 	.fixup		= tegra_harmony_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra20_init_early,
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index bbc1907..463b5a1 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -47,6 +47,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -218,6 +219,7 @@ static void __init tegra_paz00_init(void)
 
 MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
 	.atag_offset	= 0x100,
+	.soc		= &tegra_soc_desc,
 	.fixup		= tegra_paz00_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra20_init_early,
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index 71e9f3f..5de9785 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -43,6 +43,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -271,6 +272,7 @@ static void __init tegra_wario_init(void)
 
 MACHINE_START(SEABOARD, "seaboard")
 	.atag_offset    = 0x100,
+	.soc		= &tegra_soc_desc,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra20_init_early,
 	.init_irq       = tegra_init_irq,
@@ -283,6 +285,7 @@ MACHINE_END
 
 MACHINE_START(KAEN, "kaen")
 	.atag_offset    = 0x100,
+	.soc		= &tegra_soc_desc,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra20_init_early,
 	.init_irq       = tegra_init_irq,
@@ -295,6 +298,7 @@ MACHINE_END
 
 MACHINE_START(WARIO, "wario")
 	.atag_offset    = 0x100,
+	.soc		= &tegra_soc_desc,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra20_init_early,
 	.init_irq       = tegra_init_irq,
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 776aa95..b282d8a 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -40,6 +40,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 #include "board-trimslice.h"
 
@@ -171,6 +172,7 @@ static void __init tegra_trimslice_init(void)
 
 MACHINE_START(TRIMSLICE, "trimslice")
 	.atag_offset	= 0x100,
+	.soc		= &tegra_soc_desc,
 	.fixup		= tegra_trimslice_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra20_init_early,
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 204a5c8..4e1fb40 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/of_irq.h>
 
+#include <asm/soc.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 
@@ -31,6 +32,7 @@
 
 #include "board.h"
 #include "clock.h"
+#include "common.h"
 #include "fuse.h"
 #include "pmc.h"
 
@@ -152,3 +154,9 @@ void __init tegra_init_late(void)
 	tegra_clk_debugfs_init();
 	tegra_powergate_debugfs_init();
 }
+
+struct arm_soc_desc tegra_soc_desc __initdata = {
+	.name		= "NVIDIA Tegra",
+	soc_smp_init_ops(tegra_soc_smp_init_ops)
+	soc_smp_ops(tegra_soc_smp_ops)
+};
diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
new file mode 100644
index 0000000..e4c214d
--- /dev/null
+++ b/arch/arm/mach-tegra/common.h
@@ -0,0 +1,11 @@
+struct arm_soc_desc;
+extern struct arm_soc_desc tegra_soc_desc;
+
+struct arm_soc_smp_init_ops;
+struct arm_soc_smp_ops;
+extern struct arm_soc_smp_init_ops	tegra_soc_smp_init_ops;
+extern struct arm_soc_smp_ops		tegra_soc_smp_ops;
+
+extern int  tegra_cpu_kill(unsigned int cpu);
+extern void tegra_cpu_die(unsigned int cpu);
+extern int  tegra_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index d8dc9dd..c4fd658 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -87,7 +87,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int tegra_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -97,7 +97,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void tegra_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
@@ -117,7 +117,7 @@ void platform_cpu_die(unsigned int cpu)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int tegra_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 1a208db..339d6f2 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -23,6 +23,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
+#include <asm/soc.h>
 
 #include <mach/clk.h>
 #include <mach/iomap.h>
@@ -32,6 +33,8 @@
 #include "flowctrl.h"
 #include "reset.h"
 
+#include "common.h"
+
 extern void tegra_secondary_startup(void);
 
 static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
@@ -50,7 +53,7 @@ static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
 #define CPU_CLOCK(cpu)	(0x1<<(8+cpu))
 #define CPU_RESET(cpu)	(0x1111ul<<(cpu))
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit tegra_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -117,7 +120,7 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 	return 0;
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit tegra_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int status;
 
@@ -165,7 +168,7 @@ done:
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+static void __init tegra_smp_init_cpus(void)
 {
 	unsigned int i, ncores = scu_get_core_count(scu_base);
 
@@ -181,8 +184,19 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 {
 	tegra_cpu_reset_handler_init();
 	scu_enable(scu_base);
 }
+
+struct arm_soc_smp_init_ops tegra_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= tegra_smp_init_cpus,
+	.smp_prepare_cpus	= tegra_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops tegra_soc_smp_ops __initdata = {
+	.smp_secondary_init	= tegra_secondary_init,
+	.smp_boot_secondary	= tegra_boot_secondary,
+	soc_hotplug_ops(tegra)
+};
-- 
1.7.10.1
