From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 02 Nov 2011 17:06:41 -0400
Subject: [PATCH V4 1/4] ARM: S3C64XX: Add SPI clkdev support
In-Reply-To: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
References: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
Message-ID: <1320268004-4545-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Registered the SPI bus clocks with clkdev using generic
connection id.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c |   80 +++++++++++++++++++++++++----------------
 1 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 415c540..0187cde 100644
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
@@ -226,6 +214,22 @@ static struct clk init_clocks_off[] = {
 	},
 };
 
+static struct clk clk_48m_spi0 = {
+	.name		= "spi_48m",
+	.devname	= "s3c64xx-spi.0",
+	.parent		= &clk_48m,
+	.enable		= s3c64xx_sclk_ctrl,
+	.ctrlbit	= S3C_CLKCON_SCLK_SPI0_48,
+};
+
+static struct clk clk_48m_spi1 = {
+	.name		= "spi_48m",
+	.devname	= "s3c64xx-spi.1",
+	.parent		= &clk_48m,
+	.enable		= s3c64xx_sclk_ctrl,
+	.ctrlbit	= S3C_CLKCON_SCLK_SPI1_48,
+};
+
 static struct clk init_clocks[] = {
 	{
 		.name		= "lcd",
@@ -592,25 +596,6 @@ static struct clksrc_clk clksrcs[] = {
 		.sources	= &clkset_uhost,
 	}, {
 		.clk	= {
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
-		.clk	= {
 			.name		= "audio-bus",
 			.devname	= "samsung-i2s.0",
 			.ctrlbit        = S3C_CLKCON_SCLK_AUDIO0,
@@ -708,6 +693,30 @@ static struct clksrc_clk clk_sclk_mmc2 = {
 	.sources	= &clkset_spi_mmc,
 };
 
+static struct clksrc_clk clk_sclk_spi0 = {
+	.clk	= {
+		.name		= "spi-bus",
+		.devname	= "s3c64xx-spi.0",
+		.ctrlbit	= S3C_CLKCON_SCLK_SPI0,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src = { .reg = S3C_CLK_SRC, .shift = 14, .size = 2 },
+	.reg_div = { .reg = S3C_CLK_DIV2, .shift = 0, .size = 4 },
+	.sources = &clkset_spi_mmc,
+};
+
+static struct clksrc_clk clk_sclk_spi1 = {
+	.clk	= {
+		.name		= "spi-bus",
+		.devname	= "s3c64xx-spi.1",
+		.ctrlbit	= S3C_CLKCON_SCLK_SPI1,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src = { .reg = S3C_CLK_SRC, .shift = 16, .size = 2 },
+	.reg_div = { .reg = S3C_CLK_DIV2, .shift = 4, .size = 4 },
+	.sources = &clkset_spi_mmc,
+};
+
 /* Clock initialisation code */
 
 static struct clksrc_clk *init_parents[] = {
@@ -721,12 +730,16 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_mmc0,
 	&clk_sclk_mmc1,
 	&clk_sclk_mmc2,
+	&clk_sclk_spi0,
+	&clk_sclk_spi1,
 };
 
 static struct clk *clk_cdev[] = {
 	&clk_hsmmc0,
 	&clk_hsmmc1,
 	&clk_hsmmc2,
+	&clk_48m_spi0,
+	&clk_48m_spi1,
 };
 
 static struct clk_lookup s3c64xx_clk_lookup[] = {
@@ -738,6 +751,11 @@ static struct clk_lookup s3c64xx_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_48m_spi0),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk2", &clk_48m_spi1),
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
-- 
1.7.0.4
