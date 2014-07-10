From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jul 2014 10:50:23 +0200
Subject: [PATCH] ARM: ux500: remove pointless cache setup complexity
Message-ID: <1404982223-8618-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cleans out non-DT cache setup (the ux500 is DT only), and
sinks the l2cc base into the unlock function.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cache-l2x0.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 842ebedbdd1c..e97ee556f92f 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -7,17 +7,15 @@
 #include <linux/io.h>
 #include <linux/of.h>
 
-#include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include "db8500-regs.h"
 #include "id.h"
 
-static void __iomem *l2x0_base;
-
 static int __init ux500_l2x0_unlock(void)
 {
 	int i;
+	void __iomem *l2x0_base = __io_address(U8500_L2CC_BASE);
 
 	/*
 	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
@@ -45,23 +43,15 @@ static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
 
 static int __init ux500_l2x0_init(void)
 {
-	if (cpu_is_u8500_family() || cpu_is_ux540_family())
-		l2x0_base = __io_address(U8500_L2CC_BASE);
-	else
-		/* Non-Ux500 platform */
+	/* Multiplatform guard */
+	if (!((cpu_is_u8500_family() || cpu_is_ux540_family())))
 		return -ENODEV;
 
 	/* Unlock before init */
 	ux500_l2x0_unlock();
-
 	outer_cache.write_sec = ux500_l2c310_write_sec;
-
-	if (of_have_populated_dt())
-		l2x0_of_init(0, ~0);
-	else
-		l2x0_init(l2x0_base, 0, ~0);
+	l2x0_of_init(0, ~0);
 
 	return 0;
 }
-
 early_initcall(ux500_l2x0_init);
-- 
1.9.3
