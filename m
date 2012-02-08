From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Feb 2012 00:30:49 +0000
Subject: [PATCH v6 05/15] ARM: SoC: convert Tegra to SoC descriptor
In-Reply-To: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328661059-24584-6-git-send-email-marc.zyngier@arm.com>
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
 arch/arm/mach-tegra/board-dt-tegra30.c |    1 +
 arch/arm/mach-tegra/board-harmony.c    |    2 ++
 arch/arm/mach-tegra/board-paz00.c      |    2 ++
 arch/arm/mach-tegra/board-seaboard.c   |    4 ++++
 arch/arm/mach-tegra/board-trimslice.c  |    2 ++
 arch/arm/mach-tegra/common.c           |    8 ++++++++
 arch/arm/mach-tegra/common.h           |   11 +++++++++++
 arch/arm/mach-tegra/hotplug.c          |    6 +++---
 arch/arm/mach-tegra/platsmp.c          |   26 ++++++++++++++++++++++----
 10 files changed, 57 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-tegra/common.h

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 7a95e0b..759d340 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -46,6 +46,7 @@
 #include "board-harmony.h"
 #include "clock.h"
 #include "devices.h"
+#include "common.h"
 
 void harmony_pinmux_init(void);
 void paz00_pinmux_init(void);
@@ -141,6 +142,7 @@ static const char *tegra20_dt_board_compat[] = {
 
 DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
 	.map_io		= tegra_map_common_io,
+	.soc		= &tegra_soc_desc,
 	.init_early	= tegra20_init_early,
 	.init_irq	= tegra_dt_init_irq,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 3c197e2..8f058ab 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -52,6 +52,7 @@ static const char *tegra30_dt_board_compat[] = {
 };
 
 DT_MACHINE_START(TEGRA30_DT, "NVIDIA Tegra30 (Flattened Device Tree)")
+	.soc		= &tegra_soc_desc,
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra30_init_early,
 	.init_irq	= tegra_dt_init_irq,
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 789bdc9..382161b 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -44,6 +44,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -184,6 +185,7 @@ static void __init tegra_harmony_init(void)
 
 MACHINE_START(HARMONY, "harmony")
 	.atag_offset	= 0x100,
+	.soc		= &tegra_soc_desc,
 	.fixup		= tegra_harmony_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra20_init_early,
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index fcf4f37..05bbc13 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -46,6 +46,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -214,6 +215,7 @@ static void __init tegra_paz00_init(void)
 
 MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
 	.atag_offset	= 0x100,
+	.soc		= &tegra_soc_desc,
 	.fixup		= tegra_paz00_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra20_init_early,
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index ebac65f..36797bd 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -41,6 +41,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -282,6 +283,7 @@ static void __init tegra_wario_init(void)
 
 MACHINE_START(SEABOARD, "seaboard")
 	.atag_offset    = 0x100,
+	.soc		= &tegra_soc_desc,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra20_init_early,
 	.init_irq       = tegra_init_irq,
@@ -293,6 +295,7 @@ MACHINE_END
 
 MACHINE_START(KAEN, "kaen")
 	.atag_offset    = 0x100,
+	.soc		= &tegra_soc_desc,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra20_init_early,
 	.init_irq       = tegra_init_irq,
@@ -304,6 +307,7 @@ MACHINE_END
 
 MACHINE_START(WARIO, "wario")
 	.atag_offset    = 0x100,
+	.soc		= &tegra_soc_desc,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra20_init_early,
 	.init_irq       = tegra_init_irq,
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index cd52820..4391981 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -38,6 +38,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 #include "board-trimslice.h"
 
@@ -173,6 +174,7 @@ static void __init tegra_trimslice_init(void)
 
 MACHINE_START(TRIMSLICE, "trimslice")
 	.atag_offset	= 0x100,
+	.soc		= &tegra_soc_desc,
 	.fixup		= tegra_trimslice_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra20_init_early,
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index a2eb901..bfc1e35 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/of_irq.h>
 
+#include <asm/soc.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 
@@ -32,6 +33,7 @@
 #include "board.h"
 #include "clock.h"
 #include "fuse.h"
+#include "common.h"
 
 #ifdef CONFIG_OF
 static const struct of_device_id tegra_dt_irq_match[] __initconst = {
@@ -108,3 +110,9 @@ void __init tegra30_init_early(void)
 	tegra_init_cache(0x441, 0x551);
 }
 #endif
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
index f329404..7319f5f 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -86,7 +86,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int tegra_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -96,7 +96,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void tegra_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
@@ -116,7 +116,7 @@ void platform_cpu_die(unsigned int cpu)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int tegra_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 7d2b5d0..519b110 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -23,9 +23,12 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
+#include <asm/soc.h>
 
 #include <mach/iomap.h>
 
+#include "common.h"
+
 extern void tegra_secondary_startup(void);
 
 static DEFINE_SPINLOCK(boot_lock);
@@ -38,7 +41,7 @@ static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
 #define CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR \
 	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x344)
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit tegra_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -54,7 +57,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit tegra_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long old_boot_vector;
 	unsigned long boot_vector;
@@ -110,7 +113,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+static void __init tegra_smp_init_cpus(void)
 {
 	unsigned int i, ncores = scu_get_core_count(scu_base);
 
@@ -126,8 +129,23 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 {
 
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
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= tegra_cpu_kill,
+	.cpu_die		= tegra_cpu_die,
+	.cpu_disable		= tegra_cpu_disable,
+#endif
+};
-- 
1.7.3.4
