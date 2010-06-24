From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 24 Jun 2010 14:18:07 +0900
Subject: [PATCH v4] S5PV210 Correct clock register properties
Message-ID: <1277356687-9500-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Corrected shift values of I2S and UART clocks (CLK_GATE_IP3), which were
defined incorrectly.

2. Corrected shift values of sclk_audio, uclk1, sclk_fimd, sclk_mmc,
sclk_spi, sclk_pwm, which had duplicated .enable/.ctrlbit with their
twins defined in struct clk init_clocks_disable[] and struct clk
init_clocks[]. We've changed their .enable/.ctrlbit to use CLK_SRC_MASK
register to avoid the duplicated clock problem described below.

--- Duplicated Clock Problem ---
Please note that each clock definition should access different control
register; otherwise, the system may suffer lockups. For example, if we
have two clock definitions "a" and "b" which access the same register
(and the shift value). Then, when we do:

	module A
	clk = clk_get("a");
	clk->clk_enable(clk);

	module B (context switch)
	clk = clk_get("b");
	clk->clk_enable(clk);
	do something with clk.
	clk->clk_disable(clk);

	module A (context switch)
	do something with clk
	* At this point, the system may hang.

Therefore, there should be no clock definitions with the same contol
register/shift. If we need to create "aliases", then, creating child
clocks sharing the clock should be fine.

3. Corrected other sclk_* shift values and access registers.


Note that becuase UART clocks are properly disabled at boot time with
this patch, UART drivers or somebody else should turn on the clock
to read the console; otherwise, JIG willl not show any message.


Note that this patch revises and merges the two previous patches:
[PATCH] S5PV210 Correct clock register properties
[PATCH] S5PV210 Correct clock source control register properties
And follows the previous patch
[PATCH v2] S5PV210 Correct clock register properties
[PATCH v3] S5PV210 Correct clock register properties


Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |  115 ++++++++++++++++++++++-------------------
 1 files changed, 62 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 154bca4..b3d156c 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -183,6 +183,11 @@ static int s5pv210_clk_mask0_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLK_SRC_MASK0, clk, enable);
 }
 
+static int s5pv210_clk_mask1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLK_SRC_MASK1, clk, enable);
+}
+
 static struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
 	.id		= -1,
@@ -406,14 +411,14 @@ static struct clk init_clocks_disable[] = {
 		.id		= 0,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<4),
+		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "i2s_v32",
 		.id		= 1,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<4),
-	}
+		.ctrlbit	= (1 << 6),
+	},
 };
 
 static struct clk init_clocks[] = {
@@ -429,25 +434,25 @@ static struct clk init_clocks[] = {
 		.id		= 0,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<7),
+		.ctrlbit	= (1 << 17),
 	}, {
 		.name		= "uart",
 		.id		= 1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<8),
+		.ctrlbit	= (1 << 18),
 	}, {
 		.name		= "uart",
 		.id		= 2,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<9),
+		.ctrlbit	= (1 << 19),
 	}, {
 		.name		= "uart",
 		.id		= 3,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<10),
+		.ctrlbit	= (1 << 20),
 	},
 };
 
@@ -497,8 +502,8 @@ static struct clksrc_clk clk_sclk_dac = {
 	.clk		= {
 		.name		= "sclk_dac",
 		.id		= -1,
-		.ctrlbit	= (1 << 10),
-		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 2),
+		.enable		= s5pv210_clk_mask0_ctrl,
 	},
 	.sources	= &clkset_sclk_dac,
 	.reg_src	= { .reg = S5P_CLK_SRC1, .shift = 8, .size = 1 },
@@ -527,8 +532,8 @@ static struct clksrc_clk clk_sclk_hdmi = {
 	.clk		= {
 		.name		= "sclk_hdmi",
 		.id		= -1,
-		.enable		= s5pv210_clk_ip1_ctrl,
-		.ctrlbit	= (1 << 11),
+		.ctrlbit	= (1 << 0),
+		.enable		= s5pv210_clk_mask0_ctrl,
 	},
 	.sources	= &clkset_sclk_hdmi,
 	.reg_src	= { .reg = S5P_CLK_SRC1, .shift = 0, .size = 1 },
@@ -565,8 +570,8 @@ static struct clksrc_clk clk_sclk_audio0 = {
 	.clk		= {
 		.name		= "sclk_audio",
 		.id		= 0,
-		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 4),
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 24),
 	},
 	.sources = &clkset_sclk_audio0,
 	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 0, .size = 4 },
@@ -594,8 +599,8 @@ static struct clksrc_clk clk_sclk_audio1 = {
 	.clk		= {
 		.name		= "sclk_audio",
 		.id		= 1,
-		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 5),
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 25),
 	},
 	.sources = &clkset_sclk_audio1,
 	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 4, .size = 4 },
@@ -623,8 +628,8 @@ static struct clksrc_clk clk_sclk_audio2 = {
 	.clk		= {
 		.name		= "sclk_audio",
 		.id		= 2,
-		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 6),
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 26),
 	},
 	.sources = &clkset_sclk_audio2,
 	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 8, .size = 4 },
@@ -680,8 +685,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "uclk1",
 			.id		= 0,
-			.ctrlbit	= (1<<17),
-			.enable		= s5pv210_clk_ip3_ctrl,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 12),
 		},
 		.sources = &clkset_uart,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
@@ -690,8 +695,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "uclk1",
 			.id		= 1,
-			.enable		= s5pv210_clk_ip3_ctrl,
-			.ctrlbit	= (1 << 18),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 13),
 		},
 		.sources = &clkset_uart,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 20, .size = 4 },
@@ -700,8 +705,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "uclk1",
 			.id		= 2,
-			.enable		= s5pv210_clk_ip3_ctrl,
-			.ctrlbit	= (1 << 19),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 14),
 		},
 		.sources = &clkset_uart,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 24, .size = 4 },
@@ -710,8 +715,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "uclk1",
 			.id		= 3,
-			.enable		= s5pv210_clk_ip3_ctrl,
-			.ctrlbit	= (1 << 20),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 15),
 		},
 		.sources = &clkset_uart,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 28, .size = 4 },
@@ -720,8 +725,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "sclk_mixer",
 			.id		= -1,
-			.enable		= s5pv210_clk_ip1_ctrl,
-			.ctrlbit	= (1 << 9),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 1),
 		},
 		.sources = &clkset_sclk_mixer,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 1 },
@@ -738,8 +743,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "sclk_fimc",
 			.id		= 0,
-			.enable		= s5pv210_clk_ip0_ctrl,
-			.ctrlbit	= (1 << 24),
+			.enable		= s5pv210_clk_mask1_ctrl,
+			.ctrlbit	= (1 << 2),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 12, .size = 4 },
@@ -748,8 +753,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "sclk_fimc",
 			.id		= 1,
-			.enable		= s5pv210_clk_ip0_ctrl,
-			.ctrlbit	= (1 << 25),
+			.enable		= s5pv210_clk_mask1_ctrl,
+			.ctrlbit	= (1 << 3),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 16, .size = 4 },
@@ -758,8 +763,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "sclk_fimc",
 			.id		= 2,
-			.enable		= s5pv210_clk_ip0_ctrl,
-			.ctrlbit	= (1 << 26),
+			.enable		= s5pv210_clk_mask1_ctrl,
+			.ctrlbit	= (1 << 4),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 20, .size = 4 },
@@ -768,6 +773,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_cam",
 			.id		= 0,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 3),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 4 },
@@ -776,6 +783,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_cam",
 			.id		= 1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 4),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 16, .size = 4 },
@@ -784,8 +793,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_fimd",
 			.id		= -1,
-			.enable		= s5pv210_clk_ip1_ctrl,
-			.ctrlbit	= (1 << 0),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 5),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 20, .size = 4 },
@@ -794,8 +803,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_mmc",
 			.id		= 0,
-			.enable		= s5pv210_clk_ip2_ctrl,
-			.ctrlbit	= (1 << 16),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 8),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 0, .size = 4 },
@@ -804,8 +813,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_mmc",
 			.id		= 1,
-			.enable		= s5pv210_clk_ip2_ctrl,
-			.ctrlbit	= (1 << 17),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 9),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4 },
@@ -814,8 +823,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_mmc",
 			.id		= 2,
-			.enable		= s5pv210_clk_ip2_ctrl,
-			.ctrlbit	= (1 << 18),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 10),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 8, .size = 4 },
@@ -824,8 +833,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_mmc",
 			.id		= 3,
-			.enable		= s5pv210_clk_ip2_ctrl,
-			.ctrlbit	= (1 << 19),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 11),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 12, .size = 4 },
@@ -864,8 +873,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_csis",
 			.id		= -1,
-			.enable		= s5pv210_clk_ip0_ctrl,
-			.ctrlbit	= (1 << 31),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 6),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 24, .size = 4 },
@@ -874,8 +883,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_spi",
 			.id		= 0,
-			.enable		= s5pv210_clk_ip3_ctrl,
-			.ctrlbit	= (1 << 12),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 16),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 0, .size = 4 },
@@ -884,8 +893,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_spi",
 			.id		= 1,
-			.enable		= s5pv210_clk_ip3_ctrl,
-			.ctrlbit	= (1 << 13),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 17),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 4, .size = 4 },
@@ -894,8 +903,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_pwi",
 			.id		= -1,
-			.enable		= &s5pv210_clk_ip4_ctrl,
-			.ctrlbit	= (1 << 2),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 29),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 20, .size = 4 },
@@ -904,8 +913,8 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_pwm",
 			.id		= -1,
-			.enable		= s5pv210_clk_ip3_ctrl,
-			.ctrlbit	= (1 << 23),
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 19),
 		},
 		.sources = &clkset_group2,
 		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 12, .size = 4 },
-- 
1.6.3.3
