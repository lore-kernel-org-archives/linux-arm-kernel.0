From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:57 +0900
Subject: [PATCH 14/18] ARM: S5PV210: Add sclk_dac,
	sclk_mixer and sclk_hdmi clocks
Message-ID: <1274056737-14647-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Add sclk_dac, sclk_mixer and sclk_hdmi clocks. These clocks
are of type 'struct clksrc_clk' and so have a corresponding
clock list. These clocks are also added to the list of
clocks to be registered at boot time.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   75 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 74 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 2c7be15..c03e288 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -463,6 +463,67 @@ static struct clksrc_sources clkset_sclk_onenand = {
 	.nr_sources	= ARRAY_SIZE(clkset_sclk_onenand_list),
 };
 
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
+		.ctrlbit	= (1 << 10),
+		.enable		= s5pv210_clk_ip1_ctrl,
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
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 11),
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
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
@@ -490,7 +551,16 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_uart,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
-	}
+	}, {
+		.clk	= {
+			.name		= "sclk_mixer",
+			.id		= -1,
+			.enable		= s5pv210_clk_ip1_ctrl,
+			.ctrlbit	= (1 << 9),
+		},
+		.sources = &clkset_sclk_mixer,
+		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 1 },
+	},
 };
 
 /* Clock initialisation code */
@@ -508,6 +578,9 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_pclk_psys,
 	&clk_vpllsrc,
 	&clk_sclk_vpll,
+	&clk_sclk_dac,
+	&clk_sclk_pixel,
+	&clk_sclk_hdmi,
 };
 
 void __init_or_cpufreq s5pv210_setup_clocks(void)
-- 
1.6.2.5
