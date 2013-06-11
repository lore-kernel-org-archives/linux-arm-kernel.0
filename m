From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Tue, 11 Jun 2013 15:01:10 +0530
Subject: [PATCH v7 05/11] clk: samsung: Migrate exynos5420 to use common
 samsung_clk_register_pll()
In-Reply-To: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
References: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370943076-13461-6-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch migrates exynos5420 pll registeration to use common
samsung_clk_register_pll() by intialising table of PLLs and adding PLLs to
unique id list of clocks.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
---
 drivers/clk/samsung/clk-exynos5420.c |   86 +++++++++++++++++++++++-----------
 1 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 68a96cb..3ea6b4f 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -17,13 +17,30 @@
 #include <linux/of_address.h>
 
 #include "clk.h"
-#include "clk-pll.h"
 
+#define APLL_LOCK		0x0
+#define APLL_CON0		0x100
 #define SRC_CPU			0x200
 #define DIV_CPU0		0x500
 #define DIV_CPU1		0x504
 #define GATE_BUS_CPU		0x700
 #define GATE_SCLK_CPU		0x800
+#define CPLL_LOCK		0x10020
+#define DPLL_LOCK		0x10030
+#define EPLL_LOCK		0x10040
+#define RPLL_LOCK		0x10050
+#define IPLL_LOCK		0x10060
+#define SPLL_LOCK		0x10070
+#define VPLL_LOCK		0x10070
+#define MPLL_LOCK		0x10090
+#define CPLL_CON0		0x10120
+#define DPLL_CON0		0x10128
+#define EPLL_CON0		0x10130
+#define RPLL_CON0		0x10140
+#define IPLL_CON0		0x10150
+#define SPLL_CON0		0x10160
+#define VPLL_CON0		0x10170
+#define MPLL_CON0		0x10180
 #define SRC_TOP0		0x10200
 #define SRC_TOP1		0x10204
 #define SRC_TOP2		0x10208
@@ -75,15 +92,27 @@
 #define GATE_TOP_SCLK_MAU	0x1083c
 #define GATE_TOP_SCLK_FSYS	0x10840
 #define GATE_TOP_SCLK_PERIC	0x10850
+#define BPLL_LOCK		0x20010
+#define BPLL_CON0		0x20110
 #define SRC_CDREX		0x20200
+#define KPLL_LOCK		0x28000
+#define KPLL_CON0		0x28100
 #define SRC_KFC			0x28200
 #define DIV_KFC0		0x28500
 
+/* list of PLLs */
+enum exynos5420_plls {
+	apll, cpll, dpll, epll, rpll, ipll, spll, vpll, mpll,
+	bpll, kpll,
+	nr_plls			/* number of PLLs */
+};
+
 enum exynos5420_clks {
 	none,
 
 	/* core clocks */
-	fin_pll,
+	fin_pll,  fout_apll, fout_cpll, fout_dpll, fout_epll, fout_rpll,
+	fout_ipll, fout_spll, fout_vpll, fout_mpll, fout_bpll, fout_kpll,
 
 	/* gate for special clocks (sclk) */
 	sclk_uart0 = 128, sclk_uart1, sclk_uart2, sclk_uart3, sclk_mmc0,
@@ -698,6 +727,31 @@ struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(smmu_mscl2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0, 0),
 };
 
+struct __initdata samsung_pll_clock exynos5420_plls[nr_plls] = {
+	[apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
+		APLL_CON0),
+	[cpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
+		MPLL_CON0),
+	[dpll] = PLL(pll_2550, fout_dpll, "fout_dpll", "fin_pll", DPLL_LOCK,
+		DPLL_CON0),
+	[epll] = PLL(pll_2650, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
+		EPLL_CON0),
+	[rpll] = PLL(pll_2650, fout_rpll, "fout_rpll", "fin_pll", RPLL_LOCK,
+		RPLL_CON0),
+	[ipll] = PLL(pll_2550, fout_ipll, "fout_ipll", "fin_pll", IPLL_LOCK,
+		IPLL_CON0),
+	[spll] = PLL(pll_2550, fout_spll, "fout_spll", "fin_pll", SPLL_LOCK,
+		SPLL_CON0),
+	[vpll] = PLL(pll_2550, fout_vpll, "fout_vpll", "fin_pll", VPLL_LOCK,
+		VPLL_CON0),
+	[mpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
+		MPLL_CON0),
+	[bpll] = PLL(pll_2550, fout_bpll, "fout_bpll", "fin_pll", BPLL_LOCK,
+		BPLL_CON0),
+	[kpll] = PLL(pll_2550, fout_kpll, "fout_kpll", "fin_pll", KPLL_LOCK,
+		KPLL_CON0),
+};
+
 static __initdata struct of_device_id ext_clk_match[] = {
 	{ .compatible = "samsung,exynos5420-oscclk", .data = (void *)0, },
 	{ },
@@ -707,8 +761,6 @@ static __initdata struct of_device_id ext_clk_match[] = {
 void __init exynos5420_clk_init(struct device_node *np)
 {
 	void __iomem *reg_base;
-	struct clk *apll, *bpll, *cpll, *dpll, *epll, *ipll, *kpll, *mpll;
-	struct clk *rpll, *spll, *vpll;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -724,30 +776,8 @@ void __init exynos5420_clk_init(struct device_node *np)
 	samsung_clk_of_register_fixed_ext(exynos5420_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5420_fixed_rate_ext_clks),
 			ext_clk_match);
-
-	apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
-			reg_base + 0x100);
-	bpll = samsung_clk_register_pll35xx("fout_bpll", "fin_pll",
-			reg_base + 0x20110);
-	cpll = samsung_clk_register_pll35xx("fout_cpll", "fin_pll",
-			reg_base + 0x10120);
-	dpll = samsung_clk_register_pll35xx("fout_dpll", "fin_pll",
-			reg_base + 0x10128);
-	epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
-			reg_base + 0x10130);
-	ipll = samsung_clk_register_pll35xx("fout_ipll", "fin_pll",
-			reg_base + 0x10150);
-	kpll = samsung_clk_register_pll35xx("fout_kpll", "fin_pll",
-			reg_base + 0x28100);
-	mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
-			reg_base + 0x10180);
-	rpll = samsung_clk_register_pll36xx("fout_rpll", "fin_pll",
-			reg_base + 0x10140);
-	spll = samsung_clk_register_pll35xx("fout_spll", "fin_pll",
-			reg_base + 0x10160);
-	vpll = samsung_clk_register_pll35xx("fout_vpll", "fin_pll",
-			reg_base + 0x10170);
-
+	samsung_clk_register_pll(exynos5420_plls, ARRAY_SIZE(exynos5420_plls),
+					reg_base);
 	samsung_clk_register_fixed_rate(exynos5420_fixed_rate_clks,
 			ARRAY_SIZE(exynos5420_fixed_rate_clks));
 	samsung_clk_register_fixed_factor(exynos5420_fixed_factor_clks,
-- 
1.7.0.4
