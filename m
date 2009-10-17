From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 17 Oct 2009 15:25:00 +0530
Subject: [PATCH] omap: ioremap fixes for omap4
Message-ID: <mailman.77.1255776553.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below ioremap for omap4 patch.

http://patchwork.kernel.org/patch/54457/

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c      |    4 ++--
 arch/arm/mach-omap2/omap-smp.c           |   23 ++++++++++-------------
 arch/arm/plat-omap/common.c              |    3 +++
 arch/arm/plat-omap/include/mach/common.h |    3 +++
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/boar=
d-4430sdp.c
index 50a62f2..4b644a9 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -60,9 +60,9 @@ static void __init gic_init_irq(void)
 	gic_dist_init(0, base, 29);
=20
 	/* Static mapping, never released */
-	base =3D ioremap(OMAP44XX_GIC_CPU_BASE, SZ_256);
+	gic_cpu_base_addr =3D ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
 	BUG_ON(!base);
-	gic_cpu_init(0, OMAP44XX_GIC_CPU_BASE);
+	gic_cpu_init(0, gic_cpu_base_addr);
 }
=20
 static void __init omap_4430sdp_init_irq(void)
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.=
c
index a1b618c..8813ac2 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -24,6 +24,7 @@
 #include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
+#include <mach/common.h>
=20
 /* Registers used for communicating startup information */
 static void __iomem *omap4_auxcoreboot_reg0;
@@ -46,8 +47,6 @@ static DEFINE_SPINLOCK(boot_lock);
=20
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
-	void __iomem *gic_cpu_base;
-
 	trace_hardirqs_off();
=20
 	/*
@@ -55,11 +54,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-
-	/* Static mapping, never released */
-	gic_cpu_base =3D ioremap(OMAP44XX_GIC_CPU_BASE, SZ_256);
-	BUG_ON(!gic_cpu_base);
-	gic_cpu_init(0, gic_cpu_base);
+	gic_cpu_init(0, gic_cpu_base_addr);
=20
 	/*
 	 * Synchronise with the boot thread.
@@ -125,7 +120,13 @@ static void __init wakeup_secondary(void)
  */
 void __init smp_init_cpus(void)
 {
-	unsigned int i, ncores =3D get_core_count();
+	unsigned int i, ncores;
+
+	/* Never released */
+	scu_base =3D ioremap(OMAP44XX_SCU_BASE, SZ_256);
+	BUG_ON(!scu_base);
+
+	ncores =3D get_core_count();
=20
 	for (i =3D 0; i < ncores; i++)
 		set_cpu_possible(i, true);
@@ -171,11 +172,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	omap4_wkupgen_base =3D ioremap(OMAP44XX_WKUPGEN_BASE, SZ_4K);
 	BUG_ON(!omap4_wkupgen_base);
 	omap4_auxcoreboot_reg0 =3D omap4_wkupgen_base + 0x800;
-	omap4_auxcoreboot_reg0 =3D omap4_wkupgen_base + 0x804;
-
-	/* Never released */
-	scu_base =3D ioremap(OMAP44XX_GIC_CPU_BASE, SZ_256);
-	BUG_ON(!scu_base);
+	omap4_auxcoreboot_reg1 =3D omap4_wkupgen_base + 0x804;
=20
 	if (max_cpus > 1) {
 		/*
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 1aa58d2..8b3ef17 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -49,6 +49,9 @@ int omap_bootloader_tag_len;
 struct omap_board_config_kernel *omap_board_config;
 int omap_board_config_size;
=20
+/* used by omap-smp.c and board-4430sdp.c */
+void __iomem *gic_cpu_base_addr;
+
 static const void *get_config(u16 tag, size_t len, int skip, size_t *len_o=
ut)
 {
 	struct omap_board_config_kernel *kinfo =3D NULL;
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/=
include/mach/common.h
index fdeab42..064f173 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -31,6 +31,9 @@
=20
 struct sys_timer;
=20
+/* used by omap-smp.c and board-4430sdp.c */
+extern void __iomem *gic_cpu_base_addr;
+
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
--=20
1.5.4.7



Regards,
Santosh
