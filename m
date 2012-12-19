From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 19 Dec 2012 11:05:49 +0530
Subject: [PATCH 1/5] ARM: S3C64XX: Add I2S clkdev support
In-Reply-To: <1355895353-10316-1-git-send-email-padma.v@samsung.com>
References: <1355895353-10316-1-git-send-email-padma.v@samsung.com>
Message-ID: <1355895353-10316-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2S controller has an internal mux for RCLK source clks. The list
of source clk names were passed through platform data in non-dt case.
Register the existing RCLK source clocks with clkdev using generic
connection id. This is required as part of adding DT support
for I2S controller driver.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Acked-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c     |  126 ++++++++++++++++++++++--------------
 arch/arm/mach-s3c64xx/dev-audio.c |   11 ---
 2 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 1a6f857..803711e 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -149,25 +149,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C6410_CLKCON_PCLK_I2C1,
 	}, {
-		.name		= "iis",
-		.devname	= "samsung-i2s.0",
-		.parent		= &clk_p,
-		.enable		= s3c64xx_pclk_ctrl,
-		.ctrlbit	= S3C_CLKCON_PCLK_IIS0,
-	}, {
-		.name		= "iis",
-		.devname	= "samsung-i2s.1",
-		.parent		= &clk_p,
-		.enable		= s3c64xx_pclk_ctrl,
-		.ctrlbit	= S3C_CLKCON_PCLK_IIS1,
-	}, {
-#ifdef CONFIG_CPU_S3C6410
-		.name		= "iis",
-		.parent		= &clk_p,
-		.enable		= s3c64xx_pclk_ctrl,
-		.ctrlbit	= S3C6410_CLKCON_PCLK_IIS2,
-	}, {
-#endif
 		.name		= "keypad",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
@@ -337,6 +318,32 @@ static struct clk clk_48m_spi1 = {
 	.ctrlbit	= S3C_CLKCON_SCLK_SPI1_48,
 };
 
+static struct clk clk_i2s0 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.0",
+	.parent		= &clk_p,
+	.enable		= s3c64xx_pclk_ctrl,
+	.ctrlbit	= S3C_CLKCON_PCLK_IIS0,
+};
+
+static struct clk clk_i2s1 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.1",
+	.parent		= &clk_p,
+	.enable		= s3c64xx_pclk_ctrl,
+	.ctrlbit	= S3C_CLKCON_PCLK_IIS1,
+};
+
+#ifdef CONFIG_CPU_S3C6410
+static struct clk clk_i2s2 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.2",
+	.parent		= &clk_p,
+	.enable		= s3c64xx_pclk_ctrl,
+	.ctrlbit	= S3C6410_CLKCON_PCLK_IIS2,
+};
+#endif
+
 static struct clk init_clocks[] = {
 	{
 		.name		= "lcd",
@@ -660,6 +667,7 @@ static struct clksrc_sources clkset_audio1 = {
 	.nr_sources	= ARRAY_SIZE(clkset_audio1_list),
 };
 
+#ifdef CONFIG_CPU_S3C6410
 static struct clk *clkset_audio2_list[] = {
 	[0] = &clk_mout_epll.clk,
 	[1] = &clk_dout_mpll,
@@ -672,6 +680,7 @@ static struct clksrc_sources clkset_audio2 = {
 	.sources	= clkset_audio2_list,
 	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
 };
+#endif
 
 static struct clksrc_clk clksrcs[] = {
 	{
@@ -685,36 +694,6 @@ static struct clksrc_clk clksrcs[] = {
 		.sources	= &clkset_uhost,
 	}, {
 		.clk	= {
-			.name		= "audio-bus",
-			.devname	= "samsung-i2s.0",
-			.ctrlbit        = S3C_CLKCON_SCLK_AUDIO0,
-			.enable		= s3c64xx_sclk_ctrl,
-		},
-		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 7, .size = 3  },
-		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 8, .size = 4  },
-		.sources	= &clkset_audio0,
-	}, {
-		.clk	= {
-			.name		= "audio-bus",
-			.devname	= "samsung-i2s.1",
-			.ctrlbit        = S3C_CLKCON_SCLK_AUDIO1,
-			.enable		= s3c64xx_sclk_ctrl,
-		},
-		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 10, .size = 3  },
-		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 12, .size = 4  },
-		.sources	= &clkset_audio1,
-	}, {
-		.clk	= {
-			.name		= "audio-bus",
-			.devname	= "samsung-i2s.2",
-			.ctrlbit        = S3C6410_CLKCON_SCLK_AUDIO2,
-			.enable		= s3c64xx_sclk_ctrl,
-		},
-		.reg_src	= { .reg = S3C6410_CLK_SRC2, .shift = 0, .size = 3  },
-		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 24, .size = 4  },
-		.sources	= &clkset_audio2,
-	}, {
-		.clk	= {
 			.name		= "irda-bus",
 			.ctrlbit        = S3C_CLKCON_SCLK_IRDA,
 			.enable		= s3c64xx_sclk_ctrl,
@@ -805,6 +784,43 @@ static struct clksrc_clk clk_sclk_spi1 = {
 	.sources = &clkset_spi_mmc,
 };
 
+static struct clksrc_clk clk_audio_bus0 = {
+	.clk	= {
+		.name		= "audio-bus",
+		.devname	= "samsung-i2s.0",
+		.ctrlbit	= S3C_CLKCON_SCLK_AUDIO0,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 7, .size = 3  },
+	.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 8, .size = 4  },
+	.sources	= &clkset_audio0,
+};
+
+static struct clksrc_clk clk_audio_bus1 = {
+	.clk	= {
+		.name		= "audio-bus",
+		.devname	= "samsung-i2s.1",
+		.ctrlbit	= S3C_CLKCON_SCLK_AUDIO1,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 10, .size = 3  },
+	.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 12, .size = 4  },
+	.sources	= &clkset_audio1,
+};
+
+#ifdef CONFIG_CPU_S3C6410
+static struct clksrc_clk clk_audio_bus2 = {
+	.clk	= {
+		.name		= "audio-bus",
+		.devname	= "samsung-i2s.2",
+		.ctrlbit	= S3C6410_CLKCON_SCLK_AUDIO2,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src	= { .reg = S3C6410_CLK_SRC2, .shift = 0, .size = 3  },
+	.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 24, .size = 4  },
+	.sources	= &clkset_audio2,
+};
+#endif
 /* Clock initialisation code */
 
 static struct clksrc_clk *init_parents[] = {
@@ -820,6 +836,8 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_mmc2,
 	&clk_sclk_spi0,
 	&clk_sclk_spi1,
+	&clk_audio_bus0,
+	&clk_audio_bus1,
 };
 
 static struct clk *clk_cdev[] = {
@@ -828,6 +846,8 @@ static struct clk *clk_cdev[] = {
 	&clk_hsmmc2,
 	&clk_48m_spi0,
 	&clk_48m_spi1,
+	&clk_i2s0,
+	&clk_i2s1,
 };
 
 static struct clk_lookup s3c64xx_clk_lookup[] = {
@@ -844,6 +864,14 @@ static struct clk_lookup s3c64xx_clk_lookup[] = {
 	CLKDEV_INIT("s3c6410-spi.0", "spi_busclk2", &clk_48m_spi0),
 	CLKDEV_INIT("s3c6410-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
 	CLKDEV_INIT("s3c6410-spi.1", "spi_busclk2", &clk_48m_spi1),
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &clk_i2s0),
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1", &clk_audio_bus0.clk),
+	CLKDEV_INIT("samsung-i2s.1", "i2s_opclk0", &clk_i2s1),
+	CLKDEV_INIT("samsung-i2s.1", "i2s_opclk1", &clk_audio_bus1.clk),
+#ifdef CONFIG_CPU_S3C6410
+	CLKDEV_INIT("samsung-i2s.2", "i2s_opclk0", &clk_i2s2),
+	CLKDEV_INIT("samsung-i2s.2", "i2s_opclk1", &clk_audio_bus2.clk),
+#endif
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 35f3e07..e367e87 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -23,11 +23,6 @@
 #include <linux/platform_data/asoc-s3c.h>
 #include <plat/gpio-cfg.h>
 
-static const char *rclksrc[] = {
-	[0] = "iis",
-	[1] = "audio-bus",
-};
-
 static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 {
 	unsigned int base;
@@ -64,11 +59,6 @@ static struct resource s3c64xx_iis0_resource[] = {
 
 static struct s3c_audio_pdata i2sv3_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
-	.type = {
-		.i2s = {
-			.src_clk = rclksrc,
-		},
-	},
 };
 
 struct platform_device s3c64xx_device_iis0 = {
@@ -110,7 +100,6 @@ static struct s3c_audio_pdata i2sv4_pdata = {
 	.type = {
 		.i2s = {
 			.quirks = QUIRK_PRI_6CHAN,
-			.src_clk = rclksrc,
 		},
 	},
 };
-- 
1.7.4.4
