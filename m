From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 22 Dec 2009 00:21:26 +0100
Subject: [PATCH 1/10] ARM: PNX4008: convert to clkdev
Message-ID: <083DF309106F364B939360100EC290F804F592E901@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-pnx4008/clock.c               |   73 +++++++++++++++------------
 arch/arm/mach-pnx4008/clock.h               |    2 -
 arch/arm/mach-pnx4008/include/mach/clkdev.h |    7 +++
 4 files changed, 48 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-pnx4008/include/mach/clkdev.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..8714c12 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -552,6 +552,7 @@ config ARCH_PNX4008
 	bool "Philips Nexperia PNX4008 Mobile"
 	select CPU_ARM926T
 	select HAVE_CLK
+	select COMMON_CLKDEV
 	help
 	  This enables support for Philips PNX4008 mobile platform.
 
diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index 898c0e8..e0d1e9f 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -22,8 +22,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-
+#include <asm/clkdev.h>
+ 
+#include <mach/hardware.h>
 #include <mach/clock.h>
 #include "clock.h"
 
@@ -747,7 +748,7 @@ static struct clk wdt_ck = {
 /* These clocks are visible outside this module
  * and can be initialized
  */
-static struct clk *onchip_clks[] = {
+static struct clk *onchip_clks[] __initdata = {
 	&ck_13MHz,
 	&ck_pll1,
 	&ck_pll4,
@@ -777,6 +778,36 @@ static struct clk *onchip_clks[] = {
 	&wdt_ck,
 };
 
+static struct clk_lookup onchip_clkreg[] = {
+	{ .clk = &ck_13MHz,	.con_id = "ck_13MHz"	},
+	{ .clk = &ck_pll1,	.con_id = "ck_pll1"	},
+	{ .clk = &ck_pll4,	.con_id = "ck_pll4"	},
+	{ .clk = &ck_pll5,	.con_id = "ck_pll5"	},
+	{ .clk = &ck_pll3,	.con_id = "ck_pll3"	},
+	{ .clk = &vfp9_ck,	.con_id = "vfp9_ck"	},
+	{ .clk = &m2hclk_ck,	.con_id = "m2hclk_ck"	},
+	{ .clk = &hclk_ck,	.con_id = "hclk_ck"	},
+	{ .clk = &dma_ck,	.con_id = "dma_ck"	},
+	{ .clk = &flash_ck,	.con_id = "flash_ck"	},
+	{ .clk = &dum_ck,	.con_id = "dum_ck"	},
+	{ .clk = &keyscan_ck,	.con_id = "keyscan_ck"	},
+	{ .clk = &pwm1_ck,	.con_id = "pwm1_ck"	},
+	{ .clk = &pwm2_ck,	.con_id = "pwm2_ck"	},
+	{ .clk = &jpeg_ck,	.con_id = "jpeg_ck"	},
+	{ .clk = &ms_ck,	.con_id = "ms_ck"	},
+	{ .clk = &touch_ck,	.con_id = "touch_ck"	},
+	{ .clk = &i2c0_ck,	.con_id = "i2c0_ck"	},
+	{ .clk = &i2c1_ck,	.con_id = "i2c1_ck"	},
+	{ .clk = &i2c2_ck,	.con_id = "i2c2_ck"	},
+	{ .clk = &spi0_ck,	.con_id = "spi0_ck"	},
+	{ .clk = &spi1_ck,	.con_id = "spi1_ck"	},
+	{ .clk = &uart3_ck,	.con_id = "uart3_ck"	},
+	{ .clk = &uart4_ck,	.con_id = "uart4_ck"	},
+	{ .clk = &uart5_ck,	.con_id = "uart5_ck"	},
+	{ .clk = &uart6_ck,	.con_id = "uart6_ck"	},
+	{ .clk = &wdt_ck,	.con_id = "wdt_ck"	},
+};
+
 static int local_clk_enable(struct clk *clk)
 {
 	int ret = 0;
@@ -865,36 +896,7 @@ out:
 }
 
 EXPORT_SYMBOL(clk_set_rate);
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	struct clk *clk = ERR_PTR(-ENOENT);
-	struct clk **clkp;
-
-	clock_lock();
-	for (clkp = onchip_clks; clkp < onchip_clks + ARRAY_SIZE(onchip_clks);
-	     clkp++) {
-		if (strcmp(id, (*clkp)->name) == 0
-		    && try_module_get((*clkp)->owner)) {
-			clk = (*clkp);
-			break;
-		}
-	}
-	clock_unlock();
-
-	return clk;
-}
-EXPORT_SYMBOL(clk_get);
-
-void clk_put(struct clk *clk)
-{
-	clock_lock();
-	if (clk && !IS_ERR(clk))
-		module_put(clk->owner);
-	clock_unlock();
-}
-EXPORT_SYMBOL(clk_put);
-
+ 
 unsigned long clk_get_rate(struct clk *clk)
 {
 	unsigned long ret;
@@ -960,6 +962,7 @@ EXPORT_SYMBOL(clk_set_parent);
 
 static int __init clk_init(void)
 {
+	struct clk_lookup *cl;
 	struct clk **clkp;
 
 	/* Disable autoclocking, as it doesn't seem to work */
@@ -987,6 +990,10 @@ static int __init clk_init(void)
 	/* Disable autoclocking */
 	__raw_writeb(0xff, AUTOCLK_CTRL);
 
+	for (cl = onchip_clkreg;
+	     cl < onchip_clkreg + ARRAY_SIZE(onchip_clkreg); cl++)
+		clkdev_add(cl);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-pnx4008/clock.h b/arch/arm/mach-pnx4008/clock.h
index cd58f37..933e181 100644
--- a/arch/arm/mach-pnx4008/clock.h
+++ b/arch/arm/mach-pnx4008/clock.h
@@ -14,8 +14,6 @@
 #define __ARCH_ARM_PNX4008_CLOCK_H__
 
 struct clk {
-	struct list_head node;
-	struct module *owner;
 	const char *name;
 	struct clk *parent;
 	struct clk *propagate_next;
diff --git a/arch/arm/mach-pnx4008/include/mach/clkdev.h b/arch/arm/mach-pnx4008/include/mach/clkdev.h
new file mode 100644
index 0000000..8604b8e
--- /dev/null
+++ b/arch/arm/mach-pnx4008/include/mach/clkdev.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_CLKDEV_H
+#define __ASM_MACH_CLKDEV_H
+
+#define __clk_get(clk) ({ 1; })
+#define __clk_put(clk) do { } while (0)
+
+#endif
-- 
1.6.0.6
