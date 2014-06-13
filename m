From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 13 Jun 2014 15:08:10 +0900
Subject: [PATCH 1/4] clk: samsung: exynos3250: Use cpu-clock provider type to
 support cpufreq
In-Reply-To: <1402639693-31108-1-git-send-email-cw00.choi@samsung.com>
References: <1402639693-31108-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1402639693-31108-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch use cpu-clock provider type to support cpufreq for Exynos3250. The
clock-exynos3250.c didn't add separate 'arm_clk' divider for 'div_core2'.
The 'div_core2' can be represented as a cpu-clock type and then use 'div_core2'
directly to change cpu clock.

Cc: Tomas Abraham <thomas.ab@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 7a17bd4..9905fd4 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -351,8 +351,10 @@ static struct samsung_mux_clock mux_clks[] __initdata = {
 	MUX(CLK_MOUT_MPLL_USER_C, "mout_mpll_user_c", mout_mpll_user_p,
 	    SRC_CPU, 24, 1),
 	MUX(CLK_MOUT_HPM, "mout_hpm", mout_hpm_p, SRC_CPU, 20, 1),
-	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p, SRC_CPU, 16, 1),
-	MUX(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
+	MUX_F(CLK_MOUT_CORE, "mout_core", mout_core_p, SRC_CPU, 16, 1, 0,
+			CLK_MUX_READ_ONLY),
+	MUX_F(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+			CLK_SET_RATE_PARENT, 0),
 };
 
 static struct samsung_div_clock div_clks[] __initdata = {
@@ -441,11 +443,13 @@ static struct samsung_div_clock div_clks[] __initdata = {
 
 	/* DIV_CPU0 */
 	DIV(CLK_DIV_CORE2, "div_core2", "div_core", DIV_CPU0, 28, 3),
-	DIV(CLK_DIV_APLL, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
+	DIV_F(CLK_DIV_APLL, "div_apll", "mout_apll", DIV_CPU0, 24, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 	DIV(CLK_DIV_PCLK_DBG, "div_pclk_dbg", "div_core2", DIV_CPU0, 20, 3),
 	DIV(CLK_DIV_ATB, "div_atb", "div_core2", DIV_CPU0, 16, 3),
 	DIV(CLK_DIV_COREM, "div_corem", "div_core2", DIV_CPU0, 4, 3),
-	DIV(CLK_DIV_CORE, "div_core", "mout_core", DIV_CPU0, 0, 3),
+	DIV_F(CLK_DIV_CORE, "div_core", "mout_core", DIV_CPU0, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 
 	/* DIV_CPU1 */
 	DIV(CLK_DIV_HPM, "div_hpm", "div_copy", DIV_CPU1, 4, 3),
@@ -774,6 +778,8 @@ static void __init exynos3250_cmu_init(struct device_node *np)
 	samsung_clk_register_mux(ctx, mux_clks, ARRAY_SIZE(mux_clks));
 	samsung_clk_register_div(ctx, div_clks, ARRAY_SIZE(div_clks));
 	samsung_clk_register_gate(ctx, gate_clks, ARRAY_SIZE(gate_clks));
+	exynos_register_arm_clock(ctx, CLK_DIV_CORE2, mout_core_p[0],
+				mout_core_p[1], np);
 
 	exynos3250_clk_sleep_init();
 }
-- 
1.8.0
