From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:55 +0900
Subject: [PATCH 13/18] ARM: S5PV210: Add new system clocks
Message-ID: <1274056735-14614-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch adds the following system clocks.

1. clk_sclk_hdmiphy
2. clk_sclk_usbphy0
3. clk_sclk_usbphy1
4. sclk_dmc (dram memory controller clock)
5. sclk_onenand

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   56 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index c86bff5..2c7be15 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -184,6 +184,21 @@ static struct clk clk_sclk_hdmi27m = {
 	.rate		= 27000000,
 };
 
+static struct clk clk_sclk_hdmiphy = {
+	.name		= "sclk_hdmiphy",
+	.id		= -1,
+};
+
+static struct clk clk_sclk_usbphy0 = {
+	.name		= "sclk_usbphy0",
+	.id		= -1,
+};
+
+static struct clk clk_sclk_usbphy1 = {
+	.name		= "sclk_usbphy1",
+	.id		= -1,
+};
+
 static struct clk *clkset_vpllsrc_list[] = {
 	[0] = &clk_fin_vpll,
 	[1] = &clk_sclk_hdmi27m,
@@ -426,9 +441,47 @@ static struct clksrc_sources clkset_uart = {
 	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
 };
 
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
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
+			.name		= "sclk_dmc",
+			.id		= -1,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_onenand",
+			.id		= -1,
+		},
+		.sources = &clkset_sclk_onenand,
+		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 28, .size = 1 },
+		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 12, .size = 3 },
+	}, {
+		.clk	= {
 			.name		= "uclk1",
 			.id		= -1,
 			.ctrlbit	= (1<<17),
@@ -529,6 +582,9 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 
 static struct clk *clks[] __initdata = {
 	&clk_sclk_hdmi27m,
+	&clk_sclk_hdmiphy,
+	&clk_sclk_usbphy0,
+	&clk_sclk_usbphy1,
 };
 
 void __init s5pv210_register_clocks(void)
-- 
1.6.2.5
