From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 02 Jul 2015 09:42:39 +0900
Subject: [PATCH v6 1/3] clk: samsung: exynos3250: Add cpu clock configuration
 data and instaniate cpu clock
In-Reply-To: <1435797761-3339-1-git-send-email-cw00.choi@samsung.com>
References: <1435797761-3339-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1435797761-3339-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add CPU clock configuration data and instantiate the CPU clock type
for Exynos3250 to support Samsung specific cpu-clock type.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c   | 32 ++++++++++++++++++++++++++++++--
 include/dt-bindings/clock/exynos3250.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 538de66a759e..378ad5ad3492 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -19,6 +19,7 @@
 #include <dt-bindings/clock/exynos3250.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 #include "clk-pll.h"
 
 #define SRC_LEFTBUS		0x4200
@@ -319,8 +320,10 @@ static struct samsung_mux_clock mux_clks[] __initdata = {
 	MUX(CLK_MOUT_MPLL_USER_C, "mout_mpll_user_c", mout_mpll_user_p,
 	    SRC_CPU, 24, 1),
 	MUX(CLK_MOUT_HPM, "mout_hpm", mout_hpm_p, SRC_CPU, 20, 1),
-	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p, SRC_CPU, 16, 1),
-	MUX(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
+	MUX_F(CLK_MOUT_CORE, "mout_core", mout_core_p, SRC_CPU, 16, 1,
+			CLK_SET_RATE_PARENT, 0),
+	MUX_F(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+			CLK_SET_RATE_PARENT, 0),
 };
 
 static struct samsung_div_clock div_clks[] __initdata = {
@@ -772,6 +775,26 @@ static struct samsung_cmu_info cmu_info __initdata = {
 	.nr_clk_regs		= ARRAY_SIZE(exynos3250_cmu_clk_regs),
 };
 
+#define E3250_CPU_DIV0(apll, pclk_dbg, atb, corem)                     \
+               (((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |  \
+               ((corem) << 4))
+#define E3250_CPU_DIV1(hpm, copy)					\
+		(((hpm) << 4) | ((copy) << 0))
+
+static const struct exynos_cpuclk_cfg_data e3250_armclk_d[] __initconst = {
+       { 1000000, E3250_CPU_DIV0(1, 7, 4, 1), E3250_CPU_DIV1(7, 7), },
+       {  900000, E3250_CPU_DIV0(1, 7, 3, 1), E3250_CPU_DIV1(7, 7), },
+       {  800000, E3250_CPU_DIV0(1, 7, 3, 1), E3250_CPU_DIV1(7, 7), },
+       {  700000, E3250_CPU_DIV0(1, 7, 3, 1), E3250_CPU_DIV1(7, 7), },
+       {  600000, E3250_CPU_DIV0(1, 7, 3, 1), E3250_CPU_DIV1(7, 7), },
+       {  500000, E3250_CPU_DIV0(1, 7, 3, 1), E3250_CPU_DIV1(7, 7), },
+       {  400000, E3250_CPU_DIV0(1, 7, 3, 1), E3250_CPU_DIV1(7, 7), },
+       {  300000, E3250_CPU_DIV0(1, 5, 3, 1), E3250_CPU_DIV1(7, 7), },
+       {  200000, E3250_CPU_DIV0(1, 3, 3, 1), E3250_CPU_DIV1(7, 7), },
+       {  100000, E3250_CPU_DIV0(1, 1, 1, 1), E3250_CPU_DIV1(7, 7), },
+       {  0 },
+};
+
 static void __init exynos3250_cmu_init(struct device_node *np)
 {
 	struct samsung_clk_provider *ctx;
@@ -780,6 +803,11 @@ static void __init exynos3250_cmu_init(struct device_node *np)
 	if (!ctx)
 		return;
 
+	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
+			mout_core_p[0], mout_core_p[1], 0x14200,
+			e3250_armclk_d, ARRAY_SIZE(e3250_armclk_d),
+			CLK_CPU_HAS_DIV1);
+
 	exynos3_core_down_clock(ctx->reg_base);
 }
 CLK_OF_DECLARE(exynos3250_cmu, "samsung,exynos3250-cmu", exynos3250_cmu_init);
diff --git a/include/dt-bindings/clock/exynos3250.h b/include/dt-bindings/clock/exynos3250.h
index aab088d30199..63d01c15d2b3 100644
--- a/include/dt-bindings/clock/exynos3250.h
+++ b/include/dt-bindings/clock/exynos3250.h
@@ -31,6 +31,7 @@
 #define CLK_FOUT_VPLL			4
 #define CLK_FOUT_UPLL			5
 #define CLK_FOUT_MPLL			6
+#define CLK_ARM_CLK			7
 
 /* Muxes */
 #define CLK_MOUT_MPLL_USER_L		16
-- 
1.8.5.5
