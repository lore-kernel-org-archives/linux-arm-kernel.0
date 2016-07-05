From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jul 2016 14:45:05 +0200
Subject: [PATCH 06/11] ARM: ux500: use CLK_OF_DECLARE()
In-Reply-To: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1467722710-1577-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The ux500 DT support predates the CLK_OF_DECLARE macro and calls
directly into the clk driver from platform code.

Converting this to CLK_OF_DECLARE makes the code much nicer and
similar to how modern platforms do it today. It also removes the
last user of cpu_is_u8500_family() etc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS                             |  1 -
 arch/arm/mach-ux500/cpu.c               | 12 ------------
 drivers/clk/ux500/u8500_of_clk.c        | 16 ++--------------
 drivers/clk/ux500/u8540_clk.c           | 16 ++--------------
 drivers/clk/ux500/u9540_clk.c           |  4 ++--
 include/linux/platform_data/clk-ux500.h | 17 -----------------
 6 files changed, 6 insertions(+), 60 deletions(-)
 delete mode 100644 include/linux/platform_data/clk-ux500.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7304d2e37a98..1c75f3f610ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1821,7 +1821,6 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.linaro.org/people/ulfh/clk.git
 S:	Maintained
 F:	drivers/clk/ux500/
-F:	include/linux/platform_data/clk-ux500.h
 
 ARM/VERSATILE EXPRESS PLATFORM
 M:	Liviu Dudau <liviu.dudau@arm.com>
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index f8c2d6f2fb7e..63853e76a4e1 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -19,7 +19,6 @@
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
-#include <linux/platform_data/clk-ux500.h>
 #include <linux/platform_data/arm-ux500-pm.h>
 
 #include <asm/mach/map.h>
@@ -66,17 +65,6 @@ void __init ux500_init_irq(void)
 	prcmu_early_init(r.start, r.end-r.start);
 	ux500_pm_init(r.start, r.end-r.start);
 	ux500_l2x0_init();
-
-	/*
-	 * Init clocks here so that they are available for system timer
-	 * initialization.
-	 */
-	if (cpu_is_u8500_family())
-		u8500_clk_init();
-	else if (cpu_is_u9540())
-		u9540_clk_init();
-	else if (cpu_is_u8540())
-		u8540_clk_init();
 }
 
 static const char * __init ux500_get_machine(void)
diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index 9a736d939806..e960d686d9db 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -11,7 +11,6 @@
 #include <linux/of_address.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/dbx500-prcmu.h>
-#include <linux/platform_data/clk-ux500.h>
 #include "clk.h"
 
 #define PRCC_NUM_PERIPH_CLUSTERS 6
@@ -48,11 +47,6 @@ static struct clk *ux500_twocell_get(struct of_phandle_args *clkspec,
 	return PRCC_SHOW(clk_data, base, bit);
 }
 
-static const struct of_device_id u8500_clk_of_match[] = {
-	{ .compatible = "stericsson,u8500-clks", },
-	{ },
-};
-
 /* CLKRST4 is missing making it hard to index things */
 enum clkrst_index {
 	CLKRST1_INDEX = 0,
@@ -63,22 +57,15 @@ enum clkrst_index {
 	CLKRST_MAX,
 };
 
-void u8500_clk_init(void)
+static void u8500_clk_init(struct device_node *np)
 {
 	struct prcmu_fw_version *fw_version;
-	struct device_node *np = NULL;
 	struct device_node *child = NULL;
 	const char *sgaclk_parent = NULL;
 	struct clk *clk, *rtc_clk, *twd_clk;
 	u32 bases[CLKRST_MAX];
 	int i;
 
-	if (of_have_populated_dt())
-		np = of_find_matching_node(NULL, u8500_clk_of_match);
-	if (!np) {
-		pr_err("Either DT or U8500 Clock node not found\n");
-		return;
-	}
 	for (i = 0; i < ARRAY_SIZE(bases); i++) {
 		struct resource r;
 
@@ -573,3 +560,4 @@ void u8500_clk_init(void)
 			of_clk_add_provider(child, of_clk_src_simple_get, twd_clk);
 	}
 }
+CLK_OF_DECLARE(u8500_clks, "stericsson,u8500-clks", u8500_clk_init);
diff --git a/drivers/clk/ux500/u8540_clk.c b/drivers/clk/ux500/u8540_clk.c
index 86549e59fb42..133859f0e2bf 100644
--- a/drivers/clk/ux500/u8540_clk.c
+++ b/drivers/clk/ux500/u8540_clk.c
@@ -12,14 +12,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/dbx500-prcmu.h>
-#include <linux/platform_data/clk-ux500.h>
 #include "clk.h"
 
-static const struct of_device_id u8540_clk_of_match[] = {
-	{ .compatible = "stericsson,u8540-clks", },
-	{ }
-};
-
 /* CLKRST4 is missing making it hard to index things */
 enum clkrst_index {
 	CLKRST1_INDEX = 0,
@@ -30,19 +24,12 @@ enum clkrst_index {
 	CLKRST_MAX,
 };
 
-void u8540_clk_init(void)
+static void u8540_clk_init(struct device_node *np)
 {
 	struct clk *clk;
-	struct device_node *np = NULL;
 	u32 bases[CLKRST_MAX];
 	int i;
 
-	if (of_have_populated_dt())
-		np = of_find_matching_node(NULL, u8540_clk_of_match);
-	if (!np) {
-		pr_err("Either DT or U8540 Clock node not found\n");
-		return;
-	}
 	for (i = 0; i < ARRAY_SIZE(bases); i++) {
 		struct resource r;
 
@@ -607,3 +594,4 @@ void u8540_clk_init(void)
 			bases[CLKRST6_INDEX], BIT(0), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "rng");
 }
+CLK_OF_DECLARE(u8540_clks, "stericsson,u8540-clks", u8540_clk_init);
diff --git a/drivers/clk/ux500/u9540_clk.c b/drivers/clk/ux500/u9540_clk.c
index 2138a4c8cbca..7b6bca49ce42 100644
--- a/drivers/clk/ux500/u9540_clk.c
+++ b/drivers/clk/ux500/u9540_clk.c
@@ -9,10 +9,10 @@
 
 #include <linux/clk-provider.h>
 #include <linux/mfd/dbx500-prcmu.h>
-#include <linux/platform_data/clk-ux500.h>
 #include "clk.h"
 
-void u9540_clk_init(void)
+static void u9540_clk_init(struct device_node *np)
 {
 	/* register clocks here */
 }
+CLK_OF_DECLARE(u9540_clks, "stericsson,u9540-clks", u9540_clk_init);
diff --git a/include/linux/platform_data/clk-ux500.h b/include/linux/platform_data/clk-ux500.h
deleted file mode 100644
index 3af0da1f3be5..000000000000
--- a/include/linux/platform_data/clk-ux500.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Clock definitions for ux500 platforms
- *
- * Copyright (C) 2012 ST-Ericsson SA
- * Author: Ulf Hansson <ulf.hansson@linaro.org>
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#ifndef __CLK_UX500_H
-#define __CLK_UX500_H
-
-void u8500_clk_init(void);
-void u9540_clk_init(void);
-void u8540_clk_init(void);
-
-#endif /* __CLK_UX500_H */
-- 
2.4.11
