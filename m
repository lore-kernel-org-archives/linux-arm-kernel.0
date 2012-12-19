From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 19 Dec 2012 11:05:51 +0530
Subject: [PATCH 3/5] ARM: S5P64X0: Add I2S clkdev support
In-Reply-To: <1355895353-10316-1-git-send-email-padma.v@samsung.com>
References: <1355895353-10316-1-git-send-email-padma.v@samsung.com>
Message-ID: <1355895353-10316-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2S controller has an internal mux for RCLK source clk. The list
of source clk names were passed through platform data in non-dt case.
Register the existing RCLK source clocks with clkdev using generic
connection id. This is required as part of adding DT support
for I2S controller driver.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Acked-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5p64x0/clock-s5p6440.c |   49 ++++++++++++++++++---------
 arch/arm/mach-s5p64x0/clock-s5p6450.c |   61 ++++++++++++++++++++++----------
 arch/arm/mach-s5p64x0/dev-audio.c     |   12 ------
 3 files changed, 75 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index 0004455..5112371 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -243,12 +243,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s5p64x0_pclk_ctrl,
 		.ctrlbit	= (1 << 25),
 	}, {
-		.name		= "iis",
-		.devname	= "samsung-i2s.0",
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p64x0_pclk_ctrl,
-		.ctrlbit	= (1 << 26),
-	}, {
 		.name		= "dsim",
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p64x0_pclk_ctrl,
@@ -405,15 +399,6 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P64X0_CLK_SRC1, .shift = 8, .size = 2 },
 		.reg_div = { .reg = S5P64X0_CLK_DIV3, .shift = 4, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_audio2",
-			.ctrlbit	= (1 << 11),
-			.enable		= s5p64x0_sclk_ctrl,
-		},
-		.sources = &clkset_audio,
-		.reg_src = { .reg = S5P64X0_CLK_SRC1, .shift = 0, .size = 3 },
-		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 24, .size = 4 },
 	},
 };
 
@@ -464,6 +449,26 @@ static struct clksrc_clk clk_sclk_uclk = {
 	.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 16, .size = 4 },
 };
 
+static struct clk clk_i2s0 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.0",
+	.parent		= &clk_pclk_low.clk,
+	.enable		= s5p64x0_pclk_ctrl,
+	.ctrlbit	= (1 << 26),
+};
+
+static struct clksrc_clk clk_audio_bus2 = {
+	.clk	= {
+		.name		= "sclk_audio2",
+		.devname	= "samsung-i2s.0",
+		.ctrlbit	= (1 << 11),
+		.enable		= s5p64x0_sclk_ctrl,
+	},
+	.sources = &clkset_audio,
+	.reg_src = { .reg = S5P64X0_CLK_SRC1, .shift = 0, .size = 3 },
+	.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 24, .size = 4 },
+};
+
 static struct clksrc_clk clk_sclk_spi0 = {
 	.clk	= {
 		.name		= "sclk_spi",
@@ -506,13 +511,18 @@ static struct clk dummy_apb_pclk = {
 	.id		= -1,
 };
 
+static struct clk *clk_cdev[] = {
+	&clk_i2s0,
+};
+
 static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uclk,
 	&clk_sclk_spi0,
 	&clk_sclk_spi1,
 	&clk_sclk_mmc0,
 	&clk_sclk_mmc1,
-	&clk_sclk_mmc2
+	&clk_sclk_mmc2,
+	&clk_audio_bus2,
 };
 
 static struct clk_lookup s5p6440_clk_lookup[] = {
@@ -524,6 +534,8 @@ static struct clk_lookup s5p6440_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &clk_i2s0),
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1", &clk_audio_bus2.clk),
 };
 
 void __init_or_cpufreq s5p6440_setup_clocks(void)
@@ -596,12 +608,17 @@ static struct clk *clks[] __initdata = {
 void __init s5p6440_register_clocks(void)
 {
 	int ptr;
+	unsigned int cnt;
 
 	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
 
 	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
 		s3c_register_clksrc(sysclks[ptr], 1);
 
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (cnt = 0; cnt < ARRAY_SIZE(clk_cdev); cnt++)
+		s3c_disable_clocks(clk_cdev[cnt], 1);
+
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index f3e0ef3..154dea7 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -247,24 +247,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s5p64x0_pclk_ctrl,
 		.ctrlbit	= (1 << 22),
 	}, {
-		.name		= "iis",
-		.devname	= "samsung-i2s.0",
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p64x0_pclk_ctrl,
-		.ctrlbit	= (1 << 26),
-	}, {
-		.name		= "iis",
-		.devname	= "samsung-i2s.1",
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p64x0_pclk_ctrl,
-		.ctrlbit	= (1 << 15),
-	}, {
-		.name		= "iis",
-		.devname	= "samsung-i2s.2",
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p64x0_pclk_ctrl,
-		.ctrlbit	= (1 << 16),
-	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-i2c.1",
 		.parent		= &clk_pclk_low.clk,
@@ -402,6 +384,7 @@ static struct clksrc_sources clkset_sclk_audio0 = {
 static struct clksrc_clk clk_sclk_audio0 = {
 	.clk		= {
 		.name		= "audio-bus",
+		.devname	= "samsung-i2s.0",
 		.enable		= s5p64x0_sclk_ctrl,
 		.ctrlbit	= (1 << 8),
 		.parent		= &clk_dout_epll.clk,
@@ -549,6 +532,36 @@ static struct clksrc_clk clk_sclk_spi1 = {
 	.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 4, .size = 4 },
 };
 
+static struct clk clk_i2s0 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.0",
+	.parent		= &clk_pclk_low.clk,
+	.enable		= s5p64x0_pclk_ctrl,
+	.ctrlbit	= (1 << 26),
+};
+
+static struct clk clk_i2s1 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.1",
+	.parent		= &clk_pclk_low.clk,
+	.enable		= s5p64x0_pclk_ctrl,
+	.ctrlbit	= (1 << 15),
+};
+
+static struct clk clk_i2s2 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.2",
+	.parent		= &clk_pclk_low.clk,
+	.enable		= s5p64x0_pclk_ctrl,
+	.ctrlbit	= (1 << 16),
+};
+
+static struct clk *clk_cdev[] = {
+	&clk_i2s0,
+	&clk_i2s1,
+	&clk_i2s2,
+};
+
 static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uclk,
 	&clk_sclk_spi0,
@@ -556,6 +569,7 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_mmc0,
 	&clk_sclk_mmc1,
 	&clk_sclk_mmc2,
+	&clk_sclk_audio0,
 };
 
 static struct clk_lookup s5p6450_clk_lookup[] = {
@@ -567,6 +581,10 @@ static struct clk_lookup s5p6450_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &clk_i2s0),
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1", &clk_sclk_audio0.clk),
+	CLKDEV_INIT("samsung-i2s.1", "i2s_opclk0", &clk_i2s1),
+	CLKDEV_INIT("samsung-i2s.2", "i2s_opclk0", &clk_i2s2),
 };
 
 /* Clock initialization code */
@@ -584,7 +602,6 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_pclk,
 	&clk_hclk_low,
 	&clk_pclk_low,
-	&clk_sclk_audio0,
 };
 
 static struct clk dummy_apb_pclk = {
@@ -661,10 +678,16 @@ void __init_or_cpufreq s5p6450_setup_clocks(void)
 void __init s5p6450_register_clocks(void)
 {
 	int ptr;
+	unsigned int cnt;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
 		s3c_register_clksrc(sysclks[ptr], 1);
 
+
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (cnt = 0; cnt < ARRAY_SIZE(clk_cdev); cnt++)
+		s3c_disable_clocks(clk_cdev[cnt], 1);
+
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
diff --git a/arch/arm/mach-s5p64x0/dev-audio.c b/arch/arm/mach-s5p64x0/dev-audio.c
index a0d6edf..723d477 100644
--- a/arch/arm/mach-s5p64x0/dev-audio.c
+++ b/arch/arm/mach-s5p64x0/dev-audio.c
@@ -19,11 +19,6 @@
 #include <mach/dma.h>
 #include <mach/irqs.h>
 
-static const char *rclksrc[] = {
-	[0] = "iis",
-	[1] = "sclk_audio2",
-};
-
 static int s5p6440_cfg_i2s(struct platform_device *pdev)
 {
 	switch (pdev->id) {
@@ -45,7 +40,6 @@ static struct s3c_audio_pdata s5p6440_i2s_pdata = {
 	.type = {
 		.i2s = {
 			.quirks = QUIRK_PRI_6CHAN,
-			.src_clk = rclksrc,
 		},
 	},
 };
@@ -93,7 +87,6 @@ static struct s3c_audio_pdata s5p6450_i2s0_pdata = {
 	.type = {
 		.i2s = {
 			.quirks = QUIRK_PRI_6CHAN,
-			.src_clk = rclksrc,
 		},
 	},
 };
@@ -110,11 +103,6 @@ struct platform_device s5p6450_device_iis0 = {
 
 static struct s3c_audio_pdata s5p6450_i2s_pdata = {
 	.cfg_gpio = s5p6450_cfg_i2s,
-	.type = {
-		.i2s = {
-			.src_clk = rclksrc,
-		},
-	},
 };
 
 static struct resource s5p6450_i2s1_resource[] = {
-- 
1.7.4.4
