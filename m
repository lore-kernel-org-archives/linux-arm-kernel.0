From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 02 Aug 2010 11:51:32 +0900
Subject: [PATCH v2] ARM: S5PV210: clksrc-clk: wait for the stable SRC/DIV
	fields added.
Message-ID: <1280717492-32377-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch, clk_set_rate and clk_set_parent returns with stabilized
clocks for non-glitch muxs and divs.

This patch requires the following two patches.

1. V3 patch of "ARM: Samsung SoC: clksrc-clk: wait for the stable
SRC/DIV status.", which has stable SRC/DIV support for Samsung SoC.

2. "ARM: S5PV210: macros for clock registers at regs-clock.h" included
in CPUFREQ patch, which has definitions for S5P_CLK_MUX_STAT0,
S5P_CLK_MUX_STAT1, S5P_CLK_DIV_STAT0, and S5P_CLK_DIV_STAT1.

--
v2:
	- clock-clksrc definitions updataed due to struct clksrc-clk
	  changes of patch v3.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   84 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 04a0ef9..59953ef 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -38,6 +38,7 @@ static struct clksrc_clk clk_mout_apll = {
 	},
 	.sources	= &clk_src_apll,
 	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
+	.reg_src_stable = { .reg = S5P_CLK_MUX_STAT0, .shift = 2, .stable = 0 },
 };
 
 static struct clksrc_clk clk_mout_epll = {
@@ -47,6 +48,8 @@ static struct clksrc_clk clk_mout_epll = {
 	},
 	.sources	= &clk_src_epll,
 	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
+	.reg_src_stable = { .reg = S5P_CLK_MUX_STAT0,
+		.shift = 10, .stable = 0 },
 };
 
 static struct clksrc_clk clk_mout_mpll = {
@@ -56,6 +59,7 @@ static struct clksrc_clk clk_mout_mpll = {
 	},
 	.sources	= &clk_src_mpll,
 	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
+	.reg_src_stable = { .reg = S5P_CLK_MUX_STAT0, .shift = 6, .stable = 0 },
 };
 
 static struct clk *clkset_armclk_list[] = {
@@ -75,7 +79,10 @@ static struct clksrc_clk clk_armclk = {
 	},
 	.sources	= &clkset_armclk,
 	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 16, .size = 1 },
+	.reg_src_stable = { .reg = S5P_CLK_MUX_STAT0,
+		.shift = 18, .stable = 0 },
 	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 0, .size = 3 },
+	.reg_div_stable = { .reg = S5P_CLK_DIV_STAT0, .shift = 0, .stable = 0 },
 };
 
 static struct clksrc_clk clk_hclk_msys = {
@@ -85,6 +92,7 @@ static struct clksrc_clk clk_hclk_msys = {
 		.parent		= &clk_armclk.clk,
 	},
 	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 8, .size = 3 },
+	.reg_div_stable = { .reg = S5P_CLK_DIV_STAT0, .shift = 2, .stable = 0 },
 };
 
 static struct clksrc_clk clk_pclk_msys = {
@@ -94,6 +102,7 @@ static struct clksrc_clk clk_pclk_msys = {
 		.parent		= &clk_hclk_msys.clk,
 	},
 	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 12, .size = 3 },
+	.reg_div_stable = { .reg = S5P_CLK_DIV_STAT0, .shift = 3, .stable = 0 },
 };
 
 static struct clksrc_clk clk_sclk_a2m = {
@@ -103,6 +112,7 @@ static struct clksrc_clk clk_sclk_a2m = {
 		.parent		= &clk_mout_apll.clk,
 	},
 	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 4, .size = 3 },
+	.reg_div_stable = { .reg = S5P_CLK_DIV_STAT0, .shift = 1, .stable = 0 },
 };
 
 static struct clk *clkset_hclk_sys_list[] = {
@@ -122,7 +132,10 @@ static struct clksrc_clk clk_hclk_dsys = {
 	},
 	.sources	= &clkset_hclk_sys,
 	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 20, .size = 1 },
+	.reg_src_stable = { .reg = S5P_CLK_MUX_STAT0,
+		.shift = 22, .stable = 0 },
 	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 16, .size = 4 },
+	.reg_div_stable = { .reg = S5P_CLK_DIV_STAT0, .shift = 4, .stable = 0 },
 };
 
 static struct clksrc_clk clk_pclk_dsys = {
@@ -132,6 +145,7 @@ static struct clksrc_clk clk_pclk_dsys = {
 		.parent	= &clk_hclk_dsys.clk,
 	},
 	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 20, .size = 3 },
+	.reg_div_stable = { .reg = S5P_CLK_DIV_STAT0, .shift = 5, .stable = 0 },
 };
 
 static struct clksrc_clk clk_hclk_psys = {
@@ -141,7 +155,10 @@ static struct clksrc_clk clk_hclk_psys = {
 	},
 	.sources	= &clkset_hclk_sys,
 	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 24, .size = 1 },
+	.reg_src_stable = { .reg = S5P_CLK_MUX_STAT0,
+		.shift = 26, .stable = 0 },
 	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 24, .size = 4 },
+	.reg_div_stable = { .reg = S5P_CLK_DIV_STAT0, .shift = 6, .stable = 0 },
 };
 
 static struct clksrc_clk clk_pclk_psys = {
@@ -151,6 +168,7 @@ static struct clksrc_clk clk_pclk_psys = {
 		.parent	= &clk_hclk_psys.clk,
 	},
 	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 28, .size = 3 },
+	.reg_div_stable = { .reg = S5P_CLK_DIV_STAT0, .shift = 7, .stable = 0 },
 };
 
 static int s5pv210_clk_ip0_ctrl(struct clk *clk, int enable)
@@ -262,6 +280,7 @@ static struct clksrc_clk clk_sclk_vpll = {
 	},
 	.sources	= &clkset_sclk_vpll,
 	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 12, .size = 1 },
+	.reg_src	= { .reg = S5P_CLK_MUX_STAT0, .shift = 14, .size = 0 },
 };
 
 static unsigned long s5pv210_clk_imem_get_rate(struct clk *clk)
@@ -812,6 +831,7 @@ static struct clksrc_clk clk_sclk_pixel = {
 		.parent		= &clk_sclk_vpll.clk,
 	},
 	.reg_div	= { .reg = S5P_CLK_DIV1, .shift = 0, .size = 4},
+	.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0, .shift = 8, .stable = 0},
 };
 
 static struct clk *clkset_sclk_hdmi_list[] = {
@@ -872,6 +892,7 @@ static struct clksrc_clk clk_sclk_audio0 = {
 	.sources = &clkset_sclk_audio0,
 	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 0, .size = 4 },
 	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 0, .size = 4 },
+	.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1, .shift = 8, .stable = 0 },
 };
 
 static struct clk *clkset_sclk_audio1_list[] = {
@@ -901,6 +922,7 @@ static struct clksrc_clk clk_sclk_audio1 = {
 	.sources = &clkset_sclk_audio1,
 	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 4, .size = 4 },
 	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 4, .size = 4 },
+	.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1, .shift = 9, .stable = 0 },
 };
 
 static struct clk *clkset_sclk_audio2_list[] = {
@@ -930,6 +952,8 @@ static struct clksrc_clk clk_sclk_audio2 = {
 	.sources = &clkset_sclk_audio2,
 	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 8, .size = 4 },
 	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 8, .size = 4 },
+	.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1,
+		.shift = 10, .stable = 0 },
 };
 
 static struct clk *clkset_sclk_spdif_list[] = {
@@ -968,7 +992,11 @@ static struct clksrc_clk clksrcs[] = {
 		},
 		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
+		.reg_src_stable	= { .reg = S5P_CLK_MUX_STAT1,
+			.shift = 31, .stable = 0 },
 		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1,
+			.shift = 15, .stable = 0 },
 	}, {
 		.clk	= {
 			.name		= "sclk_onenand",
@@ -976,7 +1004,11 @@ static struct clksrc_clk clksrcs[] = {
 		},
 		.sources = &clkset_sclk_onenand,
 		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 28, .size = 1 },
+		.reg_src_stable	= { .reg = S5P_CLK_MUX_STAT0,
+			.shift = 30, .stable = 0 },
 		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 12, .size = 3 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1,
+			.shift = 11, .stable = 0 },
 	}, {
 		.clk	= {
 			.name		= "uclk1",
@@ -986,7 +1018,11 @@ static struct clksrc_clk clksrcs[] = {
 		},
 		.sources = &clkset_uart,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
+		.reg_src_stable	= { .reg = S5P_CLK_MUX_STAT0,
+			.shift = 30, .stable = 0 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 28, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "uclk1",
@@ -997,6 +1033,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_uart,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 20, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 29, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "uclk1",
@@ -1007,6 +1045,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_uart,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 24, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 24, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 30, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "uclk1",
@@ -1017,6 +1057,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_uart,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 28, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 28, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 31, .stable = 0 },
 	}, {
 		.clk	= {
 			.name		= "sclk_mixer",
@@ -1045,6 +1087,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 12, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 12, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 20, .stable = 0 },
 	}, {
 		.clk	= {
 			.name		= "sclk_fimc",
@@ -1055,6 +1099,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 16, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 16, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 21, .stable = 0 },
 	}, {
 		.clk	= {
 			.name		= "sclk_fimc",
@@ -1065,6 +1111,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 20, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 20, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 22, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_cam",
@@ -1075,6 +1123,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 12, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 11, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_cam",
@@ -1085,6 +1135,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 16, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 16, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 12, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_fimd",
@@ -1095,6 +1147,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 20, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 20, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 13, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
@@ -1105,6 +1159,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 0, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 0, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 24, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
@@ -1115,6 +1171,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 4, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 25, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
@@ -1125,6 +1183,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 8, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 8, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 26, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
@@ -1135,6 +1195,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 12, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 27, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_mfc",
@@ -1144,7 +1206,11 @@ static struct clksrc_clk clksrcs[] = {
 		},
 		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 4, .size = 2 },
+		.reg_src_stable	= { .reg = S5P_CLK_MUX_STAT1,
+			.shift = 7, .stable = 0 },
 		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 17, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_g2d",
@@ -1154,7 +1220,11 @@ static struct clksrc_clk clksrcs[] = {
 		},
 		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 8, .size = 2 },
+		.reg_src_stable = { .reg = S5P_CLK_MUX_STAT1,
+			.shift = 27, .stable = 0 },
 		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 8, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1,
+			.shift = 20, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_g3d",
@@ -1164,7 +1234,11 @@ static struct clksrc_clk clksrcs[] = {
 		},
 		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 0, .size = 2 },
+		.reg_src_stable	= { .reg = S5P_CLK_MUX_STAT1,
+			.shift = 3, .stable = 0 },
 		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 16, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_csis",
@@ -1175,6 +1249,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 24, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 28, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT0,
+			.shift = 15, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_spi",
@@ -1185,6 +1261,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 0, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 0, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1,
+			.shift = 0, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_spi",
@@ -1195,6 +1273,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 4, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 4, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1,
+			.shift = 1, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_pwi",
@@ -1205,6 +1285,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 20, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 24, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1,
+			.shift = 14, .stable = 0 },
 	}, {
 		.clk		= {
 			.name		= "sclk_pwm",
@@ -1215,6 +1297,8 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 12, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 12, .size = 4 },
+		.reg_div_stable	= { .reg = S5P_CLK_DIV_STAT1,
+			.shift = 3, .stable = 0 },
 	},
 };
 
-- 
1.6.3.3
