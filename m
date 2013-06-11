From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Tue, 11 Jun 2013 15:01:08 +0530
Subject: [PATCH v7 03/11] clk: samsung: Migrate exynos5250 to use common
 samsung_clk_register_pll()
In-Reply-To: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
References: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370943076-13461-4-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch migrates exynos5250 pll registeration to use common
samsung_clk_register_pll() by intialising table of PLLs and adding PLLs to
unique id list of clocks.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
---
 drivers/clk/samsung/clk-exynos5250.c |   60 +++++++++++++++++++++++-----------
 1 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index f6e3031..4027c69 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -17,11 +17,22 @@
 #include <linux/of_address.h>
 
 #include "clk.h"
-#include "clk-pll.h"
 
+#define APLL_LOCK		0x0
+#define APLL_CON0		0x100
 #define SRC_CPU			0x200
 #define DIV_CPU0		0x500
+#define MPLL_LOCK		0x4000
+#define MPLL_CON0		0x4100
 #define SRC_CORE1		0x4204
+#define CPLL_LOCK		0x10020
+#define EPLL_LOCK		0x10030
+#define VPLL_LOCK		0x10040
+#define GPLL_LOCK		0x10050
+#define CPLL_CON0		0x10120
+#define EPLL_CON0		0x10130
+#define VPLL_CON0		0x10140
+#define GPLL_CON0		0x10150
 #define SRC_TOP0		0x10210
 #define SRC_TOP1		0x10214
 #define SRC_TOP2		0x10218
@@ -61,10 +72,18 @@
 #define GATE_IP_FSYS		0x10944
 #define GATE_IP_PERIC		0x10950
 #define GATE_IP_PERIS		0x10960
+#define BPLL_LOCK		0x20010
+#define BPLL_CON0		0x20110
 #define SRC_CDREX		0x20200
 #define PLL_DIV2_SEL		0x20a24
 #define GATE_IP_DISP1		0x10928
 
+/* list of PLLs to be registered */
+enum exynos5250_plls {
+	apll, mpll, cpll, epll, vpll, gpll, bpll,
+	nr_plls			/* number of PLLs */
+};
+
 /*
  * Let each supported clock get a unique id. This id is used to lookup the clock
  * for device tree based platforms. The clocks are categorized into three
@@ -81,7 +100,8 @@ enum exynos5250_clks {
 	none,
 
 	/* core clocks */
-	fin_pll,
+	fin_pll, fout_apll, fout_mpll, fout_bpll, fout_gpll, fout_cpll,
+	fout_epll, fout_vpll,
 
 	/* gate for special clocks (sclk) */
 	sclk_cam_bayer = 128, sclk_cam0, sclk_cam1, sclk_gscl_wa, sclk_gscl_wb,
@@ -475,6 +495,23 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(g3d, "g3d", "aclk_400_g3d", GATE_IP_G3D, 0, 0, 0),
 };
 
+struct __initdata samsung_pll_clock exynos5250_plls[nr_plls] = {
+	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
+		APLL_CON0, "fout_apll"),
+	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
+		MPLL_CON0, "fout_mpll"),
+	[bpll] = PLL(pll_35xx, fout_bpll, "fout_bpll", "fin_pll", BPLL_LOCK,
+		BPLL_CON0),
+	[gpll] = PLL(pll_35xx, fout_gpll, "fout_gpll", "fin_pll", GPLL_LOCK,
+		GPLL_CON0),
+	[cpll] = PLL(pll_35xx, fout_cpll, "fout_cpll", "fin_pll", CPLL_LOCK,
+		CPLL_CON0),
+	[epll] = PLL(pll_36xx, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
+		EPLL_CON0),
+	[vpll] = PLL(pll_36xx, fout_vpll, "fout_vpll", "mout_vpllsrc",
+		VPLL_LOCK, VPLL_CON0),
+};
+
 static __initdata struct of_device_id ext_clk_match[] = {
 	{ .compatible = "samsung,clock-xxti", .data = (void *)0, },
 	{ },
@@ -484,7 +521,6 @@ static __initdata struct of_device_id ext_clk_match[] = {
 static void __init exynos5250_clk_init(struct device_node *np)
 {
 	void __iomem *reg_base;
-	struct clk *apll, *mpll, *epll, *vpll, *bpll, *gpll, *cpll;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -500,22 +536,8 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_of_register_fixed_ext(exynos5250_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
 			ext_clk_match);
-
-	apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
-			reg_base + 0x100);
-	mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
-			reg_base + 0x4100);
-	bpll = samsung_clk_register_pll35xx("fout_bpll", "fin_pll",
-			reg_base + 0x20110);
-	gpll = samsung_clk_register_pll35xx("fout_gpll", "fin_pll",
-			reg_base + 0x10150);
-	cpll = samsung_clk_register_pll35xx("fout_cpll", "fin_pll",
-			reg_base + 0x10120);
-	epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
-			reg_base + 0x10130);
-	vpll = samsung_clk_register_pll36xx("fout_vpll", "mout_vpllsrc",
-			reg_base + 0x10140);
-
+	samsung_clk_register_pll(exynos5250_plls, ARRAY_SIZE(exynos5250_plls),
+					reg_base);
 	samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_clks));
 	samsung_clk_register_fixed_factor(exynos5250_fixed_factor_clks,
-- 
1.7.0.4
