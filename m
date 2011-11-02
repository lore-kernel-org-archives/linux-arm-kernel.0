From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 02 Nov 2011 17:06:44 -0400
Subject: [PATCH V4 4/4] ARM: S5PV210: Add SPI clkdev support
In-Reply-To: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
References: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
Message-ID: <1320268004-4545-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Registered the SPI bus clocks with clkdev using generic
connection id.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   50 ++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index dc4586b..cead513 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -911,26 +911,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 28, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_spi",
-			.devname	= "s3c64xx-spi.0",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 16),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 0, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 0, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_spi",
-			.devname	= "s3c64xx-spi.1",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 17),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 4, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 4, .size = 4 },
-	}, {
-		.clk		= {
 			.name		= "sclk_pwi",
 			.enable		= s5pv210_clk_mask0_ctrl,
 			.ctrlbit	= (1 << 29),
@@ -1046,6 +1026,31 @@ static struct clksrc_clk clk_sclk_mmc3 = {
 	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
 };
 
+static struct clksrc_clk clk_sclk_spi0 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.devname	= "s3c64xx-spi.0",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 16),
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P_CLK_SRC5, .shift = 0, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV5, .shift = 0, .size = 4 },
+	};
+
+static struct clksrc_clk clk_sclk_spi1 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.devname	= "s3c64xx-spi.1",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 17),
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P_CLK_SRC5, .shift = 4, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV5, .shift = 4, .size = 4 },
+	};
+
+
 static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uart0,
 	&clk_sclk_uart1,
@@ -1055,6 +1060,8 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_mmc1,
 	&clk_sclk_mmc2,
 	&clk_sclk_mmc3,
+	&clk_sclk_spi0,
+	&clk_sclk_spi1,
 };
 
 static struct clk *clk_cdev[] = {
@@ -1317,6 +1324,9 @@ static struct clk_lookup s5pv210_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
+	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
 };
 
 void __init s5pv210_register_clocks(void)
-- 
1.7.0.4
