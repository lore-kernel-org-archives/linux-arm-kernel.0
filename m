From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:13:28 +0200
Subject: [PATCH 07/10] ARM: ux500: kill off L2CC static map
Message-ID: <1431620008-15094-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The l2x0 level 2 cache initialization used a static map
to get at the l2x0 registers. Get rid of this by getting
the register range from the device tree and just remap it
for the short time we need it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cache-l2x0.c | 11 ++++++++++-
 arch/arm/mach-ux500/cpu-db8500.c |  7 -------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index e97ee556f92f..7557bede7ae6 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -6,6 +6,7 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/hardware/cache-l2x0.h>
 
@@ -15,7 +16,14 @@
 static int __init ux500_l2x0_unlock(void)
 {
 	int i;
-	void __iomem *l2x0_base = __io_address(U8500_L2CC_BASE);
+	struct device_node *np;
+	void __iomem *l2x0_base;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
+	l2x0_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!l2x0_base)
+		return -ENODEV;
 
 	/*
 	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
@@ -30,6 +38,7 @@ static int __init ux500_l2x0_unlock(void)
 		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I_BASE +
 			       i * L2X0_LOCKDOWN_STRIDE);
 	}
+	iounmap(l2x0_base);
 	return 0;
 }
 
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 3562b9aea767..fd0bc1978dbb 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -43,11 +43,6 @@ static struct prcmu_pdata db8500_prcmu_pdata = {
 	.legacy_offset	= DB8500_PRCMU_LEGACY_OFFSET,
 };
 
-/*  U8500 and U9540 common io_desc */
-static struct map_desc u8500_common_io_desc[] __initdata = {
-	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
-};
-
 /* U8500 IO map specific description */
 static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K),
@@ -66,8 +61,6 @@ static void __init u8500_map_io(void)
 	debug_ll_io_init();
 	ux500_map_io();
 
-	iotable_init(u8500_common_io_desc, ARRAY_SIZE(u8500_common_io_desc));
-
 	if (cpu_is_ux540_family())
 		iotable_init(u9540_io_desc, ARRAY_SIZE(u9540_io_desc));
 	else
-- 
1.9.3
