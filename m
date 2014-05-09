From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri,  9 May 2014 18:30:09 +0530
Subject: [PATCH 3/4] clk: samsung: exynos5250: Add xclkout debug clock
In-Reply-To: <1399640410-30957-1-git-send-email-tushar.behera@linaro.org>
References: <1399640410-30957-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1399640410-30957-4-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new clock provider has been added to configure the XCLKOUT debug
clock. Added a minimal implemetation for Exynos5420 clock driver.

Right now, only one valid parent clock from XCLKOUT is defined
in existing clock driver. The driver will be updated later for other
for other parent clocks.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
CC: Tomasz Figa <t.figa@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c   |   14 ++++++++++++++
 include/dt-bindings/clock/exynos5250.h |    3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index e7ee442..2637aea 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -225,6 +225,13 @@ PNAME(mout_audio2_p)	= { "cdclk2", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
 PNAME(mout_spdif_p)	= { "sclk_audio0", "sclk_audio1", "sclk_audio2",
 				"spdif_extclk" };
 
+PNAME(xclkout_p) = {
+	"dummy", "dummy", "dummy", "dummy",
+	"dummy", "dummy", "dummy", "dummy",
+	"dummy", "dummy", "dummy", "dummy",
+	"dummy", "dummy", "dummy", "dummy",
+	"fin_pll", "dummy", "dummy" };
+
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock exynos5250_fixed_rate_ext_clks[] __initdata = {
 	FRATE(CLK_FIN_PLL, "fin_pll", NULL, CLK_IS_ROOT, 0),
@@ -236,6 +243,7 @@ static struct samsung_fixed_rate_clock exynos5250_fixed_rate_clks[] __initdata =
 	FRATE(0, "sclk_hdmi27m", NULL, CLK_IS_ROOT, 27000000),
 	FRATE(0, "sclk_dptxphy", NULL, CLK_IS_ROOT, 24000000),
 	FRATE(0, "sclk_uhostphy", NULL, CLK_IS_ROOT, 48000000),
+	FRATE(0, "dummy", NULL, CLK_IS_ROOT, 0),
 };
 
 static struct samsung_fixed_factor_clock exynos5250_fixed_factor_clks[] __initdata = {
@@ -678,6 +686,10 @@ static struct samsung_pll_clock exynos5250_plls[nr_plls] __initdata = {
 		VPLL_LOCK, VPLL_CON0, NULL),
 };
 
+static struct samsung_out_clock exynos5250_clkout[] __initdata = {
+	CLKOUT(CLK_XCLKOUT, "xclkout", xclkout_p),
+};
+
 static struct of_device_id ext_clk_match[] __initdata = {
 	{ .compatible = "samsung,clock-xxti", .data = (void *)0, },
 	{ },
@@ -721,6 +733,8 @@ static void __init exynos5250_clk_init(struct device_node *np)
 			ARRAY_SIZE(exynos5250_div_clks));
 	samsung_clk_register_gate(exynos5250_gate_clks,
 			ARRAY_SIZE(exynos5250_gate_clks));
+	samsung_clk_register_clkout(np,
+			exynos5250_clkout, ARRAY_SIZE(exynos5250_clkout));
 
 	exynos5250_clk_sleep_init();
 
diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
index 922f2dc..7c1cd0b 100644
--- a/include/dt-bindings/clock/exynos5250.h
+++ b/include/dt-bindings/clock/exynos5250.h
@@ -151,6 +151,9 @@
 #define CLK_MDMA0		346
 #define CLK_SMMU_MDMA0		347
 
+/* debug clocks */
+#define CLK_XCLKOUT		896
+
 /* mux clocks */
 #define CLK_MOUT_HDMI		1024
 
-- 
1.7.9.5
