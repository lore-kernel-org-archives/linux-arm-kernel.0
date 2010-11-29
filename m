From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Nov 2010 17:48:41 +0000
Subject: [PATCH v3] ARM: vexpress: add support for multiple core tiles
Message-ID: <1291052921-30695-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current Versatile Express BSP defines the MACHINE_START macro
in the core tile code.

This patch moves this into the generic board code and introduces
a method for determining the current tile at runtime, allowing
the Kernel to have support for multiple tiles compiled in.
Tile-specific functions are executed via a descriptor struct containing
the correct implementations for the current tile.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

The only change from v2 is that this is now based on 2.6.37-rc3 and
as such no longer sets the .phys_io and .io_pg_offst fields in the
machine descriptor.

 arch/arm/mach-vexpress/core.h                     |    5 --
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   34 +++++++----
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |    2 +
 arch/arm/mach-vexpress/include/mach/motherboard.h |   21 +++++++
 arch/arm/mach-vexpress/platsmp.c                  |   12 +---
 arch/arm/mach-vexpress/v2m.c                      |   62 +++++++++++++++++----
 6 files changed, 98 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index 57dd95c..c55feff 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -18,9 +18,4 @@ struct amba_device name##_device = {		\
 	/* .dma		= DMA_##base,*/		\
 }
 
-struct map_desc;
-
-void v2m_map_io(struct map_desc *tile, size_t num);
-extern struct sys_timer v2m_timer;
-
 extern void __iomem *gic_cpu_base_addr;
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index fd25ccd..0d77d04 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -10,12 +10,11 @@
 #include <linux/amba/clcd.h>
 
 #include <asm/clkdev.h>
-#include <asm/pgtable.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
-#include <asm/mach-types.h>
 #include <asm/pmu.h>
+#include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 
 #include <mach/clkdev.h>
@@ -23,7 +22,6 @@
 
 #include <plat/timer-sp.h>
 
-#include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
@@ -57,7 +55,7 @@ static void __init ct_ca9x4_map_io(void)
 #ifdef CONFIG_LOCAL_TIMERS
 	twd_base = MMIO_P2V(A9_MPCORE_TWD);
 #endif
-	v2m_map_io(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
+	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
 void __iomem *gic_cpu_base_addr;
@@ -246,14 +244,26 @@ static void __init ct_ca9x4_init(void)
 	platform_device_register(&pmu_device);
 }
 
-MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
-	.boot_params	= PHYS_OFFSET + 0x00000100,
+#ifdef CONFIG_SMP
+static unsigned int ct_ca9x4_get_core_count(void)
+{
+	return scu_get_core_count(MMIO_P2V(A9_MPCORE_SCU));
+}
+
+static void ct_ca9x4_smp_enable(void)
+{
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
+	.get_core_count	= ct_ca9x4_get_core_count,
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
index 98a8ded..6433ae5 100644
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
+	unsigned int		(*get_core_count)(void);
+	void			(*smp_enable)(void);
+#endif
+};
+
+extern struct ct_desc *ct_desc;
+
 #endif
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 6709706..b2d1e29 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -18,10 +18,8 @@
 
 #include <asm/cacheflush.h>
 #include <asm/localtimer.h>
-#include <asm/smp_scu.h>
 #include <asm/unified.h>
 
-#include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
 #define V2M_PA_CS7 0x10000000
 
@@ -35,11 +33,6 @@ extern void vexpress_secondary_startup(void);
  */
 volatile int __cpuinitdata pen_release = -1;
 
-static void __iomem *scu_base_addr(void)
-{
-	return MMIO_P2V(A9_MPCORE_SCU);
-}
-
 static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
@@ -118,10 +111,9 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  */
 void __init smp_init_cpus(void)
 {
-	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
 
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+	ncores = ct_desc->get_core_count();
 
 	/* sanity check */
 	if (ncores == 0) {
@@ -175,7 +167,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		 */
 		percpu_timer_setup();
 
-		scu_enable(scu_base_addr());
+		ct_desc->smp_enable();
 
 		/*
 		 * Write the address of secondary startup into the
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 7eaa232..99211ce 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -13,13 +13,17 @@
 #include <linux/usb/isp1760.h>
 
 #include <asm/clkdev.h>
+#include <asm/mach-types.h>
+#include <asm/pgtable.h>
 #include <asm/sizes.h>
+#include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/arm_timer.h>
 
 #include <mach/clkdev.h>
+#include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
 
 #include <plat/timer-sp.h>
@@ -41,13 +45,6 @@ static struct map_desc v2m_io_desc[] __initdata = {
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
@@ -57,7 +54,7 @@ static void __init v2m_timer_init(void)
 	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0);
 }
 
-struct sys_timer v2m_timer = {
+static struct sys_timer v2m_timer = {
 	.init	= v2m_timer_init,
 };
 
@@ -343,7 +340,43 @@ static void v2m_restart(char str, const char *cmd)
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
+	current_tile_id = readl(MMIO_P2V(V2M_SYS_PROCID0)) & V2M_CT_ID_MASK;
+	for (i = 0; i < ARRAY_SIZE(ct_descs) && !ct_desc; ++i)
+		if (ct_descs[i]->id == current_tile_id)
+			ct_desc = ct_descs[i];
+
+	if (!ct_desc)
+		panic("Versatile Express: failed to populate core tile "
+			"description for tile ID 0x%.8x\n", current_tile_id);
+
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
 
@@ -361,6 +394,13 @@ static int __init v2m_init(void)
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
