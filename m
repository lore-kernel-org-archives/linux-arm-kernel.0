From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Mon, 17 Sep 2012 20:13:15 +0530
Subject: [PATCH V4] ARM: EXYNOS5: Add bus clock and set parent clock for FIMD
Message-ID: <1347892995-17924-1-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the bus clock for FIMD and changes the device name for lcd clock
also sets mout_mpll_user as parent clock to fimd

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c |   35 ++++++++++++++++++++++++---------
 arch/arm/mach-exynos/clock-exynos5.h |   17 ++++++++++++++++
 2 files changed, 42 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-exynos/clock-exynos5.h

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 774533c..0f6ff97 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -27,6 +27,7 @@
 #include <mach/sysmmu.h>
 
 #include "common.h"
+#include "clock-exynos5.h"
 
 #ifdef CONFIG_PM_SLEEP
 static struct sleep_save exynos5_clock_save[] = {
@@ -891,6 +892,13 @@ static struct clk exynos5_clk_mdma1 = {
 	.ctrlbit	= (1 << 4),
 };
 
+static struct clk exynos5_clk_fimd1 = {
+	.name		= "fimd",
+	.devname	= "exynos5-fb.1",
+	.enable		= exynos5_clk_ip_disp1_ctrl,
+	.ctrlbit	= (1 << 0),
+};
+
 struct clk *exynos5_clkset_group_list[] = {
 	[0] = &clk_ext_xtal_mux,
 	[1] = NULL,
@@ -1120,6 +1128,18 @@ static struct clksrc_clk exynos5_clk_sclk_spi2 = {
 	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC2, .shift = 8, .size = 8 },
 };
 
+struct clksrc_clk exynos5_clk_sclk_fimd1 = {
+	.clk	= {
+		.name		= "sclk_fimd",
+		.devname	= "exynos5-fb.1",
+		.enable		= exynos5_clksrc_mask_disp1_0_ctrl,
+		.ctrlbit	= (1 << 0),
+	},
+	.sources = &exynos5_clkset_group,
+	.reg_src = { .reg = EXYNOS5_CLKSRC_DISP1_0, .shift = 0, .size = 4 },
+	.reg_div = { .reg = EXYNOS5_CLKDIV_DISP1_0, .shift = 0, .size = 4 },
+};
+
 static struct clksrc_clk exynos5_clksrcs[] = {
 	{
 		.clk	= {
@@ -1131,16 +1151,6 @@ static struct clksrc_clk exynos5_clksrcs[] = {
 		.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS3, .shift = 8, .size = 8 },
 	}, {
 		.clk	= {
-			.name		= "sclk_fimd",
-			.devname	= "s3cfb.1",
-			.enable		= exynos5_clksrc_mask_disp1_0_ctrl,
-			.ctrlbit	= (1 << 0),
-		},
-		.sources = &exynos5_clkset_group,
-		.reg_src = { .reg = EXYNOS5_CLKSRC_DISP1_0, .shift = 0, .size = 4 },
-		.reg_div = { .reg = EXYNOS5_CLKDIV_DISP1_0, .shift = 0, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "aclk_266_gscl",
 		},
 		.sources = &clk_src_gscl_266,
@@ -1240,12 +1250,14 @@ static struct clksrc_clk *exynos5_sysclks[] = {
 	&exynos5_clk_mdout_spi0,
 	&exynos5_clk_mdout_spi1,
 	&exynos5_clk_mdout_spi2,
+	&exynos5_clk_sclk_fimd1,
 };
 
 static struct clk *exynos5_clk_cdev[] = {
 	&exynos5_clk_pdma0,
 	&exynos5_clk_pdma1,
 	&exynos5_clk_mdma1,
+	&exynos5_clk_fimd1,
 };
 
 static struct clksrc_clk *exynos5_clksrc_cdev[] = {
@@ -1274,6 +1286,7 @@ static struct clk_lookup exynos5_clk_lookup[] = {
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma0),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma1),
 	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma1),
+	CLKDEV_INIT("exynos5-fb.1", "lcd", &exynos5_clk_fimd1),
 };
 
 static unsigned long exynos5_epll_get_rate(struct clk *clk)
@@ -1492,6 +1505,8 @@ void __init_or_cpufreq exynos5_setup_clocks(void)
 
 	clk_set_rate(&exynos5_clk_aclk_acp.clk, 267000000);
 	clk_set_rate(&exynos5_clk_pclk_acp.clk, 134000000);
+	clk_set_parent(&exynos5_clk_sclk_fimd1.clk,
+			&exynos5_clk_mout_mpll_user.clk);
 
 	for (ptr = 0; ptr < ARRAY_SIZE(exynos5_clksrcs); ptr++)
 		s3c_set_clksrc(&exynos5_clksrcs[ptr], true);
diff --git a/arch/arm/mach-exynos/clock-exynos5.h b/arch/arm/mach-exynos/clock-exynos5.h
new file mode 100644
index 0000000..6f78f5d
--- /dev/null
+++ b/arch/arm/mach-exynos/clock-exynos5.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header file for exynos5 clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_EXYNOS5_CLOCK_H
+#define __ASM_ARCH_EXYNOS5_CLOCK_H __FILE__
+
+extern struct clksrc_clk exynos5_clk_sclk_fimd1;
+
+#endif /* __ASM_ARCH_EXYNOS5_CLOCK_H */
-- 
1.7.0.4
