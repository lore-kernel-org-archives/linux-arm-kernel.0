From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 11 Nov 2011 18:27:03 +0000
Subject: [PATCH 2/5] ARM: vexpress: Remove platform SMP functions from ct_desc
In-Reply-To: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1321036026-23411-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes platform SMP callbacks from ct_desc struct
and replaces them with global symbols in preparation for
DT-based support code.

This is a temporary measure till "SoC descriptors" code
gets into the main line.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/core.h                     |    6 +++
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   50 +++++++++-----------
 arch/arm/mach-vexpress/include/mach/motherboard.h |    4 --
 arch/arm/mach-vexpress/platsmp.c                  |    7 ++-
 4 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index 27a622b..2139b37 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -23,3 +23,9 @@ struct amba_device name##_device = {		\
 #define V2T_PERIPH 0xf8200000
 #define V2T_PERIPH_P2V(offset) ((void __iomem *)(V2T_PERIPH | (offset)))
 
+/* Will disappear once platform SMP calls are "abstracted" */
+#if defined(CONFIG_SMP)
+extern void (*vexpress_init_cpu_map)(void);
+extern void (*vexpress_smp_enable)(unsigned int);
+#endif
+
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 47c0733..d6dc80a 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -39,9 +39,32 @@ static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 	},
 };
 
+#ifdef CONFIG_SMP
+static void ct_ca9x4_init_cpu_map(void)
+{
+	int i, ncores;
+	ncores = scu_get_core_count(V2T_PERIPH_P2V(A9_MPCORE_SCU));
+
+	for (i = 0; i < ncores; ++i)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+static void ct_ca9x4_smp_enable(unsigned int max_cpus)
+{
+	scu_enable(V2T_PERIPH_P2V(A9_MPCORE_SCU));
+}
+#endif
+
 static void __init ct_ca9x4_map_io(void)
 {
 	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
+#ifdef CONFIG_SMP
+	/* Will be gone once the SoC descriptors are in */
+	vexpress_init_cpu_map = ct_ca9x4_init_cpu_map;
+	vexpress_smp_enable = ct_ca9x4_smp_enable;
+#endif
 }
 
 static void __init ct_ca9x4_init_irq(void)
@@ -188,29 +211,6 @@ static void __init ct_ca9x4_init(void)
 	platform_device_register(&pmu_device);
 }
 
-#ifdef CONFIG_SMP
-static void ct_ca9x4_init_cpu_map(void)
-{
-	int i, ncores = scu_get_core_count(V2TILE_PERIPH_P2V(A9_MPCORE_SCU));
-
-	if (ncores > nr_cpu_ids) {
-		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
-			ncores, nr_cpu_ids);
-		ncores = nr_cpu_ids;
-	}
-
-	for (i = 0; i < ncores; ++i)
-		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
-}
-
-static void ct_ca9x4_smp_enable(unsigned int max_cpus)
-{
-	scu_enable(V2TILE_PERIPH_P2V(A9_MPCORE_SCU));
-}
-#endif
-
 struct ct_desc ct_ca9x4_desc __initdata = {
 	.id		= V2M_CT_ID_CA9,
 	.name		= "CA9x4",
@@ -218,8 +218,4 @@ struct ct_desc ct_ca9x4_desc __initdata = {
 	.init_early	= ct_ca9x4_init_early,
 	.init_irq	= ct_ca9x4_init_irq,
 	.init_tile	= ct_ca9x4_init,
-#ifdef CONFIG_SMP
-	.init_cpu_map	= ct_ca9x4_init_cpu_map,
-	.smp_enable	= ct_ca9x4_smp_enable,
-#endif
 };
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index da9ac29..848353b 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -129,10 +129,6 @@ struct ct_desc {
 	void			(*init_early)(void);
 	void			(*init_irq)(void);
 	void			(*init_tile)(void);
-#ifdef CONFIG_SMP
-	void			(*init_cpu_map)(void);
-	void			(*smp_enable)(unsigned int);
-#endif
 };
 
 extern struct ct_desc *ct_desc;
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index e8be99d..b41e4e8 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -20,6 +20,9 @@
 
 #include "core.h"
 
+void (*vexpress_init_cpu_map)(void);
+void (*vexpress_smp_enable)(unsigned int);
+
 extern void versatile_secondary_startup(void);
 
 /*
@@ -28,7 +31,7 @@ extern void versatile_secondary_startup(void);
  */
 void __init smp_init_cpus(void)
 {
-	ct_desc->init_cpu_map();
+	vexpress_init_cpu_map();
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
@@ -37,7 +40,7 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
 	 */
-	ct_desc->smp_enable(max_cpus);
+	vexpress_smp_enable(max_cpus);
 
 	/*
 	 * Write the address of secondary startup into the
-- 
1.6.3.3
