From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Mar 2014 14:55:13 +0100
Subject: [PATCH] ARM: ux500: remove pointless cache setup args
Message-ID: <1395410113-19965-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the setup of the l2x0 lines that are essentially
just noops bouncing on the hardware as the cache registers are
protected in the secure world and there is no point in writing
them. Put in (0, ~0) to the l2x0_of_init() function as
suggested by Russell and cut the complex code out.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Russell: I don't know how this fits with other changes hitting
the l2x0 code, this file is pretty much stand-alone and
orthogonal to any other stuff hitting the Ux500 code, so I
can put it in your patch tracker if you want to take it or
some version of it into your tree.
---
 arch/arm/mach-ux500/cache-l2x0.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 264f894c0e3d..b535fc8f38bf 100644
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
@@ -37,30 +35,13 @@ static int __init ux500_l2x0_unlock(void)
 
 static int __init ux500_l2x0_init(void)
 {
-	u32 aux_val = 0x3e000000;
-
-	if (cpu_is_u8500_family() || cpu_is_ux540_family())
-		l2x0_base = __io_address(U8500_L2CC_BASE);
-	else
-		/* Non-Ux500 platform */
+	/* Needed for multiplatform boots */
+	if (!(cpu_is_u8500_family() || cpu_is_ux540_family()))
 		return -ENODEV;
 
 	/* Unlock before init */
 	ux500_l2x0_unlock();
-
-	/* DBx540's L2 has 128KB way size */
-	if (cpu_is_ux540_family())
-		/* 128KB way size */
-		aux_val |= (0x4 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
-	else
-		/* 64KB way size */
-		aux_val |= (0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
-
-	/* 64KB way size, 8 way associativity, force WA */
-	if (of_have_populated_dt())
-		l2x0_of_init(aux_val, 0xc0000fff);
-	else
-		l2x0_init(l2x0_base, aux_val, 0xc0000fff);
+	l2x0_of_init(0, ~0);
 
 	/*
 	 * We can't disable l2 as we are in non secure mode, currently
-- 
1.8.5.3
