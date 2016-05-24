From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 24 May 2016 15:19:17 +0200
Subject: [PATCH 3/3] clk: samsung: exynos5433: add CPU clocks configuration
 data and instantiate CPU clocks
In-Reply-To: <1464095957-25851-1-git-send-email-b.zolnierkie@samsung.com>
References: <1464095957-25851-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1464095957-25851-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the CPU clocks configuration data and instantiate the CPU clocks
type for Exynos5433.

Cc: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 72 ++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 6dd81ed..9ff6160 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -16,6 +16,7 @@
 #include <dt-bindings/clock/exynos5433.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 #include "clk-pll.h"
 
 /*
@@ -3509,7 +3510,8 @@ static struct samsung_pll_clock apollo_pll_clks[] __initdata = {
 static struct samsung_mux_clock apollo_mux_clks[] __initdata = {
 	/* MUX_SEL_APOLLO0 */
 	MUX_F(CLK_MOUT_APOLLO_PLL, "mout_apollo_pll", mout_apollo_pll_p,
-			MUX_SEL_APOLLO0, 0, 1, CLK_SET_RATE_PARENT, 0),
+			MUX_SEL_APOLLO0, 0, 1, CLK_SET_RATE_PARENT |
+			CLK_RECALC_NEW_RATES, 0),
 
 	/* MUX_SEL_APOLLO1 */
 	MUX(CLK_MOUT_BUS_PLL_APOLLO_USER, "mout_bus_pll_apollo_user",
@@ -3590,9 +3592,27 @@ static struct samsung_gate_clock apollo_gate_clks[] __initdata = {
 			ENABLE_SCLK_APOLLO, 3, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_HPM_APOLLO, "sclk_hpm_apollo", "div_sclk_hpm_apollo",
 			ENABLE_SCLK_APOLLO, 1, CLK_IGNORE_UNUSED, 0),
-	GATE(CLK_SCLK_APOLLO, "sclk_apollo", "div_apollo2",
-			ENABLE_SCLK_APOLLO, 0,
-			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
+};
+
+#define E5433_APOLLO_DIV0(cntclk, pclk_dbg, atclk, pclk, aclk) \
+		(((cntclk) << 24) | ((pclk_dbg) << 20) | ((atclk) << 16) | \
+		 ((pclk) << 12) | ((aclk) << 8))
+
+#define E5433_APOLLO_DIV1(hpm, copy) \
+		(((hpm) << 4) | ((copy) << 0))
+
+static const struct exynos_cpuclk_cfg_data exynos5433_apolloclk_d[] __initconst = {
+	{ 1300000, E5433_APOLLO_DIV0(3, 7, 7, 7, 2), E5433_APOLLO_DIV1(7, 1), },
+	{ 1200000, E5433_APOLLO_DIV0(3, 7, 7, 7, 2), E5433_APOLLO_DIV1(7, 1), },
+	{ 1100000, E5433_APOLLO_DIV0(3, 7, 7, 7, 2), E5433_APOLLO_DIV1(7, 1), },
+	{ 1000000, E5433_APOLLO_DIV0(3, 7, 7, 7, 2), E5433_APOLLO_DIV1(7, 1), },
+	{  900000, E5433_APOLLO_DIV0(3, 7, 7, 7, 2), E5433_APOLLO_DIV1(7, 1), },
+	{  800000, E5433_APOLLO_DIV0(3, 7, 7, 7, 2), E5433_APOLLO_DIV1(7, 1), },
+	{  700000, E5433_APOLLO_DIV0(3, 7, 7, 7, 2), E5433_APOLLO_DIV1(7, 1), },
+	{  600000, E5433_APOLLO_DIV0(3, 7, 7, 7, 1), E5433_APOLLO_DIV1(7, 1), },
+	{  500000, E5433_APOLLO_DIV0(3, 7, 7, 7, 1), E5433_APOLLO_DIV1(7, 1), },
+	{  400000, E5433_APOLLO_DIV0(3, 7, 7, 7, 1), E5433_APOLLO_DIV1(7, 1), },
+	{  0 },
 };
 
 static void __init exynos5433_cmu_apollo_init(struct device_node *np)
@@ -3620,6 +3640,12 @@ static void __init exynos5433_cmu_apollo_init(struct device_node *np)
 				 ARRAY_SIZE(apollo_div_clks));
 	samsung_clk_register_gate(ctx, apollo_gate_clks,
 				  ARRAY_SIZE(apollo_gate_clks));
+
+	exynos_register_cpu_clock(ctx, CLK_SCLK_APOLLO, "apolloclk",
+		mout_apollo_p[0], mout_apollo_p[1], 0x200,
+		exynos5433_apolloclk_d, ARRAY_SIZE(exynos5433_apolloclk_d),
+		CLK_CPU_HAS_E5433_REGS_LAYOUT);
+
 	samsung_clk_sleep_init(reg_base, apollo_clk_regs,
 			       ARRAY_SIZE(apollo_clk_regs));
 
@@ -3707,7 +3733,8 @@ static struct samsung_pll_clock atlas_pll_clks[] __initdata = {
 static struct samsung_mux_clock atlas_mux_clks[] __initdata = {
 	/* MUX_SEL_ATLAS0 */
 	MUX_F(CLK_MOUT_ATLAS_PLL, "mout_atlas_pll", mout_atlas_pll_p,
-			MUX_SEL_ATLAS0, 0, 1, CLK_SET_RATE_PARENT, 0),
+			MUX_SEL_ATLAS0, 0, 1, CLK_SET_RATE_PARENT |
+			CLK_RECALC_NEW_RATES, 0),
 
 	/* MUX_SEL_ATLAS1 */
 	MUX(CLK_MOUT_BUS_PLL_ATLAS_USER, "mout_bus_pll_atlas_user",
@@ -3814,9 +3841,32 @@ static struct samsung_gate_clock atlas_gate_clks[] __initdata = {
 			ENABLE_SCLK_ATLAS, 2, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_ATCLK, "atclk", "div_atclk_atlas",
 			ENABLE_SCLK_ATLAS, 1, CLK_IGNORE_UNUSED, 0),
-	GATE(CLK_SCLK_ATLAS, "sclk_atlas", "div_atlas2",
-			ENABLE_SCLK_ATLAS, 0,
-			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
+};
+
+#define E5433_ATLAS_DIV0(cntclk, pclk_dbg, atclk, pclk, aclk) \
+		(((cntclk) << 24) | ((pclk_dbg) << 20) | ((atclk) << 16) | \
+		 ((pclk) << 12) | ((aclk) << 8))
+
+#define E5433_ATLAS_DIV1(hpm, copy) \
+		(((hpm) << 4) | ((copy) << 0))
+
+static const struct exynos_cpuclk_cfg_data exynos5433_atlasclk_d[] __initconst = {
+	{ 1900000, E5433_ATLAS_DIV0(7, 7, 7, 7, 4), E5433_ATLAS_DIV1(7, 1), },
+	{ 1800000, E5433_ATLAS_DIV0(7, 7, 7, 7, 4), E5433_ATLAS_DIV1(7, 1), },
+	{ 1700000, E5433_ATLAS_DIV0(7, 7, 7, 7, 4), E5433_ATLAS_DIV1(7, 1), },
+	{ 1600000, E5433_ATLAS_DIV0(7, 7, 7, 7, 4), E5433_ATLAS_DIV1(7, 1), },
+	{ 1500000, E5433_ATLAS_DIV0(7, 7, 7, 7, 3), E5433_ATLAS_DIV1(7, 1), },
+	{ 1400000, E5433_ATLAS_DIV0(7, 7, 7, 7, 3), E5433_ATLAS_DIV1(7, 1), },
+	{ 1300000, E5433_ATLAS_DIV0(7, 7, 7, 7, 3), E5433_ATLAS_DIV1(7, 1), },
+	{ 1200000, E5433_ATLAS_DIV0(7, 7, 7, 7, 3), E5433_ATLAS_DIV1(7, 1), },
+	{ 1100000, E5433_ATLAS_DIV0(7, 7, 7, 7, 3), E5433_ATLAS_DIV1(7, 1), },
+	{ 1000000, E5433_ATLAS_DIV0(7, 7, 7, 7, 3), E5433_ATLAS_DIV1(7, 1), },
+	{  900000, E5433_ATLAS_DIV0(7, 7, 7, 7, 2), E5433_ATLAS_DIV1(7, 1), },
+	{  800000, E5433_ATLAS_DIV0(7, 7, 7, 7, 2), E5433_ATLAS_DIV1(7, 1), },
+	{  700000, E5433_ATLAS_DIV0(7, 7, 7, 7, 2), E5433_ATLAS_DIV1(7, 1), },
+	{  600000, E5433_ATLAS_DIV0(7, 7, 7, 7, 2), E5433_ATLAS_DIV1(7, 1), },
+	{  500000, E5433_ATLAS_DIV0(7, 7, 7, 7, 2), E5433_ATLAS_DIV1(7, 1), },
+	{  0 },
 };
 
 static void __init exynos5433_cmu_atlas_init(struct device_node *np)
@@ -3844,6 +3894,12 @@ static void __init exynos5433_cmu_atlas_init(struct device_node *np)
 				 ARRAY_SIZE(atlas_div_clks));
 	samsung_clk_register_gate(ctx, atlas_gate_clks,
 				  ARRAY_SIZE(atlas_gate_clks));
+
+	exynos_register_cpu_clock(ctx, CLK_SCLK_ATLAS, "atlasclk",
+		mout_atlas_p[0], mout_atlas_p[1], 0x200,
+		exynos5433_atlasclk_d, ARRAY_SIZE(exynos5433_atlasclk_d),
+		CLK_CPU_HAS_E5433_REGS_LAYOUT);
+
 	samsung_clk_sleep_init(reg_base, atlas_clk_regs,
 			       ARRAY_SIZE(atlas_clk_regs));
 
-- 
1.9.1
