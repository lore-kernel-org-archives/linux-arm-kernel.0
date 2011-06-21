From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 21 Jun 2011 16:54:22 +0530
Subject: [PATCH v2 2/3] ARM: EXYNOS4: Add sclk_spdif clocks.
In-Reply-To: <1308655463-8787-1-git-send-email-ch.naveen@samsung.com>
References: <1308655463-8787-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1308655463-8787-3-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sclk_spdif clock is of type 'struct clksrc_clk' clock.
Also, add clk_spdifextclk clocks of type 'struct clk' clock.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 937335a..feeb27e 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -64,6 +64,11 @@ static struct clk clk_audiocdclk2 = {
 	.name		= "audiocdclk",
 };
 
+static struct clk clk_spdifextclk = {
+	.name		= "spdif_extclk",
+	.id		= -1,
+};
+
 static int exynos4_clksrc_mask_top_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_TOP, clk, enable);
@@ -550,6 +555,11 @@ static struct clk init_clocks_off[] = {
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 21),
 	}, {
+		.name		= "spdif",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 26),
+	}, {
 		.name		= "ac97",
 		.id		= -1,
 		.enable		= exynos4_clk_ip_peril_ctrl,
@@ -801,6 +811,30 @@ static struct clk init_clocks[] = {
 	}
 };
 
+static struct clk *clkset_sclk_spdif_list[] = {
+	[0] = &clk_sclk_audio0.clk,
+	[1] = &clk_sclk_audio1.clk,
+	[2] = &clk_sclk_audio2.clk,
+	[3] = &clk_spdifextclk,
+};
+
+static struct clksrc_sources clkset_sclk_spdif = {
+	.sources	= clkset_sclk_spdif_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_spdif_list),
+};
+
+static struct clksrc_clk clk_sclk_spdif = {
+	.clk	= {
+		.name		= "sclk_spdif",
+		.id		= -1,
+		.enable		= exynos4_clksrc_mask_peril1_ctrl,
+		.ctrlbit	= (1 << 8),
+		.ops		= &s5p_sclk_spdif_ops,
+	},
+		.sources = &clkset_sclk_spdif,
+		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 8, .size = 2 },
+};
+
 static struct clk *clkset_group_list[] = {
 	[0] = &clk_ext_xtal_mux,
 	[1] = &clk_xusbxti,
@@ -1206,6 +1240,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_audio0,
 	&clk_sclk_audio1,
 	&clk_sclk_audio2,
+	&clk_sclk_spdif,
 };
 
 static int xtal_rate;
-- 
1.7.2.3
