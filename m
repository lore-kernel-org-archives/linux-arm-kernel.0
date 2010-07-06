From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 06 Jul 2010 14:52:33 +0900
Subject: [PATCH] ARM: S5PV210: allow clk to use clksrc as parents
Message-ID: <1278395553-9228-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows clk in init_clocks[] and init_clocks_disable[] to use
clksrc_clk.clk in clksrcs[].

For example, clk "lcd" may need to set "sclk-fimd" as a parent if
the div and src settting of sclk-fimd changes and a user of "lcd" wants
to get the exact information about the rate. If "sclk-fimd" is set as a
parent of "lcd", then the clk framework can provide the wanted
information; otherwise, the change in "sclk-fimd" does not update "lcd"
properly.

To do so, we have relocated clksrcs[] and put enum indexes to clksrcs in
order to allow clk in init_clocks[] and init_clocks_disable[] may refer
one of clksrcs[] as its parent. (enum clksrc_refer)

For example, "lcd" may set "sclk-fimd" as a parent if the following line
replaces the line 878:

		.parent		= &clk_hclk_dsys.clk,

to

		.parent		= &clksrcs[_clksrc_sclk_fimd],

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |  986 ++++++++++++++++++++++-------------------
 1 files changed, 520 insertions(+), 466 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index aa2b1c5..e33c6ed 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -264,6 +264,526 @@ static struct clksrc_clk clk_sclk_vpll = {
 	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 12, .size = 1 },
 };
 
+static struct clk *clkset_uart_list[] = {
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+};
+
+static struct clksrc_sources clkset_uart = {
+	.sources	= clkset_uart_list,
+	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
+};
+
+static struct clk *clkset_group1_list[] = {
+	[0] = &clk_sclk_a2m.clk,
+	[1] = &clk_mout_mpll.clk,
+	[2] = &clk_mout_epll.clk,
+	[3] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_group1 = {
+	.sources	= clkset_group1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_group1_list),
+};
+
+static struct clk *clkset_sclk_onenand_list[] = {
+	[0] = &clk_hclk_psys.clk,
+	[1] = &clk_hclk_dsys.clk,
+};
+
+static struct clksrc_sources clkset_sclk_onenand = {
+	.sources	= clkset_sclk_onenand_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_onenand_list),
+};
+
+static struct clk *clkset_sclk_dac_list[] = {
+	[0] = &clk_sclk_vpll.clk,
+	[1] = &clk_sclk_hdmiphy,
+};
+
+static struct clksrc_sources clkset_sclk_dac = {
+	.sources	= clkset_sclk_dac_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_dac_list),
+};
+
+static struct clksrc_clk clk_sclk_dac = {
+	.clk		= {
+		.name		= "sclk_dac",
+		.id		= -1,
+		.ctrlbit	= (1 << 2),
+		.enable		= s5pv210_clk_mask0_ctrl,
+	},
+	.sources	= &clkset_sclk_dac,
+	.reg_src	= { .reg = S5P_CLK_SRC1, .shift = 8, .size = 1 },
+};
+
+static struct clksrc_clk clk_sclk_pixel = {
+	.clk		= {
+		.name		= "sclk_pixel",
+		.id		= -1,
+		.parent		= &clk_sclk_vpll.clk,
+	},
+	.reg_div	= { .reg = S5P_CLK_DIV1, .shift = 0, .size = 4},
+};
+
+static struct clk *clkset_sclk_hdmi_list[] = {
+	[0] = &clk_sclk_pixel.clk,
+	[1] = &clk_sclk_hdmiphy,
+};
+
+static struct clksrc_sources clkset_sclk_hdmi = {
+	.sources	= clkset_sclk_hdmi_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_hdmi_list),
+};
+
+static struct clksrc_clk clk_sclk_hdmi = {
+	.clk		= {
+		.name		= "sclk_hdmi",
+		.id		= -1,
+		.ctrlbit	= (1 << 0),
+		.enable		= s5pv210_clk_mask0_ctrl,
+	},
+	.sources	= &clkset_sclk_hdmi,
+	.reg_src	= { .reg = S5P_CLK_SRC1, .shift = 0, .size = 1 },
+};
+
+static struct clk *clkset_sclk_mixer_list[] = {
+	[0] = &clk_sclk_dac.clk,
+	[1] = &clk_sclk_hdmi.clk,
+};
+
+static struct clksrc_sources clkset_sclk_mixer = {
+	.sources	= clkset_sclk_mixer_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_mixer_list),
+};
+
+static struct clk *clkset_sclk_audio0_list[] = {
+	[0] = &clk_ext_xtal_mux,
+	[1] = &clk_pcmcdclk0,
+	[2] = &clk_sclk_hdmi27m,
+	[3] = &clk_sclk_usbphy0,
+	[4] = &clk_sclk_usbphy1,
+	[5] = &clk_sclk_hdmiphy,
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+	[8] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_sclk_audio0 = {
+	.sources	= clkset_sclk_audio0_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio0_list),
+};
+
+static struct clksrc_clk clk_sclk_audio0 = {
+	.clk		= {
+		.name		= "sclk_audio",
+		.id		= 0,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 24),
+	},
+	.sources = &clkset_sclk_audio0,
+	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 0, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 0, .size = 4 },
+};
+
+static struct clk *clkset_sclk_audio1_list[] = {
+	[0] = &clk_ext_xtal_mux,
+	[1] = &clk_pcmcdclk1,
+	[2] = &clk_sclk_hdmi27m,
+	[3] = &clk_sclk_usbphy0,
+	[4] = &clk_sclk_usbphy1,
+	[5] = &clk_sclk_hdmiphy,
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+	[8] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_sclk_audio1 = {
+	.sources	= clkset_sclk_audio1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio1_list),
+};
+
+static struct clksrc_clk clk_sclk_audio1 = {
+	.clk		= {
+		.name		= "sclk_audio",
+		.id		= 1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 25),
+	},
+	.sources = &clkset_sclk_audio1,
+	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 4, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 4, .size = 4 },
+};
+
+static struct clk *clkset_sclk_audio2_list[] = {
+	[0] = &clk_ext_xtal_mux,
+	[1] = &clk_pcmcdclk0,
+	[2] = &clk_sclk_hdmi27m,
+	[3] = &clk_sclk_usbphy0,
+	[4] = &clk_sclk_usbphy1,
+	[5] = &clk_sclk_hdmiphy,
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+	[8] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_sclk_audio2 = {
+	.sources	= clkset_sclk_audio2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio2_list),
+};
+
+static struct clksrc_clk clk_sclk_audio2 = {
+	.clk		= {
+		.name		= "sclk_audio",
+		.id		= 2,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 26),
+	},
+	.sources = &clkset_sclk_audio2,
+	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 8, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 8, .size = 4 },
+};
+
+static struct clk *clkset_sclk_spdif_list[] = {
+	[0] = &clk_sclk_audio0.clk,
+	[1] = &clk_sclk_audio1.clk,
+	[2] = &clk_sclk_audio2.clk,
+};
+
+static struct clksrc_sources clkset_sclk_spdif = {
+	.sources	= clkset_sclk_spdif_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_spdif_list),
+};
+
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
+enum clksrc_refer {
+	_clksrc_sclk_dmc,
+	_clksrc_sclk_onenand,
+	_clksrc_uclk1_0,
+	_clksrc_uclk1_1,
+	_clksrc_uclk1_2,
+	_clksrc_uclk1_3,
+	_clksrc_sclk_mixer,
+	_clksrc_sclk_spdif,
+	_clksrc_sclk_fimc_0,
+	_clksrc_sclk_fimc_1,
+	_clksrc_sclk_fimc_2,
+	_clksrc_sclk_cam_0,
+	_clksrc_sclk_cam_1,
+	_clksrc_sclk_fimd,
+	_clksrc_mmc_bus_0,
+	_clksrc_mmc_bus_1,
+	_clksrc_mmc_bus_2,
+	_clksrc_mmc_bus_3,
+	_clksrc_sclk_mfc,
+	_clksrc_sclk_g2d,
+	_clksrc_sclk_g3d,
+	_clksrc_sclk_csis,
+	_clksrc_sclk_spi_0,
+	_clksrc_sclk_spi_1,
+	_clksrc_sclk_pwi,
+	_clksrc_sclk_pwm,
+};
+
+static struct clksrc_clk clksrcs[] = {
+	[_clksrc_sclk_dmc] = {
+		.clk	= {
+			.name		= "sclk_dmc",
+			.id		= -1,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
+	},
+	[_clksrc_sclk_onenand] = {
+		.clk	= {
+			.name		= "sclk_onenand",
+			.id		= -1,
+		},
+		.sources = &clkset_sclk_onenand,
+		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 28, .size = 1 },
+		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 12, .size = 3 },
+	},
+	[_clksrc_uclk1_0] = {
+		.clk	= {
+			.name		= "uclk1",
+			.id		= 0,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 12),
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
+	},
+	[_clksrc_uclk1_1] = {
+		.clk		= {
+			.name		= "uclk1",
+			.id		= 1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 13),
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4 },
+	},
+	[_clksrc_uclk1_2] = {
+		.clk		= {
+			.name		= "uclk1",
+			.id		= 2,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 14),
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 24, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 24, .size = 4 },
+	},
+	[_clksrc_uclk1_3] = {
+		.clk		= {
+			.name		= "uclk1",
+			.id		= 3,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 15),
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 28, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 28, .size = 4 },
+	},
+	[_clksrc_sclk_mixer] = {
+		.clk	= {
+			.name		= "sclk_mixer",
+			.id		= -1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 1),
+		},
+		.sources = &clkset_sclk_mixer,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 1 },
+	},
+	[_clksrc_sclk_spdif] = {
+		.clk		= {
+			.name		= "sclk_spdif",
+			.id		= -1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 27),
+		},
+		.sources = &clkset_sclk_spdif,
+		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 12, .size = 2 },
+	},
+	[_clksrc_sclk_fimc_0] = {
+		.clk	= {
+			.name		= "sclk_fimc",
+			.id		= 0,
+			.enable		= s5pv210_clk_mask1_ctrl,
+			.ctrlbit	= (1 << 2),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 12, .size = 4 },
+	},
+	[_clksrc_sclk_fimc_1] = {
+		.clk	= {
+			.name		= "sclk_fimc",
+			.id		= 1,
+			.enable		= s5pv210_clk_mask1_ctrl,
+			.ctrlbit	= (1 << 3),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 16, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 16, .size = 4 },
+	},
+	[_clksrc_sclk_fimc_2] = {
+		.clk	= {
+			.name		= "sclk_fimc",
+			.id		= 2,
+			.enable		= s5pv210_clk_mask1_ctrl,
+			.ctrlbit	= (1 << 4),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 20, .size = 4 },
+	},
+	[_clksrc_sclk_cam_0] = {
+		.clk		= {
+			.name		= "sclk_cam",
+			.id		= 0,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 3),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 12, .size = 4 },
+	},
+	[_clksrc_sclk_cam_1] = {
+		.clk		= {
+			.name		= "sclk_cam",
+			.id		= 1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 4),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 16, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 16, .size = 4 },
+	},
+	[_clksrc_sclk_fimd] = {
+		.clk		= {
+			.name		= "sclk_fimd",
+			.id		= -1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 5),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 20, .size = 4 },
+	},
+	[_clksrc_mmc_bus_0] = {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 0,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 8),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 0, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 0, .size = 4 },
+	},
+	[_clksrc_mmc_bus_1] = {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 9),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 4, .size = 4 },
+	},
+	[_clksrc_mmc_bus_2] = {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 2,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 10),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 8, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 8, .size = 4 },
+	},
+	[_clksrc_mmc_bus_3] = {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 3,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 11),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
+	},
+	[_clksrc_sclk_mfc] = {
+		.clk		= {
+			.name		= "sclk_mfc",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 16),
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 4, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
+	},
+	[_clksrc_sclk_g2d] = {
+		.clk		= {
+			.name		= "sclk_g2d",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 12),
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 8, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 8, .size = 4 },
+	},
+	[_clksrc_sclk_g3d] = {
+		.clk		= {
+			.name		= "sclk_g3d",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip0_ctrl,
+			.ctrlbit	= (1 << 8),
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 0, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
+	},
+	[_clksrc_sclk_csis] = {
+		.clk		= {
+			.name		= "sclk_csis",
+			.id		= -1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 6),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 24, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 28, .size = 4 },
+	},
+	[_clksrc_sclk_spi_0] = {
+		.clk		= {
+			.name		= "sclk_spi",
+			.id		= 0,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 16),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 0, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 0, .size = 4 },
+	},
+	[_clksrc_sclk_spi_1] = {
+		.clk		= {
+			.name		= "sclk_spi",
+			.id		= 1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 17),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 4, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 4, .size = 4 },
+	},
+	[_clksrc_sclk_pwi] = {
+		.clk		= {
+			.name		= "sclk_pwi",
+			.id		= -1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 29),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 24, .size = 4 },
+	},
+	[_clksrc_sclk_pwm] = {
+		.clk		= {
+			.name		= "sclk_pwm",
+			.id		= -1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 19),
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 12, .size = 4 },
+	},
+};
+
 static unsigned long s5pv210_clk_imem_get_rate(struct clk *clk)
 {
 	return clk_get_rate(clk->parent) / 2;
@@ -752,472 +1272,6 @@ static struct clk init_clocks[] = {
 	},
 };
 
-static struct clk *clkset_uart_list[] = {
-	[6] = &clk_mout_mpll.clk,
-	[7] = &clk_mout_epll.clk,
-};
-
-static struct clksrc_sources clkset_uart = {
-	.sources	= clkset_uart_list,
-	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
-};
-
-static struct clk *clkset_group1_list[] = {
-	[0] = &clk_sclk_a2m.clk,
-	[1] = &clk_mout_mpll.clk,
-	[2] = &clk_mout_epll.clk,
-	[3] = &clk_sclk_vpll.clk,
-};
-
-static struct clksrc_sources clkset_group1 = {
-	.sources	= clkset_group1_list,
-	.nr_sources	= ARRAY_SIZE(clkset_group1_list),
-};
-
-static struct clk *clkset_sclk_onenand_list[] = {
-	[0] = &clk_hclk_psys.clk,
-	[1] = &clk_hclk_dsys.clk,
-};
-
-static struct clksrc_sources clkset_sclk_onenand = {
-	.sources	= clkset_sclk_onenand_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_onenand_list),
-};
-
-static struct clk *clkset_sclk_dac_list[] = {
-	[0] = &clk_sclk_vpll.clk,
-	[1] = &clk_sclk_hdmiphy,
-};
-
-static struct clksrc_sources clkset_sclk_dac = {
-	.sources	= clkset_sclk_dac_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_dac_list),
-};
-
-static struct clksrc_clk clk_sclk_dac = {
-	.clk		= {
-		.name		= "sclk_dac",
-		.id		= -1,
-		.ctrlbit	= (1 << 2),
-		.enable		= s5pv210_clk_mask0_ctrl,
-	},
-	.sources	= &clkset_sclk_dac,
-	.reg_src	= { .reg = S5P_CLK_SRC1, .shift = 8, .size = 1 },
-};
-
-static struct clksrc_clk clk_sclk_pixel = {
-	.clk		= {
-		.name		= "sclk_pixel",
-		.id		= -1,
-		.parent		= &clk_sclk_vpll.clk,
-	},
-	.reg_div	= { .reg = S5P_CLK_DIV1, .shift = 0, .size = 4},
-};
-
-static struct clk *clkset_sclk_hdmi_list[] = {
-	[0] = &clk_sclk_pixel.clk,
-	[1] = &clk_sclk_hdmiphy,
-};
-
-static struct clksrc_sources clkset_sclk_hdmi = {
-	.sources	= clkset_sclk_hdmi_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_hdmi_list),
-};
-
-static struct clksrc_clk clk_sclk_hdmi = {
-	.clk		= {
-		.name		= "sclk_hdmi",
-		.id		= -1,
-		.ctrlbit	= (1 << 0),
-		.enable		= s5pv210_clk_mask0_ctrl,
-	},
-	.sources	= &clkset_sclk_hdmi,
-	.reg_src	= { .reg = S5P_CLK_SRC1, .shift = 0, .size = 1 },
-};
-
-static struct clk *clkset_sclk_mixer_list[] = {
-	[0] = &clk_sclk_dac.clk,
-	[1] = &clk_sclk_hdmi.clk,
-};
-
-static struct clksrc_sources clkset_sclk_mixer = {
-	.sources	= clkset_sclk_mixer_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_mixer_list),
-};
-
-static struct clk *clkset_sclk_audio0_list[] = {
-	[0] = &clk_ext_xtal_mux,
-	[1] = &clk_pcmcdclk0,
-	[2] = &clk_sclk_hdmi27m,
-	[3] = &clk_sclk_usbphy0,
-	[4] = &clk_sclk_usbphy1,
-	[5] = &clk_sclk_hdmiphy,
-	[6] = &clk_mout_mpll.clk,
-	[7] = &clk_mout_epll.clk,
-	[8] = &clk_sclk_vpll.clk,
-};
-
-static struct clksrc_sources clkset_sclk_audio0 = {
-	.sources	= clkset_sclk_audio0_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio0_list),
-};
-
-static struct clksrc_clk clk_sclk_audio0 = {
-	.clk		= {
-		.name		= "sclk_audio",
-		.id		= 0,
-		.enable		= s5pv210_clk_mask0_ctrl,
-		.ctrlbit	= (1 << 24),
-	},
-	.sources = &clkset_sclk_audio0,
-	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 0, .size = 4 },
-	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 0, .size = 4 },
-};
-
-static struct clk *clkset_sclk_audio1_list[] = {
-	[0] = &clk_ext_xtal_mux,
-	[1] = &clk_pcmcdclk1,
-	[2] = &clk_sclk_hdmi27m,
-	[3] = &clk_sclk_usbphy0,
-	[4] = &clk_sclk_usbphy1,
-	[5] = &clk_sclk_hdmiphy,
-	[6] = &clk_mout_mpll.clk,
-	[7] = &clk_mout_epll.clk,
-	[8] = &clk_sclk_vpll.clk,
-};
-
-static struct clksrc_sources clkset_sclk_audio1 = {
-	.sources	= clkset_sclk_audio1_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio1_list),
-};
-
-static struct clksrc_clk clk_sclk_audio1 = {
-	.clk		= {
-		.name		= "sclk_audio",
-		.id		= 1,
-		.enable		= s5pv210_clk_mask0_ctrl,
-		.ctrlbit	= (1 << 25),
-	},
-	.sources = &clkset_sclk_audio1,
-	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 4, .size = 4 },
-	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 4, .size = 4 },
-};
-
-static struct clk *clkset_sclk_audio2_list[] = {
-	[0] = &clk_ext_xtal_mux,
-	[1] = &clk_pcmcdclk0,
-	[2] = &clk_sclk_hdmi27m,
-	[3] = &clk_sclk_usbphy0,
-	[4] = &clk_sclk_usbphy1,
-	[5] = &clk_sclk_hdmiphy,
-	[6] = &clk_mout_mpll.clk,
-	[7] = &clk_mout_epll.clk,
-	[8] = &clk_sclk_vpll.clk,
-};
-
-static struct clksrc_sources clkset_sclk_audio2 = {
-	.sources	= clkset_sclk_audio2_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio2_list),
-};
-
-static struct clksrc_clk clk_sclk_audio2 = {
-	.clk		= {
-		.name		= "sclk_audio",
-		.id		= 2,
-		.enable		= s5pv210_clk_mask0_ctrl,
-		.ctrlbit	= (1 << 26),
-	},
-	.sources = &clkset_sclk_audio2,
-	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 8, .size = 4 },
-	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 8, .size = 4 },
-};
-
-static struct clk *clkset_sclk_spdif_list[] = {
-	[0] = &clk_sclk_audio0.clk,
-	[1] = &clk_sclk_audio1.clk,
-	[2] = &clk_sclk_audio2.clk,
-};
-
-static struct clksrc_sources clkset_sclk_spdif = {
-	.sources	= clkset_sclk_spdif_list,
-	.nr_sources	= ARRAY_SIZE(clkset_sclk_spdif_list),
-};
-
-static struct clk *clkset_group2_list[] = {
-	[0] = &clk_ext_xtal_mux,
-	[1] = &clk_xusbxti,
-	[2] = &clk_sclk_hdmi27m,
-	[3] = &clk_sclk_usbphy0,
-	[4] = &clk_sclk_usbphy1,
-	[5] = &clk_sclk_hdmiphy,
-	[6] = &clk_mout_mpll.clk,
-	[7] = &clk_mout_epll.clk,
-	[8] = &clk_sclk_vpll.clk,
-};
-
-static struct clksrc_sources clkset_group2 = {
-	.sources	= clkset_group2_list,
-	.nr_sources	= ARRAY_SIZE(clkset_group2_list),
-};
-
-static struct clksrc_clk clksrcs[] = {
-	{
-		.clk	= {
-			.name		= "sclk_dmc",
-			.id		= -1,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_onenand",
-			.id		= -1,
-		},
-		.sources = &clkset_sclk_onenand,
-		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 28, .size = 1 },
-		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 12, .size = 3 },
-	}, {
-		.clk	= {
-			.name		= "uclk1",
-			.id		= 0,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 12),
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "uclk1",
-			.id		= 1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 13),
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 20, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "uclk1",
-			.id		= 2,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 14),
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 24, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 24, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "uclk1",
-			.id		= 3,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 15),
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 28, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 28, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_mixer",
-			.id		= -1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 1),
-		},
-		.sources = &clkset_sclk_mixer,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 1 },
-	}, {
-		.clk		= {
-			.name		= "sclk_spdif",
-			.id		= -1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 27),
-		},
-		.sources = &clkset_sclk_spdif,
-		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 12, .size = 2 },
-	}, {
-		.clk	= {
-			.name		= "sclk_fimc",
-			.id		= 0,
-			.enable		= s5pv210_clk_mask1_ctrl,
-			.ctrlbit	= (1 << 2),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 12, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 12, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_fimc",
-			.id		= 1,
-			.enable		= s5pv210_clk_mask1_ctrl,
-			.ctrlbit	= (1 << 3),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 16, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 16, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_fimc",
-			.id		= 2,
-			.enable		= s5pv210_clk_mask1_ctrl,
-			.ctrlbit	= (1 << 4),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 20, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 20, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_cam",
-			.id		= 0,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 3),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 12, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_cam",
-			.id		= 1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 4),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 16, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 16, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_fimd",
-			.id		= -1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 5),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 20, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 20, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.id		= 0,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 8),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 0, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 0, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.id		= 1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 9),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 4, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.id		= 2,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 10),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 8, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 8, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.id		= 3,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 11),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 12, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mfc",
-			.id		= -1,
-			.enable		= s5pv210_clk_ip0_ctrl,
-			.ctrlbit	= (1 << 16),
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 4, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_g2d",
-			.id		= -1,
-			.enable		= s5pv210_clk_ip0_ctrl,
-			.ctrlbit	= (1 << 12),
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 8, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 8, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_g3d",
-			.id		= -1,
-			.enable		= s5pv210_clk_ip0_ctrl,
-			.ctrlbit	= (1 << 8),
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 0, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_csis",
-			.id		= -1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 6),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 24, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 28, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_spi",
-			.id		= 0,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 16),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 0, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 0, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_spi",
-			.id		= 1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 17),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 4, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 4, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_pwi",
-			.id		= -1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 29),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 20, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 24, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_pwm",
-			.id		= -1,
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 19),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC5, .shift = 12, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV5, .shift = 12, .size = 4 },
-	},
-};
-
 /* Clock initialisation code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
-- 
1.6.3.3
