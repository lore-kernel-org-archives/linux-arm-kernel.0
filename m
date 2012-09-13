From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 13 Sep 2012 15:04:33 +0530
Subject: [PATCH] ARM: Tegra: Add smp_twd clock for Tegra20
Message-ID: <1347528873-3799-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clockevent's frequency is changed upon cpufreq change
notification. It fetches local timer's rate to update the
clockevent frequency. This patch adds local timer clock
for Tegra20.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/mach-tegra/tegra20_clocks.c      |   19 ++++++++++++++++++
 arch/arm/mach-tegra/tegra20_clocks.h      |    1 +
 arch/arm/mach-tegra/tegra20_clocks_data.c |   30 +++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra20_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c
index a4561da..deb873f 100644
--- a/arch/arm/mach-tegra/tegra20_clocks.c
+++ b/arch/arm/mach-tegra/tegra20_clocks.c
@@ -384,6 +384,25 @@ struct clk_ops tegra_super_ops = {
 	.recalc_rate = tegra20_super_clk_recalc_rate,
 };
 
+static unsigned long tegra20_twd_clk_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_tegra *c = to_clk_tegra(hw);
+	u64 rate = parent_rate;
+
+	if (c->mul != 0 && c->div != 0) {
+		rate *= c->mul;
+		rate += c->div - 1; /* round up */
+		do_div(rate, c->div);
+	}
+
+	return rate;
+}
+
+struct clk_ops tegra_twd_ops = {
+	.recalc_rate = tegra20_twd_clk_recalc_rate,
+};
+
 static u8 tegra20_cop_clk_get_parent(struct clk_hw *hw)
 {
 	return 0;
diff --git a/arch/arm/mach-tegra/tegra20_clocks.h b/arch/arm/mach-tegra/tegra20_clocks.h
index 0e42ec0..8bfd31b 100644
--- a/arch/arm/mach-tegra/tegra20_clocks.h
+++ b/arch/arm/mach-tegra/tegra20_clocks.h
@@ -28,6 +28,7 @@ extern struct clk_ops tegra_cdev_clk_ops;
 extern struct clk_ops tegra_audio_sync_clk_ops;
 extern struct clk_ops tegra_super_ops;
 extern struct clk_ops tegra_cpu_ops;
+extern struct clk_ops tegra_twd_ops;
 extern struct clk_ops tegra_cop_ops;
 extern struct clk_ops tegra_bus_ops;
 extern struct clk_ops tegra_blink_clk_ops;
diff --git a/arch/arm/mach-tegra/tegra20_clocks_data.c b/arch/arm/mach-tegra/tegra20_clocks_data.c
index 0e8ed37..dc2ad7d 100644
--- a/arch/arm/mach-tegra/tegra20_clocks_data.c
+++ b/arch/arm/mach-tegra/tegra20_clocks_data.c
@@ -583,6 +583,34 @@ static struct clk_tegra tegra_cclk_hw = {
 DEFINE_CLK_TEGRA(cclk, 0, &tegra_super_ops, 0, mux_cclk,
 		mux_cclk_p, NULL);
 
+static const char *mux_twd[] = {
+	"cclk",
+};
+
+static struct clk *mux_twd_p[] = {
+	&tegra_cclk,
+};
+
+static struct clk tegra_clk_twd;
+static struct clk_tegra tegra_clk_twd_hw = {
+	.hw = {
+		.clk = &tegra_clk_twd,
+	},
+	.max_rate = 1000000000,
+	.mul = 1,
+	.div = 4,
+};
+
+static struct clk tegra_clk_twd = {
+	.name = "twd",
+	.ops = &tegra_twd_ops,
+	.hw = &tegra_clk_twd_hw.hw,
+	.parent = &tegra_cclk,
+	.parent_names = mux_twd,
+	.parents = mux_twd_p,
+	.num_parents = ARRAY_SIZE(mux_twd),
+};
+
 static struct clk tegra_sclk;
 static struct clk_tegra tegra_sclk_hw = {
 	.hw = {
@@ -1023,6 +1051,7 @@ static struct clk_duplicate tegra_clk_duplicates[] = {
 	CLK_DUPLICATE("pll_p_out3", "tegra-i2c.1", "fast-clk"),
 	CLK_DUPLICATE("pll_p_out3", "tegra-i2c.2", "fast-clk"),
 	CLK_DUPLICATE("pll_p_out3", "tegra-i2c.3", "fast-clk"),
+	CLK_DUPLICATE("twd",	"smp_twd",	NULL),
 };
 
 #define CLK(dev, con, ck)	\
@@ -1053,6 +1082,7 @@ static struct clk *tegra_ptr_clks[] = {
 	&tegra_pll_x,
 	&tegra_pll_e,
 	&tegra_cclk,
+	&tegra_clk_twd,
 	&tegra_sclk,
 	&tegra_hclk,
 	&tegra_pclk,
-- 
1.7.4.1
