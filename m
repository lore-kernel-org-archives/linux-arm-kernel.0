From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:19 +0900
Subject: [PATCH 09/14] ARM: S5PV310: Adds SDMMC clock for S5PV310
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-10-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds SDMMC clocks for S5PV310/S5PC210.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |  142 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 141 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index c3ee742..8728504 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -51,6 +51,16 @@ static int s5pv310_clksrc_mask_top_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKSRC_MASK_TOP, clk, enable);
 }
 
+static int s5pv310_clksrc_mask_fsys_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKSRC_MASK_FSYS, clk, enable);
+}
+
+static int s5pv310_clk_ip_fsys_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_FSYS, clk, enable);
+}
+
 /* Core list of CMU_CPU side */
 
 static struct clksrc_clk clk_mout_apll = {
@@ -259,6 +269,36 @@ static struct clk init_clocks_disable[] = {
 		.parent		= &clk_aclk_100.clk,
 		.enable		= s5pv310_clk_ip_peril_ctrl,
 		.ctrlbit	= (1<<24),
+	}, {
+		.name		= "hsmmc",
+		.id		= 0,
+		.parent		= &clk_aclk_133.clk,
+		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 5),
+	}, {
+		.name		= "hsmmc",
+		.id		= 1,
+		.parent		= &clk_aclk_133.clk,
+		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 6),
+	}, {
+		.name		= "hsmmc",
+		.id		= 2,
+		.parent		= &clk_aclk_133.clk,
+		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 7),
+	}, {
+		.name		= "hsmmc",
+		.id		= 3,
+		.parent		= &clk_aclk_133.clk,
+		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 8),
+	}, {
+		.name		= "hsmmc",
+		.id		= 4,
+		.parent		= &clk_aclk_133.clk,
+		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 9),
 	}
 };
 
@@ -283,6 +323,56 @@ static struct clksrc_sources clkset_group = {
 	.nr_sources	= ARRAY_SIZE(clkset_group_list),
 };
 
+static struct clksrc_clk clk_dout_mmc0 = {
+	.clk		= {
+		.name		= "dout_mmc0",
+		.id		= -1,
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 0, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk clk_dout_mmc1 = {
+	.clk		= {
+		.name		= "dout_mmc1",
+		.id		= -1,
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 4, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 16, .size = 4 },
+};
+
+static struct clksrc_clk clk_dout_mmc2 = {
+	.clk		= {
+		.name		= "dout_mmc2",
+		.id		= -1,
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 8, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk clk_dout_mmc3 = {
+	.clk		= {
+		.name		= "dout_mmc3",
+		.id		= -1,
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 12, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 16, .size = 4 },
+};
+
+static struct clksrc_clk clk_dout_mmc4 = {
+	.clk		= {
+		.name		= "dout_mmc4",
+		.id		= -1,
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 16, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_FSYS3, .shift = 0, .size = 4 },
+};
+
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
@@ -334,7 +424,52 @@ static struct clksrc_clk clksrcs[] = {
 		.sources = &clkset_group,
 		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 24, .size = 4 },
 		.reg_div = { .reg = S5P_CLKDIV_PERIL3, .shift = 0, .size = 4 },
-	},
+	}, {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 0,
+			.parent		= &clk_dout_mmc0.clk,
+			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.ctrlbit	= (1 << 0),
+		},
+		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 8, .size = 8 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 1,
+			.parent         = &clk_dout_mmc1.clk,
+			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.ctrlbit	= (1 << 4),
+		},
+		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 24, .size = 8 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 2,
+			.parent         = &clk_dout_mmc2.clk,
+			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.ctrlbit	= (1 << 8),
+		},
+		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 8, .size = 8 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 3,
+			.parent         = &clk_dout_mmc3.clk,
+			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.ctrlbit	= (1 << 12),
+		},
+		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mmc",
+			.id		= 4,
+			.parent         = &clk_dout_mmc4.clk,
+			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.ctrlbit	= (1 << 16),
+		},
+		.reg_div = { .reg = S5P_CLKDIV_FSYS3, .shift = 8, .size = 8 },
+	}
 };
 
 /* Clock initialization code */
@@ -354,6 +489,11 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_aclk_100,
 	&clk_aclk_160,
 	&clk_aclk_133,
+	&clk_dout_mmc0,
+	&clk_dout_mmc1,
+	&clk_dout_mmc2,
+	&clk_dout_mmc3,
+	&clk_dout_mmc4,
 };
 
 void __init_or_cpufreq s5pv310_setup_clocks(void)
-- 
1.6.2.5
