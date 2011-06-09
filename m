From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 09 Jun 2011 10:08:44 +0530
Subject: [PATCH 9/9] ARM: Exynos4: Add clkdev support
In-Reply-To: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
References: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1307594324-11053-10-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clkdev support for Samsung's Exynos4 platform and fixes the
incorrect clock name for the dw_mmc controller.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/mach-exynos4/clock.c |  200 ++++++++++++++---------------------------
 arch/arm/mach-exynos4/time.c  |    2 +
 3 files changed, 69 insertions(+), 134 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4bcd672..9756e04 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -777,6 +777,7 @@ config ARCH_EXYNOS4
 	select ARCH_SPARSEMEM_ENABLE
 	select GENERIC_GPIO
 	select HAVE_CLK
+	select CLKDEV_LOOKUP
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
 	select HAVE_S3C_RTC if RTC_CLASS
diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index b1b93b9..937335a 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -28,49 +28,40 @@
 
 static struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
-	.id		= -1,
 	.rate		= 27000000,
 };
 
 static struct clk clk_sclk_hdmiphy = {
 	.name		= "sclk_hdmiphy",
-	.id		= -1,
 };
 
 static struct clk clk_sclk_usbphy0 = {
 	.name		= "sclk_usbphy0",
-	.id		= -1,
 	.rate		= 27000000,
 };
 
 static struct clk clk_sclk_usbphy1 = {
 	.name		= "sclk_usbphy1",
-	.id		= -1,
 };
 
 static struct clk clk_sclk_xxti = {
 	.name		= "sclk_usbphy1",
-	.id		= -1,
 };
 
 static struct clk clk_sclk_xusbxti = {
 	.name		= "sclk_usbphy1",
-	.id		= -1,
 };
 
 static struct clk clk_audiocdclk0 = {
 	.name		= "audiocdclk",
-	.id		= 0,
 };
 
 static struct clk clk_audiocdclk1 = {
 	.name		= "audiocdclk",
-	.id		= 1,
 };
 
 static struct clk clk_audiocdclk2 = {
 	.name		= "audiocdclk",
-	.id		= 2,
 };
 
 static int exynos4_clksrc_mask_top_ctrl(struct clk *clk, int enable)
@@ -168,7 +159,6 @@ static int exynos4_clk_audss_ctrl(struct clk *clk, int enable)
 static struct clksrc_clk clk_mout_apll = {
 	.clk	= {
 		.name		= "mout_apll",
-		.id		= -1,
 	},
 	.sources	= &clk_src_apll,
 	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 0, .size = 1 },
@@ -177,7 +167,6 @@ static struct clksrc_clk clk_mout_apll = {
 static struct clksrc_clk clk_sclk_apll = {
 	.clk	= {
 		.name		= "sclk_apll",
-		.id		= -1,
 		.parent		= &clk_mout_apll.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 24, .size = 3 },
@@ -186,7 +175,6 @@ static struct clksrc_clk clk_sclk_apll = {
 static struct clksrc_clk clk_mout_epll = {
 	.clk	= {
 		.name		= "mout_epll",
-		.id		= -1,
 	},
 	.sources	= &clk_src_epll,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 4, .size = 1 },
@@ -195,7 +183,6 @@ static struct clksrc_clk clk_mout_epll = {
 static struct clksrc_clk clk_mout_mpll = {
 	.clk = {
 		.name		= "mout_mpll",
-		.id		= -1,
 	},
 	.sources	= &clk_src_mpll,
 	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 8, .size = 1 },
@@ -214,7 +201,6 @@ static struct clksrc_sources clkset_moutcore = {
 static struct clksrc_clk clk_moutcore = {
 	.clk	= {
 		.name		= "moutcore",
-		.id		= -1,
 	},
 	.sources	= &clkset_moutcore,
 	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 16, .size = 1 },
@@ -223,7 +209,6 @@ static struct clksrc_clk clk_moutcore = {
 static struct clksrc_clk clk_coreclk = {
 	.clk	= {
 		.name		= "core_clk",
-		.id		= -1,
 		.parent		= &clk_moutcore.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 0, .size = 3 },
@@ -232,7 +217,6 @@ static struct clksrc_clk clk_coreclk = {
 static struct clksrc_clk clk_armclk = {
 	.clk	= {
 		.name		= "armclk",
-		.id		= -1,
 		.parent		= &clk_coreclk.clk,
 	},
 };
@@ -240,7 +224,6 @@ static struct clksrc_clk clk_armclk = {
 static struct clksrc_clk clk_aclk_corem0 = {
 	.clk	= {
 		.name		= "aclk_corem0",
-		.id		= -1,
 		.parent		= &clk_coreclk.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
@@ -249,7 +232,6 @@ static struct clksrc_clk clk_aclk_corem0 = {
 static struct clksrc_clk clk_aclk_cores = {
 	.clk	= {
 		.name		= "aclk_cores",
-		.id		= -1,
 		.parent		= &clk_coreclk.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
@@ -258,7 +240,6 @@ static struct clksrc_clk clk_aclk_cores = {
 static struct clksrc_clk clk_aclk_corem1 = {
 	.clk	= {
 		.name		= "aclk_corem1",
-		.id		= -1,
 		.parent		= &clk_coreclk.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 8, .size = 3 },
@@ -267,7 +248,6 @@ static struct clksrc_clk clk_aclk_corem1 = {
 static struct clksrc_clk clk_periphclk = {
 	.clk	= {
 		.name		= "periphclk",
-		.id		= -1,
 		.parent		= &clk_coreclk.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 12, .size = 3 },
@@ -288,7 +268,6 @@ static struct clksrc_sources clkset_mout_corebus = {
 static struct clksrc_clk clk_mout_corebus = {
 	.clk	= {
 		.name		= "mout_corebus",
-		.id		= -1,
 	},
 	.sources	= &clkset_mout_corebus,
 	.reg_src	= { .reg = S5P_CLKSRC_DMC, .shift = 4, .size = 1 },
@@ -297,7 +276,6 @@ static struct clksrc_clk clk_mout_corebus = {
 static struct clksrc_clk clk_sclk_dmc = {
 	.clk	= {
 		.name		= "sclk_dmc",
-		.id		= -1,
 		.parent		= &clk_mout_corebus.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 12, .size = 3 },
@@ -306,7 +284,6 @@ static struct clksrc_clk clk_sclk_dmc = {
 static struct clksrc_clk clk_aclk_cored = {
 	.clk	= {
 		.name		= "aclk_cored",
-		.id		= -1,
 		.parent		= &clk_sclk_dmc.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 16, .size = 3 },
@@ -315,7 +292,6 @@ static struct clksrc_clk clk_aclk_cored = {
 static struct clksrc_clk clk_aclk_corep = {
 	.clk	= {
 		.name		= "aclk_corep",
-		.id		= -1,
 		.parent		= &clk_aclk_cored.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 20, .size = 3 },
@@ -324,7 +300,6 @@ static struct clksrc_clk clk_aclk_corep = {
 static struct clksrc_clk clk_aclk_acp = {
 	.clk	= {
 		.name		= "aclk_acp",
-		.id		= -1,
 		.parent		= &clk_mout_corebus.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 0, .size = 3 },
@@ -333,7 +308,6 @@ static struct clksrc_clk clk_aclk_acp = {
 static struct clksrc_clk clk_pclk_acp = {
 	.clk	= {
 		.name		= "pclk_acp",
-		.id		= -1,
 		.parent		= &clk_aclk_acp.clk,
 	},
 	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 4, .size = 3 },
@@ -354,7 +328,6 @@ static struct clksrc_sources clkset_aclk = {
 static struct clksrc_clk clk_aclk_200 = {
 	.clk	= {
 		.name		= "aclk_200",
-		.id		= -1,
 	},
 	.sources	= &clkset_aclk,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 12, .size = 1 },
@@ -364,7 +337,6 @@ static struct clksrc_clk clk_aclk_200 = {
 static struct clksrc_clk clk_aclk_100 = {
 	.clk	= {
 		.name		= "aclk_100",
-		.id		= -1,
 	},
 	.sources	= &clkset_aclk,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 16, .size = 1 },
@@ -374,7 +346,6 @@ static struct clksrc_clk clk_aclk_100 = {
 static struct clksrc_clk clk_aclk_160 = {
 	.clk	= {
 		.name		= "aclk_160",
-		.id		= -1,
 	},
 	.sources	= &clkset_aclk,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 20, .size = 1 },
@@ -384,7 +355,6 @@ static struct clksrc_clk clk_aclk_160 = {
 static struct clksrc_clk clk_aclk_133 = {
 	.clk	= {
 		.name		= "aclk_133",
-		.id		= -1,
 	},
 	.sources	= &clkset_aclk,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 24, .size = 1 },
@@ -404,7 +374,6 @@ static struct clksrc_sources clkset_vpllsrc = {
 static struct clksrc_clk clk_vpllsrc = {
 	.clk	= {
 		.name		= "vpll_src",
-		.id		= -1,
 		.enable		= exynos4_clksrc_mask_top_ctrl,
 		.ctrlbit	= (1 << 0),
 	},
@@ -425,7 +394,6 @@ static struct clksrc_sources clkset_sclk_vpll = {
 static struct clksrc_clk clk_sclk_vpll = {
 	.clk	= {
 		.name		= "sclk_vpll",
-		.id		= -1,
 	},
 	.sources	= &clkset_sclk_vpll,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 8, .size = 1 },
@@ -434,161 +402,151 @@ static struct clksrc_clk clk_sclk_vpll = {
 static struct clk init_clocks_off[] = {
 	{
 		.name		= "timers",
-		.id		= -1,
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1<<24),
 	}, {
 		.name		= "csis",
-		.id		= 0,
+		.devname	= "s5p-mipi-csis.0",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "csis",
-		.id		= 1,
+		.devname	= "s5p-mipi-csis.1",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "fimc",
-		.id		= 0,
+		.devname	= "exynos4-fimc.0",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "fimc",
-		.id		= 1,
+		.devname	= "exynos4-fimc.1",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "fimc",
-		.id		= 2,
+		.devname	= "exynos4-fimc.2",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "fimc",
-		.id		= 3,
+		.devname	= "exynos4-fimc.3",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "fimd",
-		.id		= 0,
+		.devname	= "s5pv310-fb.0",
 		.enable		= exynos4_clk_ip_lcd0_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "fimd",
-		.id		= 1,
+		.devname	= "s5pv310-fb.1",
 		.enable		= exynos4_clk_ip_lcd1_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "sataphy",
-		.id		= -1,
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "hsmmc",
-		.id		= 0,
+		.devname	= "s3c-sdhci.0",
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "hsmmc",
-		.id		= 1,
+		.devname	= "s3c-sdhci.1",
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "hsmmc",
-		.id		= 2,
+		.devname	= "s3c-sdhci.2",
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "hsmmc",
-		.id		= 3,
+		.devname	= "s3c-sdhci.3",
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
-		.name		= "hsmmc",
-		.id		= 4,
+		.name		= "dwmmc",
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "sata",
-		.id		= -1,
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "pdma",
-		.id		= 0,
+		.devname	= "s3c-pl330.0",
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "pdma",
-		.id		= 1,
+		.devname	= "s3c-pl330.1",
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "adc",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 15),
 	}, {
 		.name		= "keypad",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_perir_ctrl,
 		.ctrlbit	= (1 << 16),
 	}, {
 		.name		= "rtc",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_perir_ctrl,
 		.ctrlbit	= (1 << 15),
 	}, {
 		.name		= "watchdog",
-		.id		= -1,
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_perir_ctrl,
 		.ctrlbit	= (1 << 14),
 	}, {
 		.name		= "usbhost",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_fsys_ctrl ,
 		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= "otg",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 13),
 	}, {
 		.name		= "spi",
-		.id		= 0,
+		.devname	= "s3c64xx-spi.0",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 16),
 	}, {
 		.name		= "spi",
-		.id		= 1,
+		.devname	= "s3c64xx-spi.1",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 17),
 	}, {
 		.name		= "spi",
-		.id		= 2,
+		.devname	= "s3c64xx-spi.2",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 18),
 	}, {
 		.name		= "iis",
-		.id		= 0,
+		.devname	= "samsung-i2s.0",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 19),
 	}, {
 		.name		= "iis",
-		.id		= 1,
+		.devname	= "samsung-i2s.1",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 20),
 	}, {
 		.name		= "iis",
-		.id		= 2,
+		.devname	= "samsung-i2s.2",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 21),
 	}, {
@@ -598,140 +556,125 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 27),
 	}, {
 		.name		= "pcm",
-		.id		= 0,
+		.devname	= "samsung-pcm.0",
 		.enable		= exynos4_clk_audss_ctrl,
 		.ctrlbit	= S5P_AUDSS_CLKGATE_PCMSPECIAL,
 	}, {
 		.name		= "pcm",
-		.id		= 1,
+		.devname	= "samsung-pcm.1",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 22),
 	}, {
 		.name		= "pcm",
-		.id		= 2,
+		.devname	= "samsung-pcm.2",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 23),
 	}, {
 		.name		= "fimg2d",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_image_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "i2c",
-		.id		= 0,
+		.devname	=  "s3c2440-i2c.0",
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "i2c",
-		.id		= 1,
+		.devname	=  "s3c2440-i2c.1",
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "i2c",
-		.id		= 2,
+		.devname	=  "s3c2440-i2c.2",
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "i2c",
-		.id		= 3,
+		.devname	=  "s3c2440-i2c.3",
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "i2c",
-		.id		= 4,
+		.devname	=  "s3c2440-i2c.4",
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "i2c",
-		.id		= 5,
+		.devname	=  "s3c2440-i2c.5",
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 11),
 	}, {
 		.name		= "i2c",
-		.id		= 6,
+		.devname	=  "s3c2440-i2c.6",
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= "i2c",
-		.id		= 7,
+		.devname	=  "s3c2440-i2c.7",
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 13),
 	}, {
 		.name		= "SYSMMU_MDMA",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_image_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "SYSMMU_FIMC0",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "SYSMMU_FIMC1",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "SYSMMU_FIMC2",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "SYSMMU_FIMC3",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "SYSMMU_JPEG",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 11),
 	}, {
 		.name		= "SYSMMU_FIMD0",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_lcd0_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "SYSMMU_FIMD1",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_lcd1_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "SYSMMU_PCIe",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 18),
 	}, {
 		.name		= "SYSMMU_G2D",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_image_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "SYSMMU_ROTATOR",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_image_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "SYSMMU_TV",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_tv_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "SYSMMU_MFC_L",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_mfc_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "SYSMMU_MFC_R",
-		.id		= -1,
 		.enable		= exynos4_clk_ip_mfc_ctrl,
 		.ctrlbit	= (1 << 2),
 	}
@@ -757,7 +700,7 @@ static struct clksrc_sources clkset_sclk_audio0 = {
 static struct clksrc_clk clk_sclk_audio0 = {
 	.clk	= {
 		.name		= "audio-bus",
-		.id		= 0,
+		.devname	= "samsung-pcm.0",
 		.enable		= exynos4_clksrc_mask_maudio_ctrl,
 		.ctrlbit	= (1 << 0),
 	},
@@ -786,7 +729,7 @@ static struct clksrc_sources clkset_sclk_audio1 = {
 static struct clksrc_clk clk_sclk_audio1 = {
 	.clk	= {
 		.name		= "audio-bus",
-		.id		= 1,
+		.devname	= "samsung-pcm.1",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 0),
 	},
@@ -815,7 +758,7 @@ static struct clksrc_sources clkset_sclk_audio2 = {
 static struct clksrc_clk clk_sclk_audio2 = {
 	.clk	= {
 		.name		= "audio-bus",
-		.id		= 2,
+		.devname	= "samsung-pcm.2",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 4),
 	},
@@ -827,32 +770,32 @@ static struct clksrc_clk clk_sclk_audio2 = {
 static struct clk init_clocks[] = {
 	{
 		.name		= "uart",
-		.id		= 0,
+		.devname	= "s5pv210-uart.0",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "uart",
-		.id		= 1,
+		.devname	= "s5pv210-uart.1",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "uart",
-		.id		= 2,
+		.devname	= "s5pv210-uart.2",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "uart",
-		.id		= 3,
+		.devname	= "s5pv210-uart.3",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "uart",
-		.id		= 4,
+		.devname	= "s5pv210-uart.4",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "uart",
-		.id		= 5,
+		.devname	= "s5pv210-uart.5",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 5),
 	}
@@ -888,7 +831,6 @@ static struct clksrc_sources clkset_mout_g2d0 = {
 static struct clksrc_clk clk_mout_g2d0 = {
 	.clk	= {
 		.name		= "mout_g2d0",
-		.id		= -1,
 	},
 	.sources	= &clkset_mout_g2d0,
 	.reg_src	= { .reg = S5P_CLKSRC_IMAGE, .shift = 0, .size = 1 },
@@ -907,7 +849,6 @@ static struct clksrc_sources clkset_mout_g2d1 = {
 static struct clksrc_clk clk_mout_g2d1 = {
 	.clk	= {
 		.name		= "mout_g2d1",
-		.id		= -1,
 	},
 	.sources	= &clkset_mout_g2d1,
 	.reg_src	= { .reg = S5P_CLKSRC_IMAGE, .shift = 4, .size = 1 },
@@ -926,7 +867,6 @@ static struct clksrc_sources clkset_mout_g2d = {
 static struct clksrc_clk clk_dout_mmc0 = {
 	.clk		= {
 		.name		= "dout_mmc0",
-		.id		= -1,
 	},
 	.sources = &clkset_group,
 	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 0, .size = 4 },
@@ -936,7 +876,6 @@ static struct clksrc_clk clk_dout_mmc0 = {
 static struct clksrc_clk clk_dout_mmc1 = {
 	.clk		= {
 		.name		= "dout_mmc1",
-		.id		= -1,
 	},
 	.sources = &clkset_group,
 	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 4, .size = 4 },
@@ -946,7 +885,6 @@ static struct clksrc_clk clk_dout_mmc1 = {
 static struct clksrc_clk clk_dout_mmc2 = {
 	.clk		= {
 		.name		= "dout_mmc2",
-		.id		= -1,
 	},
 	.sources = &clkset_group,
 	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 8, .size = 4 },
@@ -956,7 +894,6 @@ static struct clksrc_clk clk_dout_mmc2 = {
 static struct clksrc_clk clk_dout_mmc3 = {
 	.clk		= {
 		.name		= "dout_mmc3",
-		.id		= -1,
 	},
 	.sources = &clkset_group,
 	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 12, .size = 4 },
@@ -966,7 +903,6 @@ static struct clksrc_clk clk_dout_mmc3 = {
 static struct clksrc_clk clk_dout_mmc4 = {
 	.clk		= {
 		.name		= "dout_mmc4",
-		.id		= -1,
 	},
 	.sources = &clkset_group,
 	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 16, .size = 4 },
@@ -977,7 +913,7 @@ static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
 			.name		= "uclk1",
-			.id		= 0,
+			.devname	= "s5pv210-uart.0",
 			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
@@ -987,7 +923,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "uclk1",
-			.id		= 1,
+			.devname	= "s5pv210-uart.1",
 			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 4),
 		},
@@ -997,7 +933,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "uclk1",
-			.id		= 2,
+			.devname	= "s5pv210-uart.2",
 			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 8),
 		},
@@ -1007,7 +943,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "uclk1",
-			.id		= 3,
+			.devname	= "s5pv210-uart.3",
 			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 12),
 		},
@@ -1017,7 +953,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_pwm",
-			.id		= -1,
 			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
@@ -1027,7 +962,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_csis",
-			.id		= 0,
+			.devname	= "s5p-mipi-csis.0",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
@@ -1037,7 +972,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_csis",
-			.id		= 1,
+			.devname	= "s5p-mipi-csis.1",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 28),
 		},
@@ -1047,7 +982,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_cam",
-			.id		= 0,
+			.devname	= "exynos4-fimc.0",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 16),
 		},
@@ -1057,7 +992,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_cam",
-			.id		= 1,
+			.devname	= "exynos4-fimc.1",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 20),
 		},
@@ -1067,7 +1002,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_fimc",
-			.id		= 0,
+			.devname	= "exynos4-fimc.0",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
@@ -1077,7 +1012,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_fimc",
-			.id		= 1,
+			.devname	= "exynos4-fimc.1",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 4),
 		},
@@ -1087,7 +1022,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_fimc",
-			.id		= 2,
+			.devname	= "exynos4-fimc.2",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 8),
 		},
@@ -1097,7 +1032,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_fimc",
-			.id		= 3,
+			.devname	= "exynos4-fimc.3",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 12),
 		},
@@ -1107,7 +1042,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_fimd",
-			.id		= 0,
+			.devname	= "s5pv310-fb.0",
 			.enable		= exynos4_clksrc_mask_lcd0_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
@@ -1117,7 +1052,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_fimd",
-			.id		= 1,
+			.devname	= "s5pv310-fb.1",
 			.enable		= exynos4_clksrc_mask_lcd1_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
@@ -1127,7 +1062,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_sata",
-			.id		= -1,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
@@ -1137,7 +1071,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_spi",
-			.id		= 0,
+			.devname	= "s3c64xx-spi.0",
 			.enable		= exynos4_clksrc_mask_peril1_ctrl,
 			.ctrlbit	= (1 << 16),
 		},
@@ -1147,7 +1081,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_spi",
-			.id		= 1,
+			.devname	= "s3c64xx-spi.1",
 			.enable		= exynos4_clksrc_mask_peril1_ctrl,
 			.ctrlbit	= (1 << 20),
 		},
@@ -1157,7 +1091,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_spi",
-			.id		= 2,
+			.devname	= "s3c64xx-spi.2",
 			.enable		= exynos4_clksrc_mask_peril1_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
@@ -1167,7 +1101,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_fimg2d",
-			.id		= -1,
 		},
 		.sources = &clkset_mout_g2d,
 		.reg_src = { .reg = S5P_CLKSRC_IMAGE, .shift = 8, .size = 1 },
@@ -1175,7 +1108,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
-			.id		= 0,
+			.devname	= "s3c-sdhci.0",
 			.parent		= &clk_dout_mmc0.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 0),
@@ -1184,7 +1117,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
-			.id		= 1,
+			.devname	= "s3c-sdhci.1",
 			.parent         = &clk_dout_mmc1.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 4),
@@ -1193,7 +1126,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
-			.id		= 2,
+			.devname	= "s3c-sdhci.2",
 			.parent         = &clk_dout_mmc2.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 8),
@@ -1202,7 +1135,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
-			.id		= 3,
+			.devname	= "s3c-sdhci.3",
 			.parent         = &clk_dout_mmc3.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 12),
@@ -1210,8 +1143,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
 	}, {
 		.clk		= {
-			.name		= "sclk_mmc",
-			.id		= 4,
+			.name		= "sclk_dwmmc",
 			.parent         = &clk_dout_mmc4.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 16),
@@ -1220,21 +1152,21 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_pcm",
-			.id		= 0,
+			.devname	= "samsung-pcm.0",
 			.parent		= &clk_sclk_audio0.clk,
 		},
 		.reg_div = { .reg = S5P_CLKDIV_MAUDIO, .shift = 4, .size = 8 },
 	}, {
 		.clk		= {
 			.name		= "sclk_pcm",
-			.id		= 1,
+			.devname	= "samsung-pcm.1",
 			.parent		= &clk_sclk_audio1.clk,
 		},
 		.reg_div = { .reg = S5P_CLKDIV_PERIL4, .shift = 4, .size = 8 },
 	}, {
 		.clk		= {
 			.name		= "sclk_pcm",
-			.id		= 2,
+			.devname	= "samsung-pcm.2",
 			.parent		= &clk_sclk_audio2.clk,
 		},
 		.reg_div = { .reg = S5P_CLKDIV_PERIL4, .shift = 20, .size = 8 },
diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index ebb8f38..9a74294 100644
--- a/arch/arm/mach-exynos4/time.c
+++ b/arch/arm/mach-exynos4/time.c
@@ -264,6 +264,7 @@ static void __init exynos4_timer_resources(void)
 	clk_enable(timerclk);
 
 	tmpdev.id = 2;
+	tmpdev.dev.init_name = "s3c24xx-pwm.2";
 	tin2 = clk_get(&tmpdev.dev, "pwm-tin");
 	if (IS_ERR(tin2))
 		panic("failed to get pwm-tin2 clock for system timer");
@@ -274,6 +275,7 @@ static void __init exynos4_timer_resources(void)
 	clk_enable(tin2);
 
 	tmpdev.id = 4;
+	tmpdev.dev.init_name = "s3c24xx-pwm.4";
 	tin4 = clk_get(&tmpdev.dev, "pwm-tin");
 	if (IS_ERR(tin4))
 		panic("failed to get pwm-tin4 clock for system timer");
-- 
1.6.6.rc2
