From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jun 2012 13:30:47 +0100
Subject: [PATCH v8 04/13] ARM: convert Tegra to smp_ops
In-Reply-To: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
References: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339504256-11266-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Tegra to use the smp_ios to provide its SMP and CPU hotplug
operations.

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
 arch/arm/mach-tegra/common.c           |    2 ++
 arch/arm/mach-tegra/common.h           |    6 ++++++
 arch/arm/mach-tegra/hotplug.c          |    6 +++---
 arch/arm/mach-tegra/platsmp.c          |   17 +++++++++++++----
 10 files changed, 38 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-tegra/common.h

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index eb7249d..11bf7fb 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -45,6 +45,7 @@
 #include "board-harmony.h"
 #include "clock.h"
 #include "devices.h"
+#include "common.h"
 
 struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
@@ -104,6 +105,7 @@ static const char *tegra20_dt_board_compat[] = {
 };
 
 DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
+	smp_ops(tegra_smp_ops)
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra20_init_early,
 	.init_irq	= tegra_dt_init_irq,
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 4f76fa7..9b8e434 100644
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
+	smp_ops(tegra_smp_ops)
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra30_init_early,
 	.init_irq	= tegra_dt_init_irq,
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index e65e837..7eafd1c 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -45,6 +45,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -184,6 +185,7 @@ static void __init tegra_harmony_init(void)
 }
 
 MACHINE_START(HARMONY, "harmony")
+	smp_ops(tegra_smp_ops)
 	.atag_offset	= 0x100,
 	.fixup		= tegra_harmony_fixup,
 	.map_io         = tegra_map_common_io,
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index bbc1907..c2aaac3 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -47,6 +47,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -217,6 +218,7 @@ static void __init tegra_paz00_init(void)
 }
 
 MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
+	smp_ops(tegra_smp_ops)
 	.atag_offset	= 0x100,
 	.fixup		= tegra_paz00_fixup,
 	.map_io         = tegra_map_common_io,
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index 71e9f3f..8888591 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -43,6 +43,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -270,6 +271,7 @@ static void __init tegra_wario_init(void)
 
 
 MACHINE_START(SEABOARD, "seaboard")
+	smp_ops(tegra_smp_ops)
 	.atag_offset    = 0x100,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra20_init_early,
@@ -282,6 +284,7 @@ MACHINE_START(SEABOARD, "seaboard")
 MACHINE_END
 
 MACHINE_START(KAEN, "kaen")
+	smp_ops(tegra_smp_ops)
 	.atag_offset    = 0x100,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra20_init_early,
@@ -294,6 +297,7 @@ MACHINE_START(KAEN, "kaen")
 MACHINE_END
 
 MACHINE_START(WARIO, "wario")
+	smp_ops(tegra_smp_ops)
 	.atag_offset    = 0x100,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra20_init_early,
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 776aa95..afb9587 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -40,6 +40,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 #include "board-trimslice.h"
 
@@ -170,6 +171,7 @@ static void __init tegra_trimslice_init(void)
 }
 
 MACHINE_START(TRIMSLICE, "trimslice")
+	smp_ops(tegra_smp_ops)
 	.atag_offset	= 0x100,
 	.fixup		= tegra_trimslice_fixup,
 	.map_io         = tegra_map_common_io,
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 204a5c8..9b9f183 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/of_irq.h>
 
+#include <asm/smp_ops.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 
@@ -31,6 +32,7 @@
 
 #include "board.h"
 #include "clock.h"
+#include "common.h"
 #include "fuse.h"
 #include "pmc.h"
 
diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
new file mode 100644
index 0000000..191e765
--- /dev/null
+++ b/arch/arm/mach-tegra/common.h
@@ -0,0 +1,6 @@
+struct smp_ops;
+extern struct smp_ops		tegra_smp_ops;
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
index 1a208db..59aa9a0 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -23,6 +23,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
+#include <asm/smp_ops.h>
 
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
 
@@ -181,8 +184,14 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 {
 	tegra_cpu_reset_handler_init();
 	scu_enable(scu_base);
 }
+
+struct smp_ops tegra_smp_ops __initdata = {
+	smp_init_ops(tegra)
+	smp_secondary_ops(tegra)
+	smp_hotplug_ops(tegra)
+};
-- 
1.7.10.3
