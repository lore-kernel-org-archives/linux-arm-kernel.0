From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:39:03 +0900
Subject: [PATCH 16/18] ARM: S5PV210: Add sclk clocks of type 'struct
	clksrc_clk' clock
Message-ID: <1274056743-14713-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Add sclk clocks of type 'struct clksrc_clk' clock. The 'group2' of
clock clock sources is also added. This patch also changes the the
'id' member value of the uclk1 clock for instance instance 0 since
there are 4 instances of the uclk1 clock.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |  230 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 229 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 0154710..154bca4 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -173,6 +173,11 @@ static int s5pv210_clk_ip3_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_IP3, clk, enable);
 }
 
+static int s5pv210_clk_ip4_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP4, clk, enable);
+}
+
 static int s5pv210_clk_mask0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLK_SRC_MASK0, clk, enable);
@@ -637,6 +642,23 @@ static struct clksrc_sources clkset_sclk_spdif = {
 	.nr_sources	= ARRAY_SIZE(clkset_sclk_spdif_list),
 };
 
+static struct clk *clkset_group2_list[] = {
+	[0] = &clk_ext_xtal_mux,
+	[1] = &clk_xusbxti,
+	[2] = &clk_sclk_hdmi27m,
+	[3] = &clk_sclk_usbphy0,
+	[4] = &clk_sclk_usbphy1,
+	[5] = &clk_sclk_hdmiphy,
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+	[8] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_group2 = {
+	.sources	= clkset_group2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_group2_list),
+};
+
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
@@ -657,7 +679,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "uclk1",
-			.id		= -1,
+			.id		= 0,
 			.ctrlbit	= (1<<17),
 			.enable		= s5pv210_clk_ip3_ctrl,
 		},
@@ -665,6 +687,36 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
 	}, {
+		.clk		= {
+			.name		= "uclk1",
+			.id		= 1,
+			.enable		= s5pv210_clk_ip3_ctrl,
+			.ctrlbit	= (1 << 18),
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "uclk1",
+			.id		= 2,
+			.enable		= s5pv210_clk_ip3_ctrl,
+			.ctrlbit	= (1 << 19),
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 24, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 24, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "uclk1",
+			.id		= 3,
+			.enable		= s5pv210_clk_ip3_ctrl,
+			.ctrlbit	= (1 << 20),
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 28, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 28, .size = 4 },
+	}, {
 		.clk	= {
 			.name		= "sclk_mixer",
 			.id		= -1,
@@ -682,6 +734,182 @@ static struct clksrc_clk clksrcs[] = {
 		},
 		.sources = &clkset_sclk_spdif,
 		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 12, .size = 2 },
+	}, {
+		.clk	= {
+			.name		= "sclk_fimc",
+			.id		= 0,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 24),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 12, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_fimc",
+			.id		= 1,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 25),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 16, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 16, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_fimc",
+			.id		= 2,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 26),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 20, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_cam",
+			.id		= 0,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 12, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_cam",
+			.id		= 1,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 16, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 16, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_fimd",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip1_ctrl,
+			.ctrlbit	= (1 << 0),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 20, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 0,
+			.enable		= s5pv210_clk_ip2_ctrl,
+			.ctrlbit	= (1 << 16),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 0, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 1,
+			.enable		= s5pv210_clk_ip2_ctrl,
+			.ctrlbit	= (1 << 17),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 4, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 2,
+			.enable		= s5pv210_clk_ip2_ctrl,
+			.ctrlbit	= (1 << 18),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 8, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 8, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 3,
+			.enable		= s5pv210_clk_ip2_ctrl,
+			.ctrlbit	= (1 << 19),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mfc",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 16),
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 4, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_g2d",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 12),
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 8, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 8, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_g3d",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 8),
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 0, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_csis",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 31),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 24, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 28, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_spi",
+			.id		= 0,
+			.enable		= s5pv210_clk_ip3_ctrl,
+			.ctrlbit	= (1 << 12),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 0, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_spi",
+			.id		= 1,
+			.enable		= s5pv210_clk_ip3_ctrl,
+			.ctrlbit	= (1 << 13),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 4, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 4, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_pwi",
+			.id		= -1,
+			.enable		= &s5pv210_clk_ip4_ctrl,
+			.ctrlbit	= (1 << 2),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 24, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_pwm",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip3_ctrl,
+			.ctrlbit	= (1 << 23),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 12, .size = 4 },
 	},
 };
 
-- 
1.6.2.5
