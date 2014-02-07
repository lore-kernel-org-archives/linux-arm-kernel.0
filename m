From: ta.omasab@gmail.com (Thomas Abraham)
Date: Fri,  7 Feb 2014 21:25:45 +0530
Subject: [PATCH v3 4/7] clk: exynos: use cpu-clock provider type to represent
 arm clock
In-Reply-To: <1391788548-13056-1-git-send-email-thomas.ab@samsung.com>
References: <1391788548-13056-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1391788548-13056-5-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

With the addition of the new Samsung specific cpu-clock type, the
arm clock can be represented as a cpu-clock type and the independent
clock blocks that made up the arm clock can be removed.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c      |   23 +++++++----------------
 drivers/clk/samsung/clk-exynos5250.c   |   10 +++++-----
 include/dt-bindings/clock/exynos5250.h |    1 +
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 010f071..a52c622 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -336,7 +336,6 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX(0, "mout_fimd1", group1_p4210, E4210_SRC_LCD1, 0, 4),
 	MUX(0, "mout_mipi1", group1_p4210, E4210_SRC_LCD1, 12, 4),
 	MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1),
-	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4210, SRC_CPU, 16, 1),
 	MUX(CLK_SCLK_VPLL, "sclk_vpll", sclk_vpll_p4210, SRC_TOP0, 8, 1),
 	MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
 	MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4210, SRC_CAM, 4, 4),
@@ -395,7 +394,6 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX(0, "mout_jpeg", mout_jpeg_p, E4X12_SRC_CAM1, 8, 1),
 	MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_DMC, 12, 1),
 	MUX(CLK_SCLK_VPLL, "sclk_vpll", mout_vpll_p, SRC_TOP0, 8, 1),
-	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1),
 	MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4x12, SRC_CAM, 0, 4),
 	MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4x12, SRC_CAM, 4, 4),
 	MUX(CLK_MOUT_FIMC2, "mout_fimc2", group1_p4x12, SRC_CAM, 8, 4),
@@ -437,8 +435,6 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 
 /* list of divider clocks supported in all exynos4 soc's */
 static struct samsung_div_clock exynos4_div_clks[] __initdata = {
-	DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
-	DIV(0, "div_core2", "div_core", DIV_CPU0, 28, 3),
 	DIV(0, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
 	DIV(0, "div_fimc1", "mout_fimc1", DIV_CAM, 4, 4),
 	DIV(0, "div_fimc2", "mout_fimc2", DIV_CAM, 8, 4),
@@ -484,8 +480,8 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
 	DIV(0, "div_spi_pre2", "div_spi2", DIV_PERIL2, 8, 8),
 	DIV(0, "div_audio1", "mout_audio1", DIV_PERIL4, 0, 4),
 	DIV(0, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
-	DIV(CLK_ARM_CLK, "arm_clk", "div_core2", DIV_CPU0, 28, 3),
-	DIV(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
+	DIV_F(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3,
+			CLK_GET_RATE_NOCACHE, 0),
 	DIV_F(0, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
 			CLK_SET_RATE_PARENT, 0),
 	DIV_F(0, "div_mmc_pre0", "div_mmc0", DIV_FSYS1, 8, 8,
@@ -868,12 +864,6 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 		0),
 };
 
-static struct samsung_clock_alias exynos4_aliases[] __initdata = {
-	ALIAS(CLK_MOUT_CORE, NULL, "moutcore"),
-	ALIAS(CLK_ARM_CLK, NULL, "armclk"),
-	ALIAS(CLK_SCLK_APLL, NULL, "mout_apll"),
-};
-
 static struct samsung_clock_alias exynos4210_aliases[] __initdata = {
 	ALIAS(CLK_SCLK_MPLL, NULL, "mout_mpll"),
 };
@@ -1111,6 +1101,8 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4210_gate_clks));
 		samsung_clk_register_alias(exynos4210_aliases,
 			ARRAY_SIZE(exynos4210_aliases));
+		samsung_register_arm_clock(CLK_ARM_CLK, mout_core_p4210,
+			ARRAY_SIZE(mout_core_p4210), reg_base, np, NULL);
 	} else {
 		samsung_clk_register_mux(exynos4x12_mux_clks,
 			ARRAY_SIZE(exynos4x12_mux_clks));
@@ -1120,17 +1112,16 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4x12_gate_clks));
 		samsung_clk_register_alias(exynos4x12_aliases,
 			ARRAY_SIZE(exynos4x12_aliases));
+		samsung_register_arm_clock(CLK_ARM_CLK, mout_core_p4x12,
+			ARRAY_SIZE(mout_core_p4x12), reg_base, np, NULL);
 	}
 
-	samsung_clk_register_alias(exynos4_aliases,
-			ARRAY_SIZE(exynos4_aliases));
-
 	pr_info("%s clocks: sclk_apll = %ld, sclk_mpll = %ld\n"
 		"\tsclk_epll = %ld, sclk_vpll = %ld, arm_clk = %ld\n",
 		exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
 		_get_rate("sclk_apll"),	_get_rate("sclk_mpll"),
 		_get_rate("sclk_epll"), _get_rate("sclk_vpll"),
-		_get_rate("arm_clk"));
+		_get_rate("armclk"));
 }
 
 
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index ff4beeb..59742bb 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -219,7 +219,6 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	 */
 	MUX_FA(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
 					CLK_SET_RATE_PARENT, 0, "mout_apll"),
-	MUX_A(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
 
 	/*
 	 * CMU_CORE
@@ -298,9 +297,8 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	/*
 	 * CMU_CPU
 	 */
-	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
-	DIV(0, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV_A(0, "div_arm2", "div_arm", DIV_CPU0, 28, 3, "armclk"),
+	DIV_F(0, "div_apll", "mout_apll", DIV_CPU0, 24, 3,
+			CLK_GET_RATE_NOCACHE, 0),
 
 	/*
 	 * CMU_TOP
@@ -684,8 +682,10 @@ static void __init exynos5250_clk_init(struct device_node *np)
 			ARRAY_SIZE(exynos5250_div_clks));
 	samsung_clk_register_gate(exynos5250_gate_clks,
 			ARRAY_SIZE(exynos5250_gate_clks));
+	samsung_register_arm_clock(CLK_ARM_CLK, mout_cpu_p,
+			ARRAY_SIZE(mout_cpu_p), reg_base, np, NULL);
 
 	pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
-			_get_rate("div_arm2"));
+			_get_rate("armclk"));
 }
 CLK_OF_DECLARE(exynos5250_clk, "samsung,exynos5250-clock", exynos5250_clk_init);
diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
index 922f2dc..59a10fb 100644
--- a/include/dt-bindings/clock/exynos5250.h
+++ b/include/dt-bindings/clock/exynos5250.h
@@ -21,6 +21,7 @@
 #define CLK_FOUT_CPLL		6
 #define CLK_FOUT_EPLL		7
 #define CLK_FOUT_VPLL		8
+#define CLK_ARM_CLK		12
 
 /* gate for special clocks (sclk) */
 #define CLK_SCLK_CAM_BAYER	128
-- 
1.7.10.4
