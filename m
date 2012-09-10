From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Tue, 11 Sep 2012 01:41:06 +0530
Subject: [PATCH] ARM: EXYNOS5: Add bus clock and set parent clock for FIMD
Message-ID: <1347307866-30641-1-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the bus clock for FIMD and changes the device name for lcd clock
also sets mout_mpll_user as parent clock to fimd

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c       |   34 +++++++++++++++++++--------
 arch/arm/plat-samsung/include/plat/clock.h |    2 +
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 774533c..f1281cf 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -891,6 +891,13 @@ static struct clk exynos5_clk_mdma1 = {
 	.ctrlbit	= (1 << 4),
 };
 
+static struct clk exynos5_clk_fimd = {
+	.name		= "fimd",
+	.devname	= "exynos5-fb",
+	.enable		= exynos5_clk_ip_disp1_ctrl,
+	.ctrlbit	= (1 << 0),
+};
+
 struct clk *exynos5_clkset_group_list[] = {
 	[0] = &clk_ext_xtal_mux,
 	[1] = NULL,
@@ -1120,6 +1127,18 @@ static struct clksrc_clk exynos5_clk_sclk_spi2 = {
 	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC2, .shift = 8, .size = 8 },
 };
 
+struct clksrc_clk exynos5_clk_sclk_fimd = {
+	.clk	= {
+		.name	        = "sclk_fimd",
+		.devname        = "exynos5-fb",
+		.enable         = exynos5_clksrc_mask_disp1_0_ctrl,
+		.ctrlbit        = (1 << 0),
+	},
+	.sources = &exynos5_clkset_group,
+	.reg_src = { .reg = EXYNOS5_CLKSRC_DISP1_0, .shift = 0, .size = 4 },
+	.reg_div = { .reg = EXYNOS5_CLKDIV_DISP1_0, .shift = 0, .size = 4 },
+};
+
 static struct clksrc_clk exynos5_clksrcs[] = {
 	{
 		.clk	= {
@@ -1131,16 +1150,6 @@ static struct clksrc_clk exynos5_clksrcs[] = {
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
@@ -1240,12 +1249,14 @@ static struct clksrc_clk *exynos5_sysclks[] = {
 	&exynos5_clk_mdout_spi0,
 	&exynos5_clk_mdout_spi1,
 	&exynos5_clk_mdout_spi2,
+	&exynos5_clk_sclk_fimd,
 };
 
 static struct clk *exynos5_clk_cdev[] = {
 	&exynos5_clk_pdma0,
 	&exynos5_clk_pdma1,
 	&exynos5_clk_mdma1,
+	&exynos5_clk_fimd,
 };
 
 static struct clksrc_clk *exynos5_clksrc_cdev[] = {
@@ -1274,6 +1285,7 @@ static struct clk_lookup exynos5_clk_lookup[] = {
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma0),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma1),
 	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma1),
+	CLKDEV_INIT("exynos5-fb", "lcd", &exynos5_clk_fimd),
 };
 
 static unsigned long exynos5_epll_get_rate(struct clk *clk)
@@ -1492,6 +1504,8 @@ void __init_or_cpufreq exynos5_setup_clocks(void)
 
 	clk_set_rate(&exynos5_clk_aclk_acp.clk, 267000000);
 	clk_set_rate(&exynos5_clk_pclk_acp.clk, 134000000);
+	clk_set_parent(&exynos5_clk_sclk_fimd.clk,
+			&exynos5_clk_mout_mpll_user.clk);
 
 	for (ptr = 0; ptr < ARRAY_SIZE(exynos5_clksrcs); ptr++)
 		s3c_set_clksrc(&exynos5_clksrcs[ptr], true);
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index a62753d..3d27783 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -83,6 +83,8 @@ extern struct clk clk_ext;
 extern struct clksrc_clk clk_epllref;
 extern struct clksrc_clk clk_esysclk;
 
+extern struct clksrc_clk exynos5_clk_sclk_fimd;
+
 /* S3C64XX specific clocks */
 extern struct clk clk_h2;
 extern struct clk clk_27m;
-- 
1.7.0.4
