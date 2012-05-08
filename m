From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 09 May 2012 03:34:52 +0530
Subject: [PATCH 08/10] ARM: Exynos4: Fix the incorrect hierarchy of spi
 controller bus clock
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1336514694-22393-9-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sclk_spi clock is derived currently from the first level divider
(MMCx_RATIO) which is incorrect. The output of the first level clock
is divided by a second level divider (MMCx_PRE_RATIO), the output of
which is used as the spi bus clock (sclk_spi). Fix the clock hierarchy
issues for the sclk_spi clock.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/clock-exynos4.c |   48 ++++++++++++++++++++++++++++-----
 1 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
index 57b5464..331186e 100644
--- a/arch/arm/mach-exynos/clock-exynos4.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -1243,40 +1243,70 @@ static struct clksrc_clk exynos4_clk_sclk_mmc3 = {
 	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS2, .shift = 24, .size = 8 },
 };
 
+static struct clksrc_clk exynos4_clk_mdout_spi0 = {
+	.clk	= {
+		.name		= "sclk_spi_mdout",
+		.devname	= "exynos4210-spi.0",
+	},
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL1, .shift = 16, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL1, .shift = 0, .size = 4 },
+
+};
+
 static struct clksrc_clk exynos4_clk_sclk_spi0 = {
 	.clk	= {
 		.name		= "sclk_spi",
 		.devname	= "exynos4210-spi.0",
+		.parent		= &exynos4_clk_mdout_spi0.clk,
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 16),
 	},
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL1, .shift = 8, .size = 8 },
+};
+
+static struct clksrc_clk exynos4_clk_mdout_spi1 = {
+	.clk	= {
+		.name		= "sclk_spi_mdout",
+		.devname	= "exynos4210-spi.1",
+	},
 	.sources = &exynos4_clkset_group,
-	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL1, .shift = 16, .size = 4 },
-	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL1, .shift = 0, .size = 4 },
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL1, .shift = 20, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL1, .shift = 16, .size = 4 },
+
 };
 
 static struct clksrc_clk exynos4_clk_sclk_spi1 = {
 	.clk	= {
 		.name		= "sclk_spi",
 		.devname	= "exynos4210-spi.1",
+		.parent		= &exynos4_clk_mdout_spi1.clk,
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 20),
 	},
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL1, .shift = 24, .size = 8 },
+};
+
+static struct clksrc_clk exynos4_clk_mdout_spi2 = {
+	.clk	= {
+		.name		= "sclk_spi_mdout",
+		.devname	= "exynos4210-spi.2",
+	},
 	.sources = &exynos4_clkset_group,
-	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL1, .shift = 20, .size = 4 },
-	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL1, .shift = 16, .size = 4 },
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL1, .shift = 24, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL2, .shift = 0, .size = 4 },
+
 };
 
 static struct clksrc_clk exynos4_clk_sclk_spi2 = {
 	.clk	= {
 		.name		= "sclk_spi",
 		.devname	= "exynos4210-spi.2",
+		.parent		= &exynos4_clk_mdout_spi2.clk,
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 24),
 	},
-	.sources = &exynos4_clkset_group,
-	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL1, .shift = 24, .size = 4 },
-	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL2, .shift = 0, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL2, .shift = 8, .size = 8 },
 };
 
 /* Clock initialization code */
@@ -1332,7 +1362,9 @@ static struct clksrc_clk *exynos4_clksrc_cdev[] = {
 	&exynos4_clk_sclk_spi0,
 	&exynos4_clk_sclk_spi1,
 	&exynos4_clk_sclk_spi2,
-
+	&exynos4_clk_mdout_spi0,
+	&exynos4_clk_mdout_spi1,
+	&exynos4_clk_mdout_spi2,
 };
 
 static struct clk_lookup exynos4_clk_lookup[] = {
-- 
1.6.6.rc2
