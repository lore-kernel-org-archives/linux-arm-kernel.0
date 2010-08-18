From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:23 +0900
Subject: [PATCH 13/14] ARM: S5PV310: Add video clocks
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-14-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds video clocks for S5PV310/S5PC210.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |   74 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 14c9707..04bde94 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -506,6 +506,78 @@ static struct clksrc_sources clkset_group = {
 	.nr_sources	= ARRAY_SIZE(clkset_group_list),
 };
 
+static struct clksrc_clk clk_sclk_mipidphy4l = {
+	.clk    = {
+		.name           = "sclk_mipidphy4l",
+		.id             = -1,
+		.enable		= s5pv310_clk_ip_lcd0_ctrl,
+		.ctrlbit	= (1 << 4),
+	},
+	.sources        = &clkset_group,
+	.reg_src        = { .reg = S5P_CLKSRC_LCD0, .shift = 12, .size = 4 },
+	.reg_div	= { .reg = S5P_CLKDIV_LCD0, .shift = 16, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mipidphy2l = {
+	.clk    = {
+		.name           = "sclk_mipidphy2l",
+		.id             = -1,
+		.enable		= s5pv310_clk_ip_lcd1_ctrl,
+		.ctrlbit	= (1 << 4),
+	},
+	.sources        = &clkset_group,
+	.reg_src        = { .reg = S5P_CLKSRC_LCD1, .shift = 12, .size = 4 },
+	.reg_div	= { .reg = S5P_CLKDIV_LCD1, .shift = 16, .size = 4 },
+};
+
+static struct clk *clkset_mout_g2d0_list[] = {
+	[0] = &clk_mout_mpll.clk,
+	[1] = &clk_sclk_apll.clk,
+};
+
+static struct clksrc_sources clkset_mout_g2d0 = {
+	.sources	= clkset_mout_g2d0_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mout_g2d0_list),
+};
+
+static struct clksrc_clk clk_mout_g2d0 = {
+	.clk	= {
+		.name		= "mout_g2d0",
+		.id		= -1,
+	},
+	.sources	= &clkset_mout_g2d0,
+	.reg_src	= { .reg = S5P_CLKSRC_IMAGE, .shift = 0, .size = 1 },
+};
+
+static struct clk *clkset_mout_g2d1_list[] = {
+	[0] = &clk_mout_epll.clk,
+	[1] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_mout_g2d1 = {
+	.sources	= clkset_mout_g2d1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mout_g2d1_list),
+};
+
+static struct clksrc_clk clk_mout_g2d1 = {
+	.clk	= {
+		.name		= "mout_g2d1",
+		.id		= -1,
+	},
+	.sources	= &clkset_mout_g2d1,
+	.reg_src	= { .reg = S5P_CLKSRC_IMAGE, .shift = 4, .size = 1 },
+};
+
+static struct clk *clkset_mout_g2d_list[] = {
+	[0] = &clk_mout_g2d0.clk,
+	[1] = &clk_mout_g2d1.clk,
+};
+
+static struct clksrc_sources clkset_mout_g2d = {
+	.sources	= clkset_mout_g2d_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mout_g2d_list),
+};
+
 static struct clksrc_clk clk_dout_mmc0 = {
 	.clk		= {
 		.name		= "dout_mmc0",
@@ -672,6 +744,8 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_aclk_100,
 	&clk_aclk_160,
 	&clk_aclk_133,
+	&clk_sclk_mipidphy4l,
+	&clk_sclk_mipidphy2l,
 	&clk_dout_mmc0,
 	&clk_dout_mmc1,
 	&clk_dout_mmc2,
-- 
1.6.2.5
