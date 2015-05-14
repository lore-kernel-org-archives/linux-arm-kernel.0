From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:13:37 +0200
Subject: [PATCH 08/10] ARM: ux500: look up PRCMU resource from DT
Message-ID: <1431620017-15134-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the static map for the PRCMU in favor of looking
up that resource from the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 18 ------------------
 arch/arm/mach-ux500/cpu.c        | 20 +++++++++++++-------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index fd0bc1978dbb..d9359d7b80d7 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -43,28 +43,10 @@ static struct prcmu_pdata db8500_prcmu_pdata = {
 	.legacy_offset	= DB8500_PRCMU_LEGACY_OFFSET,
 };
 
-/* U8500 IO map specific description */
-static struct map_desc u8500_io_desc[] __initdata = {
-	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K),
-
-};
-
-/* U9540 IO map specific description */
-static struct map_desc u9540_io_desc[] __initdata = {
-	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K + SZ_8K),
-	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K + SZ_8K),
-};
-
 static void __init u8500_map_io(void)
 {
 	debug_ll_io_init();
 	ux500_map_io();
-
-	if (cpu_is_ux540_family())
-		iotable_init(u9540_io_desc, ARRAY_SIZE(u9540_io_desc));
-	else
-		iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
 }
 
 /*
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 6ced0f680262..e31d3d61c998 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -16,6 +16,7 @@
 #include <linux/stat.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/of_address.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
@@ -52,31 +53,36 @@ void ux500_restart(enum reboot_mode mode, const char *cmd)
 */
 void __init ux500_init_irq(void)
 {
+	struct device_node *np;
+	struct resource r;
+
 	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND);
 	irqchip_init();
+	np = of_find_compatible_node(NULL, NULL, "stericsson,db8500-prcmu");
+	of_address_to_resource(np, 0, &r);
+	of_node_put(np);
+	if (!r.start) {
+		pr_err("could not find PRCMU base resource\n");
+		return;
+	}
+	prcmu_early_init(r.start, r.end-r.start);
+	ux500_pm_init(r.start, r.end-r.start);
 
 	/*
 	 * Init clocks here so that they are available for system timer
 	 * initialization.
 	 */
 	if (cpu_is_u8500_family()) {
-		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
-		ux500_pm_init(U8500_PRCMU_BASE, SZ_8K - 1);
-
 		u8500_of_clk_init(U8500_CLKRST1_BASE,
 				  U8500_CLKRST2_BASE,
 				  U8500_CLKRST3_BASE,
 				  U8500_CLKRST5_BASE,
 				  U8500_CLKRST6_BASE);
 	} else if (cpu_is_u9540()) {
-		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
-		ux500_pm_init(U8500_PRCMU_BASE, SZ_8K - 1);
 		u9540_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
 			       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
 			       U8500_CLKRST6_BASE);
 	} else if (cpu_is_u8540()) {
-		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K + SZ_4K - 1);
-		ux500_pm_init(U8500_PRCMU_BASE, SZ_8K + SZ_4K - 1);
 		u8540_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
 			       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
 			       U8500_CLKRST6_BASE);
-- 
1.9.3
