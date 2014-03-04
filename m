From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  4 Mar 2014 17:18:00 +0100
Subject: [PATCH v3 3/7] ARM: sunxi: Move the clock protection to machine hooks
In-Reply-To: <1393949884-892-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393949884-892-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393949884-892-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we start to have a lot of clocks to protect, some of them in a few boards
only, it becomes difficult to handle the clock protection without having to add
per machine exceptions.

Move these where they belong, in the machine definition code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sun4i.c   |  9 +++++++++
 arch/arm/mach-sunxi/sun5i.c   | 14 ++++++++++++++
 arch/arm/mach-sunxi/sun7i.c   | 14 ++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c | 24 ------------------------
 4 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-sunxi/sun4i.c b/arch/arm/mach-sunxi/sun4i.c
index fc28b89..3276e63 100644
--- a/arch/arm/mach-sunxi/sun4i.c
+++ b/arch/arm/mach-sunxi/sun4i.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
 
@@ -19,9 +20,17 @@
 
 static void __init sun4i_dt_init(void)
 {
+	struct clk *clk;
+
 	sunxi_setup_restart();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	/* Make sure the clocks we absolutely need are enabled */
+	/* DDR clock */
+	clk = clk_get(NULL, "pll5_ddr");
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
 }
 
 static const char * const sun4i_board_dt_compat[] = {
diff --git a/arch/arm/mach-sunxi/sun5i.c b/arch/arm/mach-sunxi/sun5i.c
index 623a95a..990dcfd 100644
--- a/arch/arm/mach-sunxi/sun5i.c
+++ b/arch/arm/mach-sunxi/sun5i.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
 
@@ -19,9 +20,22 @@
 
 static void __init sun5i_dt_init(void)
 {
+	struct clk *clk;
+
 	sunxi_setup_restart();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	/* Make sure the clocks we absolutely need are enabled */
+	/* Memory bus clock */
+	clk = clk_get(NULL, "mbus");
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
+
+	/* DDR clock */
+	clk = clk_get(NULL, "pll5_ddr");
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
 }
 
 static const char * const sun5i_board_dt_compat[] = {
diff --git a/arch/arm/mach-sunxi/sun7i.c b/arch/arm/mach-sunxi/sun7i.c
index 2e6a8ee..48a090b 100644
--- a/arch/arm/mach-sunxi/sun7i.c
+++ b/arch/arm/mach-sunxi/sun7i.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
 
@@ -19,9 +20,22 @@
 
 static void __init sun7i_dt_init(void)
 {
+	struct clk *clk;
+
 	sunxi_setup_restart();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	/* Make sure the clocks we absolutely need are enabled */
+	/* Memory bus clock */
+	clk = clk_get(NULL, "mbus");
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
+
+	/* DDR clock */
+	clk = clk_get(NULL, "pll5_ddr");
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
 }
 
 static const char * const sun7i_board_dt_compat[] = {
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 7119c02..27290a0 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1278,27 +1278,6 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
 	}
 }
 
-/**
- * System clock protection
- *
- * By enabling these critical clocks, we prevent their accidental gating
- * by the framework
- */
-static void __init sunxi_clock_protect(void)
-{
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
-
 static void __init sunxi_init_clocks(void)
 {
 	/* Register factor clocks */
@@ -1315,9 +1294,6 @@ static void __init sunxi_init_clocks(void)
 
 	/* Register gate clocks */
 	of_sunxi_table_clock_setup(clk_gates_match, sunxi_gates_clk_setup);
-
-	/* Enable core system clocks */
-	sunxi_clock_protect();
 }
 CLK_OF_DECLARE(sun4i_a10_clk_init, "allwinner,sun4i-a10", sunxi_init_clocks);
 CLK_OF_DECLARE(sun5i_a10s_clk_init, "allwinner,sun5i-a10s", sunxi_init_clocks);
-- 
1.9.0
