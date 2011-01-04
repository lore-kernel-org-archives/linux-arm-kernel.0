From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Tue, 4 Jan 2011 14:22:55 +0800
Subject: [PATCH v3 1/2] ARM i.MX53: Some bug fix about MX53 MSL code
In-Reply-To: <1294122176-26450-1-git-send-email-yong.shen@freescale.com>
References: <1294122176-26450-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1294122176-26450-2-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@linaro.org>

1. pll_base address should return right value
2. uart parent clk is from pll3

Signed-off-by: Yong Shen <yong.shen@linaro.org>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |   25 ++++++++++++++++++++++++-
 arch/arm/mach-mx5/crm_regs.h        |    4 ++++
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 2f9eae2..b290f3f 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -124,7 +124,7 @@ static inline u32 _get_mux(struct clk *parent, struct clk *m0,
 	return -EINVAL;
 }
 
-static inline void __iomem *_get_pll_base(struct clk *pll)
+static inline void __iomem *_mx51_get_pll_base(struct clk *pll)
 {
 	if (pll == &pll1_main_clk)
 		return MX51_DPLL1_BASE;
@@ -132,6 +132,20 @@ static inline void __iomem *_get_pll_base(struct clk *pll)
 		return MX51_DPLL2_BASE;
 	else if (pll == &pll3_sw_clk)
 		return MX51_DPLL3_BASE;
+	else
+		BUG();
+
+	return NULL;
+}
+
+static inline void __iomem *_mx53_get_pll_base(struct clk *pll)
+{
+	if (pll == &pll1_main_clk)
+		return MX53_DPLL1_BASE;
+	else if (pll == &pll2_sw_clk)
+		return MX53_DPLL2_BASE;
+	else if (pll == &pll3_sw_clk)
+		return MX53_DPLL3_BASE;
 	else if (pll == &mx53_pll4_sw_clk)
 		return MX53_DPLL4_BASE;
 	else
@@ -140,6 +154,14 @@ static inline void __iomem *_get_pll_base(struct clk *pll)
 	return NULL;
 }
 
+static inline void __iomem *_get_pll_base(struct clk *pll)
+{
+	if (cpu_is_mx51())
+		return _mx51_get_pll_base(pll);
+	else
+		return _mx53_get_pll_base(pll);
+}
+
 static unsigned long clk_pll_get_rate(struct clk *clk)
 {
 	long mfi, mfn, mfd, pdf, ref_clk, mfn_abs;
@@ -1243,6 +1265,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 
 	clk_tree_init();
 
+	clk_set_parent(&uart_root_clk, &pll3_sw_clk);
 	clk_enable(&cpu_clk);
 	clk_enable(&main_bus_clk);
 
diff --git a/arch/arm/mach-mx5/crm_regs.h b/arch/arm/mach-mx5/crm_regs.h
index 51ff9bb..b462c22 100644
--- a/arch/arm/mach-mx5/crm_regs.h
+++ b/arch/arm/mach-mx5/crm_regs.h
@@ -19,6 +19,10 @@
 #define MX51_GPC_BASE		MX51_IO_ADDRESS(MX51_GPC_BASE_ADDR)
 
 /*MX53*/
+#define MX53_CCM_BASE		MX53_IO_ADDRESS(MX53_CCM_BASE_ADDR)
+#define MX53_DPLL1_BASE		MX53_IO_ADDRESS(MX53_PLL1_BASE_ADDR)
+#define MX53_DPLL2_BASE		MX53_IO_ADDRESS(MX53_PLL2_BASE_ADDR)
+#define MX53_DPLL3_BASE		MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
 #define MX53_DPLL4_BASE		MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
 
 /* PLL Register Offsets */
-- 
1.7.0.4
