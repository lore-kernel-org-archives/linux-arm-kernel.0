From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 10 Oct 2011 15:02:17 +0100
Subject: [PATCH v5 05/10] ARM: SoC: convert Tegra to SoC descriptor
In-Reply-To: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
References: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1318255342-17451-6-git-send-email-marc.zyngier@arm.com>
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
 arch/arm/mach-tegra/board-dt.c        |    2 ++
 arch/arm/mach-tegra/board-harmony.c   |    2 ++
 arch/arm/mach-tegra/board-paz00.c     |    2 ++
 arch/arm/mach-tegra/board-seaboard.c  |    4 ++++
 arch/arm/mach-tegra/board-trimslice.c |    2 ++
 arch/arm/mach-tegra/common.c          |    8 ++++++++
 arch/arm/mach-tegra/common.h          |   11 +++++++++++
 arch/arm/mach-tegra/hotplug.c         |    6 +++---
 arch/arm/mach-tegra/platsmp.c         |   26 ++++++++++++++++++++++----
 9 files changed, 56 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-tegra/common.h

diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index 9f47e04..0b3f937 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -44,6 +44,7 @@
 #include "board-harmony.h"
 #include "clock.h"
 #include "devices.h"
+#include "common.h"
 
 void harmony_pinmux_init(void);
 void seaboard_pinmux_init(void);
@@ -111,6 +112,7 @@ static const char * tegra_dt_board_compat[] = {
 
 DT_MACHINE_START(TEGRA_DT, "nVidia Tegra (Flattened Device Tree)")
 	.map_io		= tegra_map_common_io,
+	.soc		= &tegra_soc_desc,
 	.init_early	= tegra_init_early,
 	.init_irq	= tegra_init_irq,
 	.timer		= &tegra_timer,
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index f0bdc5e..f2ef94f 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -43,6 +43,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -183,6 +184,7 @@ static void __init tegra_harmony_init(void)
 
 MACHINE_START(HARMONY, "harmony")
 	.atag_offset	= 0x100,
+	.soc		= &tegra_soc_desc,
 	.fixup		= tegra_harmony_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra_init_early,
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 602f8dd..63595f0 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -43,6 +43,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -186,6 +187,7 @@ static void __init tegra_paz00_init(void)
 
 MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
 	.atag_offset	= 0x100,
+	.soc		= &tegra_soc_desc,
 	.fixup		= tegra_paz00_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra_init_early,
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index bf13ea3..dfd9c95 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -40,6 +40,7 @@
 #include "clock.h"
 #include "devices.h"
 #include "gpio-names.h"
+#include "common.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
 	{
@@ -281,6 +282,7 @@ static void __init tegra_wario_init(void)
 
 MACHINE_START(SEABOARD, "seaboard")
 	.atag_offset    = 0x100,
+	.soc		= &tegra_soc_desc,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra_init_early,
 	.init_irq       = tegra_init_irq,
@@ -290,6 +292,7 @@ MACHINE_END
 
 MACHINE_START(KAEN, "kaen")
 	.atag_offset    = 0x100,
+	.soc		= &tegra_soc_desc,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra_init_early,
 	.init_irq       = tegra_init_irq,
@@ -299,6 +302,7 @@ MACHINE_END
 
 MACHINE_START(WARIO, "wario")
 	.atag_offset    = 0x100,
+	.soc		= &tegra_soc_desc,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra_init_early,
 	.init_irq       = tegra_init_irq,
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index e008c0e..16cfc39 100644
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
 	.init_early	= tegra_init_early,
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index d5e3f89..9f796bf 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 
+#include <asm/soc.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include <mach/iomap.h>
@@ -30,6 +31,7 @@
 #include "board.h"
 #include "clock.h"
 #include "fuse.h"
+#include "common.h"
 
 void (*arch_reset)(char mode, const char *cmd) = tegra_assert_system_reset;
 
@@ -81,3 +83,9 @@ void __init tegra_init_early(void)
 	tegra_clk_init_from_table(common_clk_init_table);
 	tegra_init_cache();
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
index 0886cbc..f18b07d 100644
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
1.7.0.4
