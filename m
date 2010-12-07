From: will.deacon@arm.com (Will Deacon)
Date: Tue,  7 Dec 2010 14:43:18 +0000
Subject: [PATCH v4] ARM: vexpress: add support for multiple core tiles
Message-ID: <1291732998-22789-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current Versatile Express BSP defines the MACHINE_START macro
in the core tile code.

This patch moves this into the generic board code and introduces
a method for determining the current tile at runtime, allowing
the Kernel to have support for multiple tiles compiled in.
Tile-specific functions are executed via a descriptor struct containing
the correct implementations for the current tile.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Rebased against -next and updated following discussion with Russell on
the list.

 arch/arm/mach-vexpress/core.h                     |    5 --
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   41 ++++++++++----
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |    2 +
 arch/arm/mach-vexpress/include/mach/motherboard.h |   21 +++++++
 arch/arm/mach-vexpress/platsmp.c                  |   33 ++---------
 arch/arm/mach-vexpress/v2m.c                      |   62 +++++++++++++++++----
 6 files changed, 109 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index 362780d..f439715 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -17,8 +17,3 @@ struct amba_device name##_device = {		\
 	.irq		= IRQ_##base,		\
 	/* .dma		= DMA_##base,*/		\
 }
-
-struct map_desc;
-
-void v2m_map_io(struct map_desc *tile, size_t num);
-extern struct sys_timer v2m_timer;
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index e628402..881aeca 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -10,19 +10,17 @@
 #include <linux/amba/clcd.h>
 #include <linux/clkdev.h>
 
-#include <asm/pgtable.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
-#include <asm/mach-types.h>
 #include <asm/pmu.h>
+#include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 
 #include <mach/ct-ca9x4.h>
 
 #include <asm/hardware/timer-sp.h>
 
-#include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
@@ -56,7 +54,7 @@ static void __init ct_ca9x4_map_io(void)
 #ifdef CONFIG_LOCAL_TIMERS
 	twd_base = MMIO_P2V(A9_MPCORE_TWD);
 #endif
-	v2m_map_io(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
+	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
 static void __init ct_ca9x4_init_irq(void)
@@ -242,14 +240,33 @@ static void __init ct_ca9x4_init(void)
 	platform_device_register(&pmu_device);
 }
 
-MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
-	.boot_params	= PHYS_OFFSET + 0x00000100,
+#ifdef CONFIG_SMP
+static void ct_ca9x4_init_cpu_map(void)
+{
+	int i, ncores = scu_get_core_count(MMIO_P2V(A9_MPCORE_SCU));
+
+	for (i = 0; i < ncores; ++i)
+		set_cpu_possible(i, true);
+}
+
+static void ct_ca9x4_smp_enable(unsigned int max_cpus)
+{
+	int i;
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	scu_enable(MMIO_P2V(A9_MPCORE_SCU));
+}
+#endif
+
+struct ct_desc ct_ca9x4_desc = {
+	.id		= V2M_CT_ID_CA9,
+	.name		= "CA9x4",
 	.map_io		= ct_ca9x4_map_io,
 	.init_irq	= ct_ca9x4_init_irq,
-#if 0
-	.timer		= &ct_ca9x4_timer,
-#else
-	.timer		= &v2m_timer,
+	.init_tile	= ct_ca9x4_init,
+#ifdef CONFIG_SMP
+	.init_cpu_map	= ct_ca9x4_init_cpu_map,
+	.smp_enable	= ct_ca9x4_smp_enable,
 #endif
-	.init_machine	= ct_ca9x4_init,
-MACHINE_END
+};
diff --git a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
index f9e2f8d..a34d3d4 100644
--- a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
+++ b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
@@ -45,4 +45,6 @@
 #define IRQ_CT_CA9X4_PMU_CPU2	94
 #define IRQ_CT_CA9X4_PMU_CPU3	95
 
+extern struct ct_desc ct_ca9x4_desc;
+
 #endif
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index 98a8ded..aab3805 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -118,4 +118,25 @@
 int v2m_cfg_write(u32 devfn, u32 data);
 int v2m_cfg_read(u32 devfn, u32 *data);
 
+/*
+ * Core tile IDs
+ */
+#define V2M_CT_ID_CA9		0x0c000191
+#define V2M_CT_ID_UNSUPPORTED	0xff000191
+#define V2M_CT_ID_MASK		0xff000fff
+
+struct ct_desc {
+	u32			id;
+	const char		*name;
+	void			(*map_io)(void);
+	void			(*init_irq)(void);
+	void			(*init_tile)(void);
+#ifdef CONFIG_SMP
+	void			(*init_cpu_map)(void);
+	void			(*smp_enable)(unsigned int);
+#endif
+};
+
+extern struct ct_desc *ct_desc;
+
 #endif
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 24f1493..9e53d89 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -17,10 +17,8 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
-#include <asm/smp_scu.h>
 #include <asm/unified.h>
 
-#include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
 #define V2M_PA_CS7 0x10000000
 
@@ -34,11 +32,6 @@ extern void vexpress_secondary_startup(void);
  */
 volatile int __cpuinitdata pen_release = -1;
 
-static void __iomem *scu_base_addr(void)
-{
-	return MMIO_P2V(A9_MPCORE_SCU);
-}
-
 static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
@@ -115,36 +108,22 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  */
 void __init smp_init_cpus(void)
 {
-	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
-
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
+	ct_desc->init_cpu_map();
+	if (!num_possible_cpus()) {
 		printk(KERN_WARNING
-		       "vexpress: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
+		       "vexpress: no possible CPUs declared, forcing logical "
+		       "CPU 0\n");
+		set_cpu_possible(0, true);
 	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated@the present time.
 	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
-	scu_enable(scu_base_addr());
+	ct_desc->smp_enable(max_cpus);
 
 	/*
 	 * Write the address of secondary startup into the
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 314cedc..7f2de55 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -13,12 +13,15 @@
 #include <linux/usb/isp1760.h>
 #include <linux/clkdev.h>
 
+#include <asm/mach-types.h>
 #include <asm/sizes.h>
+#include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/arm_timer.h>
 
+#include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
 
 #include <asm/hardware/timer-sp.h>
@@ -40,13 +43,6 @@ static struct map_desc v2m_io_desc[] __initdata = {
 	},
 };
 
-void __init v2m_map_io(struct map_desc *tile, size_t num)
-{
-	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
-	iotable_init(tile, num);
-}
-
-
 static void __init v2m_timer_init(void)
 {
 	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
@@ -56,7 +52,7 @@ static void __init v2m_timer_init(void)
 	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0);
 }
 
-struct sys_timer v2m_timer = {
+static struct sys_timer v2m_timer = {
 	.init	= v2m_timer_init,
 };
 
@@ -342,7 +338,44 @@ static void v2m_restart(char str, const char *cmd)
 		printk(KERN_EMERG "Unable to reboot\n");
 }
 
-static int __init v2m_init(void)
+struct ct_desc *ct_desc;
+
+static struct ct_desc *ct_descs[] __initdata = {
+#ifdef CONFIG_ARCH_VEXPRESS_CA9X4
+	&ct_ca9x4_desc,
+#endif
+};
+
+static void __init v2m_populate_ct_desc(void)
+{
+	int i;
+	u32 current_tile_id;
+
+	ct_desc = NULL;
+	current_tile_id = readl(MMIO_P2V(V2M_SYS_PROCID0)) & V2M_CT_ID_MASK;
+
+	for (i = 0; i < ARRAY_SIZE(ct_descs) && !ct_desc; ++i)
+		if (ct_descs[i]->id == current_tile_id)
+			ct_desc = ct_descs[i];
+
+	if (!ct_desc)
+		panic("vexpress: failed to populate core tile description "
+		      "for tile ID 0x%8x\n", current_tile_id);
+}
+
+static void __init v2m_map_io(void)
+{
+	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
+	v2m_populate_ct_desc();
+	ct_desc->map_io();
+}
+
+static void __init v2m_init_irq(void)
+{
+	ct_desc->init_irq();
+}
+
+static void __init v2m_init(void)
 {
 	int i;
 
@@ -360,6 +393,13 @@ static int __init v2m_init(void)
 	pm_power_off = v2m_power_off;
 	arm_pm_restart = v2m_restart;
 
-	return 0;
+	ct_desc->init_tile();
 }
-arch_initcall(v2m_init);
+
+MACHINE_START(VEXPRESS, "ARM-Versatile Express")
+	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.map_io		= v2m_map_io,
+	.init_irq	= v2m_init_irq,
+	.timer		= &v2m_timer,
+	.init_machine	= v2m_init,
+MACHINE_END
-- 
1.7.0.4
