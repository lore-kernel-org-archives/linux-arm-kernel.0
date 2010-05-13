From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:27:54 +0900
Subject: [PATCH 10/11] ARM: S5P6440: Add clocks of type 'struct clksrc_clk'.
Message-ID: <1273710474-14823-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch adds the following.

1. Add new definitions of clock of type 'struct clksrc_clk'.
2. Add gate control function for GATE_SCLK1 which is required
   for new clock additions.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c |   60 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index b47f77d..ca6e48d 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -336,6 +336,11 @@ static int s5p6440_sclk_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLK_GATE_SCLK0, clk, enable);
 }
 
+static int s5p6440_sclk1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLK_GATE_SCLK1, clk, enable);
+}
+
 static int s5p6440_mem_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLK_GATE_MEM0, clk, enable);
@@ -616,6 +621,19 @@ static struct clksrc_sources clkset_uart = {
 	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
 };
 
+static struct clk *clkset_audio_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll.clk,
+	&clk_fin_epll,
+	&clk_iis_cd_v40,
+	&clk_pcm_cd,
+};
+
+static struct clksrc_sources clkset_audio = {
+	.sources	= clkset_audio_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio_list),
+};
+
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
@@ -677,7 +695,47 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 16, .size = 2 },
 		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
-	}
+	}, {
+		.clk	= {
+			.name		= "sclk_post",
+			.id		= -1,
+			.ctrlbit	= (1 << 10),
+			.enable		= s5p6440_sclk_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 26, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 12, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_dispcon",
+			.id		= -1,
+			.ctrlbit	= (1 << 1),
+			.enable		= s5p6440_sclk1_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 0, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_fimgvg",
+			.id		= -1,
+			.ctrlbit	= (1 << 2),
+			.enable		= s5p6440_sclk1_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 8, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 4, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_audio2",
+			.id		= -1,
+			.ctrlbit	= (1 << 11),
+			.enable		= s5p6440_sclk_ctrl,
+		},
+		.sources = &clkset_audio,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 0, .size = 3 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 24, .size = 4 },
+	},
 };
 
 /* Clock initialisation code */
-- 
1.6.2.5
