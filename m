From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Tue, 11 Jun 2013 15:01:09 +0530
Subject: [PATCH v7 04/11] clk: samsung: Migrate exynos4 to use common
 samsung_clk_register_pll()
In-Reply-To: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
References: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370943076-13461-5-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch migrates exynos4 pll registeration to use common
samsung_clk_register_pll() by intialising table of PLLs.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
---
 drivers/clk/samsung/clk-exynos4.c |   40 ++++++++++++++++++++++++-------------
 1 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 50af410..f2c2156 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -17,7 +17,6 @@
 #include <linux/of_address.h>
 
 #include "clk.h"
-#include "clk-pll.h"
 
 /* Exynos4 clock controller register offsets */
 #define SRC_LEFTBUS		0x4200
@@ -97,12 +96,14 @@
 #define GATE_IP_PERIL		0xc950
 #define E4210_GATE_IP_PERIR	0xc960
 #define GATE_BLOCK		0xc970
+#define E4X12_MPLL_LOCK		0x10008
 #define E4X12_MPLL_CON0		0x10108
 #define SRC_DMC			0x10200
 #define SRC_MASK_DMC		0x10300
 #define DIV_DMC0		0x10500
 #define DIV_DMC1		0x10504
 #define GATE_IP_DMC		0x10900
+#define APLL_LOCK		0x14000
 #define APLL_CON0		0x14100
 #define E4210_MPLL_CON0		0x14108
 #define SRC_CPU			0x14200
@@ -121,6 +122,12 @@ enum exynos4_soc {
 	EXYNOS4X12,
 };
 
+/* list of PLLs to be registered */
+enum exynos4_plls {
+	apll, mpll, epll, vpll,
+	nr_plls			/* number of PLLs */
+};
+
 /*
  * Let each supported clock get a unique id. This id is used to lookup the clock
  * for device tree based platforms. The clocks are categorized into three
@@ -990,6 +997,17 @@ static __initdata struct of_device_id ext_clk_match[] = {
 	{},
 };
 
+struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
+	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
+		APLL_CON0, "fout_apll"),
+	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll",
+		E4X12_MPLL_LOCK, E4X12_MPLL_CON0, "fout_mpll"),
+	[epll] = PLL_A(pll_36xx, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
+		EPLL_CON0, "fout_epll"),
+	[vpll] = PLL_A(pll_36xx, fout_vpll, "fout_vpll", "fin_pll", VPLL_LOCK,
+		VPLL_CON0, "fout_vpll"),
+};
+
 /* register exynos4 clocks */
 void __init exynos4_clk_init(struct device_node *np, enum exynos4_soc exynos4_soc, void __iomem *reg_base, unsigned long xom)
 {
@@ -1026,22 +1044,16 @@ void __init exynos4_clk_init(struct device_node *np, enum exynos4_soc exynos4_so
 					reg_base + EPLL_CON0, pll_4600);
 		vpll = samsung_clk_register_pll46xx("fout_vpll", "mout_vpllsrc",
 					reg_base + VPLL_CON0, pll_4650c);
+
+		samsung_clk_add_lookup(apll, fout_apll);
+		samsung_clk_add_lookup(mpll, fout_mpll);
+		samsung_clk_add_lookup(epll, fout_epll);
+		samsung_clk_add_lookup(vpll, fout_vpll);
 	} else {
-		apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
-					reg_base + APLL_CON0);
-		mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
-					reg_base + E4X12_MPLL_CON0);
-		epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
-					reg_base + EPLL_CON0);
-		vpll = samsung_clk_register_pll36xx("fout_vpll", "fin_pll",
-					reg_base + VPLL_CON0);
+		samsung_clk_register_pll(exynos4_plls,
+					ARRAY_SIZE(exynos4_plls), reg_base);
 	}
 
-	samsung_clk_add_lookup(apll, fout_apll);
-	samsung_clk_add_lookup(mpll, fout_mpll);
-	samsung_clk_add_lookup(epll, fout_epll);
-	samsung_clk_add_lookup(vpll, fout_vpll);
-
 	samsung_clk_register_fixed_rate(exynos4_fixed_rate_clks,
 			ARRAY_SIZE(exynos4_fixed_rate_clks));
 	samsung_clk_register_mux(exynos4_mux_clks,
-- 
1.7.0.4
