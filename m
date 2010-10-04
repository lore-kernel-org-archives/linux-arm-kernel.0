From: sw.youn@samsung.com (Seungwhan Youn)
Date: Mon,  4 Oct 2010 20:42:25 +0900
Subject: [PATCH 3/10] ARM: S5PC100: Add SCLK_SPDIF clock
In-Reply-To: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1286192545-18327-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add SCLK_SPDIF clock to support source clock of S/PDIF
on S5PC100.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c |   59 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 42b7138..306ae74 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -980,6 +980,64 @@ struct clksrc_sources clk_src_pwi = {
 	.nr_sources	= ARRAY_SIZE(clk_src_pwi_list),
 };
 
+static struct clk *clk_sclk_spdif_list[] = {
+	[0] = &clk_sclk_audio0.clk,
+	[1] = &clk_sclk_audio1.clk,
+	[2] = &clk_sclk_audio2.clk,
+};
+
+struct clksrc_sources clk_src_sclk_spdif = {
+	.sources	= clk_sclk_spdif_list,
+	.nr_sources	= ARRAY_SIZE(clk_sclk_spdif_list),
+};
+
+static int s5pc100_spdif_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk *pclk;
+	int ret;
+
+	pclk = clk_get_parent(clk);
+	if (IS_ERR(pclk))
+		return -EINVAL;
+
+	ret = pclk->ops->set_rate(pclk, rate);
+	clk_put(pclk);
+
+	return ret;
+}
+
+static unsigned long s5pc100_spdif_get_rate(struct clk *clk)
+{
+	struct clk *pclk;
+	int rate;
+
+	pclk = clk_get_parent(clk);
+	if (IS_ERR(pclk))
+		return -EINVAL;
+
+	rate = pclk->ops->get_rate(clk);
+	clk_put(pclk);
+
+	return rate;
+}
+
+static struct clk_ops s5pc100_sclk_spdif_ops = {
+	.set_rate	= s5pc100_spdif_set_rate,
+	.get_rate	= s5pc100_spdif_get_rate,
+};
+
+static struct clksrc_clk clk_sclk_spdif = {
+	.clk	= {
+		.name		= "sclk_spdif",
+		.id		= -1,
+		.ctrlbit	= (1 << 11),
+		.enable		= s5pc100_sclk1_ctrl,
+		.ops		= &s5pc100_sclk_spdif_ops,
+	},
+	.sources = &clk_src_sclk_spdif,
+	.reg_src = { .reg = S5P_CLK_SRC3, .shift = 24, .size = 2 },
+};
+
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
@@ -1185,6 +1243,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_audio0,
 	&clk_sclk_audio1,
 	&clk_sclk_audio2,
+	&clk_sclk_spdif,
 };
 
 void __init_or_cpufreq s5pc100_setup_clocks(void)
-- 
1.6.2.5
