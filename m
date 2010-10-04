From: sw.youn@samsung.com (Seungwhan Youn)
Date: Mon,  4 Oct 2010 20:39:16 +0900
Subject: [PATCH 2/10] ARM: S5PC100: Modify SCLK_AUDIO{0,1,2} clock as sysclks
In-Reply-To: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1286192356-17997-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modify SCLK_AUDIO{0,1,2} to be initial as sysclks
on boot-time.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c |   72 ++++++++++++++++++++++-------------------
 1 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 084abd1..42b7138 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -848,6 +848,18 @@ struct clksrc_sources clk_src_group3 = {
 	.nr_sources	= ARRAY_SIZE(clk_src_group3_list),
 };
 
+static struct clksrc_clk clk_sclk_audio0 = {
+	.clk	= {
+		.name		= "sclk_audio",
+		.id		= 0,
+		.ctrlbit	= (1 << 8),
+		.enable		= s5pc100_sclk1_ctrl,
+	},
+	.sources = &clk_src_group3,
+	.reg_src = { .reg = S5P_CLK_SRC3, .shift = 12, .size = 3 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
+};
+
 static struct clk *clk_src_group4_list[] = {
 	[0] = &clk_mout_epll.clk,
 	[1] = &clk_div_mpll.clk,
@@ -862,6 +874,18 @@ struct clksrc_sources clk_src_group4 = {
 	.nr_sources	= ARRAY_SIZE(clk_src_group4_list),
 };
 
+static struct clksrc_clk clk_sclk_audio1 = {
+	.clk	= {
+		.name		= "sclk_audio",
+		.id		= 1,
+		.ctrlbit	= (1 << 9),
+		.enable		= s5pc100_sclk1_ctrl,
+	},
+	.sources = &clk_src_group4,
+	.reg_src = { .reg = S5P_CLK_SRC3, .shift = 16, .size = 3 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
+};
+
 static struct clk *clk_src_group5_list[] = {
 	[0] = &clk_mout_epll.clk,
 	[1] = &clk_div_mpll.clk,
@@ -875,6 +899,18 @@ struct clksrc_sources clk_src_group5 = {
 	.nr_sources	= ARRAY_SIZE(clk_src_group5_list),
 };
 
+static struct clksrc_clk clk_sclk_audio2 = {
+	.clk	= {
+		.name		= "sclk_audio",
+		.id		= 2,
+		.ctrlbit	= (1 << 10),
+		.enable		= s5pc100_sclk1_ctrl,
+	},
+	.sources = &clk_src_group5,
+	.reg_src = { .reg = S5P_CLK_SRC3, .shift = 20, .size = 3 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4 },
+};
+
 static struct clk *clk_src_group6_list[] = {
 	[0] = &s5p_clk_27m,
 	[1] = &clk_vclk54m,
@@ -1001,39 +1037,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 28, .size = 2 },
 	}, {
 		.clk	= {
-			.name		= "sclk_audio",
-			.id		= 0,
-			.ctrlbit	= (1 << 8),
-			.enable		= s5pc100_sclk1_ctrl,
-
-		},
-		.sources = &clk_src_group3,
-		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 12, .size = 3 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_audio",
-			.id		= 1,
-			.ctrlbit	= (1 << 9),
-			.enable		= s5pc100_sclk1_ctrl,
-
-		},
-		.sources = &clk_src_group4,
-		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 16, .size = 3 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_audio",
-			.id		= 2,
-			.ctrlbit	= (1 << 10),
-			.enable		= s5pc100_sclk1_ctrl,
-
-		},
-		.sources = &clk_src_group5,
-		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 20, .size = 3 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "sclk_lcd",
 			.id		= -1,
 			.ctrlbit	= (1 << 0),
@@ -1179,6 +1182,9 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_div_pclkd1,
 	&clk_div_cam,
 	&clk_div_hdmi,
+	&clk_sclk_audio0,
+	&clk_sclk_audio1,
+	&clk_sclk_audio2,
 };
 
 void __init_or_cpufreq s5pc100_setup_clocks(void)
-- 
1.6.2.5
