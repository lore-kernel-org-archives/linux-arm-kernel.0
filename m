From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 10 Mar 2012 02:19:05 -0800
Subject: [PATCH 1/5] ARM: EXYNOS: replace clock.c for other new EXYNOS SoCs
In-Reply-To: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
References: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1331374749-23256-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the name of clock.c to clock-exynos4.c for other
EXYNOS series such as EXYNOS5. And since the header file of clock
is used only in arch/arm/mach-exynos, moves it in the local directory.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Makefile                      |    3 +-
 arch/arm/mach-exynos/{clock.c => clock-exynos4.c}  |  173 ++++++++++----------
 .../mach/exynos4-clock.h => clock-exynos4.h}       |    1 -
 arch/arm/mach-exynos/clock-exynos4210.c            |    2 +-
 arch/arm/mach-exynos/clock-exynos4212.c            |    2 +-
 5 files changed, 90 insertions(+), 91 deletions(-)
 rename arch/arm/mach-exynos/{clock.c => clock-exynos4.c} (92%)
 rename arch/arm/mach-exynos/{include/mach/exynos4-clock.h => clock-exynos4.h} (95%)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 5fc202c..995e7cc 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -12,7 +12,8 @@ obj-				:=
 
 # Core
 
-obj-$(CONFIG_ARCH_EXYNOS4)	+= common.o clock.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
+obj-$(CONFIG_ARCH_EXYNOS4)	+= clock-exynos4.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
 
diff --git a/arch/arm/mach-exynos/clock.c b/arch/arm/mach-exynos/clock-exynos4.c
similarity index 92%
rename from arch/arm/mach-exynos/clock.c
rename to arch/arm/mach-exynos/clock-exynos4.c
index 187287a..1d6d64f 100644
--- a/arch/arm/mach-exynos/clock.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-exynos4/clock.c
- *
+/*
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
@@ -26,9 +25,9 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/sysmmu.h>
-#include <mach/exynos4-clock.h>
 
 #include "common.h"
+#include "clock-exynos4.h"
 
 #ifdef CONFIG_PM_SLEEP
 static struct sleep_save exynos4_clock_save[] = {
@@ -215,8 +214,8 @@ static struct clksrc_clk clk_mout_apll = {
 	.clk	= {
 		.name		= "mout_apll",
 	},
-	.sources	= &clk_src_apll,
-	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 0, .size = 1 },
+	.sources = &clk_src_apll,
+	.reg_src = { .reg = S5P_CLKSRC_CPU, .shift = 0, .size = 1 },
 };
 
 struct clksrc_clk clk_sclk_apll = {
@@ -224,22 +223,22 @@ struct clksrc_clk clk_sclk_apll = {
 		.name		= "sclk_apll",
 		.parent		= &clk_mout_apll.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 24, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 24, .size = 3 },
 };
 
 struct clksrc_clk clk_mout_epll = {
 	.clk	= {
 		.name		= "mout_epll",
 	},
-	.sources	= &clk_src_epll,
-	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 4, .size = 1 },
+	.sources = &clk_src_epll,
+	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 4, .size = 1 },
 };
 
 struct clksrc_clk clk_mout_mpll = {
-	.clk = {
+	.clk	= {
 		.name		= "mout_mpll",
 	},
-	.sources	= &clk_src_mpll,
+	.sources = &clk_src_mpll,
 
 	/* reg_src will be added in each SoCs' clock */
 };
@@ -258,8 +257,8 @@ static struct clksrc_clk clk_moutcore = {
 	.clk	= {
 		.name		= "moutcore",
 	},
-	.sources	= &clkset_moutcore,
-	.reg_src	= { .reg = S5P_CLKSRC_CPU, .shift = 16, .size = 1 },
+	.sources = &clkset_moutcore,
+	.reg_src = { .reg = S5P_CLKSRC_CPU, .shift = 16, .size = 1 },
 };
 
 static struct clksrc_clk clk_coreclk = {
@@ -267,7 +266,7 @@ static struct clksrc_clk clk_coreclk = {
 		.name		= "core_clk",
 		.parent		= &clk_moutcore.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 0, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 0, .size = 3 },
 };
 
 static struct clksrc_clk clk_armclk = {
@@ -282,7 +281,7 @@ static struct clksrc_clk clk_aclk_corem0 = {
 		.name		= "aclk_corem0",
 		.parent		= &clk_coreclk.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
 };
 
 static struct clksrc_clk clk_aclk_cores = {
@@ -290,7 +289,7 @@ static struct clksrc_clk clk_aclk_cores = {
 		.name		= "aclk_cores",
 		.parent		= &clk_coreclk.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
 };
 
 static struct clksrc_clk clk_aclk_corem1 = {
@@ -298,7 +297,7 @@ static struct clksrc_clk clk_aclk_corem1 = {
 		.name		= "aclk_corem1",
 		.parent		= &clk_coreclk.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 8, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 8, .size = 3 },
 };
 
 static struct clksrc_clk clk_periphclk = {
@@ -306,7 +305,7 @@ static struct clksrc_clk clk_periphclk = {
 		.name		= "periphclk",
 		.parent		= &clk_coreclk.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 12, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 12, .size = 3 },
 };
 
 /* Core list of CMU_CORE side */
@@ -325,8 +324,8 @@ static struct clksrc_clk clk_mout_corebus = {
 	.clk	= {
 		.name		= "mout_corebus",
 	},
-	.sources	= &clkset_mout_corebus,
-	.reg_src	= { .reg = S5P_CLKSRC_DMC, .shift = 4, .size = 1 },
+	.sources = &clkset_mout_corebus,
+	.reg_src = { .reg = S5P_CLKSRC_DMC, .shift = 4, .size = 1 },
 };
 
 static struct clksrc_clk clk_sclk_dmc = {
@@ -334,7 +333,7 @@ static struct clksrc_clk clk_sclk_dmc = {
 		.name		= "sclk_dmc",
 		.parent		= &clk_mout_corebus.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 12, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 12, .size = 3 },
 };
 
 static struct clksrc_clk clk_aclk_cored = {
@@ -342,7 +341,7 @@ static struct clksrc_clk clk_aclk_cored = {
 		.name		= "aclk_cored",
 		.parent		= &clk_sclk_dmc.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 16, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 16, .size = 3 },
 };
 
 static struct clksrc_clk clk_aclk_corep = {
@@ -350,7 +349,7 @@ static struct clksrc_clk clk_aclk_corep = {
 		.name		= "aclk_corep",
 		.parent		= &clk_aclk_cored.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 20, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 20, .size = 3 },
 };
 
 static struct clksrc_clk clk_aclk_acp = {
@@ -358,7 +357,7 @@ static struct clksrc_clk clk_aclk_acp = {
 		.name		= "aclk_acp",
 		.parent		= &clk_mout_corebus.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 0, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 0, .size = 3 },
 };
 
 static struct clksrc_clk clk_pclk_acp = {
@@ -366,7 +365,7 @@ static struct clksrc_clk clk_pclk_acp = {
 		.name		= "pclk_acp",
 		.parent		= &clk_aclk_acp.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 4, .size = 3 },
+	.reg_div = { .reg = S5P_CLKDIV_DMC0, .shift = 4, .size = 3 },
 };
 
 /* Core list of CMU_TOP side */
@@ -385,36 +384,36 @@ static struct clksrc_clk clk_aclk_200 = {
 	.clk	= {
 		.name		= "aclk_200",
 	},
-	.sources	= &clkset_aclk,
-	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 12, .size = 1 },
-	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 0, .size = 3 },
+	.sources = &clkset_aclk,
+	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 12, .size = 1 },
+	.reg_div = { .reg = S5P_CLKDIV_TOP, .shift = 0, .size = 3 },
 };
 
 static struct clksrc_clk clk_aclk_100 = {
 	.clk	= {
 		.name		= "aclk_100",
 	},
-	.sources	= &clkset_aclk,
-	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 16, .size = 1 },
-	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 4, .size = 4 },
+	.sources = &clkset_aclk,
+	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 16, .size = 1 },
+	.reg_div = { .reg = S5P_CLKDIV_TOP, .shift = 4, .size = 4 },
 };
 
 static struct clksrc_clk clk_aclk_160 = {
 	.clk	= {
 		.name		= "aclk_160",
 	},
-	.sources	= &clkset_aclk,
-	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 20, .size = 1 },
-	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 8, .size = 3 },
+	.sources = &clkset_aclk,
+	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 20, .size = 1 },
+	.reg_div = { .reg = S5P_CLKDIV_TOP, .shift = 8, .size = 3 },
 };
 
 struct clksrc_clk clk_aclk_133 = {
 	.clk	= {
 		.name		= "aclk_133",
 	},
-	.sources	= &clkset_aclk,
-	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 24, .size = 1 },
-	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 12, .size = 3 },
+	.sources = &clkset_aclk,
+	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 24, .size = 1 },
+	.reg_div = { .reg = S5P_CLKDIV_TOP, .shift = 12, .size = 3 },
 };
 
 static struct clk *clkset_vpllsrc_list[] = {
@@ -433,8 +432,8 @@ static struct clksrc_clk clk_vpllsrc = {
 		.enable		= exynos4_clksrc_mask_top_ctrl,
 		.ctrlbit	= (1 << 0),
 	},
-	.sources	= &clkset_vpllsrc,
-	.reg_src	= { .reg = S5P_CLKSRC_TOP1, .shift = 0, .size = 1 },
+	.sources = &clkset_vpllsrc,
+	.reg_src = { .reg = S5P_CLKSRC_TOP1, .shift = 0, .size = 1 },
 };
 
 static struct clk *clkset_sclk_vpll_list[] = {
@@ -451,8 +450,8 @@ struct clksrc_clk clk_sclk_vpll = {
 	.clk	= {
 		.name		= "sclk_vpll",
 	},
-	.sources	= &clkset_sclk_vpll,
-	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 8, .size = 1 },
+	.sources = &clkset_sclk_vpll,
+	.reg_src = { .reg = S5P_CLKSRC_TOP0, .shift = 8, .size = 1 },
 };
 
 static struct clk init_clocks_off[] = {
@@ -816,8 +815,8 @@ static struct clksrc_clk clk_mout_g2d0 = {
 	.clk	= {
 		.name		= "mout_g2d0",
 	},
-	.sources	= &clkset_mout_g2d0,
-	.reg_src	= { .reg = S5P_CLKSRC_IMAGE, .shift = 0, .size = 1 },
+	.sources = &clkset_mout_g2d0,
+	.reg_src = { .reg = S5P_CLKSRC_IMAGE, .shift = 0, .size = 1 },
 };
 
 static struct clk *clkset_mout_g2d1_list[] = {
@@ -834,8 +833,8 @@ static struct clksrc_clk clk_mout_g2d1 = {
 	.clk	= {
 		.name		= "mout_g2d1",
 	},
-	.sources	= &clkset_mout_g2d1,
-	.reg_src	= { .reg = S5P_CLKSRC_IMAGE, .shift = 4, .size = 1 },
+	.sources = &clkset_mout_g2d1,
+	.reg_src = { .reg = S5P_CLKSRC_IMAGE, .shift = 4, .size = 1 },
 };
 
 static struct clk *clkset_mout_g2d_list[] = {
@@ -862,8 +861,8 @@ static struct clksrc_clk clk_mout_mfc0 = {
 	.clk	= {
 		.name		= "mout_mfc0",
 	},
-	.sources	= &clkset_mout_mfc0,
-	.reg_src	= { .reg = S5P_CLKSRC_MFC, .shift = 0, .size = 1 },
+	.sources = &clkset_mout_mfc0,
+	.reg_src = { .reg = S5P_CLKSRC_MFC, .shift = 0, .size = 1 },
 };
 
 static struct clk *clkset_mout_mfc1_list[] = {
@@ -880,8 +879,8 @@ static struct clksrc_clk clk_mout_mfc1 = {
 	.clk	= {
 		.name		= "mout_mfc1",
 	},
-	.sources	= &clkset_mout_mfc1,
-	.reg_src	= { .reg = S5P_CLKSRC_MFC, .shift = 4, .size = 1 },
+	.sources = &clkset_mout_mfc1,
+	.reg_src = { .reg = S5P_CLKSRC_MFC, .shift = 4, .size = 1 },
 };
 
 static struct clk *clkset_mout_mfc_list[] = {
@@ -917,7 +916,7 @@ static struct clksrc_clk clk_sclk_dac = {
 static struct clksrc_clk clk_sclk_pixel = {
 	.clk		= {
 		.name		= "sclk_pixel",
-		.parent = &clk_sclk_vpll.clk,
+		.parent		= &clk_sclk_vpll.clk,
 	},
 	.reg_div = { .reg = S5P_CLKDIV_TV, .shift = 0, .size = 4 },
 };
@@ -953,7 +952,7 @@ static struct clksrc_sources clkset_sclk_mixer = {
 };
 
 static struct clksrc_clk clk_sclk_mixer = {
-	.clk		= {
+	.clk	= {
 		.name		= "sclk_mixer",
 		.enable		= exynos4_clksrc_mask_tv_ctrl,
 		.ctrlbit	= (1 << 4),
@@ -970,7 +969,7 @@ static struct clksrc_clk *sclk_tv[] = {
 };
 
 static struct clksrc_clk clk_dout_mmc0 = {
-	.clk		= {
+	.clk	= {
 		.name		= "dout_mmc0",
 	},
 	.sources = &clkset_group,
@@ -979,7 +978,7 @@ static struct clksrc_clk clk_dout_mmc0 = {
 };
 
 static struct clksrc_clk clk_dout_mmc1 = {
-	.clk		= {
+	.clk	= {
 		.name		= "dout_mmc1",
 	},
 	.sources = &clkset_group,
@@ -988,7 +987,7 @@ static struct clksrc_clk clk_dout_mmc1 = {
 };
 
 static struct clksrc_clk clk_dout_mmc2 = {
-	.clk		= {
+	.clk	= {
 		.name		= "dout_mmc2",
 	},
 	.sources = &clkset_group,
@@ -997,7 +996,7 @@ static struct clksrc_clk clk_dout_mmc2 = {
 };
 
 static struct clksrc_clk clk_dout_mmc3 = {
-	.clk		= {
+	.clk	= {
 		.name		= "dout_mmc3",
 	},
 	.sources = &clkset_group,
@@ -1016,7 +1015,7 @@ static struct clksrc_clk clk_dout_mmc4 = {
 
 static struct clksrc_clk clksrcs[] = {
 	{
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_pwm",
 			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 24),
@@ -1025,7 +1024,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 24, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_PERIL3, .shift = 0, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_csis",
 			.devname	= "s5p-mipi-csis.0",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
@@ -1035,7 +1034,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 24, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 24, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_csis",
 			.devname	= "s5p-mipi-csis.1",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
@@ -1045,7 +1044,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 28, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 28, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_cam0",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 16),
@@ -1054,7 +1053,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 16, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 16, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_cam1",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 20),
@@ -1063,7 +1062,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 20, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 20, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_fimc",
 			.devname	= "exynos4-fimc.0",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
@@ -1073,7 +1072,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 0, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 0, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_fimc",
 			.devname	= "exynos4-fimc.1",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
@@ -1083,7 +1082,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 4, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 4, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_fimc",
 			.devname	= "exynos4-fimc.2",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
@@ -1093,7 +1092,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 8, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 8, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_fimc",
 			.devname	= "exynos4-fimc.3",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
@@ -1103,7 +1102,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 12, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 12, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_fimd",
 			.devname	= "exynos4-fb.0",
 			.enable		= exynos4_clksrc_mask_lcd0_ctrl,
@@ -1113,14 +1112,14 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_LCD0, .shift = 0, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_LCD0, .shift = 0, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_fimg2d",
 		},
 		.sources = &clkset_mout_g2d,
 		.reg_src = { .reg = S5P_CLKSRC_IMAGE, .shift = 8, .size = 1 },
 		.reg_div = { .reg = S5P_CLKDIV_IMAGE, .shift = 0, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_mfc",
 			.devname	= "s5p-mfc",
 		},
@@ -1128,9 +1127,9 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLKSRC_MFC, .shift = 8, .size = 1 },
 		.reg_div = { .reg = S5P_CLKDIV_MFC, .shift = 0, .size = 4 },
 	}, {
-		.clk		= {
+		.clk	= {
 			.name		= "sclk_dwmmc",
-			.parent         = &clk_dout_mmc4.clk,
+			.parent		= &clk_dout_mmc4.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 16),
 		},
@@ -1151,7 +1150,7 @@ static struct clksrc_clk clk_sclk_uart0 = {
 };
 
 static struct clksrc_clk clk_sclk_uart1 = {
-	.clk		= {
+	.clk	= {
 		.name		= "uclk1",
 		.devname	= "exynos4210-uart.1",
 		.enable		= exynos4_clksrc_mask_peril0_ctrl,
@@ -1163,7 +1162,7 @@ static struct clksrc_clk clk_sclk_uart1 = {
 };
 
 static struct clksrc_clk clk_sclk_uart2 = {
-	.clk		= {
+	.clk	= {
 		.name		= "uclk1",
 		.devname	= "exynos4210-uart.2",
 		.enable		= exynos4_clksrc_mask_peril0_ctrl,
@@ -1175,7 +1174,7 @@ static struct clksrc_clk clk_sclk_uart2 = {
 };
 
 static struct clksrc_clk clk_sclk_uart3 = {
-	.clk		= {
+	.clk	= {
 		.name		= "uclk1",
 		.devname	= "exynos4210-uart.3",
 		.enable		= exynos4_clksrc_mask_peril0_ctrl,
@@ -1187,7 +1186,7 @@ static struct clksrc_clk clk_sclk_uart3 = {
 };
 
 static struct clksrc_clk clk_sclk_mmc0 = {
-	.clk		= {
+	.clk	= {
 		.name		= "sclk_mmc",
 		.devname	= "s3c-sdhci.0",
 		.parent		= &clk_dout_mmc0.clk,
@@ -1198,10 +1197,10 @@ static struct clksrc_clk clk_sclk_mmc0 = {
 };
 
 static struct clksrc_clk clk_sclk_mmc1 = {
-	.clk		= {
+	.clk	= {
 		.name		= "sclk_mmc",
 		.devname	= "s3c-sdhci.1",
-		.parent         = &clk_dout_mmc1.clk,
+		.parent		= &clk_dout_mmc1.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 4),
 	},
@@ -1209,10 +1208,10 @@ static struct clksrc_clk clk_sclk_mmc1 = {
 };
 
 static struct clksrc_clk clk_sclk_mmc2 = {
-	.clk		= {
+	.clk	= {
 		.name		= "sclk_mmc",
 		.devname	= "s3c-sdhci.2",
-		.parent         = &clk_dout_mmc2.clk,
+		.parent		= &clk_dout_mmc2.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 8),
 	},
@@ -1220,10 +1219,10 @@ static struct clksrc_clk clk_sclk_mmc2 = {
 };
 
 static struct clksrc_clk clk_sclk_mmc3 = {
-	.clk		= {
+	.clk	= {
 		.name		= "sclk_mmc",
 		.devname	= "s3c-sdhci.3",
-		.parent         = &clk_dout_mmc3.clk,
+		.parent		= &clk_dout_mmc3.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 12),
 	},
@@ -1231,11 +1230,11 @@ static struct clksrc_clk clk_sclk_mmc3 = {
 };
 
 static struct clksrc_clk clk_sclk_spi0 = {
-	.clk		= {
+	.clk	= {
 		.name		= "sclk_spi",
-		.devname		= "s3c64xx-spi.0",
+		.devname	= "s3c64xx-spi.0",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
-		.ctrlbit		= (1 << 16),
+		.ctrlbit	= (1 << 16),
 	},
 	.sources = &clkset_group,
 	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 16, .size = 4 },
@@ -1243,11 +1242,11 @@ static struct clksrc_clk clk_sclk_spi0 = {
 };
 
 static struct clksrc_clk clk_sclk_spi1 = {
-	.clk		= {
+	.clk	= {
 		.name		= "sclk_spi",
-		.devname		= "s3c64xx-spi.1",
+		.devname	= "s3c64xx-spi.1",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
-		.ctrlbit		= (1 << 20),
+		.ctrlbit	= (1 << 20),
 	},
 	.sources = &clkset_group,
 	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 20, .size = 4 },
@@ -1255,11 +1254,11 @@ static struct clksrc_clk clk_sclk_spi1 = {
 };
 
 static struct clksrc_clk clk_sclk_spi2 = {
-	.clk		= {
+	.clk	= {
 		.name		= "sclk_spi",
-		.devname		= "s3c64xx-spi.2",
+		.devname	= "s3c64xx-spi.2",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
-		.ctrlbit		= (1 << 24),
+		.ctrlbit	= (1 << 24),
 	},
 	.sources = &clkset_group,
 	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 24, .size = 4 },
diff --git a/arch/arm/mach-exynos/include/mach/exynos4-clock.h b/arch/arm/mach-exynos/clock-exynos4.h
similarity index 95%
rename from arch/arm/mach-exynos/include/mach/exynos4-clock.h
rename to arch/arm/mach-exynos/clock-exynos4.h
index a07fcbf..f64e9f7 100644
--- a/arch/arm/mach-exynos/include/mach/exynos4-clock.h
+++ b/arch/arm/mach-exynos/clock-exynos4.h
@@ -1,5 +1,4 @@
 /*
- * linux/arch/arm/mach-exynos4/include/mach/exynos4-clock.h
  *
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/arch/arm/mach-exynos/clock-exynos4210.c b/arch/arm/mach-exynos/clock-exynos4210.c
index 13312cc..190d94a 100644
--- a/arch/arm/mach-exynos/clock-exynos4210.c
+++ b/arch/arm/mach-exynos/clock-exynos4210.c
@@ -28,9 +28,9 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
-#include <mach/exynos4-clock.h>
 
 #include "common.h"
+#include "clock-exynos4.h"
 
 #ifdef CONFIG_PM_SLEEP
 static struct sleep_save exynos4210_clock_save[] = {
diff --git a/arch/arm/mach-exynos/clock-exynos4212.c b/arch/arm/mach-exynos/clock-exynos4212.c
index 48af285..e83d4b2 100644
--- a/arch/arm/mach-exynos/clock-exynos4212.c
+++ b/arch/arm/mach-exynos/clock-exynos4212.c
@@ -28,9 +28,9 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
-#include <mach/exynos4-clock.h>
 
 #include "common.h"
+#include "clock-exynos4.h"
 
 #ifdef CONFIG_PM_SLEEP
 static struct sleep_save exynos4212_clock_save[] = {
-- 
1.7.4.4
