From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Feb 2011 12:18:38 +0000
Subject: [PATCH][RESEND] ARM: vexpress: add support for multiple core tiles
Message-ID: <1297685918-11804-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current Versatile Express BSP defines the MACHINE_START macro
in the core tile code.

This patch moves this into the generic board code and introduces a
method for determining the current tile at runtime, allowing the
Kernel to have support for multiple tiles compiled in. Tile-specific
functions are executed via a descriptor struct containing the correct
implementations for the current tile.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Russell - this has been sitting in your patch system for a while now and
I've been rebasing it onto -next so that it applies cleanly. I haven't
seen any conflicts lately so I wondered if there was anything else pending
or if this can now be merged? It's a pre-requisite for the A5 and A15 BSPs
which we hope to post soon.

 arch/arm/mach-vexpress/core.h                     |    6 --
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   45 ++++++++++-----
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |    2 +
 arch/arm/mach-vexpress/include/mach/motherboard.h |   22 +++++++
 arch/arm/mach-vexpress/platsmp.c                  |   31 +---------
 arch/arm/mach-vexpress/v2m.c                      |   65 +++++++++++++++++----
 6 files changed, 110 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index e0312a1..f439715 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -17,9 +17,3 @@ struct amba_device name##_device = {		\
 	.irq		= IRQ_##base,		\
 	/* .dma		= DMA_##base,*/		\
 }
-
-struct map_desc;
-
-void v2m_map_io(struct map_desc *tile, size_t num);
-void v2m_init_early(void);
-extern struct sys_timer v2m_timer;
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 30d5a5b..ebc22e7 100644
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
 
@@ -58,7 +56,7 @@ static void __init ct_ca9x4_map_io(void)
 #ifdef CONFIG_LOCAL_TIMERS
 	twd_base = MMIO_P2V(A9_MPCORE_TWD);
 #endif
-	v2m_map_io(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
+	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
 static void __init ct_ca9x4_init_irq(void)
@@ -183,8 +181,6 @@ static struct platform_device pmu_device = {
 static void __init ct_ca9x4_init_early(void)
 {
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	v2m_init_early();
 }
 
 static void __init ct_ca9x4_init(void)
@@ -207,15 +203,34 @@ static void __init ct_ca9x4_init(void)
 	platform_device_register(&pmu_device);
 }
 
-MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
-	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
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
+struct ct_desc ct_ca9x4_desc __initdata = {
+	.id		= V2M_CT_ID_CA9,
+	.name		= "CA9x4",
 	.map_io		= ct_ca9x4_map_io,
-	.init_irq	= ct_ca9x4_init_irq,
 	.init_early	= ct_ca9x4_init_early,
-#if 0
-	.timer		= &ct_ca9x4_timer,
-#else
-	.timer		= &v2m_timer,
+	.init_irq	= ct_ca9x4_init_irq,
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
index 98a8ded..0a3a375 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -118,4 +118,26 @@
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
+	void			(*init_early)(void);
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
index 1892702..2b5f7ac 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -13,10 +13,8 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <asm/smp_scu.h>
 #include <asm/unified.h>
 
-#include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
 #define V2M_PA_CS7 0x10000000
 
@@ -24,47 +22,22 @@
 
 extern void versatile_secondary_startup(void);
 
-static void __iomem *scu_base_addr(void)
-{
-	return MMIO_P2V(A9_MPCORE_SCU);
-}
-
 /*
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
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
-		printk(KERN_WARNING
-		       "vexpress: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	ct_desc->init_cpu_map();
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
 	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
-	scu_enable(scu_base_addr());
+	ct_desc->smp_enable(max_cpus);
 
 	/*
 	 * Write the address of secondary startup into the
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 63ef663..ba46e8e 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -14,7 +14,9 @@
 #include <linux/usb/isp1760.h>
 #include <linux/clkdev.h>
 
+#include <asm/mach-types.h>
 #include <asm/sizes.h>
+#include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -22,6 +24,7 @@
 #include <asm/hardware/timer-sp.h>
 #include <asm/hardware/sp810.h>
 
+#include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
 
 #include <plat/sched_clock.h>
@@ -43,14 +46,9 @@ static struct map_desc v2m_io_desc[] __initdata = {
 	},
 };
 
-void __init v2m_map_io(struct map_desc *tile, size_t num)
-{
-	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
-	iotable_init(tile, num);
-}
-
-void __init v2m_init_early(void)
+static void __init v2m_init_early(void)
 {
+	ct_desc->init_early();
 	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
 }
 
@@ -71,7 +69,7 @@ static void __init v2m_timer_init(void)
 	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0);
 }
 
-struct sys_timer v2m_timer = {
+static struct sys_timer v2m_timer = {
 	.init	= v2m_timer_init,
 };
 
@@ -380,7 +378,44 @@ static void v2m_restart(char str, const char *cmd)
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
 
@@ -399,6 +434,14 @@ static int __init v2m_init(void)
 	pm_power_off = v2m_power_off;
 	arm_pm_restart = v2m_restart;
 
-	return 0;
+	ct_desc->init_tile();
 }
-arch_initcall(v2m_init);
+
+MACHINE_START(VEXPRESS, "ARM-Versatile Express")
+	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
+	.map_io		= v2m_map_io,
+	.init_early	= v2m_init_early,
+	.init_irq	= v2m_init_irq,
+	.timer		= &v2m_timer,
+	.init_machine	= v2m_init,
+MACHINE_END
-- 
1.7.0.4
