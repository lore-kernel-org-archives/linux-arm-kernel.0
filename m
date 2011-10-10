From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 10 Oct 2011 13:33:07 +0530
Subject: [PATCH V3 2/4] ARM: S5PC100: Add SPI clkdev support
In-Reply-To: <1318233789-19882-1-git-send-email-padma.v@samsung.com>
References: <1318233789-19882-1-git-send-email-padma.v@samsung.com>
Message-ID: <1318233789-19882-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Registered the SPI bus clocks with clkdev using generic
connection id.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c |  132 +++++++++++++++++++++++++----------------
 1 files changed, 81 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 8d47709..e025be7 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -673,24 +673,6 @@ static struct clk init_clocks_off[] = {
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
@@ -929,39 +911,6 @@ static struct clksrc_clk clk_sclk_spdif = {
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
 			.name		= "uclk1",
 			.ctrlbit	= (1 << 3),
 			.enable		= s5pc100_sclk0_ctrl,
@@ -1098,6 +1047,78 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clk clk_48m_spi0 = {
+	.name		= "spi_48m",
+	.parent		= &clk_mout_48m.clk,
+	.enable		= s5pc100_sclk0_ctrl,
+	.ctrlbit	= (1 << 7),
+};
+
+static struct clk clk_48m_spi1 = {
+	.name		= "spi_48m",
+	.parent		= &clk_mout_48m.clk,
+	.enable		= s5pc100_sclk0_ctrl,
+	.ctrlbit	= (1 << 8),
+};
+
+static struct clk clk_48m_spi2 = {
+	.name		= "spi_48m",
+	.parent		= &clk_mout_48m.clk,
+	.enable		= s5pc100_sclk0_ctrl,
+	.ctrlbit	= (1 << 9),
+};
+
+static struct clksrc_clk sclk_spi0 = {
+	.clk	= {
+		.name		= "sclk_spi",
+		.ctrlbit	= (1 << 4),
+		.enable		= s5pc100_sclk0_ctrl,
+		},
+	.sources = &clk_src_group1,
+	.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 2 },
+	.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
+};
+
+static struct clksrc_clk sclk_spi1 = {
+	.clk	= {
+		.name		= "sclk_spi",
+		.ctrlbit	= (1 << 5),
+		.enable		= s5pc100_sclk0_ctrl,
+	},
+	.sources = &clk_src_group1,
+	.reg_src = { .reg = S5P_CLK_SRC1, .shift = 8, .size = 2 },
+	.reg_div = { .reg = S5P_CLK_DIV2, .shift = 8, .size = 4 },
+};
+
+static struct clksrc_clk sclk_spi2 = {
+	.clk	= {
+		.name		= "sclk_spi",
+		.ctrlbit	= (1 << 6),
+		.enable		= s5pc100_sclk0_ctrl,
+	},
+	.sources = &clk_src_group1,
+	.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 2 },
+	.reg_div = { .reg = S5P_CLK_DIV2, .shift = 12, .size = 4 },
+};
+
+static struct clk_lookup clk_lookup_table[] = {
+	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_48m_spi0),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &sclk_spi0.clk),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_48m_spi1),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk2", &sclk_spi1.clk),
+};
+
+static struct clksrc_clk *clksrc_cdev[] = {
+	&sclk_spi0,
+	&sclk_spi1,
+};
+
+static struct clk *clk_cdev[] = {
+	&clk_48m_spi0,
+	&clk_48m_spi1,
+};
+
 /* Clock initialisation code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1276,12 +1297,21 @@ void __init s5pc100_register_clocks(void)
 		s3c_register_clksrc(sysclks[ptr], 1);
 
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
+
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
+		s3c_disable_clocks(clk_cdev[ptr], 1);
+
 	s3c24xx_register_clock(&dummy_apb_pclk);
 
 	s3c_pwmclk_init();
+	clkdev_add_table(clk_lookup_table, ARRAY_SIZE(clk_lookup_table));
 }
-- 
1.7.4.4
