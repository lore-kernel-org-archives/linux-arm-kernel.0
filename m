From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  3 Oct 2011 18:35:50 +0100
Subject: [PATCH v4 04/10] ARM: SoC: convert OMAP4 to SoC descriptor
In-Reply-To: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
References: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1317663356-5114-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert OMAP4 to use the SoC descriptor to provide its SMP
and CPU hotplug operations.

Tested on both Panda and IGEPv2 (MULTI_OMAP kernel)

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/board-4430sdp.c             |    1 +
 arch/arm/mach-omap2/board-omap4panda.c          |    1 +
 arch/arm/mach-omap2/include/mach/omap4-common.h |   14 +++++++++++++
 arch/arm/mach-omap2/omap-hotplug.c              |    6 ++--
 arch/arm/mach-omap2/omap-smp.c                  |   24 +++++++++++++++++++---
 arch/arm/mach-omap2/omap4-common.c              |    7 ++++++
 6 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 4d0c8b9..c404c5b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -986,6 +986,7 @@ static void __init omap_4430sdp_map_io(void)
 MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	/* Maintainer: Santosh Shilimkar - Texas Instruments Inc */
 	.atag_offset	= 0x100,
+	.soc		= &omap4_soc_desc,
 	.reserve	= omap_reserve,
 	.map_io		= omap_4430sdp_map_io,
 	.init_early	= omap4430_init_early,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 201c0c2..42d6168 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -579,6 +579,7 @@ static void __init omap4_panda_map_io(void)
 MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.atag_offset	= 0x100,
+	.soc		= &omap4_soc_desc,
 	.reserve	= omap_reserve,
 	.map_io		= omap4_panda_map_io,
 	.init_early	= omap4430_init_early,
diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index e4bd876..1db7941 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -39,5 +39,19 @@ extern void omap_secondary_startup(void);
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
+
+struct arm_soc_desc;
+extern struct arm_soc_desc		omap4_soc_desc;
+
 #endif
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 4976b93..40982c6 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -21,7 +21,7 @@
 #include <asm/cacheflush.h>
 #include <mach/omap4-common.h>
 
-int platform_cpu_kill(unsigned int cpu)
+int omap4_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -30,7 +30,7 @@ int platform_cpu_kill(unsigned int cpu)
  * platform-specific code to shutdown a CPU
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void omap4_cpu_die(unsigned int cpu)
 {
 	flush_cache_all();
 	dsb();
@@ -57,7 +57,7 @@ void platform_cpu_die(unsigned int cpu)
 	}
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int omap4_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index ce65e93..061ed7f 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -23,6 +23,7 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
+#include <asm/soc.h>
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
 
@@ -31,7 +32,7 @@ static void __iomem *scu_base;
 
 static DEFINE_SPINLOCK(boot_lock);
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit omap4_secondary_init(unsigned int cpu)
 {
 	/*
 	 * If any interrupts are already enabled for the primary
@@ -47,7 +48,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/*
 	 * Set synchronisation state between this boot processor
@@ -98,7 +99,7 @@ static void __init wakeup_secondary(void)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+static void __init omap4_smp_init_cpus(void)
 {
 	unsigned int i, ncores;
 
@@ -123,7 +124,7 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 {
 
 	/*
@@ -133,3 +134,18 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
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
index 35ac3e5..de39fd4 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
+#include <asm/soc.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 
@@ -111,3 +112,9 @@ static int __init omap_l2_cache_init(void)
 }
 early_initcall(omap_l2_cache_init);
 #endif
+
+struct arm_soc_desc omap4_soc_desc __initdata = {
+	.name		= "TI OMAP4",
+	soc_smp_init_ops(omap4_soc_smp_init_ops)
+	soc_smp_ops(omap4_soc_smp_ops)
+};
-- 
1.7.0.4
