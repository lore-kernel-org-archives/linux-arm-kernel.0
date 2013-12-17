From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 17 Dec 2013 17:26:40 +0800
Subject: [PATCH 4/4] clk: tegra20: enable EMC clock driver
In-Reply-To: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
Message-ID: <1387272400-4689-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-register the EMC clock to the EMC clock driver in the Tegra CCF
driver to support EMC scaling.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/tegra/clk-tegra20.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index dbace152b2fa..ecae0f6bb7bf 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -795,6 +795,20 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
 	TEGRA_INIT_DATA_NODIV("disp2",	mux_pllpdc_clkm, CLK_SOURCE_DISP2, 30, 2, 26,  0, TEGRA20_CLK_DISP2),
 };
 
+static struct tegra_clk_periph tegra_emc_periph =
+	TEGRA_CLK_PERIPH(30, 3, 0, 0, 8, 1, 0, TEGRA20_CLK_EMC, 0, NULL, NULL);
+
+static __init void tegra20_emc_clk_init(void __iomem *clk_base)
+{
+	struct clk *clk;
+
+	clk = tegra_clk_register_emc("emc", mux_pllmcp_clkm,
+		ARRAY_SIZE(mux_pllmcp_clkm), &tegra_emc_periph, clk_base,
+		CLK_SOURCE_EMC, CLK_IGNORE_UNUSED | CLK_GET_RATE_NOCACHE);
+
+	clks[TEGRA20_CLK_EMC] = clk;
+}
+
 static void __init tegra20_periph_clk_init(void)
 {
 	struct tegra_periph_init_data *data;
@@ -812,16 +826,6 @@ static void __init tegra20_periph_clk_init(void)
 				    0, 34, periph_clk_enb_refcnt);
 	clks[TEGRA20_CLK_APBDMA] = clk;
 
-	/* emc */
-	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
-			       ARRAY_SIZE(mux_pllmcp_clkm),
-			       CLK_SET_RATE_NO_REPARENT,
-			       clk_base + CLK_SOURCE_EMC,
-			       30, 2, 0, NULL);
-	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base, 0,
-				    57, periph_clk_enb_refcnt);
-	clks[TEGRA20_CLK_EMC] = clk;
-
 	/* dsi */
 	clk = tegra_clk_register_periph_gate("dsi", "pll_d", 0, clk_base, 0,
 				    48, periph_clk_enb_refcnt);
@@ -1114,6 +1118,7 @@ static void __init tegra20_clock_init(struct device_node *np)
 	tegra20_super_clk_init();
 	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra20_clks, NULL);
 	tegra20_periph_clk_init();
+	tegra20_emc_clk_init(clk_base);
 	tegra20_audio_clk_init();
 	tegra_pmc_clk_init(pmc_base, tegra20_clks);
 
-- 
1.8.5
