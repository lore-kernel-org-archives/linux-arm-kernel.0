From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Feb 2012 00:30:48 +0000
Subject: [PATCH v6 04/15] ARM: SoC: convert OMAP4 to SoC descriptor
In-Reply-To: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328661059-24584-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert OMAP4 to use the SoC descriptor to provide its SMP
and CPU hotplug operations.

Tested on both Panda and IGEPv2 (MULTI_OMAP kernel)

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    1 +
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 arch/arm/mach-omap2/common.h           |   13 +++++++++++++
 arch/arm/mach-omap2/omap-hotplug.c     |    6 +++---
 arch/arm/mach-omap2/omap-smp.c         |   24 ++++++++++++++++++++----
 arch/arm/mach-omap2/omap4-common.c     |    7 +++++++
 6 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 39fba9d..21834d1 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -914,6 +914,7 @@ static void __init omap_4430sdp_init(void)
 MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	/* Maintainer: Santosh Shilimkar - Texas Instruments Inc */
 	.atag_offset	= 0x100,
+	.soc		= &omap4_soc_desc,
 	.reserve	= omap_reserve,
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 30ad40d..f84cc0b 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -500,6 +500,7 @@ static void __init omap4_panda_init(void)
 MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.atag_offset	= 0x100,
+	.soc		= &omap4_soc_desc,
 	.reserve	= omap_reserve,
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index febffde..961b79a 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -194,8 +194,21 @@ extern void omap_secondary_startup(void);
 extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
 extern void omap_auxcoreboot_addr(u32 cpu_addr);
 extern u32 omap_read_auxcoreboot0(void);
+
+extern int  omap4_cpu_kill(unsigned int cpu);
+extern void omap4_cpu_die(unsigned int cpu);
+extern int  omap4_cpu_disable(unsigned int cpu);
+
+struct arm_soc_smp_init_ops;
+struct arm_soc_smp_ops;
+
+extern struct arm_soc_smp_init_ops	omap4_soc_smp_init_ops;
+extern struct arm_soc_smp_ops		omap4_soc_smp_ops;
 #endif
 
+struct arm_soc_desc;
+extern struct arm_soc_desc		omap4_soc_desc;
+
 #if defined(CONFIG_SMP) && defined(CONFIG_PM)
 extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index adbe4d8..e794f4b 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -24,7 +24,7 @@
 
 #include "powerdomain.h"
 
-int platform_cpu_kill(unsigned int cpu)
+int omap4_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -33,7 +33,7 @@ int platform_cpu_kill(unsigned int cpu)
  * platform-specific code to shutdown a CPU
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void omap4_cpu_die(unsigned int cpu)
 {
 	unsigned int this_cpu;
 
@@ -62,7 +62,7 @@ void platform_cpu_die(unsigned int cpu)
 	}
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int omap4_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index c1bf3ef..4d39fd0 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -23,6 +23,7 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
+#include <asm/soc.h>
 #include <mach/hardware.h>
 #include <mach/omap-secure.h>
 
@@ -40,7 +41,7 @@ void __iomem *omap4_get_scu_base(void)
 	return scu_base;
 }
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit omap4_secondary_init(unsigned int cpu)
 {
 	/*
 	 * Configure ACTRL and enable NS SMP bit access on CPU1 on HS device.
@@ -68,7 +69,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	static struct clockdomain *cpu1_clkdm;
 	static bool booted;
@@ -144,7 +145,7 @@ static void __init wakeup_secondary(void)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+static void __init omap4_smp_init_cpus(void)
 {
 	unsigned int i, ncores;
 
@@ -170,7 +171,7 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 {
 
 	/*
@@ -180,3 +181,18 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	scu_enable(scu_base);
 	wakeup_secondary();
 }
+
+struct arm_soc_smp_init_ops omap4_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= omap4_smp_init_cpus,
+	.smp_prepare_cpus	= omap4_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops omap4_soc_smp_ops __initdata = {
+	.smp_secondary_init	= omap4_secondary_init,
+	.smp_boot_secondary	= omap4_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= omap4_cpu_kill,
+	.cpu_die		= omap4_cpu_die,
+	.cpu_disable		= omap4_cpu_disable,
+#endif
+};
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 40a8fbc..0742ddf 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/memblock.h>
 
+#include <asm/soc.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
@@ -198,3 +199,9 @@ static int __init omap4_sar_ram_init(void)
 	return 0;
 }
 early_initcall(omap4_sar_ram_init);
+
+struct arm_soc_desc omap4_soc_desc __initdata = {
+	.name		= "TI OMAP4",
+	soc_smp_init_ops(omap4_soc_smp_init_ops)
+	soc_smp_ops(omap4_soc_smp_ops)
+};
-- 
1.7.3.4
