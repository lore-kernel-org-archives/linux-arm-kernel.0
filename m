From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 17 Jun 2010 18:15:16 +0900
Subject: [PATCH] S5PV210 Correct clock source control register properties
Message-ID: <1276766116-6839-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock source controls (struct clksrc_clk) have been often accessing
CLK_GATE_IPx, which are for clock gating and are accessed by each clock
as well as the clock source. This duplicated clock issue may incur
lockup problems when there are two modules accessing the same clock with
different names.

Besides, the clock source control is supposed to control (setting values
of MASK, SRC, DIV), not to turn on/off individual clock.

Another point is that there are registers (CLK_SRC_MASK0/1) specialized
for masking clock source control in S5PV210/S5PC110 according to the
user manual (rev 20100201).

Therefore, accessing CLK_SRC_MASK0/1 (rather than accessing
CLK_GATE_IPx) for the clock source control is safer and fits to the
semantics of S5PV210/S5PC110 registers. And fortuneatly, each clock
source defined in clock.c has corresponding bit at CLK_SRC_MASK0/1
except for MFC, G2D, and G3D.

In this patch,

- DAC, HDMI, AUDIO 0/1/2, UCLK(uart) 0/1/2/3, MIXER, FIMC 0/1/2,
FIMC, MMC 0/1/2/3, CSIS, SPI 0/1, PWI, and PWM clock sources are
modified to use CLK_SRC_MASK0/1, which were using CLK_GATE_IPx.

- CAM 0/1 did not have enable/disable control. They now access
  CLK_SRC_MASK0.

- MFC, G3D, G2D were using CLK_GATE_IPx. However, as there are no clocks
  defined to control MFC, G3D, and G2D, we kept them to access
CLK_GATE_IPx. These may need to be modified (erase .enable, .ctrlbit
from sclk_mfc, sclk_g2d, sclk_g3d and create clocks: g3d, g2d, mfc)
later.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |  101 ++++++++++++++++++++++-------------------
 1 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index ec5ad8c..08c1063 100644
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
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 0),
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
+			.ctrlbit	= (1 << 12),
+			.enable		= s5pv210_clk_mask0_ctrl,
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
+			.enable		= &s5pv210_clk_mask0_ctrl,
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
