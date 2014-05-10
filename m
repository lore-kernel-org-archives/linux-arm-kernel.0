From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  9 May 2014 22:33:39 -0500
Subject: [PATCH 4/6] clk: sunxi: Rework clock protection code
In-Reply-To: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399692821-20988-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we start to have a lot of clocks to protect, some of them in a few SoCs
only, it becomes difficult to handle the clock protection without having to add
per machine exceptions.

Add per-SoC data to tell which clock to leave enabled.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 72 ++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 291a2605afa7..384a6763eccc 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1130,29 +1130,10 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
 	}
 }
 
-/**
- * System clock protection
- *
- * By enabling these critical clocks, we prevent their accidental gating
- * by the framework
- */
-static void __init sunxi_clock_protect(void)
+static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
 {
-	struct clk *clk;
-
-	/* memory bus clock - sun5i+ */
-	clk = clk_get(NULL, "mbus");
-	if (!IS_ERR(clk))
-		clk_prepare_enable(clk);
-
-	/* DDR clock - sun4i+ */
-	clk = clk_get(NULL, "pll5_ddr");
-	if (!IS_ERR(clk))
-		clk_prepare_enable(clk);
-}
+	unsigned int i;
 
-static void __init sunxi_init_clocks(void)
-{
 	/* Register factor clocks */
 	of_sunxi_table_clock_setup(clk_factors_match, sunxi_factors_clk_setup);
 
@@ -1168,11 +1149,46 @@ static void __init sunxi_init_clocks(void)
 	/* Register gate clocks */
 	of_sunxi_table_clock_setup(clk_gates_match, sunxi_gates_clk_setup);
 
-	/* Enable core system clocks */
-	sunxi_clock_protect();
+	/* Protect the clocks that needs to stay on */
+	for (i = 0; i < nclocks; i++) {
+		struct clk *clk = clk_get(NULL, clocks[i]);
+
+		if (!IS_ERR(clk))
+			clk_prepare_enable(clk);
+	}
+}
+
+static const char *sun4i_a10_critical_clocks[] __initdata = {
+	"pll5_ddr",
+};
+
+static void __init sun4i_a10_init_clocks(void)
+{
+	sunxi_init_clocks(sun4i_a10_critical_clocks,
+			  ARRAY_SIZE(sun4i_a10_critical_clocks));
+}
+CLK_OF_DECLARE(sun4i_a10_clk_init, "allwinner,sun4i-a10", sun4i_a10_init_clocks);
+
+static const char *sun5i_critical_clocks[] __initdata = {
+	"mbus",
+	"pll5_ddr",
+};
+
+static void __init sun5i_init_clocks(void)
+{
+	sunxi_init_clocks(sun5i_critical_clocks,
+			  ARRAY_SIZE(sun5i_critical_clocks));
+}
+CLK_OF_DECLARE(sun5i_a10s_clk_init, "allwinner,sun5i-a10s", sun5i_init_clocks);
+CLK_OF_DECLARE(sun5i_a13_clk_init, "allwinner,sun5i-a13", sun5i_init_clocks);
+CLK_OF_DECLARE(sun7i_a20_clk_init, "allwinner,sun7i-a20", sun5i_init_clocks);
+
+static const char *sun6i_critical_clocks[] __initdata = {
+};
+
+static void __init sun6i_init_clocks(void)
+{
+	sunxi_init_clocks(sun6i_critical_clocks,
+			  ARRAY_SIZE(sun6i_critical_clocks));
 }
-CLK_OF_DECLARE(sun4i_a10_clk_init, "allwinner,sun4i-a10", sunxi_init_clocks);
-CLK_OF_DECLARE(sun5i_a10s_clk_init, "allwinner,sun5i-a10s", sunxi_init_clocks);
-CLK_OF_DECLARE(sun5i_a13_clk_init, "allwinner,sun5i-a13", sunxi_init_clocks);
-CLK_OF_DECLARE(sun6i_a31_clk_init, "allwinner,sun6i-a31", sunxi_init_clocks);
-CLK_OF_DECLARE(sun7i_a20_clk_init, "allwinner,sun7i-a20", sunxi_init_clocks);
+CLK_OF_DECLARE(sun6i_a31_clk_init, "allwinner,sun6i-a31", sun6i_init_clocks);
-- 
1.9.1
