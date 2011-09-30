From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 30 Sep 2011 16:52:33 +0530
Subject: [PATCH 4/4] ARM: S5PV210: Add SPI clkdev support
In-Reply-To: <1317381753-2845-1-git-send-email-padma.v@samsung.com>
References: <1317381753-2845-1-git-send-email-padma.v@samsung.com>
Message-ID: <1317381753-2845-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Registered the SPI bus clocks with clkdev using generic
connection id.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   58 ++++++++++++++++++++++++++--------------
 1 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 4c5ac7a..3edf034 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -983,26 +983,6 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -1022,6 +1002,39 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk sclk_spi0 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 16),
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P_CLK_SRC5, .shift = 0, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV5, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk sclk_spi1 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 17),
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P_CLK_SRC5, .shift = 4, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV5, .shift = 4, .size = 4 },
+};
+
+static struct clk_lookup clk_lookup_table[] = {
+	CLKDEV_INIT(NULL, "spi_busclk0", clk_p)
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", sclk_spi0.clk)
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", sclk_spi1.clk)
+};
+
+static struct clksrc_clk *clksrc_cdev[] = {
+	&sclk_spi0,
+	&sclk_spi1,
+};
+
 /* Clock initialisation code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1273,6 +1286,9 @@ void __init s5pv210_register_clocks(void)
 	for (ptr = 0; ptr < ARRAY_SIZE(sclk_tv); ptr++)
 		s3c_register_clksrc(sclk_tv[ptr], 1);
 
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
+
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
@@ -1281,4 +1297,6 @@ void __init s5pv210_register_clocks(void)
 
 	s3c24xx_register_clock(&dummy_apb_pclk);
 	s3c_pwmclk_init();
+
+	clkdev_add_table(clk_lookup_table, ARRAY_SIZE(clk_lookup_table));
 }
-- 
1.7.4.4
