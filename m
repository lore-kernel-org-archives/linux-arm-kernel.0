From: sbkim73@samsung.com (Sangbeom Kim)
Date: Mon, 20 Sep 2010 15:04:52 +0900
Subject: [PATCH v2 3/6] ARM: S5PV210: Add MOUT_DMC0 and SCLK_DMC0 clocks
In-Reply-To: <1284962695-8542-1-git-send-email-sbkim73@samsung.com>
References: <1284962695-8542-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1284962695-8542-4-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

This patch adds MOUT_DMC0 and SCLK_DMC0 for checking the dmc0 clock
in CPUFREQ driver.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index e18e098..1b01120 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -261,6 +261,36 @@ static struct clksrc_clk clk_sclk_vpll = {
 	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 12, .size = 1 },
 };
 
+static struct clk *clkset_moutdmc0src_list[] = {
+	[0] = &clk_sclk_a2m.clk,
+	[1] = &clk_mout_mpll.clk,
+	[2] = NULL,
+	[3] = NULL,
+};
+
+static struct clksrc_sources clkset_moutdmc0src = {
+	.sources	= clkset_moutdmc0src_list,
+	.nr_sources	= ARRAY_SIZE(clkset_moutdmc0src_list),
+};
+
+static struct clksrc_clk clk_mout_dmc0 = {
+	.clk	= {
+		.name		= "mout_dmc0",
+		.id		= -1,
+	},
+	.sources	= &clkset_moutdmc0src,
+	.reg_src	= { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
+};
+
+static struct clksrc_clk clk_sclk_dmc0 = {
+	.clk	= {
+		.name		= "sclk_dmc0",
+		.id		= -1,
+		.parent		= &clk_mout_dmc0.clk,
+	},
+	.reg_div	= { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
+};
+
 static unsigned long s5pv210_clk_imem_get_rate(struct clk *clk)
 {
 	return clk_get_rate(clk->parent) / 2;
@@ -964,6 +994,8 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_dac,
 	&clk_sclk_pixel,
 	&clk_sclk_hdmi,
+	&clk_mout_dmc0,
+	&clk_sclk_dmc0,
 };
 
 void __init_or_cpufreq s5pv210_setup_clocks(void)
-- 
1.6.2.5
