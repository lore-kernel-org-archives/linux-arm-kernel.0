From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri,  6 Feb 2015 19:27:46 +0530
Subject: [PATCH v2 3/3] clk: samsung: add cpu clock configuration data and
 instantiate cpu clock
In-Reply-To: <1423231066-7341-1-git-send-email-a.kesavan@samsung.com>
References: <1423231066-7341-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1423231066-7341-4-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Atlas CPU clock configuration data and instantiate the CPU clock
type for Exynos7.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-cpu.h           |    5 +++++
 drivers/clk/samsung/clk-exynos7.c       |   33 ++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/exynos7-clk.h |    3 ++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index 24e844e..1fd7f51 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -31,6 +31,11 @@
 #define E5420_KFC_DIV(kpll, pclk, aclk)					\
 		((((kpll) << 24) | ((pclk) << 20) | ((aclk) << 4)))
 
+#define EXYNOS7_ATL_DIV0(aclk, pclk, atclk, pclk_dbg) \
+		((aclk << 8) | (pclk << 12) | (atclk << 20) | (pclk_dbg << 26))
+#define EXYNOS7_ATL_DIV1(pll, hpm, cntclk) \
+		((pll << 0) | (hpm << 4) | (cntclk << 8))
+
 /**
  * struct exynos_cpuclk_data: config data to setup cpu clocks.
  * @prate: frequency of the primary parent clock (in KHz).
diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index cec026c..f2a9895 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 #include <dt-bindings/clock/exynos7-clk.h>
 
 /* Register Offset definitions for CMU_TOPC (0x10570000) */
@@ -64,6 +65,30 @@ static const struct samsung_pll_rate_table pll1450x_24mhz_tbl[] = {
 	PLL_35XX_RATE(200000000, 200, 3, 3),
 };
 
+static const struct exynos_cpuclk_cfg_data exynos7_atlclk_d[] __initconst = {
+	{ 2100000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 5, 6), },
+	{ 2000000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 5, 6), },
+	{ 1896000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1800000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1704000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1600000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1500000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1400000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1300000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1200000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 3, 6), },
+	{ 1100000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 3, 6), },
+	{ 1000000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 3, 6), },
+	{  900000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 3, 6), },
+	{  800000, EXYNOS7_ATL_DIV0(2, 5, 5, 5), EXYNOS7_ATL_DIV1(1, 3, 5), },
+	{  700000, EXYNOS7_ATL_DIV0(2, 5, 5, 5), EXYNOS7_ATL_DIV1(1, 3, 5), },
+	{  600000, EXYNOS7_ATL_DIV0(2, 4, 4, 4), EXYNOS7_ATL_DIV1(1, 3, 4), },
+	{  500000, EXYNOS7_ATL_DIV0(2, 3, 3, 3), EXYNOS7_ATL_DIV1(1, 2, 3), },
+	{  400000, EXYNOS7_ATL_DIV0(2, 3, 3, 3), EXYNOS7_ATL_DIV1(1, 2, 3), },
+	{  300000, EXYNOS7_ATL_DIV0(2, 3, 3, 3), EXYNOS7_ATL_DIV1(1, 2, 3), },
+	{  200000, EXYNOS7_ATL_DIV0(2, 3, 3, 3), EXYNOS7_ATL_DIV1(1, 1, 3), },
+	{  0 },
+};
+
 static struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initdata = {
 	FFACTOR(0, "ffac_topc_bus0_pll_div2", "mout_bus0_pll_ctrl", 1, 2, 0),
 	FFACTOR(0, "ffac_topc_bus0_pll_div4",
@@ -620,7 +645,13 @@ static struct samsung_cmu_info atlas_cmu_info __initdata = {
 
 static void __init exynos7_clk_atlas_init(struct device_node *np)
 {
-	samsung_cmu_register_one(np, &atlas_cmu_info);
+	struct samsung_clk_provider *ctx;
+
+	ctx = samsung_cmu_register_one(np, &atlas_cmu_info);
+	exynos_register_cpu_clock(ctx, CLK_ATLAS_CLK, "atlclk",
+		mout_atlas_p[0], mout_atlas_p[1], 0,
+		exynos7_atlclk_d, ARRAY_SIZE(exynos7_atlclk_d),
+		0, np);
 }
 
 CLK_OF_DECLARE(exynos7_clk_atlas, "samsung,exynos7-clock-atlas",
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 6b9465c..6df64ef 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -67,7 +67,8 @@
 #define CLK_ATLAS			12
 #define DOUT_SCLK_HPM_ATLAS		13
 #define DOUT_ATLAS_PLL			14
-#define ATLAS_NR_CLK			15
+#define CLK_ATLAS_CLK			15
+#define ATLAS_NR_CLK			16
 
 /* CCORE */
 #define PCLK_RTC			1
-- 
1.7.9.5
