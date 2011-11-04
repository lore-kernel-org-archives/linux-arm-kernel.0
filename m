From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Fri, 04 Nov 2011 19:26:59 +0530
Subject: [PATCH 2/3] ARM: S5P64X0: Add lookup of sdhci-s3c clocks using generic
	names
In-Reply-To: <1320415020-7439-1-git-send-email-rajeshwari.s@samsung.com>
References: <1320415020-7439-1-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <1320415020-7439-3-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for lookup of sdhci-s3c controller clocks using generic
names for s5p64x0

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-s5p64x0/clock-s5p6440.c |   72 +++++++++++++++++++--------------
 arch/arm/mach-s5p64x0/clock-s5p6450.c |   72 +++++++++++++++++++--------------
 2 files changed, 84 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index 73c7cc9..c041ad7 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -379,36 +379,6 @@ static struct clksrc_sources clkset_audio = {
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.0",
-			.ctrlbit	= (1 << 24),
-			.enable		= s5p64x0_sclk_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 18, .size = 2 },
-		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 0, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.1",
-			.ctrlbit	= (1 << 25),
-			.enable		= s5p64x0_sclk_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 20, .size = 2 },
-		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 4, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.2",
-			.ctrlbit	= (1 << 26),
-			.enable		= s5p64x0_sclk_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 22, .size = 2 },
-		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 8, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "sclk_post",
 			.ctrlbit	= (1 << 10),
 			.enable		= s5p64x0_sclk_ctrl,
@@ -446,6 +416,42 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk clk_sclk_mmc0 = {
+	.clk	= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.0",
+		.ctrlbit	= (1 << 24),
+		.enable		= s5p64x0_sclk_ctrl,
+	},
+	.sources = &clkset_group1,
+	.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 18, .size = 2 },
+	.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mmc1 = {
+	.clk	= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.1",
+		.ctrlbit	= (1 << 25),
+		.enable		= s5p64x0_sclk_ctrl,
+	},
+	.sources = &clkset_group1,
+	.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 20, .size = 2 },
+	.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 4, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mmc2 = {
+	.clk	= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.2",
+		.ctrlbit	= (1 << 26),
+		.enable		= s5p64x0_sclk_ctrl,
+	},
+	.sources = &clkset_group1,
+	.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 22, .size = 2 },
+	.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 8, .size = 4 },
+};
+
 static struct clksrc_clk clk_sclk_uclk = {
 	.clk	= {
 		.name		= "uclk1",
@@ -503,6 +509,9 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uclk,
 	&clk_sclk_spi0,
 	&clk_sclk_spi1,
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2
 };
 
 static struct clk_lookup s5p6440_clk_lookup[] = {
@@ -511,6 +520,9 @@ static struct clk_lookup s5p6440_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
 	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
 	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 };
 
 void __init_or_cpufreq s5p6440_setup_clocks(void)
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index 50f90cb..b5087cb 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -413,36 +413,6 @@ static struct clksrc_clk clk_sclk_audio0 = {
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.0",
-			.ctrlbit	= (1 << 24),
-			.enable		= s5p64x0_sclk_ctrl,
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 18, .size = 2 },
-		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 0, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.1",
-			.ctrlbit	= (1 << 25),
-			.enable		= s5p64x0_sclk_ctrl,
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 20, .size = 2 },
-		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 4, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.2",
-			.ctrlbit	= (1 << 26),
-			.enable		= s5p64x0_sclk_ctrl,
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 22, .size = 2 },
-		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 8, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "sclk_fimc",
 			.ctrlbit	= (1 << 10),
 			.enable		= s5p64x0_sclk_ctrl,
@@ -507,6 +477,42 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk clk_sclk_mmc0 = {
+	.clk	= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.0",
+		.ctrlbit	= (1 << 24),
+		.enable		= s5p64x0_sclk_ctrl,
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 18, .size = 2 },
+	.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mmc1 = {
+	.clk	= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.1",
+		.ctrlbit	= (1 << 25),
+		.enable		= s5p64x0_sclk_ctrl,
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 20, .size = 2 },
+	.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 4, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mmc2 = {
+	.clk	= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.2",
+		.ctrlbit	= (1 << 26),
+		.enable		= s5p64x0_sclk_ctrl,
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 22, .size = 2 },
+	.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 8, .size = 4 },
+};
+
 static struct clksrc_clk clk_sclk_uclk = {
 	.clk	= {
 		.name		= "uclk1",
@@ -546,6 +552,9 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uclk,
 	&clk_sclk_spi0,
 	&clk_sclk_spi1,
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2,
 };
 
 static struct clk_lookup s5p6450_clk_lookup[] = {
@@ -554,6 +563,9 @@ static struct clk_lookup s5p6450_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
 	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
 	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 };
 
 /* Clock initialization code */
-- 
1.7.4.4
