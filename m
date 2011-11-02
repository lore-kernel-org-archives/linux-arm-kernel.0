From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 02 Nov 2011 17:06:42 -0400
Subject: [PATCH V4 2/4] ARM: S5PC100: Add SPI clkdev support
In-Reply-To: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
References: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
Message-ID: <1320268004-4545-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Registered the SPI bus clocks with clkdev using generic
connection id.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c |  124 ++++++++++++++++++++++++-----------------
 1 files changed, 73 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 69829ba..88110ab 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -655,24 +655,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
-		.name		= "spi_48m",
-		.devname	= "s3c64xx-spi.0",
-		.parent		= &clk_mout_48m.clk,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= (1 << 7),
-	}, {
-		.name		= "spi_48m",
-		.devname	= "s3c64xx-spi.1",
-		.parent		= &clk_mout_48m.clk,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= (1 << 8),
-	}, {
-		.name		= "spi_48m",
-		.devname	= "s3c64xx-spi.2",
-		.parent		= &clk_mout_48m.clk,
-		.enable		= s5pc100_sclk0_ctrl,
-		.ctrlbit	= (1 << 9),
-	}, {
 		.name		= "mmc_48m",
 		.devname	= "s3c-sdhci.0",
 		.parent		= &clk_mout_48m.clk,
@@ -717,6 +699,30 @@ static struct clk clk_hsmmc0 = {
 	.ctrlbit	= (1 << 5),
 };
 
+static struct clk clk_48m_spi0 = {
+	.name           = "spi_48m",
+	.devname        = "s3c64xx-spi.0",
+	.parent         = &clk_mout_48m.clk,
+	.enable         = s5pc100_sclk0_ctrl,
+	.ctrlbit        = (1 << 7),
+};
+
+static struct clk clk_48m_spi1 = {
+	.name           = "spi_48m",
+	.devname        = "s3c64xx-spi.1",
+	.parent         = &clk_mout_48m.clk,
+	.enable         = s5pc100_sclk0_ctrl,
+	.ctrlbit        = (1 << 8),
+};
+
+static struct clk clk_48m_spi2 = {
+	.name           = "spi_48m",
+	.devname        = "s3c64xx-spi.2",
+	.parent         = &clk_mout_48m.clk,
+	.enable         = s5pc100_sclk0_ctrl,
+	.ctrlbit        = (1 << 9),
+};
+
 static struct clk clk_vclk54m = {
 	.name		= "vclk_54m",
 	.rate		= 54000000,
@@ -935,39 +941,6 @@ static struct clksrc_clk clk_sclk_spdif = {
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
-			.name		= "sclk_spi",
-			.devname	= "s3c64xx-spi.0",
-			.ctrlbit	= (1 << 4),
-			.enable		= s5pc100_sclk0_ctrl,
-
-		},
-		.sources = &clk_src_group1,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_spi",
-			.devname	= "s3c64xx-spi.1",
-			.ctrlbit	= (1 << 5),
-			.enable		= s5pc100_sclk0_ctrl,
-
-		},
-		.sources = &clk_src_group1,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 8, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 8, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_spi",
-			.devname	= "s3c64xx-spi.2",
-			.ctrlbit	= (1 << 6),
-			.enable		= s5pc100_sclk0_ctrl,
-
-		},
-		.sources = &clk_src_group1,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 12, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "sclk_mixer",
 			.ctrlbit	= (1 << 6),
 			.enable		= s5pc100_sclk0_ctrl,
@@ -1108,6 +1081,42 @@ static struct clksrc_clk clk_sclk_mmc2 = {
 	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 8, .size = 4 },
 };
 
+static struct clksrc_clk clk_sclk_spi0 = {
+	.clk	= {
+		.name		= "sclk_spi",
+		.devname        = "s3c64xx-spi.0",
+		.ctrlbit	= (1 << 4),
+		.enable		= s5pc100_sclk0_ctrl,
+	},
+	.sources = &clk_src_group1,
+	.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 2 },
+	.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_spi1 = {
+	.clk	= {
+		.name		= "sclk_spi",
+		.devname        = "s3c64xx-spi.1",
+		.ctrlbit	= (1 << 5),
+		.enable		= s5pc100_sclk0_ctrl,
+	},
+	.sources = &clk_src_group1,
+	.reg_src = { .reg = S5P_CLK_SRC1, .shift = 8, .size = 2 },
+	.reg_div = { .reg = S5P_CLK_DIV2, .shift = 8, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_spi2 = {
+	.clk	= {
+		.name		= "sclk_spi",
+		.devname        = "s3c64xx-spi.2",
+		.ctrlbit	= (1 << 6),
+		.enable		= s5pc100_sclk0_ctrl,
+	},
+	.sources = &clk_src_group1,
+	.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 2 },
+	.reg_div = { .reg = S5P_CLK_DIV2, .shift = 12, .size = 4 },
+};
+
 /* Clock initialisation code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1141,6 +1150,9 @@ static struct clk *clk_cdev[] = {
 	&clk_hsmmc0,
 	&clk_hsmmc1,
 	&clk_hsmmc2,
+	&clk_48m_spi0,
+	&clk_48m_spi1,
+	&clk_48m_spi2,
 };
 
 static struct clksrc_clk *clksrc_cdev[] = {
@@ -1148,6 +1160,9 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_mmc0,
 	&clk_sclk_mmc1,
 	&clk_sclk_mmc2,
+	&clk_sclk_spi0,
+	&clk_sclk_spi1,
+	&clk_sclk_spi2,
 };
 
 void __init_or_cpufreq s5pc100_setup_clocks(void)
@@ -1298,6 +1313,13 @@ static struct clk_lookup s5pc100_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_48m_spi0),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_48m_spi1),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk2", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk1", &clk_48m_spi2),
+	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk2", &clk_sclk_spi2.clk),
 };
 
 void __init s5pc100_register_clocks(void)
-- 
1.7.0.4
