From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 09 Jun 2011 10:08:42 +0530
Subject: [PATCH 7/9] ARM: S5PC100: Add clkdev support
In-Reply-To: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
References: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1307594324-11053-8-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clkdev support for Samsung's s5pc100 platforms.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/mach-s5pc100/clock.c |  163 ++++++++++-------------------------------
 2 files changed, 41 insertions(+), 123 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a96f764..f682107 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -744,6 +744,7 @@ config ARCH_S5PC100
 	bool "Samsung S5PC100"
 	select GENERIC_GPIO
 	select HAVE_CLK
+	select CLKDEV_LOOKUP
 	select CPU_V7
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_USES_GETTIMEOFFSET
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 0305e9b..cd248e6 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -31,7 +31,6 @@
 
 static struct clk s5p_clk_otgphy = {
 	.name		= "otg_phy",
-	.id		= -1,
 };
 
 static struct clk *clk_src_mout_href_list[] = {
@@ -47,7 +46,6 @@ static struct clksrc_sources clk_src_mout_href = {
 static struct clksrc_clk clk_mout_href = {
 	.clk = {
 		.name           = "mout_href",
-		.id             = -1,
 	},
 	.sources        = &clk_src_mout_href,
 	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 20, .size = 1 },
@@ -66,7 +64,6 @@ static struct clksrc_sources clk_src_mout_48m = {
 static struct clksrc_clk clk_mout_48m = {
 	.clk = {
 		.name           = "mout_48m",
-		.id             = -1,
 	},
 	.sources        = &clk_src_mout_48m,
 	.reg_src        = { .reg = S5P_CLK_SRC1, .shift = 24, .size = 1 },
@@ -75,7 +72,6 @@ static struct clksrc_clk clk_mout_48m = {
 static struct clksrc_clk clk_mout_mpll = {
 	.clk = {
 		.name           = "mout_mpll",
-		.id             = -1,
 	},
 	.sources        = &clk_src_mpll,
 	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
@@ -85,7 +81,6 @@ static struct clksrc_clk clk_mout_mpll = {
 static struct clksrc_clk clk_mout_apll = {
 	.clk    = {
 		.name           = "mout_apll",
-		.id             = -1,
 	},
 	.sources        = &clk_src_apll,
 	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
@@ -94,7 +89,6 @@ static struct clksrc_clk clk_mout_apll = {
 static struct clksrc_clk clk_mout_epll = {
 	.clk    = {
 		.name           = "mout_epll",
-		.id             = -1,
 	},
 	.sources        = &clk_src_epll,
 	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
@@ -112,7 +106,6 @@ static struct clksrc_sources clk_src_mout_hpll = {
 static struct clksrc_clk clk_mout_hpll = {
 	.clk    = {
 		.name           = "mout_hpll",
-		.id             = -1,
 	},
 	.sources        = &clk_src_mout_hpll,
 	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 12, .size = 1 },
@@ -121,7 +114,6 @@ static struct clksrc_clk clk_mout_hpll = {
 static struct clksrc_clk clk_div_apll = {
 	.clk	= {
 		.name	= "div_apll",
-		.id	= -1,
 		.parent	= &clk_mout_apll.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 0, .size = 1 },
@@ -130,7 +122,6 @@ static struct clksrc_clk clk_div_apll = {
 static struct clksrc_clk clk_div_arm = {
 	.clk	= {
 		.name	= "div_arm",
-		.id	= -1,
 		.parent	= &clk_div_apll.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 4, .size = 3 },
@@ -139,7 +130,6 @@ static struct clksrc_clk clk_div_arm = {
 static struct clksrc_clk clk_div_d0_bus = {
 	.clk	= {
 		.name	= "div_d0_bus",
-		.id	= -1,
 		.parent	= &clk_div_arm.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 8, .size = 3 },
@@ -148,7 +138,6 @@ static struct clksrc_clk clk_div_d0_bus = {
 static struct clksrc_clk clk_div_pclkd0 = {
 	.clk	= {
 		.name	= "div_pclkd0",
-		.id	= -1,
 		.parent	= &clk_div_d0_bus.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 12, .size = 3 },
@@ -157,7 +146,6 @@ static struct clksrc_clk clk_div_pclkd0 = {
 static struct clksrc_clk clk_div_secss = {
 	.clk	= {
 		.name	= "div_secss",
-		.id	= -1,
 		.parent	= &clk_div_d0_bus.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 16, .size = 3 },
@@ -166,7 +154,6 @@ static struct clksrc_clk clk_div_secss = {
 static struct clksrc_clk clk_div_apll2 = {
 	.clk	= {
 		.name	= "div_apll2",
-		.id	= -1,
 		.parent	= &clk_mout_apll.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 0, .size = 3 },
@@ -185,7 +172,6 @@ struct clksrc_sources clk_src_mout_am = {
 static struct clksrc_clk clk_mout_am = {
 	.clk	= {
 		.name	= "mout_am",
-		.id	= -1,
 	},
 	.sources = &clk_src_mout_am,
 	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 16, .size = 1 },
@@ -194,7 +180,6 @@ static struct clksrc_clk clk_mout_am = {
 static struct clksrc_clk clk_div_d1_bus = {
 	.clk	= {
 		.name	= "div_d1_bus",
-		.id	= -1,
 		.parent	= &clk_mout_am.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 12, .size = 3 },
@@ -203,7 +188,6 @@ static struct clksrc_clk clk_div_d1_bus = {
 static struct clksrc_clk clk_div_mpll2 = {
 	.clk	= {
 		.name	= "div_mpll2",
-		.id	= -1,
 		.parent	= &clk_mout_am.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 8, .size = 1 },
@@ -212,7 +196,6 @@ static struct clksrc_clk clk_div_mpll2 = {
 static struct clksrc_clk clk_div_mpll = {
 	.clk	= {
 		.name	= "div_mpll",
-		.id	= -1,
 		.parent	= &clk_mout_am.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 4, .size = 2 },
@@ -231,7 +214,6 @@ struct clksrc_sources clk_src_mout_onenand = {
 static struct clksrc_clk clk_mout_onenand = {
 	.clk	= {
 		.name	= "mout_onenand",
-		.id	= -1,
 	},
 	.sources = &clk_src_mout_onenand,
 	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 24, .size = 1 },
@@ -240,7 +222,6 @@ static struct clksrc_clk clk_mout_onenand = {
 static struct clksrc_clk clk_div_onenand = {
 	.clk	= {
 		.name	= "div_onenand",
-		.id	= -1,
 		.parent	= &clk_mout_onenand.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 20, .size = 2 },
@@ -249,7 +230,6 @@ static struct clksrc_clk clk_div_onenand = {
 static struct clksrc_clk clk_div_pclkd1 = {
 	.clk	= {
 		.name	= "div_pclkd1",
-		.id	= -1,
 		.parent	= &clk_div_d1_bus.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 16, .size = 3 },
@@ -258,7 +238,6 @@ static struct clksrc_clk clk_div_pclkd1 = {
 static struct clksrc_clk clk_div_cam = {
 	.clk	= {
 		.name	= "div_cam",
-		.id	= -1,
 		.parent	= &clk_div_mpll2.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 24, .size = 5 },
@@ -267,7 +246,6 @@ static struct clksrc_clk clk_div_cam = {
 static struct clksrc_clk clk_div_hdmi = {
 	.clk	= {
 		.name	= "div_hdmi",
-		.id	= -1,
 		.parent	= &clk_mout_hpll.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 28, .size = 4 },
@@ -399,367 +377,329 @@ static int s5pc100_sclk1_ctrl(struct clk *clk, int enable)
 static struct clk init_clocks_off[] = {
 	{
 		.name		= "cssys",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_0_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "secss",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_0_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "g2d",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_0_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "mdma",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_0_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "cfcon",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_0_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "nfcon",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_1_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "onenandc",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_1_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "sdm",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_2_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "seckey",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_2_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "hsmmc",
-		.id		= 2,
+		.devname	= "s3c-sdhci.2",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "hsmmc",
-		.id		= 1,
+		.devname	= "s3c-sdhci.1",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "hsmmc",
-		.id		= 0,
+		.devname	= "s3c-sdhci.0",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "modemif",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "otg",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "usbhost",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "pdma",
-		.id		= 1,
+		.devname	= "s3c-pl330.1",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "pdma",
-		.id		= 0,
+		.devname	= "s3c-pl330.0",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "lcd",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_1_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "rotator",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_1_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "fimc",
-		.id		= 0,
+		.devname	= "s5p-fimc.0",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_1_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "fimc",
-		.id		= 1,
+		.devname	= "s5p-fimc.1",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_1_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "fimc",
-		.id		= 2,
-		.parent		= &clk_div_d1_bus.clk,
+		.devname	= "s5p-fimc.2",
 		.enable		= s5pc100_d1_1_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "jpeg",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_1_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "mipi-dsim",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_1_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "mipi-csis",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_1_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "g3d",
-		.id		= 0,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "tv",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_2_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "vp",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_2_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "mixer",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_2_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "hdmi",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_2_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "mfc",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_2_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "apc",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_3_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "iec",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_3_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "systimer",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_3_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "watchdog",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_3_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "rtc",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_3_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "i2c",
-		.id		= 0,
+		.devname	= "s3c2440-i2c.0",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "i2c",
-		.id		= 1,
+		.devname	= "s3c2440-i2c.1",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "spi",
-		.id		= 0,
+		.devname	= "s3c64xx-spi.0",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "spi",
-		.id		= 1,
+		.devname	= "s3c64xx-spi.1",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "spi",
-		.id		= 2,
+		.devname	= "s3c64xx-spi.2",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "irda",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "ccan",
-		.id		= 0,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "ccan",
-		.id		= 1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 11),
 	}, {
 		.name		= "hsitx",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= "hsirx",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 13),
 	}, {
 		.name		= "iis",
-		.id		= 0,
+		.devname	= "samsung-i2s.0",
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "iis",
-		.id		= 1,
+		.devname	= "samsung-i2s.1",
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "iis",
-		.id		= 2,
+		.devname	= "samsung-i2s.2",
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "ac97",
-		.id		= -1,
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "pcm",
-		.id		= 0,
+		.devname	= "samsung-pcm.0",
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "pcm",
-		.id		= 1,
+		.devname	= "samsung-pcm.1",
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "spdif",
-		.id		= -1,
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "adc",
-		.id		= -1,
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "keypad",
-		.id		= -1,
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "spi_48m",
-		.id		= 0,
+		.devname	= "s3c64xx-spi.0",
 		.parent		= &clk_mout_48m.clk,
 		.enable		= s5pc100_sclk0_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "spi_48m",
-		.id		= 1,
+		.devname	= "s3c64xx-spi.1",
 		.parent		= &clk_mout_48m.clk,
 		.enable		= s5pc100_sclk0_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "spi_48m",
-		.id		= 2,
+		.devname	= "s3c64xx-spi.2",
 		.parent		= &clk_mout_48m.clk,
 		.enable		= s5pc100_sclk0_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "mmc_48m",
-		.id		= 0,
+		.devname	= "s3c-sdhci.0",
 		.parent		= &clk_mout_48m.clk,
 		.enable		= s5pc100_sclk0_ctrl,
 		.ctrlbit	= (1 << 15),
 	}, {
 		.name		= "mmc_48m",
-		.id		= 1,
+		.devname	= "s3c-sdhci.1",
 		.parent		= &clk_mout_48m.clk,
 		.enable		= s5pc100_sclk0_ctrl,
 		.ctrlbit	= (1 << 16),
 	}, {
 		.name		= "mmc_48m",
-		.id		= 2,
+		.devname	= "s3c-sdhci.2",
 		.parent		= &clk_mout_48m.clk,
 		.enable		= s5pc100_sclk0_ctrl,
 		.ctrlbit	= (1 << 17),
@@ -768,33 +708,27 @@ static struct clk init_clocks_off[] = {
 
 static struct clk clk_vclk54m = {
 	.name		= "vclk_54m",
-	.id		= -1,
 	.rate		= 54000000,
 };
 
 static struct clk clk_i2scdclk0 = {
 	.name		= "i2s_cdclk0",
-	.id		= -1,
 };
 
 static struct clk clk_i2scdclk1 = {
 	.name		= "i2s_cdclk1",
-	.id		= -1,
 };
 
 static struct clk clk_i2scdclk2 = {
 	.name		= "i2s_cdclk2",
-	.id		= -1,
 };
 
 static struct clk clk_pcmcdclk0 = {
 	.name		= "pcm_cdclk0",
-	.id		= -1,
 };
 
 static struct clk clk_pcmcdclk1 = {
 	.name		= "pcm_cdclk1",
-	.id		= -1,
 };
 
 static struct clk *clk_src_group1_list[] = {
@@ -836,7 +770,7 @@ struct clksrc_sources clk_src_group3 = {
 static struct clksrc_clk clk_sclk_audio0 = {
 	.clk	= {
 		.name		= "sclk_audio",
-		.id		= 0,
+		.devname	= "samsung-pcm.0",
 		.ctrlbit	= (1 << 8),
 		.enable		= s5pc100_sclk1_ctrl,
 	},
@@ -862,7 +796,7 @@ struct clksrc_sources clk_src_group4 = {
 static struct clksrc_clk clk_sclk_audio1 = {
 	.clk	= {
 		.name		= "sclk_audio",
-		.id		= 1,
+		.devname	= "samsung-pcm.1",
 		.ctrlbit	= (1 << 9),
 		.enable		= s5pc100_sclk1_ctrl,
 	},
@@ -887,7 +821,7 @@ struct clksrc_sources clk_src_group5 = {
 static struct clksrc_clk clk_sclk_audio2 = {
 	.clk	= {
 		.name		= "sclk_audio",
-		.id		= 2,
+		.devname	= "samsung-pcm.2",
 		.ctrlbit	= (1 << 10),
 		.enable		= s5pc100_sclk1_ctrl,
 	},
@@ -1014,7 +948,6 @@ static struct clk_ops s5pc100_sclk_spdif_ops = {
 static struct clksrc_clk clk_sclk_spdif = {
 	.clk	= {
 		.name		= "sclk_spdif",
-		.id		= -1,
 		.ctrlbit	= (1 << 11),
 		.enable		= s5pc100_sclk1_ctrl,
 		.ops		= &s5pc100_sclk_spdif_ops,
@@ -1027,7 +960,7 @@ static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
 			.name		= "sclk_spi",
-			.id		= 0,
+			.devname	= "s3c64xx-spi.0",
 			.ctrlbit	= (1 << 4),
 			.enable		= s5pc100_sclk0_ctrl,
 
@@ -1038,7 +971,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_spi",
-			.id		= 1,
+			.devname	= "s3c64xx-spi.1",
 			.ctrlbit	= (1 << 5),
 			.enable		= s5pc100_sclk0_ctrl,
 
@@ -1049,7 +982,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_spi",
-			.id		= 2,
+			.devname	= "s3c64xx-spi.2",
 			.ctrlbit	= (1 << 6),
 			.enable		= s5pc100_sclk0_ctrl,
 
@@ -1060,7 +993,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "uclk1",
-			.id		= -1,
 			.ctrlbit	= (1 << 3),
 			.enable		= s5pc100_sclk0_ctrl,
 
@@ -1071,7 +1003,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_mixer",
-			.id		= -1,
 			.ctrlbit	= (1 << 6),
 			.enable		= s5pc100_sclk0_ctrl,
 
@@ -1081,7 +1012,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_lcd",
-			.id		= -1,
 			.ctrlbit	= (1 << 0),
 			.enable		= s5pc100_sclk1_ctrl,
 
@@ -1092,7 +1022,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_fimc",
-			.id		= 0,
+			.devname	= "s5p-fimc.0",
 			.ctrlbit	= (1 << 1),
 			.enable		= s5pc100_sclk1_ctrl,
 
@@ -1103,7 +1033,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_fimc",
-			.id		= 1,
+			.devname	= "s5p-fimc.1",
 			.ctrlbit	= (1 << 2),
 			.enable		= s5pc100_sclk1_ctrl,
 
@@ -1114,7 +1044,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_fimc",
-			.id		= 2,
+			.devname	= "s5p-fimc.2",
 			.ctrlbit	= (1 << 3),
 			.enable		= s5pc100_sclk1_ctrl,
 
@@ -1125,7 +1055,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_mmc",
-			.id		= 0,
+			.devname	= "s3c-sdhci.0",
 			.ctrlbit	= (1 << 12),
 			.enable		= s5pc100_sclk1_ctrl,
 
@@ -1136,7 +1066,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_mmc",
-			.id		= 1,
+			.devname	= "s3c-sdhci.1",
 			.ctrlbit	= (1 << 13),
 			.enable		= s5pc100_sclk1_ctrl,
 
@@ -1147,7 +1077,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_mmc",
-			.id		= 2,
+			.devname	= "s3c-sdhci.2",
 			.ctrlbit	= (1 << 14),
 			.enable		= s5pc100_sclk1_ctrl,
 
@@ -1158,7 +1088,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_irda",
-			.id		= 2,
 			.ctrlbit	= (1 << 10),
 			.enable		= s5pc100_sclk0_ctrl,
 
@@ -1169,7 +1098,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_irda",
-			.id		= -1,
 			.ctrlbit	= (1 << 10),
 			.enable		= s5pc100_sclk0_ctrl,
 
@@ -1180,7 +1108,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_pwi",
-			.id		= -1,
 			.ctrlbit	= (1 << 1),
 			.enable		= s5pc100_sclk0_ctrl,
 
@@ -1191,7 +1118,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_uhost",
-			.id		= -1,
 			.ctrlbit	= (1 << 11),
 			.enable		= s5pc100_sclk0_ctrl,
 
@@ -1291,79 +1217,70 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
 static struct clk init_clocks[] = {
 	{
 		.name		= "tzic",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_0_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "intc",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_0_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "ebi",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_1_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "intmem",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_1_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "sromc",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_1_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "dmc",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_1_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "chipid",
-		.id		= -1,
 		.parent		= &clk_div_d0_bus.clk,
 		.enable		= s5pc100_d0_1_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "gpio",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_3_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "uart",
-		.id		= 0,
+		.devname	= "s3c6400-uart.0",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "uart",
-		.id		= 1,
+		.devname	= "s3c6400-uart.1",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "uart",
-		.id		= 2,
+		.devname	= "s3c6400-uart.2",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "uart",
-		.id		= 3,
+		.devname	= "s3c6400-uart.3",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "timers",
-		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_3_ctrl,
 		.ctrlbit	= (1 << 6),
-- 
1.6.6.rc2
