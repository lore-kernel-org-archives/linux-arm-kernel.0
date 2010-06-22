From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 22 Jun 2010 17:05:51 +0900
Subject: [PATCH v2] S5PV210 Correct clock register properties
Message-ID: <1277193951-22559-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that this patch revises and merges the two previous patches:
[PATCH] S5PV210 Correct clock register properties 
[PATCH] S5PV210 Correct clock source control register properties 

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

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   72 ++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 154bca4..10a9f84 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -406,13 +406,13 @@ static struct clk init_clocks_disable[] = {
 		.id		= 0,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<4),
+		.ctrlbit	= (1<<5),
 	}, {
 		.name		= "i2s_v32",
 		.id		= 1,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<4),
+		.ctrlbit	= (1<<6),
 	}
 };
 
@@ -429,25 +429,25 @@ static struct clk init_clocks[] = {
 		.id		= 0,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<7),
+		.ctrlbit	= (1<<17),
 	}, {
 		.name		= "uart",
 		.id		= 1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<8),
+		.ctrlbit	= (1<<18),
 	}, {
 		.name		= "uart",
 		.id		= 2,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<9),
+		.ctrlbit	= (1<<19),
 	}, {
 		.name		= "uart",
 		.id		= 3,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<10),
+		.ctrlbit	= (1<<20),
 	},
 };
 
@@ -565,8 +565,8 @@ static struct clksrc_clk clk_sclk_audio0 = {
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
@@ -594,8 +594,8 @@ static struct clksrc_clk clk_sclk_audio1 = {
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
@@ -623,8 +623,8 @@ static struct clksrc_clk clk_sclk_audio2 = {
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
@@ -680,8 +680,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -690,8 +690,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -700,8 +700,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -710,8 +710,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -784,8 +784,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -794,8 +794,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -804,8 +804,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -814,8 +814,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -824,8 +824,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -874,8 +874,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -884,8 +884,8 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -904,8 +904,8 @@ static struct clksrc_clk clksrcs[] = {
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
