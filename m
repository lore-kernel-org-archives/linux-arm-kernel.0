From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 10 Mar 2012 02:19:07 -0800
Subject: [PATCH 3/5] ARM: EXYNOS: change the prefix S5P_ to EXYNOS4_ for clock
In-Reply-To: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
References: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1331374749-23256-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes prefix of the clk register from S5P_ to
EXYNOS4_ for new EXYNOS SoCs such as EXYNOS5 and adds prefix
exynos4_ on clk declarations.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos4.c           | 1028 ++++++++++++------------
 arch/arm/mach-exynos/clock-exynos4.h           |   15 +-
 arch/arm/mach-exynos/clock-exynos4210.c        |   44 +-
 arch/arm/mach-exynos/clock-exynos4212.c        |   28 +-
 arch/arm/mach-exynos/common.h                  |    9 +
 arch/arm/mach-exynos/include/mach/regs-clock.h |  364 +++++-----
 arch/arm/mach-exynos/pm.c                      |   40 +-
 7 files changed, 766 insertions(+), 762 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
index 7dde81b..8ebf411 100644
--- a/arch/arm/mach-exynos/clock-exynos4.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * EXYNOS4 - Clock support
@@ -31,85 +31,85 @@
 
 #ifdef CONFIG_PM_SLEEP
 static struct sleep_save exynos4_clock_save[] = {
-	SAVE_ITEM(S5P_CLKDIV_LEFTBUS),
-	SAVE_ITEM(S5P_CLKGATE_IP_LEFTBUS),
-	SAVE_ITEM(S5P_CLKDIV_RIGHTBUS),
-	SAVE_ITEM(S5P_CLKGATE_IP_RIGHTBUS),
-	SAVE_ITEM(S5P_CLKSRC_TOP0),
-	SAVE_ITEM(S5P_CLKSRC_TOP1),
-	SAVE_ITEM(S5P_CLKSRC_CAM),
-	SAVE_ITEM(S5P_CLKSRC_TV),
-	SAVE_ITEM(S5P_CLKSRC_MFC),
-	SAVE_ITEM(S5P_CLKSRC_G3D),
-	SAVE_ITEM(S5P_CLKSRC_LCD0),
-	SAVE_ITEM(S5P_CLKSRC_MAUDIO),
-	SAVE_ITEM(S5P_CLKSRC_FSYS),
-	SAVE_ITEM(S5P_CLKSRC_PERIL0),
-	SAVE_ITEM(S5P_CLKSRC_PERIL1),
-	SAVE_ITEM(S5P_CLKDIV_CAM),
-	SAVE_ITEM(S5P_CLKDIV_TV),
-	SAVE_ITEM(S5P_CLKDIV_MFC),
-	SAVE_ITEM(S5P_CLKDIV_G3D),
-	SAVE_ITEM(S5P_CLKDIV_LCD0),
-	SAVE_ITEM(S5P_CLKDIV_MAUDIO),
-	SAVE_ITEM(S5P_CLKDIV_FSYS0),
-	SAVE_ITEM(S5P_CLKDIV_FSYS1),
-	SAVE_ITEM(S5P_CLKDIV_FSYS2),
-	SAVE_ITEM(S5P_CLKDIV_FSYS3),
-	SAVE_ITEM(S5P_CLKDIV_PERIL0),
-	SAVE_ITEM(S5P_CLKDIV_PERIL1),
-	SAVE_ITEM(S5P_CLKDIV_PERIL2),
-	SAVE_ITEM(S5P_CLKDIV_PERIL3),
-	SAVE_ITEM(S5P_CLKDIV_PERIL4),
-	SAVE_ITEM(S5P_CLKDIV_PERIL5),
-	SAVE_ITEM(S5P_CLKDIV_TOP),
-	SAVE_ITEM(S5P_CLKSRC_MASK_TOP),
-	SAVE_ITEM(S5P_CLKSRC_MASK_CAM),
-	SAVE_ITEM(S5P_CLKSRC_MASK_TV),
-	SAVE_ITEM(S5P_CLKSRC_MASK_LCD0),
-	SAVE_ITEM(S5P_CLKSRC_MASK_MAUDIO),
-	SAVE_ITEM(S5P_CLKSRC_MASK_FSYS),
-	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL0),
-	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL1),
-	SAVE_ITEM(S5P_CLKDIV2_RATIO),
-	SAVE_ITEM(S5P_CLKGATE_SCLKCAM),
-	SAVE_ITEM(S5P_CLKGATE_IP_CAM),
-	SAVE_ITEM(S5P_CLKGATE_IP_TV),
-	SAVE_ITEM(S5P_CLKGATE_IP_MFC),
-	SAVE_ITEM(S5P_CLKGATE_IP_G3D),
-	SAVE_ITEM(S5P_CLKGATE_IP_LCD0),
-	SAVE_ITEM(S5P_CLKGATE_IP_FSYS),
-	SAVE_ITEM(S5P_CLKGATE_IP_GPS),
-	SAVE_ITEM(S5P_CLKGATE_IP_PERIL),
-	SAVE_ITEM(S5P_CLKGATE_BLOCK),
-	SAVE_ITEM(S5P_CLKSRC_MASK_DMC),
-	SAVE_ITEM(S5P_CLKSRC_DMC),
-	SAVE_ITEM(S5P_CLKDIV_DMC0),
-	SAVE_ITEM(S5P_CLKDIV_DMC1),
-	SAVE_ITEM(S5P_CLKGATE_IP_DMC),
-	SAVE_ITEM(S5P_CLKSRC_CPU),
-	SAVE_ITEM(S5P_CLKDIV_CPU),
-	SAVE_ITEM(S5P_CLKDIV_CPU + 0x4),
-	SAVE_ITEM(S5P_CLKGATE_SCLKCPU),
-	SAVE_ITEM(S5P_CLKGATE_IP_CPU),
+	SAVE_ITEM(EXYNOS4_CLKDIV_LEFTBUS),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_LEFTBUS),
+	SAVE_ITEM(EXYNOS4_CLKDIV_RIGHTBUS),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_RIGHTBUS),
+	SAVE_ITEM(EXYNOS4_CLKSRC_TOP0),
+	SAVE_ITEM(EXYNOS4_CLKSRC_TOP1),
+	SAVE_ITEM(EXYNOS4_CLKSRC_CAM),
+	SAVE_ITEM(EXYNOS4_CLKSRC_TV),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MFC),
+	SAVE_ITEM(EXYNOS4_CLKSRC_G3D),
+	SAVE_ITEM(EXYNOS4_CLKSRC_LCD0),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MAUDIO),
+	SAVE_ITEM(EXYNOS4_CLKSRC_FSYS),
+	SAVE_ITEM(EXYNOS4_CLKSRC_PERIL0),
+	SAVE_ITEM(EXYNOS4_CLKSRC_PERIL1),
+	SAVE_ITEM(EXYNOS4_CLKDIV_CAM),
+	SAVE_ITEM(EXYNOS4_CLKDIV_TV),
+	SAVE_ITEM(EXYNOS4_CLKDIV_MFC),
+	SAVE_ITEM(EXYNOS4_CLKDIV_G3D),
+	SAVE_ITEM(EXYNOS4_CLKDIV_LCD0),
+	SAVE_ITEM(EXYNOS4_CLKDIV_MAUDIO),
+	SAVE_ITEM(EXYNOS4_CLKDIV_FSYS0),
+	SAVE_ITEM(EXYNOS4_CLKDIV_FSYS1),
+	SAVE_ITEM(EXYNOS4_CLKDIV_FSYS2),
+	SAVE_ITEM(EXYNOS4_CLKDIV_FSYS3),
+	SAVE_ITEM(EXYNOS4_CLKDIV_PERIL0),
+	SAVE_ITEM(EXYNOS4_CLKDIV_PERIL1),
+	SAVE_ITEM(EXYNOS4_CLKDIV_PERIL2),
+	SAVE_ITEM(EXYNOS4_CLKDIV_PERIL3),
+	SAVE_ITEM(EXYNOS4_CLKDIV_PERIL4),
+	SAVE_ITEM(EXYNOS4_CLKDIV_PERIL5),
+	SAVE_ITEM(EXYNOS4_CLKDIV_TOP),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_TOP),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_CAM),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_TV),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_LCD0),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_MAUDIO),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_FSYS),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_PERIL0),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_PERIL1),
+	SAVE_ITEM(EXYNOS4_CLKDIV2_RATIO),
+	SAVE_ITEM(EXYNOS4_CLKGATE_SCLKCAM),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_CAM),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_TV),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_MFC),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_G3D),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_LCD0),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_FSYS),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_GPS),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_PERIL),
+	SAVE_ITEM(EXYNOS4_CLKGATE_BLOCK),
+	SAVE_ITEM(EXYNOS4_CLKSRC_MASK_DMC),
+	SAVE_ITEM(EXYNOS4_CLKSRC_DMC),
+	SAVE_ITEM(EXYNOS4_CLKDIV_DMC0),
+	SAVE_ITEM(EXYNOS4_CLKDIV_DMC1),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_DMC),
+	SAVE_ITEM(EXYNOS4_CLKSRC_CPU),
+	SAVE_ITEM(EXYNOS4_CLKDIV_CPU),
+	SAVE_ITEM(EXYNOS4_CLKDIV_CPU + 0x4),
+	SAVE_ITEM(EXYNOS4_CLKGATE_SCLKCPU),
+	SAVE_ITEM(EXYNOS4_CLKGATE_IP_CPU),
 };
 #endif
 
-static struct clk clk_sclk_hdmi27m = {
+static struct clk exynos4_clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
 	.rate		= 27000000,
 };
 
-static struct clk clk_sclk_hdmiphy = {
+static struct clk exynos4_clk_sclk_hdmiphy = {
 	.name		= "sclk_hdmiphy",
 };
 
-static struct clk clk_sclk_usbphy0 = {
+static struct clk exynos4_clk_sclk_usbphy0 = {
 	.name		= "sclk_usbphy0",
 	.rate		= 27000000,
 };
 
-static struct clk clk_sclk_usbphy1 = {
+static struct clk exynos4_clk_sclk_usbphy1 = {
 	.name		= "sclk_usbphy1",
 };
 
@@ -120,82 +120,82 @@ static struct clk dummy_apb_pclk = {
 
 static int exynos4_clksrc_mask_top_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKSRC_MASK_TOP, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKSRC_MASK_TOP, clk, enable);
 }
 
 static int exynos4_clksrc_mask_cam_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKSRC_MASK_CAM, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKSRC_MASK_CAM, clk, enable);
 }
 
 static int exynos4_clksrc_mask_lcd0_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKSRC_MASK_LCD0, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKSRC_MASK_LCD0, clk, enable);
 }
 
 int exynos4_clksrc_mask_fsys_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKSRC_MASK_FSYS, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKSRC_MASK_FSYS, clk, enable);
 }
 
 static int exynos4_clksrc_mask_peril0_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKSRC_MASK_PERIL0, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKSRC_MASK_PERIL0, clk, enable);
 }
 
 static int exynos4_clksrc_mask_peril1_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKSRC_MASK_PERIL1, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKSRC_MASK_PERIL1, clk, enable);
 }
 
 static int exynos4_clk_ip_mfc_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKGATE_IP_MFC, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_MFC, clk, enable);
 }
 
 static int exynos4_clksrc_mask_tv_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKSRC_MASK_TV, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKSRC_MASK_TV, clk, enable);
 }
 
 static int exynos4_clk_ip_cam_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKGATE_IP_CAM, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_CAM, clk, enable);
 }
 
 static int exynos4_clk_ip_tv_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKGATE_IP_TV, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_TV, clk, enable);
 }
 
 static int exynos4_clk_ip_image_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKGATE_IP_IMAGE, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_IMAGE, clk, enable);
 }
 
 static int exynos4_clk_ip_lcd0_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKGATE_IP_LCD0, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_LCD0, clk, enable);
 }
 
 int exynos4_clk_ip_lcd1_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKGATE_IP_LCD1, clk, enable);
+	return s5p_gatectrl(EXYNOS4210_CLKGATE_IP_LCD1, clk, enable);
 }
 
 int exynos4_clk_ip_fsys_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKGATE_IP_FSYS, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_FSYS, clk, enable);
 }
 
 static int exynos4_clk_ip_peril_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKGATE_IP_PERIL, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_PERIL, clk, enable);
 }
 
 static int exynos4_clk_ip_perir_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKGATE_IP_PERIR, clk, enable);
+	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_PERIR, clk, enable);
 }
 
 static int exynos4_clk_hdmiphy_ctrl(struct clk *clk, int enable)
@@ -210,31 +210,31 @@ static int exynos4_clk_dac_ctrl(struct clk *clk, int enable)
 
 /* Core list of CMU_CPU side */
 
-static struct clksrc_clk clk_mout_apll = {
+static struct clksrc_clk exynos4_clk_mout_apll = {
 	.clk	= {
 		.name		= "mout_apll",
 	},
 	.sources = &clk_src_apll,
-	.reg_src = { .reg = S5P_CLKSRC_CPU, .shift = 0, .size = 1 },
+	.reg_src = { .reg = EXYNOS4_CLKSRC_CPU, .shift = 0, .size = 1 },
 };
 
-static struct clksrc_clk clk_sclk_apll = {
+static struct clksrc_clk exynos4_clk_sclk_apll = {
 	.clk	= {
 		.name		= "sclk_apll",
-		.parent		= &clk_mout_apll.clk,
+		.parent		= &exynos4_clk_mout_apll.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 24, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_CPU, .shift = 24, .size = 3 },
 };
 
-static struct clksrc_clk clk_mout_epll = {
+static struct clksrc_clk exynos4_clk_mout_epll = {
 	.clk	= {
 		.name		= "mout_epll",
 	},
 	.sources = &clk_src_epll,
-	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 4, .size = 1 },
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TOP0, .shift = 4, .size = 1 },
 };
 
-struct clksrc_clk clk_mout_mpll = {
+struct clksrc_clk exynos4_clk_mout_mpll = {
 	.clk	= {
 		.name		= "mout_mpll",
 	},
@@ -243,221 +243,221 @@ struct clksrc_clk clk_mout_mpll = {
 	/* reg_src will be added in each SoCs' clock */
 };
 
-static struct clk *clkset_moutcore_list[] = {
-	[0] = &clk_mout_apll.clk,
-	[1] = &clk_mout_mpll.clk,
+static struct clk *exynos4_clkset_moutcore_list[] = {
+	[0] = &exynos4_clk_mout_apll.clk,
+	[1] = &exynos4_clk_mout_mpll.clk,
 };
 
-static struct clksrc_sources clkset_moutcore = {
-	.sources	= clkset_moutcore_list,
-	.nr_sources	= ARRAY_SIZE(clkset_moutcore_list),
+static struct clksrc_sources exynos4_clkset_moutcore = {
+	.sources	= exynos4_clkset_moutcore_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_moutcore_list),
 };
 
-static struct clksrc_clk clk_moutcore = {
+static struct clksrc_clk exynos4_clk_moutcore = {
 	.clk	= {
 		.name		= "moutcore",
 	},
-	.sources = &clkset_moutcore,
-	.reg_src = { .reg = S5P_CLKSRC_CPU, .shift = 16, .size = 1 },
+	.sources = &exynos4_clkset_moutcore,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_CPU, .shift = 16, .size = 1 },
 };
 
-static struct clksrc_clk clk_coreclk = {
+static struct clksrc_clk exynos4_clk_coreclk = {
 	.clk	= {
 		.name		= "core_clk",
-		.parent		= &clk_moutcore.clk,
+		.parent		= &exynos4_clk_moutcore.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 0, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_CPU, .shift = 0, .size = 3 },
 };
 
-static struct clksrc_clk clk_armclk = {
+static struct clksrc_clk exynos4_clk_armclk = {
 	.clk	= {
 		.name		= "armclk",
-		.parent		= &clk_coreclk.clk,
+		.parent		= &exynos4_clk_coreclk.clk,
 	},
 };
 
-static struct clksrc_clk clk_aclk_corem0 = {
+static struct clksrc_clk exynos4_clk_aclk_corem0 = {
 	.clk	= {
 		.name		= "aclk_corem0",
-		.parent		= &clk_coreclk.clk,
+		.parent		= &exynos4_clk_coreclk.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_CPU, .shift = 4, .size = 3 },
 };
 
-static struct clksrc_clk clk_aclk_cores = {
+static struct clksrc_clk exynos4_clk_aclk_cores = {
 	.clk	= {
 		.name		= "aclk_cores",
-		.parent		= &clk_coreclk.clk,
+		.parent		= &exynos4_clk_coreclk.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_CPU, .shift = 4, .size = 3 },
 };
 
-static struct clksrc_clk clk_aclk_corem1 = {
+static struct clksrc_clk exynos4_clk_aclk_corem1 = {
 	.clk	= {
 		.name		= "aclk_corem1",
-		.parent		= &clk_coreclk.clk,
+		.parent		= &exynos4_clk_coreclk.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 8, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_CPU, .shift = 8, .size = 3 },
 };
 
-static struct clksrc_clk clk_periphclk = {
+static struct clksrc_clk exynos4_clk_periphclk = {
 	.clk	= {
 		.name		= "periphclk",
-		.parent		= &clk_coreclk.clk,
+		.parent		= &exynos4_clk_coreclk.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 12, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_CPU, .shift = 12, .size = 3 },
 };
 
 /* Core list of CMU_CORE side */
 
-static struct clk *clkset_corebus_list[] = {
-	[0] = &clk_mout_mpll.clk,
-	[1] = &clk_sclk_apll.clk,
+static struct clk *exynos4_clkset_corebus_list[] = {
+	[0] = &exynos4_clk_mout_mpll.clk,
+	[1] = &exynos4_clk_sclk_apll.clk,
 };
 
-struct clksrc_sources clkset_mout_corebus = {
-	.sources	= clkset_corebus_list,
-	.nr_sources	= ARRAY_SIZE(clkset_corebus_list),
+struct clksrc_sources exynos4_clkset_mout_corebus = {
+	.sources	= exynos4_clkset_corebus_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_corebus_list),
 };
 
-static struct clksrc_clk clk_mout_corebus = {
+static struct clksrc_clk exynos4_clk_mout_corebus = {
 	.clk	= {
 		.name		= "mout_corebus",
 	},
-	.sources = &clkset_mout_corebus,
-	.reg_src = { .reg = S5P_CLKSRC_DMC, .shift = 4, .size = 1 },
+	.sources = &exynos4_clkset_mout_corebus,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_DMC, .shift = 4, .size = 1 },
 };
 
-static struct clksrc_clk clk_sclk_dmc = {
+static struct clksrc_clk exynos4_clk_sclk_dmc = {
 	.clk	= {
 		.name		= "sclk_dmc",
-		.parent		= &clk_mout_corebus.clk,
+		.parent		= &exynos4_clk_mout_corebus.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 12, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_DMC0, .shift = 12, .size = 3 },
 };
 
-static struct clksrc_clk clk_aclk_cored = {
+static struct clksrc_clk exynos4_clk_aclk_cored = {
 	.clk	= {
 		.name		= "aclk_cored",
-		.parent		= &clk_sclk_dmc.clk,
+		.parent		= &exynos4_clk_sclk_dmc.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 16, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_DMC0, .shift = 16, .size = 3 },
 };
 
-static struct clksrc_clk clk_aclk_corep = {
+static struct clksrc_clk exynos4_clk_aclk_corep = {
 	.clk	= {
 		.name		= "aclk_corep",
-		.parent		= &clk_aclk_cored.clk,
+		.parent		= &exynos4_clk_aclk_cored.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 20, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_DMC0, .shift = 20, .size = 3 },
 };
 
-static struct clksrc_clk clk_aclk_acp = {
+static struct clksrc_clk exynos4_clk_aclk_acp = {
 	.clk	= {
 		.name		= "aclk_acp",
-		.parent		= &clk_mout_corebus.clk,
+		.parent		= &exynos4_clk_mout_corebus.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 0, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_DMC0, .shift = 0, .size = 3 },
 };
 
-static struct clksrc_clk clk_pclk_acp = {
+static struct clksrc_clk exynos4_clk_pclk_acp = {
 	.clk	= {
 		.name		= "pclk_acp",
-		.parent		= &clk_aclk_acp.clk,
+		.parent		= &exynos4_clk_aclk_acp.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 4, .size = 3 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_DMC0, .shift = 4, .size = 3 },
 };
 
 /* Core list of CMU_TOP side */
 
-struct clk *clkset_aclk_top_list[] = {
-	[0] = &clk_mout_mpll.clk,
-	[1] = &clk_sclk_apll.clk,
+struct clk *exynos4_clkset_aclk_top_list[] = {
+	[0] = &exynos4_clk_mout_mpll.clk,
+	[1] = &exynos4_clk_sclk_apll.clk,
 };
 
-static struct clksrc_sources clkset_aclk = {
-	.sources	= clkset_aclk_top_list,
-	.nr_sources	= ARRAY_SIZE(clkset_aclk_top_list),
+static struct clksrc_sources exynos4_clkset_aclk = {
+	.sources	= exynos4_clkset_aclk_top_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_aclk_top_list),
 };
 
-static struct clksrc_clk clk_aclk_200 = {
+static struct clksrc_clk exynos4_clk_aclk_200 = {
 	.clk	= {
 		.name		= "aclk_200",
 	},
-	.sources = &clkset_aclk,
-	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 12, .size = 1 },
-	.reg_div = { .reg = S5P_CLKDIV_TOP, .shift = 0, .size = 3 },
+	.sources = &exynos4_clkset_aclk,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TOP0, .shift = 12, .size = 1 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_TOP, .shift = 0, .size = 3 },
 };
 
-static struct clksrc_clk clk_aclk_100 = {
+static struct clksrc_clk exynos4_clk_aclk_100 = {
 	.clk	= {
 		.name		= "aclk_100",
 	},
-	.sources = &clkset_aclk,
-	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 16, .size = 1 },
-	.reg_div = { .reg = S5P_CLKDIV_TOP, .shift = 4, .size = 4 },
+	.sources = &exynos4_clkset_aclk,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TOP0, .shift = 16, .size = 1 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_TOP, .shift = 4, .size = 4 },
 };
 
-static struct clksrc_clk clk_aclk_160 = {
+static struct clksrc_clk exynos4_clk_aclk_160 = {
 	.clk	= {
 		.name		= "aclk_160",
 	},
-	.sources = &clkset_aclk,
-	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 20, .size = 1 },
-	.reg_div = { .reg = S5P_CLKDIV_TOP, .shift = 8, .size = 3 },
+	.sources = &exynos4_clkset_aclk,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TOP0, .shift = 20, .size = 1 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_TOP, .shift = 8, .size = 3 },
 };
 
-struct clksrc_clk clk_aclk_133 = {
+struct clksrc_clk exynos4_clk_aclk_133 = {
 	.clk	= {
 		.name		= "aclk_133",
 	},
-	.sources = &clkset_aclk,
-	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 24, .size = 1 },
-	.reg_div = { .reg = S5P_CLKDIV_TOP, .shift = 12, .size = 3 },
+	.sources = &exynos4_clkset_aclk,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TOP0, .shift = 24, .size = 1 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_TOP, .shift = 12, .size = 3 },
 };
 
-static struct clk *clkset_vpllsrc_list[] = {
+static struct clk *exynos4_clkset_vpllsrc_list[] = {
 	[0] = &clk_fin_vpll,
-	[1] = &clk_sclk_hdmi27m,
+	[1] = &exynos4_clk_sclk_hdmi27m,
 };
 
-static struct clksrc_sources clkset_vpllsrc = {
-	.sources	= clkset_vpllsrc_list,
-	.nr_sources	= ARRAY_SIZE(clkset_vpllsrc_list),
+static struct clksrc_sources exynos4_clkset_vpllsrc = {
+	.sources	= exynos4_clkset_vpllsrc_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_vpllsrc_list),
 };
 
-static struct clksrc_clk clk_vpllsrc = {
+static struct clksrc_clk exynos4_clk_vpllsrc = {
 	.clk	= {
 		.name		= "vpll_src",
 		.enable		= exynos4_clksrc_mask_top_ctrl,
 		.ctrlbit	= (1 << 0),
 	},
-	.sources = &clkset_vpllsrc,
-	.reg_src = { .reg = S5P_CLKSRC_TOP1, .shift = 0, .size = 1 },
+	.sources = &exynos4_clkset_vpllsrc,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TOP1, .shift = 0, .size = 1 },
 };
 
-static struct clk *clkset_sclk_vpll_list[] = {
-	[0] = &clk_vpllsrc.clk,
+static struct clk *exynos4_clkset_sclk_vpll_list[] = {
+	[0] = &exynos4_clk_vpllsrc.clk,
 	[1] = &clk_fout_vpll,
 };
 
-static struct clksrc_sources clkset_sclk_vpll = {
-	.sources	= clkset_sclk_vpll_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_vpll_list),
+static struct clksrc_sources exynos4_clkset_sclk_vpll = {
+	.sources	= exynos4_clkset_sclk_vpll_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_sclk_vpll_list),
 };
 
-static struct clksrc_clk clk_sclk_vpll = {
+static struct clksrc_clk exynos4_clk_sclk_vpll = {
 	.clk	= {
 		.name		= "sclk_vpll",
 	},
-	.sources = &clkset_sclk_vpll,
-	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 8, .size = 1 },
+	.sources = &exynos4_clkset_sclk_vpll,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TOP0, .shift = 8, .size = 1 },
 };
 
-static struct clk init_clocks_off[] = {
+static struct clk exynos4_init_clocks_off[] = {
 	{
 		.name		= "timers",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1<<24),
 	}, {
@@ -498,30 +498,30 @@ static struct clk init_clocks_off[] = {
 	}, {
 		.name		= "hsmmc",
 		.devname	= "s3c-sdhci.0",
-		.parent		= &clk_aclk_133.clk,
+		.parent		= &exynos4_clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "hsmmc",
 		.devname	= "s3c-sdhci.1",
-		.parent		= &clk_aclk_133.clk,
+		.parent		= &exynos4_clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "hsmmc",
 		.devname	= "s3c-sdhci.2",
-		.parent		= &clk_aclk_133.clk,
+		.parent		= &exynos4_clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "hsmmc",
 		.devname	= "s3c-sdhci.3",
-		.parent		= &clk_aclk_133.clk,
+		.parent		= &exynos4_clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "dwmmc",
-		.parent		= &clk_aclk_133.clk,
+		.parent		= &exynos4_clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
@@ -568,7 +568,7 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 15),
 	}, {
 		.name		= "watchdog",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_perir_ctrl,
 		.ctrlbit	= (1 << 14),
 	}, {
@@ -626,55 +626,55 @@ static struct clk init_clocks_off[] = {
 	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-i2c.0",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-i2c.1",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-i2c.2",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-i2c.3",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-i2c.4",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-i2c.5",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 11),
 	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-i2c.6",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-i2c.7",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 13),
 	}, {
 		.name		= "i2c",
 		.devname	= "s3c2440-hdmiphy-i2c",
-		.parent		= &clk_aclk_100.clk,
+		.parent		= &exynos4_clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 14),
 	}, {
@@ -736,7 +736,7 @@ static struct clk init_clocks_off[] = {
 	}
 };
 
-static struct clk init_clocks[] = {
+static struct clk exynos4_init_clocks_on[] = {
 	{
 		.name		= "uart",
 		.devname	= "s5pv210-uart.0",
@@ -770,259 +770,259 @@ static struct clk init_clocks[] = {
 	}
 };
 
-static struct clk clk_pdma0 = {
+static struct clk exynos4_clk_pdma0 = {
 	.name		= "dma",
 	.devname	= "dma-pl330.0",
 	.enable		= exynos4_clk_ip_fsys_ctrl,
 	.ctrlbit	= (1 << 0),
 };
 
-static struct clk clk_pdma1 = {
+static struct clk exynos4_clk_pdma1 = {
 	.name		= "dma",
 	.devname	= "dma-pl330.1",
 	.enable		= exynos4_clk_ip_fsys_ctrl,
 	.ctrlbit	= (1 << 1),
 };
 
-struct clk *clkset_group_list[] = {
+struct clk *exynos4_clkset_group_list[] = {
 	[0] = &clk_ext_xtal_mux,
 	[1] = &clk_xusbxti,
-	[2] = &clk_sclk_hdmi27m,
-	[3] = &clk_sclk_usbphy0,
-	[4] = &clk_sclk_usbphy1,
-	[5] = &clk_sclk_hdmiphy,
-	[6] = &clk_mout_mpll.clk,
-	[7] = &clk_mout_epll.clk,
-	[8] = &clk_sclk_vpll.clk,
+	[2] = &exynos4_clk_sclk_hdmi27m,
+	[3] = &exynos4_clk_sclk_usbphy0,
+	[4] = &exynos4_clk_sclk_usbphy1,
+	[5] = &exynos4_clk_sclk_hdmiphy,
+	[6] = &exynos4_clk_mout_mpll.clk,
+	[7] = &exynos4_clk_mout_epll.clk,
+	[8] = &exynos4_clk_sclk_vpll.clk,
 };
 
-struct clksrc_sources clkset_group = {
-	.sources	= clkset_group_list,
-	.nr_sources	= ARRAY_SIZE(clkset_group_list),
+struct clksrc_sources exynos4_clkset_group = {
+	.sources	= exynos4_clkset_group_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_group_list),
 };
 
-static struct clk *clkset_mout_g2d0_list[] = {
-	[0] = &clk_mout_mpll.clk,
-	[1] = &clk_sclk_apll.clk,
+static struct clk *exynos4_clkset_mout_g2d0_list[] = {
+	[0] = &exynos4_clk_mout_mpll.clk,
+	[1] = &exynos4_clk_sclk_apll.clk,
 };
 
-static struct clksrc_sources clkset_mout_g2d0 = {
-	.sources	= clkset_mout_g2d0_list,
-	.nr_sources	= ARRAY_SIZE(clkset_mout_g2d0_list),
+static struct clksrc_sources exynos4_clkset_mout_g2d0 = {
+	.sources	= exynos4_clkset_mout_g2d0_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_mout_g2d0_list),
 };
 
-static struct clksrc_clk clk_mout_g2d0 = {
+static struct clksrc_clk exynos4_clk_mout_g2d0 = {
 	.clk	= {
 		.name		= "mout_g2d0",
 	},
-	.sources = &clkset_mout_g2d0,
-	.reg_src = { .reg = S5P_CLKSRC_IMAGE, .shift = 0, .size = 1 },
+	.sources = &exynos4_clkset_mout_g2d0,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_IMAGE, .shift = 0, .size = 1 },
 };
 
-static struct clk *clkset_mout_g2d1_list[] = {
-	[0] = &clk_mout_epll.clk,
-	[1] = &clk_sclk_vpll.clk,
+static struct clk *exynos4_clkset_mout_g2d1_list[] = {
+	[0] = &exynos4_clk_mout_epll.clk,
+	[1] = &exynos4_clk_sclk_vpll.clk,
 };
 
-static struct clksrc_sources clkset_mout_g2d1 = {
-	.sources	= clkset_mout_g2d1_list,
-	.nr_sources	= ARRAY_SIZE(clkset_mout_g2d1_list),
+static struct clksrc_sources exynos4_clkset_mout_g2d1 = {
+	.sources	= exynos4_clkset_mout_g2d1_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_mout_g2d1_list),
 };
 
-static struct clksrc_clk clk_mout_g2d1 = {
+static struct clksrc_clk exynos4_clk_mout_g2d1 = {
 	.clk	= {
 		.name		= "mout_g2d1",
 	},
-	.sources = &clkset_mout_g2d1,
-	.reg_src = { .reg = S5P_CLKSRC_IMAGE, .shift = 4, .size = 1 },
+	.sources = &exynos4_clkset_mout_g2d1,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_IMAGE, .shift = 4, .size = 1 },
 };
 
-static struct clk *clkset_mout_g2d_list[] = {
-	[0] = &clk_mout_g2d0.clk,
-	[1] = &clk_mout_g2d1.clk,
+static struct clk *exynos4_clkset_mout_g2d_list[] = {
+	[0] = &exynos4_clk_mout_g2d0.clk,
+	[1] = &exynos4_clk_mout_g2d1.clk,
 };
 
-static struct clksrc_sources clkset_mout_g2d = {
-	.sources	= clkset_mout_g2d_list,
-	.nr_sources	= ARRAY_SIZE(clkset_mout_g2d_list),
+static struct clksrc_sources exynos4_clkset_mout_g2d = {
+	.sources	= exynos4_clkset_mout_g2d_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_mout_g2d_list),
 };
 
-static struct clk *clkset_mout_mfc0_list[] = {
-	[0] = &clk_mout_mpll.clk,
-	[1] = &clk_sclk_apll.clk,
+static struct clk *exynos4_clkset_mout_mfc0_list[] = {
+	[0] = &exynos4_clk_mout_mpll.clk,
+	[1] = &exynos4_clk_sclk_apll.clk,
 };
 
-static struct clksrc_sources clkset_mout_mfc0 = {
-	.sources	= clkset_mout_mfc0_list,
-	.nr_sources	= ARRAY_SIZE(clkset_mout_mfc0_list),
+static struct clksrc_sources exynos4_clkset_mout_mfc0 = {
+	.sources	= exynos4_clkset_mout_mfc0_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_mout_mfc0_list),
 };
 
-static struct clksrc_clk clk_mout_mfc0 = {
+static struct clksrc_clk exynos4_clk_mout_mfc0 = {
 	.clk	= {
 		.name		= "mout_mfc0",
 	},
-	.sources = &clkset_mout_mfc0,
-	.reg_src = { .reg = S5P_CLKSRC_MFC, .shift = 0, .size = 1 },
+	.sources = &exynos4_clkset_mout_mfc0,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_MFC, .shift = 0, .size = 1 },
 };
 
-static struct clk *clkset_mout_mfc1_list[] = {
-	[0] = &clk_mout_epll.clk,
-	[1] = &clk_sclk_vpll.clk,
+static struct clk *exynos4_clkset_mout_mfc1_list[] = {
+	[0] = &exynos4_clk_mout_epll.clk,
+	[1] = &exynos4_clk_sclk_vpll.clk,
 };
 
-static struct clksrc_sources clkset_mout_mfc1 = {
-	.sources	= clkset_mout_mfc1_list,
-	.nr_sources	= ARRAY_SIZE(clkset_mout_mfc1_list),
+static struct clksrc_sources exynos4_clkset_mout_mfc1 = {
+	.sources	= exynos4_clkset_mout_mfc1_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_mout_mfc1_list),
 };
 
-static struct clksrc_clk clk_mout_mfc1 = {
+static struct clksrc_clk exynos4_clk_mout_mfc1 = {
 	.clk	= {
 		.name		= "mout_mfc1",
 	},
-	.sources = &clkset_mout_mfc1,
-	.reg_src = { .reg = S5P_CLKSRC_MFC, .shift = 4, .size = 1 },
+	.sources = &exynos4_clkset_mout_mfc1,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_MFC, .shift = 4, .size = 1 },
 };
 
-static struct clk *clkset_mout_mfc_list[] = {
-	[0] = &clk_mout_mfc0.clk,
-	[1] = &clk_mout_mfc1.clk,
+static struct clk *exynos4_clkset_mout_mfc_list[] = {
+	[0] = &exynos4_clk_mout_mfc0.clk,
+	[1] = &exynos4_clk_mout_mfc1.clk,
 };
 
-static struct clksrc_sources clkset_mout_mfc = {
-	.sources	= clkset_mout_mfc_list,
-	.nr_sources	= ARRAY_SIZE(clkset_mout_mfc_list),
+static struct clksrc_sources exynos4_clkset_mout_mfc = {
+	.sources	= exynos4_clkset_mout_mfc_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_mout_mfc_list),
 };
 
-static struct clk *clkset_sclk_dac_list[] = {
-	[0] = &clk_sclk_vpll.clk,
-	[1] = &clk_sclk_hdmiphy,
+static struct clk *exynos4_clkset_sclk_dac_list[] = {
+	[0] = &exynos4_clk_sclk_vpll.clk,
+	[1] = &exynos4_clk_sclk_hdmiphy,
 };
 
-static struct clksrc_sources clkset_sclk_dac = {
-	.sources	= clkset_sclk_dac_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_dac_list),
+static struct clksrc_sources exynos4_clkset_sclk_dac = {
+	.sources	= exynos4_clkset_sclk_dac_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_sclk_dac_list),
 };
 
-static struct clksrc_clk clk_sclk_dac = {
+static struct clksrc_clk exynos4_clk_sclk_dac = {
 	.clk		= {
 		.name		= "sclk_dac",
 		.enable		= exynos4_clksrc_mask_tv_ctrl,
 		.ctrlbit	= (1 << 8),
 	},
-	.sources = &clkset_sclk_dac,
-	.reg_src = { .reg = S5P_CLKSRC_TV, .shift = 8, .size = 1 },
+	.sources = &exynos4_clkset_sclk_dac,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TV, .shift = 8, .size = 1 },
 };
 
-static struct clksrc_clk clk_sclk_pixel = {
+static struct clksrc_clk exynos4_clk_sclk_pixel = {
 	.clk		= {
 		.name		= "sclk_pixel",
-		.parent		= &clk_sclk_vpll.clk,
+		.parent		= &exynos4_clk_sclk_vpll.clk,
 	},
-	.reg_div = { .reg = S5P_CLKDIV_TV, .shift = 0, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_TV, .shift = 0, .size = 4 },
 };
 
-static struct clk *clkset_sclk_hdmi_list[] = {
-	[0] = &clk_sclk_pixel.clk,
-	[1] = &clk_sclk_hdmiphy,
+static struct clk *exynos4_clkset_sclk_hdmi_list[] = {
+	[0] = &exynos4_clk_sclk_pixel.clk,
+	[1] = &exynos4_clk_sclk_hdmiphy,
 };
 
-static struct clksrc_sources clkset_sclk_hdmi = {
-	.sources	= clkset_sclk_hdmi_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_hdmi_list),
+static struct clksrc_sources exynos4_clkset_sclk_hdmi = {
+	.sources	= exynos4_clkset_sclk_hdmi_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_sclk_hdmi_list),
 };
 
-static struct clksrc_clk clk_sclk_hdmi = {
+static struct clksrc_clk exynos4_clk_sclk_hdmi = {
 	.clk		= {
 		.name		= "sclk_hdmi",
 		.enable		= exynos4_clksrc_mask_tv_ctrl,
 		.ctrlbit	= (1 << 0),
 	},
-	.sources = &clkset_sclk_hdmi,
-	.reg_src = { .reg = S5P_CLKSRC_TV, .shift = 0, .size = 1 },
+	.sources = &exynos4_clkset_sclk_hdmi,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TV, .shift = 0, .size = 1 },
 };
 
-static struct clk *clkset_sclk_mixer_list[] = {
-	[0] = &clk_sclk_dac.clk,
-	[1] = &clk_sclk_hdmi.clk,
+static struct clk *exynos4_clkset_sclk_mixer_list[] = {
+	[0] = &exynos4_clk_sclk_dac.clk,
+	[1] = &exynos4_clk_sclk_hdmi.clk,
 };
 
-static struct clksrc_sources clkset_sclk_mixer = {
-	.sources	= clkset_sclk_mixer_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_mixer_list),
+static struct clksrc_sources exynos4_clkset_sclk_mixer = {
+	.sources	= exynos4_clkset_sclk_mixer_list,
+	.nr_sources	= ARRAY_SIZE(exynos4_clkset_sclk_mixer_list),
 };
 
-static struct clksrc_clk clk_sclk_mixer = {
+static struct clksrc_clk exynos4_clk_sclk_mixer = {
 	.clk	= {
 		.name		= "sclk_mixer",
 		.enable		= exynos4_clksrc_mask_tv_ctrl,
 		.ctrlbit	= (1 << 4),
 	},
-	.sources = &clkset_sclk_mixer,
-	.reg_src = { .reg = S5P_CLKSRC_TV, .shift = 4, .size = 1 },
+	.sources = &exynos4_clkset_sclk_mixer,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_TV, .shift = 4, .size = 1 },
 };
 
-static struct clksrc_clk *sclk_tv[] = {
-	&clk_sclk_dac,
-	&clk_sclk_pixel,
-	&clk_sclk_hdmi,
-	&clk_sclk_mixer,
+static struct clksrc_clk *exynos4_sclk_tv[] = {
+	&exynos4_clk_sclk_dac,
+	&exynos4_clk_sclk_pixel,
+	&exynos4_clk_sclk_hdmi,
+	&exynos4_clk_sclk_mixer,
 };
 
-static struct clksrc_clk clk_dout_mmc0 = {
+static struct clksrc_clk exynos4_clk_dout_mmc0 = {
 	.clk	= {
 		.name		= "dout_mmc0",
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 0, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 0, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_FSYS, .shift = 0, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS1, .shift = 0, .size = 4 },
 };
 
-static struct clksrc_clk clk_dout_mmc1 = {
+static struct clksrc_clk exynos4_clk_dout_mmc1 = {
 	.clk	= {
 		.name		= "dout_mmc1",
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 4, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 16, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_FSYS, .shift = 4, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS1, .shift = 16, .size = 4 },
 };
 
-static struct clksrc_clk clk_dout_mmc2 = {
+static struct clksrc_clk exynos4_clk_dout_mmc2 = {
 	.clk	= {
 		.name		= "dout_mmc2",
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 8, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 0, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_FSYS, .shift = 8, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS2, .shift = 0, .size = 4 },
 };
 
-static struct clksrc_clk clk_dout_mmc3 = {
+static struct clksrc_clk exynos4_clk_dout_mmc3 = {
 	.clk	= {
 		.name		= "dout_mmc3",
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 12, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 16, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_FSYS, .shift = 12, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS2, .shift = 16, .size = 4 },
 };
 
-static struct clksrc_clk clk_dout_mmc4 = {
+static struct clksrc_clk exynos4_clk_dout_mmc4 = {
 	.clk		= {
 		.name		= "dout_mmc4",
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 16, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_FSYS3, .shift = 0, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_FSYS, .shift = 16, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS3, .shift = 0, .size = 4 },
 };
 
-static struct clksrc_clk clksrcs[] = {
+static struct clksrc_clk exynos4_clksrcs[] = {
 	{
 		.clk	= {
 			.name		= "sclk_pwm",
 			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 24, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_PERIL3, .shift = 0, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL0, .shift = 24, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL3, .shift = 0, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_csis",
@@ -1030,9 +1030,9 @@ static struct clksrc_clk clksrcs[] = {
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 24, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 24, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_CAM, .shift = 24, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_CAM, .shift = 24, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_csis",
@@ -1040,27 +1040,27 @@ static struct clksrc_clk clksrcs[] = {
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 28),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 28, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 28, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_CAM, .shift = 28, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_CAM, .shift = 28, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_cam0",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 16),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 16, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 16, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_CAM, .shift = 16, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_CAM, .shift = 16, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_cam1",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 20),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 20, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 20, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_CAM, .shift = 20, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_CAM, .shift = 20, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_fimc",
@@ -1068,9 +1068,9 @@ static struct clksrc_clk clksrcs[] = {
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 0, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 0, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_CAM, .shift = 0, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_CAM, .shift = 0, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_fimc",
@@ -1078,9 +1078,9 @@ static struct clksrc_clk clksrcs[] = {
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 4),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 4, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 4, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_CAM, .shift = 4, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_CAM, .shift = 4, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_fimc",
@@ -1088,9 +1088,9 @@ static struct clksrc_clk clksrcs[] = {
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 8),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 8, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 8, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_CAM, .shift = 8, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_CAM, .shift = 8, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_fimc",
@@ -1098,9 +1098,9 @@ static struct clksrc_clk clksrcs[] = {
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 12),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 12, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 12, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_CAM, .shift = 12, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_CAM, .shift = 12, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_fimd",
@@ -1108,231 +1108,231 @@ static struct clksrc_clk clksrcs[] = {
 			.enable		= exynos4_clksrc_mask_lcd0_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_LCD0, .shift = 0, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_LCD0, .shift = 0, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_LCD0, .shift = 0, .size = 4 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_LCD0, .shift = 0, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_fimg2d",
 		},
-		.sources = &clkset_mout_g2d,
-		.reg_src = { .reg = S5P_CLKSRC_IMAGE, .shift = 8, .size = 1 },
-		.reg_div = { .reg = S5P_CLKDIV_IMAGE, .shift = 0, .size = 4 },
+		.sources = &exynos4_clkset_mout_g2d,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_IMAGE, .shift = 8, .size = 1 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_IMAGE, .shift = 0, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_mfc",
 			.devname	= "s5p-mfc",
 		},
-		.sources = &clkset_mout_mfc,
-		.reg_src = { .reg = S5P_CLKSRC_MFC, .shift = 8, .size = 1 },
-		.reg_div = { .reg = S5P_CLKDIV_MFC, .shift = 0, .size = 4 },
+		.sources = &exynos4_clkset_mout_mfc,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_MFC, .shift = 8, .size = 1 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_MFC, .shift = 0, .size = 4 },
 	}, {
 		.clk	= {
 			.name		= "sclk_dwmmc",
-			.parent		= &clk_dout_mmc4.clk,
+			.parent		= &exynos4_clk_dout_mmc4.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 16),
 		},
-		.reg_div = { .reg = S5P_CLKDIV_FSYS3, .shift = 8, .size = 8 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS3, .shift = 8, .size = 8 },
 	}
 };
 
-static struct clksrc_clk clk_sclk_uart0 = {
+static struct clksrc_clk exynos4_clk_sclk_uart0 = {
 	.clk	= {
 		.name		= "uclk1",
 		.devname	= "exynos4210-uart.0",
 		.enable		= exynos4_clksrc_mask_peril0_ctrl,
 		.ctrlbit	= (1 << 0),
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 0, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 0, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL0, .shift = 0, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL0, .shift = 0, .size = 4 },
 };
 
-static struct clksrc_clk clk_sclk_uart1 = {
+static struct clksrc_clk exynos4_clk_sclk_uart1 = {
 	.clk	= {
 		.name		= "uclk1",
 		.devname	= "exynos4210-uart.1",
 		.enable		= exynos4_clksrc_mask_peril0_ctrl,
 		.ctrlbit	= (1 << 4),
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 4, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 4, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL0, .shift = 4, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL0, .shift = 4, .size = 4 },
 };
 
-static struct clksrc_clk clk_sclk_uart2 = {
+static struct clksrc_clk exynos4_clk_sclk_uart2 = {
 	.clk	= {
 		.name		= "uclk1",
 		.devname	= "exynos4210-uart.2",
 		.enable		= exynos4_clksrc_mask_peril0_ctrl,
 		.ctrlbit	= (1 << 8),
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 8, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 8, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL0, .shift = 8, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL0, .shift = 8, .size = 4 },
 };
 
-static struct clksrc_clk clk_sclk_uart3 = {
+static struct clksrc_clk exynos4_clk_sclk_uart3 = {
 	.clk	= {
 		.name		= "uclk1",
 		.devname	= "exynos4210-uart.3",
 		.enable		= exynos4_clksrc_mask_peril0_ctrl,
 		.ctrlbit	= (1 << 12),
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 12, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 12, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL0, .shift = 12, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL0, .shift = 12, .size = 4 },
 };
 
-static struct clksrc_clk clk_sclk_mmc0 = {
+static struct clksrc_clk exynos4_clk_sclk_mmc0 = {
 	.clk	= {
 		.name		= "sclk_mmc",
 		.devname	= "s3c-sdhci.0",
-		.parent		= &clk_dout_mmc0.clk,
+		.parent		= &exynos4_clk_dout_mmc0.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 0),
 	},
-	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 8, .size = 8 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS1, .shift = 8, .size = 8 },
 };
 
-static struct clksrc_clk clk_sclk_mmc1 = {
+static struct clksrc_clk exynos4_clk_sclk_mmc1 = {
 	.clk	= {
 		.name		= "sclk_mmc",
 		.devname	= "s3c-sdhci.1",
-		.parent		= &clk_dout_mmc1.clk,
+		.parent		= &exynos4_clk_dout_mmc1.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 4),
 	},
-	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 24, .size = 8 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS1, .shift = 24, .size = 8 },
 };
 
-static struct clksrc_clk clk_sclk_mmc2 = {
+static struct clksrc_clk exynos4_clk_sclk_mmc2 = {
 	.clk	= {
 		.name		= "sclk_mmc",
 		.devname	= "s3c-sdhci.2",
-		.parent		= &clk_dout_mmc2.clk,
+		.parent		= &exynos4_clk_dout_mmc2.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 8),
 	},
-	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 8, .size = 8 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS2, .shift = 8, .size = 8 },
 };
 
-static struct clksrc_clk clk_sclk_mmc3 = {
+static struct clksrc_clk exynos4_clk_sclk_mmc3 = {
 	.clk	= {
 		.name		= "sclk_mmc",
 		.devname	= "s3c-sdhci.3",
-		.parent		= &clk_dout_mmc3.clk,
+		.parent		= &exynos4_clk_dout_mmc3.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 12),
 	},
-	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS2, .shift = 24, .size = 8 },
 };
 
-static struct clksrc_clk clk_sclk_spi0 = {
+static struct clksrc_clk exynos4_clk_sclk_spi0 = {
 	.clk	= {
 		.name		= "sclk_spi",
 		.devname	= "s3c64xx-spi.0",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 16),
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 16, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 0, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL1, .shift = 16, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL1, .shift = 0, .size = 4 },
 };
 
-static struct clksrc_clk clk_sclk_spi1 = {
+static struct clksrc_clk exynos4_clk_sclk_spi1 = {
 	.clk	= {
 		.name		= "sclk_spi",
 		.devname	= "s3c64xx-spi.1",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 20),
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 20, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 16, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL1, .shift = 20, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL1, .shift = 16, .size = 4 },
 };
 
-static struct clksrc_clk clk_sclk_spi2 = {
+static struct clksrc_clk exynos4_clk_sclk_spi2 = {
 	.clk	= {
 		.name		= "sclk_spi",
 		.devname	= "s3c64xx-spi.2",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 24),
 	},
-	.sources = &clkset_group,
-	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 24, .size = 4 },
-	.reg_div = { .reg = S5P_CLKDIV_PERIL2, .shift = 0, .size = 4 },
+	.sources = &exynos4_clkset_group,
+	.reg_src = { .reg = EXYNOS4_CLKSRC_PERIL1, .shift = 24, .size = 4 },
+	.reg_div = { .reg = EXYNOS4_CLKDIV_PERIL2, .shift = 0, .size = 4 },
 };
 
 /* Clock initialization code */
-static struct clksrc_clk *sysclks[] = {
-	&clk_mout_apll,
-	&clk_sclk_apll,
-	&clk_mout_epll,
-	&clk_mout_mpll,
-	&clk_moutcore,
-	&clk_coreclk,
-	&clk_armclk,
-	&clk_aclk_corem0,
-	&clk_aclk_cores,
-	&clk_aclk_corem1,
-	&clk_periphclk,
-	&clk_mout_corebus,
-	&clk_sclk_dmc,
-	&clk_aclk_cored,
-	&clk_aclk_corep,
-	&clk_aclk_acp,
-	&clk_pclk_acp,
-	&clk_vpllsrc,
-	&clk_sclk_vpll,
-	&clk_aclk_200,
-	&clk_aclk_100,
-	&clk_aclk_160,
-	&clk_aclk_133,
-	&clk_dout_mmc0,
-	&clk_dout_mmc1,
-	&clk_dout_mmc2,
-	&clk_dout_mmc3,
-	&clk_dout_mmc4,
-	&clk_mout_mfc0,
-	&clk_mout_mfc1,
-};
-
-static struct clk *clk_cdev[] = {
-	&clk_pdma0,
-	&clk_pdma1,
-};
-
-static struct clksrc_clk *clksrc_cdev[] = {
-	&clk_sclk_uart0,
-	&clk_sclk_uart1,
-	&clk_sclk_uart2,
-	&clk_sclk_uart3,
-	&clk_sclk_mmc0,
-	&clk_sclk_mmc1,
-	&clk_sclk_mmc2,
-	&clk_sclk_mmc3,
-	&clk_sclk_spi0,
-	&clk_sclk_spi1,
-	&clk_sclk_spi2,
+static struct clksrc_clk *exynos4_sysclks[] = {
+	&exynos4_clk_mout_apll,
+	&exynos4_clk_sclk_apll,
+	&exynos4_clk_mout_epll,
+	&exynos4_clk_mout_mpll,
+	&exynos4_clk_moutcore,
+	&exynos4_clk_coreclk,
+	&exynos4_clk_armclk,
+	&exynos4_clk_aclk_corem0,
+	&exynos4_clk_aclk_cores,
+	&exynos4_clk_aclk_corem1,
+	&exynos4_clk_periphclk,
+	&exynos4_clk_mout_corebus,
+	&exynos4_clk_sclk_dmc,
+	&exynos4_clk_aclk_cored,
+	&exynos4_clk_aclk_corep,
+	&exynos4_clk_aclk_acp,
+	&exynos4_clk_pclk_acp,
+	&exynos4_clk_vpllsrc,
+	&exynos4_clk_sclk_vpll,
+	&exynos4_clk_aclk_200,
+	&exynos4_clk_aclk_100,
+	&exynos4_clk_aclk_160,
+	&exynos4_clk_aclk_133,
+	&exynos4_clk_dout_mmc0,
+	&exynos4_clk_dout_mmc1,
+	&exynos4_clk_dout_mmc2,
+	&exynos4_clk_dout_mmc3,
+	&exynos4_clk_dout_mmc4,
+	&exynos4_clk_mout_mfc0,
+	&exynos4_clk_mout_mfc1,
+};
+
+static struct clk *exynos4_clk_cdev[] = {
+	&exynos4_clk_pdma0,
+	&exynos4_clk_pdma1,
+};
+
+static struct clksrc_clk *exynos4_clksrc_cdev[] = {
+	&exynos4_clk_sclk_uart0,
+	&exynos4_clk_sclk_uart1,
+	&exynos4_clk_sclk_uart2,
+	&exynos4_clk_sclk_uart3,
+	&exynos4_clk_sclk_mmc0,
+	&exynos4_clk_sclk_mmc1,
+	&exynos4_clk_sclk_mmc2,
+	&exynos4_clk_sclk_mmc3,
+	&exynos4_clk_sclk_spi0,
+	&exynos4_clk_sclk_spi1,
+	&exynos4_clk_sclk_spi2,
 
 };
 
 static struct clk_lookup exynos4_clk_lookup[] = {
-	CLKDEV_INIT("exynos4210-uart.0", "clk_uart_baud0", &clk_sclk_uart0.clk),
-	CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0", &clk_sclk_uart1.clk),
-	CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0", &clk_sclk_uart2.clk),
-	CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0", &clk_sclk_uart3.clk),
-	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
-	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
-	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
-	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
-	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &clk_pdma0),
-	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &clk_pdma1),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &clk_sclk_spi0.clk),
-	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0", &clk_sclk_spi1.clk),
-	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0", &clk_sclk_spi2.clk),
+	CLKDEV_INIT("exynos4210-uart.0", "clk_uart_baud0", &exynos4_clk_sclk_uart0.clk),
+	CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0", &exynos4_clk_sclk_uart1.clk),
+	CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0", &exynos4_clk_sclk_uart2.clk),
+	CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0", &exynos4_clk_sclk_uart3.clk),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &exynos4_clk_sclk_mmc0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &exynos4_clk_sclk_mmc1.clk),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &exynos4_clk_sclk_mmc2.clk),
+	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &exynos4_clk_sclk_mmc3.clk),
+	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos4_clk_pdma0),
+	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos4_clk_pdma1),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &exynos4_clk_sclk_spi0.clk),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0", &exynos4_clk_sclk_spi1.clk),
+	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0", &exynos4_clk_sclk_spi2.clk),
 };
 
 static int xtal_rate;
@@ -1340,10 +1340,10 @@ static int xtal_rate;
 static unsigned long exynos4_fout_apll_get_rate(struct clk *clk)
 {
 	if (soc_is_exynos4210())
-		return s5p_get_pll45xx(xtal_rate, __raw_readl(S5P_APLL_CON0),
+		return s5p_get_pll45xx(xtal_rate, __raw_readl(EXYNOS4_APLL_CON0),
 					pll_4508);
 	else if (soc_is_exynos4212() || soc_is_exynos4412())
-		return s5p_get_pll35xx(xtal_rate, __raw_readl(S5P_APLL_CON0));
+		return s5p_get_pll35xx(xtal_rate, __raw_readl(EXYNOS4_APLL_CON0));
 	else
 		return 0;
 }
@@ -1352,7 +1352,7 @@ static struct clk_ops exynos4_fout_apll_ops = {
 	.get_rate = exynos4_fout_apll_get_rate,
 };
 
-static u32 vpll_div[][8] = {
+static u32 exynos4_vpll_div[][8] = {
 	{  54000000, 3, 53, 3, 1024, 0, 17, 0 },
 	{ 108000000, 3, 53, 2, 1024, 0, 17, 0 },
 };
@@ -1371,41 +1371,41 @@ static int exynos4_vpll_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->rate == rate)
 		return 0;
 
-	vpll_con0 = __raw_readl(S5P_VPLL_CON0);
+	vpll_con0 = __raw_readl(EXYNOS4_VPLL_CON0);
 	vpll_con0 &= ~(0x1 << 27 |					\
 			PLL90XX_MDIV_MASK << PLL46XX_MDIV_SHIFT |	\
 			PLL90XX_PDIV_MASK << PLL46XX_PDIV_SHIFT |	\
 			PLL90XX_SDIV_MASK << PLL46XX_SDIV_SHIFT);
 
-	vpll_con1 = __raw_readl(S5P_VPLL_CON1);
+	vpll_con1 = __raw_readl(EXYNOS4_VPLL_CON1);
 	vpll_con1 &= ~(PLL46XX_MRR_MASK << PLL46XX_MRR_SHIFT |	\
 			PLL46XX_MFR_MASK << PLL46XX_MFR_SHIFT |	\
 			PLL4650C_KDIV_MASK << PLL46XX_KDIV_SHIFT);
 
-	for (i = 0; i < ARRAY_SIZE(vpll_div); i++) {
-		if (vpll_div[i][0] == rate) {
-			vpll_con0 |= vpll_div[i][1] << PLL46XX_PDIV_SHIFT;
-			vpll_con0 |= vpll_div[i][2] << PLL46XX_MDIV_SHIFT;
-			vpll_con0 |= vpll_div[i][3] << PLL46XX_SDIV_SHIFT;
-			vpll_con1 |= vpll_div[i][4] << PLL46XX_KDIV_SHIFT;
-			vpll_con1 |= vpll_div[i][5] << PLL46XX_MFR_SHIFT;
-			vpll_con1 |= vpll_div[i][6] << PLL46XX_MRR_SHIFT;
-			vpll_con0 |= vpll_div[i][7] << 27;
+	for (i = 0; i < ARRAY_SIZE(exynos4_vpll_div); i++) {
+		if (exynos4_vpll_div[i][0] == rate) {
+			vpll_con0 |= exynos4_vpll_div[i][1] << PLL46XX_PDIV_SHIFT;
+			vpll_con0 |= exynos4_vpll_div[i][2] << PLL46XX_MDIV_SHIFT;
+			vpll_con0 |= exynos4_vpll_div[i][3] << PLL46XX_SDIV_SHIFT;
+			vpll_con1 |= exynos4_vpll_div[i][4] << PLL46XX_KDIV_SHIFT;
+			vpll_con1 |= exynos4_vpll_div[i][5] << PLL46XX_MFR_SHIFT;
+			vpll_con1 |= exynos4_vpll_div[i][6] << PLL46XX_MRR_SHIFT;
+			vpll_con0 |= exynos4_vpll_div[i][7] << 27;
 			break;
 		}
 	}
 
-	if (i == ARRAY_SIZE(vpll_div)) {
+	if (i == ARRAY_SIZE(exynos4_vpll_div)) {
 		printk(KERN_ERR "%s: Invalid Clock VPLL Frequency\n",
 				__func__);
 		return -EINVAL;
 	}
 
-	__raw_writel(vpll_con0, S5P_VPLL_CON0);
-	__raw_writel(vpll_con1, S5P_VPLL_CON1);
+	__raw_writel(vpll_con0, EXYNOS4_VPLL_CON0);
+	__raw_writel(vpll_con1, EXYNOS4_VPLL_CON1);
 
 	/* Wait for VPLL lock */
-	while (!(__raw_readl(S5P_VPLL_CON0) & (1 << PLL46XX_LOCKED_SHIFT)))
+	while (!(__raw_readl(EXYNOS4_VPLL_CON0) & (1 << PLL46XX_LOCKED_SHIFT)))
 		continue;
 
 	clk->rate = rate;
@@ -1448,25 +1448,25 @@ void __init_or_cpufreq exynos4_setup_clocks(void)
 	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
 
 	if (soc_is_exynos4210()) {
-		apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON0),
+		apll = s5p_get_pll45xx(xtal, __raw_readl(EXYNOS4_APLL_CON0),
 					pll_4508);
-		mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON0),
+		mpll = s5p_get_pll45xx(xtal, __raw_readl(EXYNOS4_MPLL_CON0),
 					pll_4508);
-		epll = s5p_get_pll46xx(xtal, __raw_readl(S5P_EPLL_CON0),
-					__raw_readl(S5P_EPLL_CON1), pll_4600);
+		epll = s5p_get_pll46xx(xtal, __raw_readl(EXYNOS4_EPLL_CON0),
+					__raw_readl(EXYNOS4_EPLL_CON1), pll_4600);
 
-		vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
-		vpll = s5p_get_pll46xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
-					__raw_readl(S5P_VPLL_CON1), pll_4650c);
+		vpllsrc = clk_get_rate(&exynos4_clk_vpllsrc.clk);
+		vpll = s5p_get_pll46xx(vpllsrc, __raw_readl(EXYNOS4_VPLL_CON0),
+					__raw_readl(EXYNOS4_VPLL_CON1), pll_4650c);
 	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
-		apll = s5p_get_pll35xx(xtal, __raw_readl(S5P_APLL_CON0));
-		mpll = s5p_get_pll35xx(xtal, __raw_readl(S5P_MPLL_CON0));
-		epll = s5p_get_pll36xx(xtal, __raw_readl(S5P_EPLL_CON0),
-					__raw_readl(S5P_EPLL_CON1));
-
-		vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
-		vpll = s5p_get_pll36xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
-					__raw_readl(S5P_VPLL_CON1));
+		apll = s5p_get_pll35xx(xtal, __raw_readl(EXYNOS4_APLL_CON0));
+		mpll = s5p_get_pll35xx(xtal, __raw_readl(EXYNOS4_MPLL_CON0));
+		epll = s5p_get_pll36xx(xtal, __raw_readl(EXYNOS4_EPLL_CON0),
+					__raw_readl(EXYNOS4_EPLL_CON1));
+
+		vpllsrc = clk_get_rate(&exynos4_clk_vpllsrc.clk);
+		vpll = s5p_get_pll36xx(vpllsrc, __raw_readl(EXYNOS4_VPLL_CON0),
+					__raw_readl(EXYNOS4_VPLL_CON1));
 	} else {
 		/* nothing */
 	}
@@ -1480,13 +1480,13 @@ void __init_or_cpufreq exynos4_setup_clocks(void)
 	printk(KERN_INFO "EXYNOS4: PLL settings, A=%ld, M=%ld, E=%ld V=%ld",
 			apll, mpll, epll, vpll);
 
-	armclk = clk_get_rate(&clk_armclk.clk);
-	sclk_dmc = clk_get_rate(&clk_sclk_dmc.clk);
+	armclk = clk_get_rate(&exynos4_clk_armclk.clk);
+	sclk_dmc = clk_get_rate(&exynos4_clk_sclk_dmc.clk);
 
-	aclk_200 = clk_get_rate(&clk_aclk_200.clk);
-	aclk_100 = clk_get_rate(&clk_aclk_100.clk);
-	aclk_160 = clk_get_rate(&clk_aclk_160.clk);
-	aclk_133 = clk_get_rate(&clk_aclk_133.clk);
+	aclk_200 = clk_get_rate(&exynos4_clk_aclk_200.clk);
+	aclk_100 = clk_get_rate(&exynos4_clk_aclk_100.clk);
+	aclk_160 = clk_get_rate(&exynos4_clk_aclk_160.clk);
+	aclk_133 = clk_get_rate(&exynos4_clk_aclk_133.clk);
 
 	printk(KERN_INFO "EXYNOS4: ARMCLK=%ld, DMC=%ld, ACLK200=%ld\n"
 			 "ACLK100=%ld, ACLK160=%ld, ACLK133=%ld\n",
@@ -1497,15 +1497,15 @@ void __init_or_cpufreq exynos4_setup_clocks(void)
 	clk_h.rate = sclk_dmc;
 	clk_p.rate = aclk_100;
 
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
-		s3c_set_clksrc(&clksrcs[ptr], true);
+	for (ptr = 0; ptr < ARRAY_SIZE(exynos4_clksrcs); ptr++)
+		s3c_set_clksrc(&exynos4_clksrcs[ptr], true);
 }
 
-static struct clk *clks[] __initdata = {
-	&clk_sclk_hdmi27m,
-	&clk_sclk_hdmiphy,
-	&clk_sclk_usbphy0,
-	&clk_sclk_usbphy1,
+static struct clk *exynos4_clks[] __initdata = {
+	&exynos4_clk_sclk_hdmi27m,
+	&exynos4_clk_sclk_hdmiphy,
+	&exynos4_clk_sclk_usbphy0,
+	&exynos4_clk_sclk_usbphy1,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -1534,26 +1534,26 @@ void __init exynos4_register_clocks(void)
 {
 	int ptr;
 
-	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
+	s3c24xx_register_clocks(exynos4_clks, ARRAY_SIZE(exynos4_clks));
 
-	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
-		s3c_register_clksrc(sysclks[ptr], 1);
+	for (ptr = 0; ptr < ARRAY_SIZE(exynos4_sysclks); ptr++)
+		s3c_register_clksrc(exynos4_sysclks[ptr], 1);
 
-	for (ptr = 0; ptr < ARRAY_SIZE(sclk_tv); ptr++)
-		s3c_register_clksrc(sclk_tv[ptr], 1);
+	for (ptr = 0; ptr < ARRAY_SIZE(exynos4_sclk_tv); ptr++)
+		s3c_register_clksrc(exynos4_sclk_tv[ptr], 1);
 
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
-		s3c_register_clksrc(clksrc_cdev[ptr], 1);
+	for (ptr = 0; ptr < ARRAY_SIZE(exynos4_clksrc_cdev); ptr++)
+		s3c_register_clksrc(exynos4_clksrc_cdev[ptr], 1);
 
-	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
-	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+	s3c_register_clksrc(exynos4_clksrcs, ARRAY_SIZE(exynos4_clksrcs));
+	s3c_register_clocks(exynos4_init_clocks_on, ARRAY_SIZE(exynos4_init_clocks_on));
 
-	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
-	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
-		s3c_disable_clocks(clk_cdev[ptr], 1);
+	s3c24xx_register_clocks(exynos4_clk_cdev, ARRAY_SIZE(exynos4_clk_cdev));
+	for (ptr = 0; ptr < ARRAY_SIZE(exynos4_clk_cdev); ptr++)
+		s3c_disable_clocks(exynos4_clk_cdev[ptr], 1);
 
-	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	s3c_register_clocks(exynos4_init_clocks_off, ARRAY_SIZE(exynos4_init_clocks_off));
+	s3c_disable_clocks(exynos4_init_clocks_off, ARRAY_SIZE(exynos4_init_clocks_off));
 	clkdev_add_table(exynos4_clk_lookup, ARRAY_SIZE(exynos4_clk_lookup));
 
 	register_syscore_ops(&exynos4_clock_syscore_ops);
diff --git a/arch/arm/mach-exynos/clock-exynos4.h b/arch/arm/mach-exynos/clock-exynos4.h
index d2ef305..cb71c29 100644
--- a/arch/arm/mach-exynos/clock-exynos4.h
+++ b/arch/arm/mach-exynos/clock-exynos4.h
@@ -1,6 +1,5 @@
 /*
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Header file for exynos4 clock support
@@ -15,14 +14,14 @@
 
 #include <linux/clk.h>
 
-extern struct clksrc_clk clk_mout_mpll;
-extern struct clksrc_clk clk_aclk_133;
+extern struct clksrc_clk exynos4_clk_aclk_133;
+extern struct clksrc_clk exynos4_clk_mout_mpll;
 
-extern struct clksrc_sources clkset_mout_corebus;
-extern struct clksrc_sources clkset_group;
+extern struct clksrc_sources exynos4_clkset_mout_corebus;
+extern struct clksrc_sources exynos4_clkset_group;
 
-extern struct clk *clkset_aclk_top_list[];
-extern struct clk *clkset_group_list[];
+extern struct clk *exynos4_clkset_aclk_top_list[];
+extern struct clk *exynos4_clkset_group_list[];
 
 extern int exynos4_clksrc_mask_fsys_ctrl(struct clk *clk, int enable);
 extern int exynos4_clk_ip_fsys_ctrl(struct clk *clk, int enable);
diff --git a/arch/arm/mach-exynos/clock-exynos4210.c b/arch/arm/mach-exynos/clock-exynos4210.c
index 190d94a..bb8c7f4 100644
--- a/arch/arm/mach-exynos/clock-exynos4210.c
+++ b/arch/arm/mach-exynos/clock-exynos4210.c
@@ -1,7 +1,5 @@
 /*
- * linux/arch/arm/mach-exynos4/clock-exynos4210.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * EXYNOS4210 - Clock support
@@ -34,14 +32,14 @@
 
 #ifdef CONFIG_PM_SLEEP
 static struct sleep_save exynos4210_clock_save[] = {
-	SAVE_ITEM(S5P_CLKSRC_IMAGE),
-	SAVE_ITEM(S5P_CLKSRC_LCD1),
-	SAVE_ITEM(S5P_CLKDIV_IMAGE),
-	SAVE_ITEM(S5P_CLKDIV_LCD1),
-	SAVE_ITEM(S5P_CLKSRC_MASK_LCD1),
-	SAVE_ITEM(S5P_CLKGATE_IP_IMAGE_4210),
-	SAVE_ITEM(S5P_CLKGATE_IP_LCD1),
-	SAVE_ITEM(S5P_CLKGATE_IP_PERIR_4210),
+	SAVE_ITEM(EXYNOS4_CLKSRC_IMAGE),
+	SAVE_ITEM(EXYNOS4_CLKDIV_IMAGE),
+	SAVE_ITEM(EXYNOS4210_CLKSRC_LCD1),
+	SAVE_ITEM(EXYNOS4210_CLKDIV_LCD1),
+	SAVE_ITEM(EXYNOS4210_CLKSRC_MASK_LCD1),
+	SAVE_ITEM(EXYNOS4210_CLKGATE_IP_IMAGE),
+	SAVE_ITEM(EXYNOS4210_CLKGATE_IP_LCD1),
+	SAVE_ITEM(EXYNOS4210_CLKGATE_IP_PERIR),
 };
 #endif
 
@@ -51,7 +49,7 @@ static struct clksrc_clk *sysclks[] = {
 
 static int exynos4_clksrc_mask_lcd1_ctrl(struct clk *clk, int enable)
 {
-	return s5p_gatectrl(S5P_CLKSRC_MASK_LCD1, clk, enable);
+	return s5p_gatectrl(EXYNOS4210_CLKSRC_MASK_LCD1, clk, enable);
 }
 
 static struct clksrc_clk clksrcs[] = {
@@ -62,9 +60,9 @@ static struct clksrc_clk clksrcs[] = {
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
-		.sources = &clkset_mout_corebus,
-		.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 24, .size = 1 },
-		.reg_div = { .reg = S5P_CLKDIV_FSYS0, .shift = 20, .size = 4 },
+		.sources = &exynos4_clkset_mout_corebus,
+		.reg_src = { .reg = EXYNOS4_CLKSRC_FSYS, .shift = 24, .size = 1 },
+		.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS0, .shift = 20, .size = 4 },
 	}, {
 		.clk		= {
 			.name		= "sclk_fimd",
@@ -72,9 +70,9 @@ static struct clksrc_clk clksrcs[] = {
 			.enable		= exynos4_clksrc_mask_lcd1_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_LCD1, .shift = 0, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_LCD1, .shift = 0, .size = 4 },
+		.sources = &exynos4_clkset_group,
+		.reg_src = { .reg = EXYNOS4210_CLKSRC_LCD1, .shift = 0, .size = 4 },
+		.reg_div = { .reg = EXYNOS4210_CLKDIV_LCD1, .shift = 0, .size = 4 },
 	},
 };
 
@@ -82,13 +80,13 @@ static struct clk init_clocks_off[] = {
 	{
 		.name		= "sataphy",
 		.id		= -1,
-		.parent		= &clk_aclk_133.clk,
+		.parent		= &exynos4_clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "sata",
 		.id		= -1,
-		.parent		= &clk_aclk_133.clk,
+		.parent		= &exynos4_clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
@@ -126,9 +124,9 @@ void __init exynos4210_register_clocks(void)
 {
 	int ptr;
 
-	clk_mout_mpll.reg_src.reg = S5P_CLKSRC_CPU;
-	clk_mout_mpll.reg_src.shift = 8;
-	clk_mout_mpll.reg_src.size = 1;
+	exynos4_clk_mout_mpll.reg_src.reg = EXYNOS4_CLKSRC_CPU;
+	exynos4_clk_mout_mpll.reg_src.shift = 8;
+	exynos4_clk_mout_mpll.reg_src.size = 1;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
 		s3c_register_clksrc(sysclks[ptr], 1);
diff --git a/arch/arm/mach-exynos/clock-exynos4212.c b/arch/arm/mach-exynos/clock-exynos4212.c
index e83d4b2..b478f44 100644
--- a/arch/arm/mach-exynos/clock-exynos4212.c
+++ b/arch/arm/mach-exynos/clock-exynos4212.c
@@ -1,7 +1,5 @@
 /*
- * linux/arch/arm/mach-exynos4/clock-exynos4212.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * EXYNOS4212 - Clock support
@@ -34,16 +32,16 @@
 
 #ifdef CONFIG_PM_SLEEP
 static struct sleep_save exynos4212_clock_save[] = {
-	SAVE_ITEM(S5P_CLKSRC_IMAGE),
-	SAVE_ITEM(S5P_CLKDIV_IMAGE),
-	SAVE_ITEM(S5P_CLKGATE_IP_IMAGE_4212),
-	SAVE_ITEM(S5P_CLKGATE_IP_PERIR_4212),
+	SAVE_ITEM(EXYNOS4_CLKSRC_IMAGE),
+	SAVE_ITEM(EXYNOS4_CLKDIV_IMAGE),
+	SAVE_ITEM(EXYNOS4212_CLKGATE_IP_IMAGE),
+	SAVE_ITEM(EXYNOS4212_CLKGATE_IP_PERIR),
 };
 #endif
 
 static struct clk *clk_src_mpll_user_list[] = {
 	[0] = &clk_fin_mpll,
-	[1] = &clk_mout_mpll.clk,
+	[1] = &exynos4_clk_mout_mpll.clk,
 };
 
 static struct clksrc_sources clk_src_mpll_user = {
@@ -56,7 +54,7 @@ static struct clksrc_clk clk_mout_mpll_user = {
 		.name		= "mout_mpll_user",
 	},
 	.sources	= &clk_src_mpll_user,
-	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 24, .size = 1 },
+	.reg_src	= { .reg = EXYNOS4_CLKSRC_CPU, .shift = 24, .size = 1 },
 };
 
 static struct clksrc_clk *sysclks[] = {
@@ -99,15 +97,15 @@ void __init exynos4212_register_clocks(void)
 	int ptr;
 
 	/* usbphy1 is removed */
-	clkset_group_list[4] = NULL;
+	exynos4_clkset_group_list[4] = NULL;
 
 	/* mout_mpll_user is used */
-	clkset_group_list[6] = &clk_mout_mpll_user.clk;
-	clkset_aclk_top_list[0] = &clk_mout_mpll_user.clk;
+	exynos4_clkset_group_list[6] = &clk_mout_mpll_user.clk;
+	exynos4_clkset_aclk_top_list[0] = &clk_mout_mpll_user.clk;
 
-	clk_mout_mpll.reg_src.reg = S5P_CLKSRC_DMC;
-	clk_mout_mpll.reg_src.shift = 12;
-	clk_mout_mpll.reg_src.size = 1;
+	exynos4_clk_mout_mpll.reg_src.reg = EXYNOS4_CLKSRC_DMC;
+	exynos4_clk_mout_mpll.reg_src.shift = 12;
+	exynos4_clk_mout_mpll.reg_src.size = 1;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
 		s3c_register_clksrc(sysclks[ptr], 1);
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 1ac49de..8c1efe6 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -15,12 +15,21 @@
 void exynos_init_io(struct map_desc *mach_desc, int size);
 void exynos4_init_irq(void);
 
+#ifdef CONFIG_ARCH_EXYNOS4
 void exynos4_register_clocks(void);
 void exynos4_setup_clocks(void);
 
 void exynos4210_register_clocks(void);
 void exynos4212_register_clocks(void);
 
+#else
+#define exynos4_register_clocks()
+#define exynos4_setup_clocks()
+
+#define exynos4210_register_clocks()
+#define exynos4212_register_clocks()
+#endif
+
 void exynos4_restart(char mode, const char *cmd);
 
 extern struct sys_timer exynos4_timer;
diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
index 6c37ebe..790f525 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -16,195 +16,195 @@
 #include <plat/cpu.h>
 #include <mach/map.h>
 
-#define S5P_CLKREG(x)			(S5P_VA_CMU + (x))
-
-#define S5P_CLKDIV_LEFTBUS		S5P_CLKREG(0x04500)
-#define S5P_CLKDIV_STAT_LEFTBUS		S5P_CLKREG(0x04600)
-#define S5P_CLKGATE_IP_LEFTBUS		S5P_CLKREG(0x04800)
-
-#define S5P_CLKDIV_RIGHTBUS		S5P_CLKREG(0x08500)
-#define S5P_CLKDIV_STAT_RIGHTBUS	S5P_CLKREG(0x08600)
-#define S5P_CLKGATE_IP_RIGHTBUS		S5P_CLKREG(0x08800)
-
-#define S5P_EPLL_LOCK			S5P_CLKREG(0x0C010)
-#define S5P_VPLL_LOCK			S5P_CLKREG(0x0C020)
-
-#define S5P_EPLL_CON0			S5P_CLKREG(0x0C110)
-#define S5P_EPLL_CON1			S5P_CLKREG(0x0C114)
-#define S5P_VPLL_CON0			S5P_CLKREG(0x0C120)
-#define S5P_VPLL_CON1			S5P_CLKREG(0x0C124)
-
-#define S5P_CLKSRC_TOP0			S5P_CLKREG(0x0C210)
-#define S5P_CLKSRC_TOP1			S5P_CLKREG(0x0C214)
-#define S5P_CLKSRC_CAM			S5P_CLKREG(0x0C220)
-#define S5P_CLKSRC_TV			S5P_CLKREG(0x0C224)
-#define S5P_CLKSRC_MFC			S5P_CLKREG(0x0C228)
-#define S5P_CLKSRC_G3D			S5P_CLKREG(0x0C22C)
-#define S5P_CLKSRC_IMAGE		S5P_CLKREG(0x0C230)
-#define S5P_CLKSRC_LCD0			S5P_CLKREG(0x0C234)
-#define S5P_CLKSRC_MAUDIO		S5P_CLKREG(0x0C23C)
-#define S5P_CLKSRC_FSYS			S5P_CLKREG(0x0C240)
-#define S5P_CLKSRC_PERIL0		S5P_CLKREG(0x0C250)
-#define S5P_CLKSRC_PERIL1		S5P_CLKREG(0x0C254)
-
-#define S5P_CLKSRC_MASK_TOP		S5P_CLKREG(0x0C310)
-#define S5P_CLKSRC_MASK_CAM		S5P_CLKREG(0x0C320)
-#define S5P_CLKSRC_MASK_TV		S5P_CLKREG(0x0C324)
-#define S5P_CLKSRC_MASK_LCD0		S5P_CLKREG(0x0C334)
-#define S5P_CLKSRC_MASK_MAUDIO		S5P_CLKREG(0x0C33C)
-#define S5P_CLKSRC_MASK_FSYS		S5P_CLKREG(0x0C340)
-#define S5P_CLKSRC_MASK_PERIL0		S5P_CLKREG(0x0C350)
-#define S5P_CLKSRC_MASK_PERIL1		S5P_CLKREG(0x0C354)
-
-#define S5P_CLKDIV_TOP			S5P_CLKREG(0x0C510)
-#define S5P_CLKDIV_CAM			S5P_CLKREG(0x0C520)
-#define S5P_CLKDIV_TV			S5P_CLKREG(0x0C524)
-#define S5P_CLKDIV_MFC			S5P_CLKREG(0x0C528)
-#define S5P_CLKDIV_G3D			S5P_CLKREG(0x0C52C)
-#define S5P_CLKDIV_IMAGE		S5P_CLKREG(0x0C530)
-#define S5P_CLKDIV_LCD0			S5P_CLKREG(0x0C534)
-#define S5P_CLKDIV_MAUDIO		S5P_CLKREG(0x0C53C)
-#define S5P_CLKDIV_FSYS0		S5P_CLKREG(0x0C540)
-#define S5P_CLKDIV_FSYS1		S5P_CLKREG(0x0C544)
-#define S5P_CLKDIV_FSYS2		S5P_CLKREG(0x0C548)
-#define S5P_CLKDIV_FSYS3		S5P_CLKREG(0x0C54C)
-#define S5P_CLKDIV_PERIL0		S5P_CLKREG(0x0C550)
-#define S5P_CLKDIV_PERIL1		S5P_CLKREG(0x0C554)
-#define S5P_CLKDIV_PERIL2		S5P_CLKREG(0x0C558)
-#define S5P_CLKDIV_PERIL3		S5P_CLKREG(0x0C55C)
-#define S5P_CLKDIV_PERIL4		S5P_CLKREG(0x0C560)
-#define S5P_CLKDIV_PERIL5		S5P_CLKREG(0x0C564)
-#define S5P_CLKDIV2_RATIO		S5P_CLKREG(0x0C580)
-
-#define S5P_CLKDIV_STAT_TOP		S5P_CLKREG(0x0C610)
-
-#define S5P_CLKGATE_SCLKCAM		S5P_CLKREG(0x0C820)
-#define S5P_CLKGATE_IP_CAM		S5P_CLKREG(0x0C920)
-#define S5P_CLKGATE_IP_TV		S5P_CLKREG(0x0C924)
-#define S5P_CLKGATE_IP_MFC		S5P_CLKREG(0x0C928)
-#define S5P_CLKGATE_IP_G3D		S5P_CLKREG(0x0C92C)
-#define S5P_CLKGATE_IP_IMAGE		(soc_is_exynos4210() ? \
-					S5P_CLKREG(0x0C930) : \
-					S5P_CLKREG(0x04930))
-#define S5P_CLKGATE_IP_IMAGE_4210	S5P_CLKREG(0x0C930)
-#define S5P_CLKGATE_IP_IMAGE_4212	S5P_CLKREG(0x04930)
-#define S5P_CLKGATE_IP_LCD0		S5P_CLKREG(0x0C934)
-#define S5P_CLKGATE_IP_FSYS		S5P_CLKREG(0x0C940)
-#define S5P_CLKGATE_IP_GPS		S5P_CLKREG(0x0C94C)
-#define S5P_CLKGATE_IP_PERIL		S5P_CLKREG(0x0C950)
-#define S5P_CLKGATE_IP_PERIR		(soc_is_exynos4210() ? \
-					S5P_CLKREG(0x0C960) : \
-					S5P_CLKREG(0x08960))
-#define S5P_CLKGATE_IP_PERIR_4210	S5P_CLKREG(0x0C960)
-#define S5P_CLKGATE_IP_PERIR_4212	S5P_CLKREG(0x08960)
-#define S5P_CLKGATE_BLOCK		S5P_CLKREG(0x0C970)
-
-#define S5P_CLKSRC_MASK_DMC		S5P_CLKREG(0x10300)
-#define S5P_CLKSRC_DMC			S5P_CLKREG(0x10200)
-#define S5P_CLKDIV_DMC0			S5P_CLKREG(0x10500)
-#define S5P_CLKDIV_DMC1			S5P_CLKREG(0x10504)
-#define S5P_CLKDIV_STAT_DMC0		S5P_CLKREG(0x10600)
-#define S5P_CLKGATE_IP_DMC		S5P_CLKREG(0x10900)
-
-#define S5P_APLL_LOCK			S5P_CLKREG(0x14000)
-#define S5P_MPLL_LOCK			(soc_is_exynos4210() ? \
-					S5P_CLKREG(0x14004) :  \
-					S5P_CLKREG(0x10008))
-#define S5P_APLL_CON0			S5P_CLKREG(0x14100)
-#define S5P_APLL_CON1			S5P_CLKREG(0x14104)
-#define S5P_MPLL_CON0			(soc_is_exynos4210() ? \
-					S5P_CLKREG(0x14108) : \
-					S5P_CLKREG(0x10108))
-#define S5P_MPLL_CON1			(soc_is_exynos4210() ? \
-					S5P_CLKREG(0x1410C) : \
-					S5P_CLKREG(0x1010C))
-
-#define S5P_CLKSRC_CPU			S5P_CLKREG(0x14200)
-#define S5P_CLKMUX_STATCPU		S5P_CLKREG(0x14400)
-
-#define S5P_CLKDIV_CPU			S5P_CLKREG(0x14500)
-#define S5P_CLKDIV_CPU1			S5P_CLKREG(0x14504)
-#define S5P_CLKDIV_STATCPU		S5P_CLKREG(0x14600)
-#define S5P_CLKDIV_STATCPU1		S5P_CLKREG(0x14604)
-
-#define S5P_CLKGATE_SCLKCPU		S5P_CLKREG(0x14800)
-#define S5P_CLKGATE_IP_CPU		S5P_CLKREG(0x14900)
-
-#define S5P_APLL_LOCKTIME		(0x1C20)	/* 300us */
-
-#define S5P_APLLCON0_ENABLE_SHIFT	(31)
-#define S5P_APLLCON0_LOCKED_SHIFT	(29)
-#define S5P_APLL_VAL_1000		((250 << 16) | (6 << 8) | 1)
-#define S5P_APLL_VAL_800		((200 << 16) | (6 << 8) | 1)
-
-#define S5P_EPLLCON0_ENABLE_SHIFT	(31)
-#define S5P_EPLLCON0_LOCKED_SHIFT	(29)
-
-#define S5P_VPLLCON0_ENABLE_SHIFT	(31)
-#define S5P_VPLLCON0_LOCKED_SHIFT	(29)
-
-#define S5P_CLKSRC_CPU_MUXCORE_SHIFT	(16)
-#define S5P_CLKMUX_STATCPU_MUXCORE_MASK	(0x7 << S5P_CLKSRC_CPU_MUXCORE_SHIFT)
-
-#define S5P_CLKDIV_CPU0_CORE_SHIFT	(0)
-#define S5P_CLKDIV_CPU0_CORE_MASK	(0x7 << S5P_CLKDIV_CPU0_CORE_SHIFT)
-#define S5P_CLKDIV_CPU0_COREM0_SHIFT	(4)
-#define S5P_CLKDIV_CPU0_COREM0_MASK	(0x7 << S5P_CLKDIV_CPU0_COREM0_SHIFT)
-#define S5P_CLKDIV_CPU0_COREM1_SHIFT	(8)
-#define S5P_CLKDIV_CPU0_COREM1_MASK	(0x7 << S5P_CLKDIV_CPU0_COREM1_SHIFT)
-#define S5P_CLKDIV_CPU0_PERIPH_SHIFT	(12)
-#define S5P_CLKDIV_CPU0_PERIPH_MASK	(0x7 << S5P_CLKDIV_CPU0_PERIPH_SHIFT)
-#define S5P_CLKDIV_CPU0_ATB_SHIFT	(16)
-#define S5P_CLKDIV_CPU0_ATB_MASK	(0x7 << S5P_CLKDIV_CPU0_ATB_SHIFT)
-#define S5P_CLKDIV_CPU0_PCLKDBG_SHIFT	(20)
-#define S5P_CLKDIV_CPU0_PCLKDBG_MASK	(0x7 << S5P_CLKDIV_CPU0_PCLKDBG_SHIFT)
-#define S5P_CLKDIV_CPU0_APLL_SHIFT	(24)
-#define S5P_CLKDIV_CPU0_APLL_MASK	(0x7 << S5P_CLKDIV_CPU0_APLL_SHIFT)
-
-#define S5P_CLKDIV_DMC0_ACP_SHIFT	(0)
-#define S5P_CLKDIV_DMC0_ACP_MASK	(0x7 << S5P_CLKDIV_DMC0_ACP_SHIFT)
-#define S5P_CLKDIV_DMC0_ACPPCLK_SHIFT	(4)
-#define S5P_CLKDIV_DMC0_ACPPCLK_MASK	(0x7 << S5P_CLKDIV_DMC0_ACPPCLK_SHIFT)
-#define S5P_CLKDIV_DMC0_DPHY_SHIFT	(8)
-#define S5P_CLKDIV_DMC0_DPHY_MASK	(0x7 << S5P_CLKDIV_DMC0_DPHY_SHIFT)
-#define S5P_CLKDIV_DMC0_DMC_SHIFT	(12)
-#define S5P_CLKDIV_DMC0_DMC_MASK	(0x7 << S5P_CLKDIV_DMC0_DMC_SHIFT)
-#define S5P_CLKDIV_DMC0_DMCD_SHIFT	(16)
-#define S5P_CLKDIV_DMC0_DMCD_MASK	(0x7 << S5P_CLKDIV_DMC0_DMCD_SHIFT)
-#define S5P_CLKDIV_DMC0_DMCP_SHIFT	(20)
-#define S5P_CLKDIV_DMC0_DMCP_MASK	(0x7 << S5P_CLKDIV_DMC0_DMCP_SHIFT)
-#define S5P_CLKDIV_DMC0_COPY2_SHIFT	(24)
-#define S5P_CLKDIV_DMC0_COPY2_MASK	(0x7 << S5P_CLKDIV_DMC0_COPY2_SHIFT)
-#define S5P_CLKDIV_DMC0_CORETI_SHIFT	(28)
-#define S5P_CLKDIV_DMC0_CORETI_MASK	(0x7 << S5P_CLKDIV_DMC0_CORETI_SHIFT)
-
-#define S5P_CLKDIV_TOP_ACLK200_SHIFT	(0)
-#define S5P_CLKDIV_TOP_ACLK200_MASK	(0x7 << S5P_CLKDIV_TOP_ACLK200_SHIFT)
-#define S5P_CLKDIV_TOP_ACLK100_SHIFT	(4)
-#define S5P_CLKDIV_TOP_ACLK100_MASK	(0xf << S5P_CLKDIV_TOP_ACLK100_SHIFT)
-#define S5P_CLKDIV_TOP_ACLK160_SHIFT	(8)
-#define S5P_CLKDIV_TOP_ACLK160_MASK	(0x7 << S5P_CLKDIV_TOP_ACLK160_SHIFT)
-#define S5P_CLKDIV_TOP_ACLK133_SHIFT	(12)
-#define S5P_CLKDIV_TOP_ACLK133_MASK	(0x7 << S5P_CLKDIV_TOP_ACLK133_SHIFT)
-#define S5P_CLKDIV_TOP_ONENAND_SHIFT	(16)
-#define S5P_CLKDIV_TOP_ONENAND_MASK	(0x7 << S5P_CLKDIV_TOP_ONENAND_SHIFT)
-
-#define S5P_CLKDIV_BUS_GDLR_SHIFT	(0)
-#define S5P_CLKDIV_BUS_GDLR_MASK	(0x7 << S5P_CLKDIV_BUS_GDLR_SHIFT)
-#define S5P_CLKDIV_BUS_GPLR_SHIFT	(4)
-#define S5P_CLKDIV_BUS_GPLR_MASK	(0x7 << S5P_CLKDIV_BUS_GPLR_SHIFT)
+#define EXYNOS_CLKREG(x)			(S5P_VA_CMU + (x))
+
+#define EXYNOS4_CLKDIV_LEFTBUS			EXYNOS_CLKREG(0x04500)
+#define EXYNOS4_CLKDIV_STAT_LEFTBUS		EXYNOS_CLKREG(0x04600)
+#define EXYNOS4_CLKGATE_IP_LEFTBUS		EXYNOS_CLKREG(0x04800)
+
+#define EXYNOS4_CLKDIV_RIGHTBUS			EXYNOS_CLKREG(0x08500)
+#define EXYNOS4_CLKDIV_STAT_RIGHTBUS		EXYNOS_CLKREG(0x08600)
+#define EXYNOS4_CLKGATE_IP_RIGHTBUS		EXYNOS_CLKREG(0x08800)
+
+#define EXYNOS4_EPLL_LOCK			EXYNOS_CLKREG(0x0C010)
+#define EXYNOS4_VPLL_LOCK			EXYNOS_CLKREG(0x0C020)
+
+#define EXYNOS4_EPLL_CON0			EXYNOS_CLKREG(0x0C110)
+#define EXYNOS4_EPLL_CON1			EXYNOS_CLKREG(0x0C114)
+#define EXYNOS4_VPLL_CON0			EXYNOS_CLKREG(0x0C120)
+#define EXYNOS4_VPLL_CON1			EXYNOS_CLKREG(0x0C124)
+
+#define EXYNOS4_CLKSRC_TOP0			EXYNOS_CLKREG(0x0C210)
+#define EXYNOS4_CLKSRC_TOP1			EXYNOS_CLKREG(0x0C214)
+#define EXYNOS4_CLKSRC_CAM			EXYNOS_CLKREG(0x0C220)
+#define EXYNOS4_CLKSRC_TV			EXYNOS_CLKREG(0x0C224)
+#define EXYNOS4_CLKSRC_MFC			EXYNOS_CLKREG(0x0C228)
+#define EXYNOS4_CLKSRC_G3D			EXYNOS_CLKREG(0x0C22C)
+#define EXYNOS4_CLKSRC_IMAGE			EXYNOS_CLKREG(0x0C230)
+#define EXYNOS4_CLKSRC_LCD0			EXYNOS_CLKREG(0x0C234)
+#define EXYNOS4_CLKSRC_MAUDIO			EXYNOS_CLKREG(0x0C23C)
+#define EXYNOS4_CLKSRC_FSYS			EXYNOS_CLKREG(0x0C240)
+#define EXYNOS4_CLKSRC_PERIL0			EXYNOS_CLKREG(0x0C250)
+#define EXYNOS4_CLKSRC_PERIL1			EXYNOS_CLKREG(0x0C254)
+
+#define EXYNOS4_CLKSRC_MASK_TOP			EXYNOS_CLKREG(0x0C310)
+#define EXYNOS4_CLKSRC_MASK_CAM			EXYNOS_CLKREG(0x0C320)
+#define EXYNOS4_CLKSRC_MASK_TV			EXYNOS_CLKREG(0x0C324)
+#define EXYNOS4_CLKSRC_MASK_LCD0		EXYNOS_CLKREG(0x0C334)
+#define EXYNOS4_CLKSRC_MASK_MAUDIO		EXYNOS_CLKREG(0x0C33C)
+#define EXYNOS4_CLKSRC_MASK_FSYS		EXYNOS_CLKREG(0x0C340)
+#define EXYNOS4_CLKSRC_MASK_PERIL0		EXYNOS_CLKREG(0x0C350)
+#define EXYNOS4_CLKSRC_MASK_PERIL1		EXYNOS_CLKREG(0x0C354)
+
+#define EXYNOS4_CLKDIV_TOP			EXYNOS_CLKREG(0x0C510)
+#define EXYNOS4_CLKDIV_CAM			EXYNOS_CLKREG(0x0C520)
+#define EXYNOS4_CLKDIV_TV			EXYNOS_CLKREG(0x0C524)
+#define EXYNOS4_CLKDIV_MFC			EXYNOS_CLKREG(0x0C528)
+#define EXYNOS4_CLKDIV_G3D			EXYNOS_CLKREG(0x0C52C)
+#define EXYNOS4_CLKDIV_IMAGE			EXYNOS_CLKREG(0x0C530)
+#define EXYNOS4_CLKDIV_LCD0			EXYNOS_CLKREG(0x0C534)
+#define EXYNOS4_CLKDIV_MAUDIO			EXYNOS_CLKREG(0x0C53C)
+#define EXYNOS4_CLKDIV_FSYS0			EXYNOS_CLKREG(0x0C540)
+#define EXYNOS4_CLKDIV_FSYS1			EXYNOS_CLKREG(0x0C544)
+#define EXYNOS4_CLKDIV_FSYS2			EXYNOS_CLKREG(0x0C548)
+#define EXYNOS4_CLKDIV_FSYS3			EXYNOS_CLKREG(0x0C54C)
+#define EXYNOS4_CLKDIV_PERIL0			EXYNOS_CLKREG(0x0C550)
+#define EXYNOS4_CLKDIV_PERIL1			EXYNOS_CLKREG(0x0C554)
+#define EXYNOS4_CLKDIV_PERIL2			EXYNOS_CLKREG(0x0C558)
+#define EXYNOS4_CLKDIV_PERIL3			EXYNOS_CLKREG(0x0C55C)
+#define EXYNOS4_CLKDIV_PERIL4			EXYNOS_CLKREG(0x0C560)
+#define EXYNOS4_CLKDIV_PERIL5			EXYNOS_CLKREG(0x0C564)
+#define EXYNOS4_CLKDIV2_RATIO			EXYNOS_CLKREG(0x0C580)
+
+#define EXYNOS4_CLKDIV_STAT_TOP			EXYNOS_CLKREG(0x0C610)
+
+#define EXYNOS4_CLKGATE_SCLKCAM			EXYNOS_CLKREG(0x0C820)
+#define EXYNOS4_CLKGATE_IP_CAM			EXYNOS_CLKREG(0x0C920)
+#define EXYNOS4_CLKGATE_IP_TV			EXYNOS_CLKREG(0x0C924)
+#define EXYNOS4_CLKGATE_IP_MFC			EXYNOS_CLKREG(0x0C928)
+#define EXYNOS4_CLKGATE_IP_G3D			EXYNOS_CLKREG(0x0C92C)
+#define EXYNOS4_CLKGATE_IP_IMAGE		(soc_is_exynos4210() ? \
+						EXYNOS_CLKREG(0x0C930) : \
+						EXYNOS_CLKREG(0x04930))
+#define EXYNOS4210_CLKGATE_IP_IMAGE		EXYNOS_CLKREG(0x0C930)
+#define EXYNOS4212_CLKGATE_IP_IMAGE		EXYNOS_CLKREG(0x04930)
+#define EXYNOS4_CLKGATE_IP_LCD0			EXYNOS_CLKREG(0x0C934)
+#define EXYNOS4_CLKGATE_IP_FSYS			EXYNOS_CLKREG(0x0C940)
+#define EXYNOS4_CLKGATE_IP_GPS			EXYNOS_CLKREG(0x0C94C)
+#define EXYNOS4_CLKGATE_IP_PERIL		EXYNOS_CLKREG(0x0C950)
+#define EXYNOS4_CLKGATE_IP_PERIR		(soc_is_exynos4210() ? \
+						EXYNOS_CLKREG(0x0C960) : \
+						EXYNOS_CLKREG(0x08960))
+#define EXYNOS4210_CLKGATE_IP_PERIR		EXYNOS_CLKREG(0x0C960)
+#define EXYNOS4212_CLKGATE_IP_PERIR		EXYNOS_CLKREG(0x08960)
+#define EXYNOS4_CLKGATE_BLOCK			EXYNOS_CLKREG(0x0C970)
+
+#define EXYNOS4_CLKSRC_MASK_DMC			EXYNOS_CLKREG(0x10300)
+#define EXYNOS4_CLKSRC_DMC			EXYNOS_CLKREG(0x10200)
+#define EXYNOS4_CLKDIV_DMC0			EXYNOS_CLKREG(0x10500)
+#define EXYNOS4_CLKDIV_DMC1			EXYNOS_CLKREG(0x10504)
+#define EXYNOS4_CLKDIV_STAT_DMC0		EXYNOS_CLKREG(0x10600)
+#define EXYNOS4_CLKGATE_IP_DMC			EXYNOS_CLKREG(0x10900)
+
+#define EXYNOS4_APLL_LOCK			EXYNOS_CLKREG(0x14000)
+#define EXYNOS4_MPLL_LOCK			(soc_is_exynos4210() ? \
+						EXYNOS_CLKREG(0x14004) :  \
+						EXYNOS_CLKREG(0x10008))
+#define EXYNOS4_APLL_CON0			EXYNOS_CLKREG(0x14100)
+#define EXYNOS4_APLL_CON1			EXYNOS_CLKREG(0x14104)
+#define EXYNOS4_MPLL_CON0			(soc_is_exynos4210() ? \
+						EXYNOS_CLKREG(0x14108) : \
+						EXYNOS_CLKREG(0x10108))
+#define EXYNOS4_MPLL_CON1			(soc_is_exynos4210() ? \
+						EXYNOS_CLKREG(0x1410C) : \
+						EXYNOS_CLKREG(0x1010C))
+
+#define EXYNOS4_CLKSRC_CPU			EXYNOS_CLKREG(0x14200)
+#define EXYNOS4_CLKMUX_STATCPU			EXYNOS_CLKREG(0x14400)
+
+#define EXYNOS4_CLKDIV_CPU			EXYNOS_CLKREG(0x14500)
+#define EXYNOS4_CLKDIV_CPU1			EXYNOS_CLKREG(0x14504)
+#define EXYNOS4_CLKDIV_STATCPU			EXYNOS_CLKREG(0x14600)
+#define EXYNOS4_CLKDIV_STATCPU1			EXYNOS_CLKREG(0x14604)
+
+#define EXYNOS4_CLKGATE_SCLKCPU			EXYNOS_CLKREG(0x14800)
+#define EXYNOS4_CLKGATE_IP_CPU			EXYNOS_CLKREG(0x14900)
+
+#define EXYNOS4_APLL_LOCKTIME			(0x1C20)	/* 300us */
+
+#define EXYNOS4_APLLCON0_ENABLE_SHIFT		(31)
+#define EXYNOS4_APLLCON0_LOCKED_SHIFT		(29)
+#define EXYNOS4_APLL_VAL_1000			((250 << 16) | (6 << 8) | 1)
+#define EXYNOS4_APLL_VAL_800			((200 << 16) | (6 << 8) | 1)
+
+#define EXYNOS4_EPLLCON0_ENABLE_SHIFT		(31)
+#define EXYNOS4_EPLLCON0_LOCKED_SHIFT		(29)
+
+#define EXYNOS4_VPLLCON0_ENABLE_SHIFT		(31)
+#define EXYNOS4_VPLLCON0_LOCKED_SHIFT		(29)
+
+#define EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT	(16)
+#define EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK	(0x7 << EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT)
+
+#define EXYNOS4_CLKDIV_CPU0_CORE_SHIFT		(0)
+#define EXYNOS4_CLKDIV_CPU0_CORE_MASK		(0x7 << EXYNOS4_CLKDIV_CPU0_CORE_SHIFT)
+#define EXYNOS4_CLKDIV_CPU0_COREM0_SHIFT	(4)
+#define EXYNOS4_CLKDIV_CPU0_COREM0_MASK		(0x7 << EXYNOS4_CLKDIV_CPU0_COREM0_SHIFT)
+#define EXYNOS4_CLKDIV_CPU0_COREM1_SHIFT	(8)
+#define EXYNOS4_CLKDIV_CPU0_COREM1_MASK		(0x7 << EXYNOS4_CLKDIV_CPU0_COREM1_SHIFT)
+#define EXYNOS4_CLKDIV_CPU0_PERIPH_SHIFT	(12)
+#define EXYNOS4_CLKDIV_CPU0_PERIPH_MASK		(0x7 << EXYNOS4_CLKDIV_CPU0_PERIPH_SHIFT)
+#define EXYNOS4_CLKDIV_CPU0_ATB_SHIFT		(16)
+#define EXYNOS4_CLKDIV_CPU0_ATB_MASK		(0x7 << EXYNOS4_CLKDIV_CPU0_ATB_SHIFT)
+#define EXYNOS4_CLKDIV_CPU0_PCLKDBG_SHIFT	(20)
+#define EXYNOS4_CLKDIV_CPU0_PCLKDBG_MASK	(0x7 << EXYNOS4_CLKDIV_CPU0_PCLKDBG_SHIFT)
+#define EXYNOS4_CLKDIV_CPU0_APLL_SHIFT		(24)
+#define EXYNOS4_CLKDIV_CPU0_APLL_MASK		(0x7 << EXYNOS4_CLKDIV_CPU0_APLL_SHIFT)
+
+#define EXYNOS4_CLKDIV_DMC0_ACP_SHIFT		(0)
+#define EXYNOS4_CLKDIV_DMC0_ACP_MASK		(0x7 << EXYNOS4_CLKDIV_DMC0_ACP_SHIFT)
+#define EXYNOS4_CLKDIV_DMC0_ACPPCLK_SHIFT	(4)
+#define EXYNOS4_CLKDIV_DMC0_ACPPCLK_MASK	(0x7 << EXYNOS4_CLKDIV_DMC0_ACPPCLK_SHIFT)
+#define EXYNOS4_CLKDIV_DMC0_DPHY_SHIFT		(8)
+#define EXYNOS4_CLKDIV_DMC0_DPHY_MASK		(0x7 << EXYNOS4_CLKDIV_DMC0_DPHY_SHIFT)
+#define EXYNOS4_CLKDIV_DMC0_DMC_SHIFT		(12)
+#define EXYNOS4_CLKDIV_DMC0_DMC_MASK		(0x7 << EXYNOS4_CLKDIV_DMC0_DMC_SHIFT)
+#define EXYNOS4_CLKDIV_DMC0_DMCD_SHIFT		(16)
+#define EXYNOS4_CLKDIV_DMC0_DMCD_MASK		(0x7 << EXYNOS4_CLKDIV_DMC0_DMCD_SHIFT)
+#define EXYNOS4_CLKDIV_DMC0_DMCP_SHIFT		(20)
+#define EXYNOS4_CLKDIV_DMC0_DMCP_MASK		(0x7 << EXYNOS4_CLKDIV_DMC0_DMCP_SHIFT)
+#define EXYNOS4_CLKDIV_DMC0_COPY2_SHIFT		(24)
+#define EXYNOS4_CLKDIV_DMC0_COPY2_MASK		(0x7 << EXYNOS4_CLKDIV_DMC0_COPY2_SHIFT)
+#define EXYNOS4_CLKDIV_DMC0_CORETI_SHIFT	(28)
+#define EXYNOS4_CLKDIV_DMC0_CORETI_MASK		(0x7 << EXYNOS4_CLKDIV_DMC0_CORETI_SHIFT)
+
+#define EXYNOS4_CLKDIV_TOP_ACLK200_SHIFT	(0)
+#define EXYNOS4_CLKDIV_TOP_ACLK200_MASK		(0x7 << EXYNOS4_CLKDIV_TOP_ACLK200_SHIFT)
+#define EXYNOS4_CLKDIV_TOP_ACLK100_SHIFT	(4)
+#define EXYNOS4_CLKDIV_TOP_ACLK100_MASK		(0xF << EXYNOS4_CLKDIV_TOP_ACLK100_SHIFT)
+#define EXYNOS4_CLKDIV_TOP_ACLK160_SHIFT	(8)
+#define EXYNOS4_CLKDIV_TOP_ACLK160_MASK		(0x7 << EXYNOS4_CLKDIV_TOP_ACLK160_SHIFT)
+#define EXYNOS4_CLKDIV_TOP_ACLK133_SHIFT	(12)
+#define EXYNOS4_CLKDIV_TOP_ACLK133_MASK		(0x7 << EXYNOS4_CLKDIV_TOP_ACLK133_SHIFT)
+#define EXYNOS4_CLKDIV_TOP_ONENAND_SHIFT	(16)
+#define EXYNOS4_CLKDIV_TOP_ONENAND_MASK		(0x7 << EXYNOS4_CLKDIV_TOP_ONENAND_SHIFT)
+
+#define EXYNOS4_CLKDIV_BUS_GDLR_SHIFT		(0)
+#define EXYNOS4_CLKDIV_BUS_GDLR_MASK		(0x7 << EXYNOS4_CLKDIV_BUS_GDLR_SHIFT)
+#define EXYNOS4_CLKDIV_BUS_GPLR_SHIFT		(4)
+#define EXYNOS4_CLKDIV_BUS_GPLR_MASK		(0x7 << EXYNOS4_CLKDIV_BUS_GPLR_SHIFT)
 
 /* Only for EXYNOS4210 */
 
-#define S5P_CLKSRC_LCD1			S5P_CLKREG(0x0C238)
-#define S5P_CLKSRC_MASK_LCD1		S5P_CLKREG(0x0C338)
-#define S5P_CLKDIV_LCD1			S5P_CLKREG(0x0C538)
-#define S5P_CLKGATE_IP_LCD1		S5P_CLKREG(0x0C938)
+#define EXYNOS4210_CLKSRC_LCD1			EXYNOS_CLKREG(0x0C238)
+#define EXYNOS4210_CLKSRC_MASK_LCD1		EXYNOS_CLKREG(0x0C338)
+#define EXYNOS4210_CLKDIV_LCD1			EXYNOS_CLKREG(0x0C538)
+#define EXYNOS4210_CLKGATE_IP_LCD1		EXYNOS_CLKREG(0x0C938)
 
 /* Compatibility defines and inclusion */
 
 #include <mach/regs-pmu.h>
 
-#define S5P_EPLL_CON			S5P_EPLL_CON0
+#define S5P_EPLL_CON				EXYNOS4_EPLL_CON0
 
 #endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index e190130..f105bd2 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -38,29 +38,29 @@
 #include <mach/pmu.h>
 
 static struct sleep_save exynos4_set_clksrc[] = {
-	{ .reg = S5P_CLKSRC_MASK_TOP			, .val = 0x00000001, },
-	{ .reg = S5P_CLKSRC_MASK_CAM			, .val = 0x11111111, },
-	{ .reg = S5P_CLKSRC_MASK_TV			, .val = 0x00000111, },
-	{ .reg = S5P_CLKSRC_MASK_LCD0			, .val = 0x00001111, },
-	{ .reg = S5P_CLKSRC_MASK_MAUDIO			, .val = 0x00000001, },
-	{ .reg = S5P_CLKSRC_MASK_FSYS			, .val = 0x01011111, },
-	{ .reg = S5P_CLKSRC_MASK_PERIL0			, .val = 0x01111111, },
-	{ .reg = S5P_CLKSRC_MASK_PERIL1			, .val = 0x01110111, },
-	{ .reg = S5P_CLKSRC_MASK_DMC			, .val = 0x00010000, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_TOP		, .val = 0x00000001, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_CAM		, .val = 0x11111111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_TV			, .val = 0x00000111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_LCD0		, .val = 0x00001111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_MAUDIO		, .val = 0x00000001, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_FSYS		, .val = 0x01011111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_PERIL0		, .val = 0x01111111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_PERIL1		, .val = 0x01110111, },
+	{ .reg = EXYNOS4_CLKSRC_MASK_DMC		, .val = 0x00010000, },
 };
 
 static struct sleep_save exynos4210_set_clksrc[] = {
-	{ .reg = S5P_CLKSRC_MASK_LCD1			, .val = 0x00001111, },
+	{ .reg = EXYNOS4210_CLKSRC_MASK_LCD1		, .val = 0x00001111, },
 };
 
 static struct sleep_save exynos4_epll_save[] = {
-	SAVE_ITEM(S5P_EPLL_CON0),
-	SAVE_ITEM(S5P_EPLL_CON1),
+	SAVE_ITEM(EXYNOS4_EPLL_CON0),
+	SAVE_ITEM(EXYNOS4_EPLL_CON1),
 };
 
 static struct sleep_save exynos4_vpll_save[] = {
-	SAVE_ITEM(S5P_VPLL_CON0),
-	SAVE_ITEM(S5P_VPLL_CON1),
+	SAVE_ITEM(EXYNOS4_VPLL_CON0),
+	SAVE_ITEM(EXYNOS4_VPLL_CON1),
 };
 
 static struct sleep_save exynos4_core_save[] = {
@@ -239,7 +239,7 @@ static void exynos4_restore_pll(void)
 		locktime = (3000 / pll_in_rate) * p_div;
 		lockcnt = locktime * 10000 / (10000 / pll_in_rate);
 
-		__raw_writel(lockcnt, S5P_EPLL_LOCK);
+		__raw_writel(lockcnt, EXYNOS4_EPLL_LOCK);
 
 		s3c_pm_do_restore_core(exynos4_epll_save,
 					ARRAY_SIZE(exynos4_epll_save));
@@ -257,7 +257,7 @@ static void exynos4_restore_pll(void)
 		locktime = 750;
 		lockcnt = locktime * 10000 / (10000 / pll_in_rate);
 
-		__raw_writel(lockcnt, S5P_VPLL_LOCK);
+		__raw_writel(lockcnt, EXYNOS4_VPLL_LOCK);
 
 		s3c_pm_do_restore_core(exynos4_vpll_save,
 					ARRAY_SIZE(exynos4_vpll_save));
@@ -268,14 +268,14 @@ static void exynos4_restore_pll(void)
 
 	do {
 		if (epll_wait) {
-			pll_con = __raw_readl(S5P_EPLL_CON0);
-			if (pll_con & (1 << S5P_EPLLCON0_LOCKED_SHIFT))
+			pll_con = __raw_readl(EXYNOS4_EPLL_CON0);
+			if (pll_con & (1 << EXYNOS4_EPLLCON0_LOCKED_SHIFT))
 				epll_wait = 0;
 		}
 
 		if (vpll_wait) {
-			pll_con = __raw_readl(S5P_VPLL_CON0);
-			if (pll_con & (1 << S5P_VPLLCON0_LOCKED_SHIFT))
+			pll_con = __raw_readl(EXYNOS4_VPLL_CON0);
+			if (pll_con & (1 << EXYNOS4_VPLLCON0_LOCKED_SHIFT))
 				vpll_wait = 0;
 		}
 	} while (epll_wait || vpll_wait);
-- 
1.7.4.4
