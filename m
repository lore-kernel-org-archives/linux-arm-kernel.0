From: tony@atomide.com (Tony Lindgren)
Date: Sun, 18 Oct 2009 17:19:30 -0700
Subject: [PATCH] omap: Use ioremap for omap4 L4 code
Message-ID: <mailman.79.1255911869.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use ioremap for omap4 L4 code

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index eb37c40..2545230 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -52,8 +52,17 @@ static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 
 static void __init gic_init_irq(void)
 {
-	gic_dist_init(0, OMAP2_IO_ADDRESS(OMAP44XX_GIC_DIST_BASE), 29);
-	gic_cpu_init(0, OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
+	void __iomem *base;
+
+	/* Static mapping, never released */
+	base = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
+	BUG_ON(!base);
+	gic_dist_init(0, base, 29);
+
+	/* Static mapping, never released */
+	gic_cpu_base_addr = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
+	BUG_ON(!base);
+	gic_cpu_init(0, gic_cpu_base_addr);
 }
 
 static void __init omap_4430sdp_init_irq(void)
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 48ee295..8813ac2 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -24,13 +24,14 @@
 #include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
+#include <mach/common.h>
 
 /* Registers used for communicating startup information */
-#define OMAP4_AUXCOREBOOT_REG0		(OMAP44XX_VA_WKUPGEN_BASE + 0x800)
-#define OMAP4_AUXCOREBOOT_REG1		(OMAP44XX_VA_WKUPGEN_BASE + 0x804)
+static void __iomem *omap4_auxcoreboot_reg0;
+static void __iomem *omap4_auxcoreboot_reg1;
 
 /* SCU base address */
-static void __iomem *scu_base = OMAP44XX_VA_SCU_BASE;
+static void __iomem *scu_base;
 
 /*
  * Use SCU config register to count number of cores
@@ -53,8 +54,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-
-	gic_cpu_init(0, OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
+	gic_cpu_init(0, gic_cpu_base_addr);
 
 	/*
 	 * Synchronise with the boot thread.
@@ -79,7 +79,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the AuxCoreBoot1 register is updated with cpu state
 	 * A barrier is added to ensure that write buffer is drained
 	 */
-	__raw_writel(cpu, OMAP4_AUXCOREBOOT_REG1);
+	__raw_writel(cpu, omap4_auxcoreboot_reg1);
 	smp_wmb();
 
 	timeout = jiffies + (1 * HZ);
@@ -104,7 +104,7 @@ static void __init wakeup_secondary(void)
 	 * A barrier is added to ensure that write buffer is drained
 	 */
 	__raw_writel(virt_to_phys(omap_secondary_startup),	   \
-					OMAP4_AUXCOREBOOT_REG0);
+					omap4_auxcoreboot_reg0);
 	smp_wmb();
 
 	/*
@@ -120,7 +120,13 @@ static void __init wakeup_secondary(void)
  */
 void __init smp_init_cpus(void)
 {
-	unsigned int i, ncores = get_core_count();
+	unsigned int i, ncores;
+
+	/* Never released */
+	scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
+	BUG_ON(!scu_base);
+
+	ncores = get_core_count();
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
@@ -130,6 +136,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int ncores = get_core_count();
 	unsigned int cpu = smp_processor_id();
+	void __iomem *omap4_wkupgen_base;
 	int i;
 
 	/* sanity check */
@@ -161,6 +168,12 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
+	/* Never released */
+	omap4_wkupgen_base = ioremap(OMAP44XX_WKUPGEN_BASE, SZ_4K);
+	BUG_ON(!omap4_wkupgen_base);
+	omap4_auxcoreboot_reg0 = omap4_wkupgen_base + 0x800;
+	omap4_auxcoreboot_reg1 = omap4_wkupgen_base + 0x804;
+
 	if (max_cpus > 1) {
 		/*
 		 * Enable the local timer or broadcast device for the
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index e2338c0..cd72970 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -231,7 +231,8 @@ static void __init omap2_gp_clocksource_init(void)
 static void __init omap2_gp_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
-	twd_base = OMAP2_IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE);
+	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
+	BUG_ON(!twd_base);
 #endif
 	omap_dm_timer_init();
 
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 3a4768d..fdcb1cf 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -49,6 +49,9 @@ int omap_bootloader_tag_len;
 struct omap_board_config_kernel *omap_board_config;
 int omap_board_config_size;
 
+/* used by omap-smp.c and board-4430sdp.c */
+void __iomem *gic_cpu_base_addr;
+
 static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
 {
 	struct omap_board_config_kernel *kinfo = NULL;
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index fdeab42..064f173 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -31,6 +31,9 @@
 
 struct sys_timer;
 
+/* used by omap-smp.c and board-4430sdp.c */
+extern void __iomem *gic_cpu_base_addr;
+
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index abe0864..3bad928 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -104,6 +104,8 @@
 
 		.endm
 #else
+#define OMAP44XX_VA_GIC_CPU_BASE	OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
+
 		/*
 		 * The interrupt numbering scheme is defined in the
 		 * interrupt controller spec.  To wit:
diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
index b3ba5ac..8b4a578 100644
--- a/arch/arm/plat-omap/include/mach/omap44xx.h
+++ b/arch/arm/plat-omap/include/mach/omap44xx.h
@@ -33,14 +33,9 @@
 #define IRQ_SIR_IRQ			0x0040
 #define OMAP44XX_GIC_DIST_BASE		0x48241000
 #define OMAP44XX_GIC_CPU_BASE		0x48240100
-#define OMAP44XX_VA_GIC_CPU_BASE	OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
 #define OMAP44XX_SCU_BASE		0x48240000
-#define OMAP44XX_VA_SCU_BASE		OMAP2_IO_ADDRESS(OMAP44XX_SCU_BASE)
 #define OMAP44XX_LOCAL_TWD_BASE		0x48240600
-#define OMAP44XX_VA_LOCAL_TWD_BASE	OMAP2_IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE)
-#define OMAP44XX_LOCAL_TWD_SIZE		0x00000100
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
-#define OMAP44XX_VA_WKUPGEN_BASE	OMAP2_IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
 
 #endif /* __ASM_ARCH_OMAP44XX_H */
 

--7qSK/uQB79J36Y4o--
