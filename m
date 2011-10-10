From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 10 Oct 2011 13:33:06 +0530
Subject: [PATCH V3 1/4] ARM: S3C64XX: Add SPI clkdev support
In-Reply-To: <1318233789-19882-1-git-send-email-padma.v@samsung.com>
References: <1318233789-19882-1-git-send-email-padma.v@samsung.com>
Message-ID: <1318233789-19882-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Registered the SPI bus clocks with clkdev using generic
connection id.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c |   98 +++++++++++++++++++++++++++-------------
 1 files changed, 66 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 39c238d..3420e5c 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -184,18 +184,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_SPI1,
 	}, {
-		.name		= "spi_48m",
-		.devname	= "s3c64xx-spi.0",
-		.parent		= &clk_48m,
-		.enable		= s3c64xx_sclk_ctrl,
-		.ctrlbit	= S3C_CLKCON_SCLK_SPI0_48,
-	}, {
-		.name		= "spi_48m",
-		.devname	= "s3c64xx-spi.1",
-		.parent		= &clk_48m,
-		.enable		= s3c64xx_sclk_ctrl,
-		.ctrlbit	= S3C_CLKCON_SCLK_SPI1_48,
-	}, {
 		.name		= "48m",
 		.devname	= "s3c-sdhci.0",
 		.parent		= &clk_48m,
@@ -625,26 +613,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 16, .size = 4  },
 		.sources	= &clkset_uart,
 	}, {
-/* Where does UCLK0 come from? */
-		.clk	= {
-			.name		= "spi-bus",
-			.devname	= "s3c64xx-spi.0",
-			.ctrlbit        = S3C_CLKCON_SCLK_SPI0,
-			.enable		= s3c64xx_sclk_ctrl,
-		},
-		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 14, .size = 2  },
-		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 0, .size = 4  },
-		.sources	= &clkset_spi_mmc,
-	}, {
-		.clk	= {
-			.name		= "spi-bus",
-			.devname	= "s3c64xx-spi.1",
-			.enable		= s3c64xx_sclk_ctrl,
-		},
-		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 16, .size = 2  },
-		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 4, .size = 4  },
-		.sources	= &clkset_spi_mmc,
-	}, {
 		.clk	= {
 			.name		= "audio-bus",
 			.devname	= "samsung-i2s.0",
@@ -695,6 +663,60 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clk clk_48m_spi0 = {
+	.name		= "spi_48m",
+	.parent		= &clk_48m,
+	.enable		= s3c64xx_sclk_ctrl,
+	.ctrlbit	= S3C_CLKCON_SCLK_SPI0_48,
+};
+
+static struct clk clk_48m_spi1 = {
+	.name		= "spi_48m",
+	.parent		= &clk_48m,
+	.enable		= s3c64xx_sclk_ctrl,
+	.ctrlbit	= S3C_CLKCON_SCLK_SPI1_48,
+};
+
+static struct clksrc_clk sclk_spi0 = {
+	.clk	 = {
+		.name		= "spi-bus",
+		.ctrlbit	= S3C_CLKCON_SCLK_SPI0,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src = { .reg = S3C_CLK_SRC, .shift = 14, .size = 2 },
+	.reg_div = { .reg = S3C_CLK_DIV2, .shift = 0, .size = 4 },
+	.sources = &clkset_spi_mmc,
+};
+
+static struct clksrc_clk sclk_spi1 = {
+	.clk	= {
+		.name		= "spi-bus",
+		.ctrlbit	= S3C_CLKCON_SCLK_SPI1,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src = { .reg = S3C_CLK_SRC, .shift = 16, .size = 2 },
+	.reg_div = { .reg = S3C_CLK_DIV2, .shift = 4, .size = 4 },
+	.sources = &clkset_spi_mmc,
+};
+
+static struct clk_lookup clk_lookup_table[] = {
+	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &sclk_spi0.clk),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_48m_spi0),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &sclk_spi1.clk),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk2", &clk_48m_spi1),
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
 
 static struct clksrc_clk *init_parents[] = {
@@ -811,11 +833,16 @@ static struct clk *clks[] __initdata = {
 void __init s3c64xx_register_clocks(unsigned long xtal, 
 				    unsigned armclk_divlimit)
 {
+	int ptr;
+
 	armclk_mask = armclk_divlimit;
 
 	s3c24xx_register_baseclocks(xtal);
 	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
 
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
+
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
@@ -823,5 +850,12 @@ void __init s3c64xx_register_clocks(unsigned long xtal,
 
 	s3c24xx_register_clocks(clks1, ARRAY_SIZE(clks1));
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
+		s3c_disable_clocks(clk_cdev[ptr], 1);
+
 	s3c_pwmclk_init();
+
+	clkdev_add_table(clk_lookup_table, ARRAY_SIZE(clk_lookup_table));
 }
-- 
1.7.4.4
