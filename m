From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:09 +0800
Subject: [PATCH 08/11] ARM: imx: add clk-pllv1 type support
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of calling cpu_is_xxx() in clk-pllv1 driver, let's add clk-pllv1
type support to handle the difference/quirk in particular SoC designs.
Doing so will help get clk-pllv1 driver ready for being moved out of
arch/arm/mach-imx folder.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx1.c  |  4 ++--
 arch/arm/mach-imx/clk-imx21.c |  4 ++--
 arch/arm/mach-imx/clk-imx25.c |  4 ++--
 arch/arm/mach-imx/clk-imx27.c |  4 ++--
 arch/arm/mach-imx/clk-imx31.c |  6 +++---
 arch/arm/mach-imx/clk-imx35.c |  4 ++--
 arch/arm/mach-imx/clk-pllv1.c | 31 ++++++++++++++++++++++++-------
 arch/arm/mach-imx/clk.h       | 13 +++++++++++--
 8 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 5301d2ebb234..9e68351bb72c 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -50,9 +50,9 @@ static void __init _mx1_clocks_init(unsigned long fref)
 	clk[IMX1_CLK_CLK16M] = imx_clk_gate("clk16m", "clk16m_ext", CCM_CSCR, 17);
 	clk[IMX1_CLK_CLK32_PREMULT] = imx_clk_fixed_factor("clk32_premult", "clk32", 512, 1);
 	clk[IMX1_CLK_PREM] = imx_clk_mux("prem", CCM_CSCR, 16, 1, prem_sel_clks, ARRAY_SIZE(prem_sel_clks));
-	clk[IMX1_CLK_MPLL] = imx_clk_pllv1("mpll", "clk32_premult", CCM_MPCTL0);
+	clk[IMX1_CLK_MPLL] = imx_clk_pllv1(IMX_PLLV1_IMX1, "mpll", "clk32_premult", CCM_MPCTL0);
 	clk[IMX1_CLK_MPLL_GATE] = imx_clk_gate("mpll_gate", "mpll", CCM_CSCR, 0);
-	clk[IMX1_CLK_SPLL] = imx_clk_pllv1("spll", "prem", CCM_SPCTL0);
+	clk[IMX1_CLK_SPLL] = imx_clk_pllv1(IMX_PLLV1_IMX1, "spll", "prem", CCM_SPCTL0);
 	clk[IMX1_CLK_SPLL_GATE] = imx_clk_gate("spll_gate", "spll", CCM_CSCR, 1);
 	clk[IMX1_CLK_MCU] = imx_clk_divider("mcu", "clk32_premult", CCM_CSCR, 15, 1);
 	clk[IMX1_CLK_FCLK] = imx_clk_divider("fclk", "mpll_gate", CCM_CSCR, 15, 1);
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index facdf1ddd7f1..bc4254dd40a1 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -63,9 +63,9 @@ static void __init _mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk[IMX21_CLK_USB_DIV] = imx_clk_divider("usb_div", "spll_gate", CCM_CSCR, 26, 3);
 	clk[IMX21_CLK_FCLK] = imx_clk_divider("fclk", "mpll_gate", CCM_CSCR, 29, 3);
 
-	clk[IMX21_CLK_MPLL] = imx_clk_pllv1("mpll", "mpll_sel", CCM_MPCTL0);
+	clk[IMX21_CLK_MPLL] = imx_clk_pllv1(IMX_PLLV1_IMX21, "mpll", "mpll_sel", CCM_MPCTL0);
 
-	clk[IMX21_CLK_SPLL] = imx_clk_pllv1("spll", "spll_sel", CCM_SPCTL0);
+	clk[IMX21_CLK_SPLL] = imx_clk_pllv1(IMX_PLLV1_IMX21, "spll", "spll_sel", CCM_SPCTL0);
 
 	clk[IMX21_CLK_NFC_DIV] = imx_clk_divider("nfc_div", "fclk", CCM_PCDR0, 12, 4);
 	clk[IMX21_CLK_SSI1_DIV] = imx_clk_divider("ssi1_div", "ssi1_sel", CCM_PCDR0, 16, 6);
diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 9c2633a9de9f..485d090d2267 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -95,8 +95,8 @@ static int __init __mx25_clocks_init(unsigned long osc_rate,
 
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[osc] = imx_clk_fixed("osc", osc_rate);
-	clk[mpll] = imx_clk_pllv1("mpll", "osc", ccm(CCM_MPCTL));
-	clk[upll] = imx_clk_pllv1("upll", "osc", ccm(CCM_UPCTL));
+	clk[mpll] = imx_clk_pllv1(IMX_PLLV1_IMX25, "mpll", "osc", ccm(CCM_MPCTL));
+	clk[upll] = imx_clk_pllv1(IMX_PLLV1_IMX25, "upll", "osc", ccm(CCM_UPCTL));
 	clk[mpll_cpu_3_4] = imx_clk_fixed_factor("mpll_cpu_3_4", "mpll", 3, 4);
 	clk[cpu_sel] = imx_clk_mux("cpu_sel", ccm(CCM_CCTL), 14, 1, cpu_sel_clks, ARRAY_SIZE(cpu_sel_clks));
 	clk[cpu] = imx_clk_divider("cpu", "cpu_sel", ccm(CCM_CCTL), 30, 2);
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index aeb19982a36e..530af09c6bc7 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -54,8 +54,8 @@ static void __init _mx27_clocks_init(unsigned long fref)
 	clk[IMX27_CLK_CKIH_GATE] = imx_clk_gate_dis("ckih_gate", "ckih", CCM_CSCR, 3);
 	clk[IMX27_CLK_MPLL_OSC_SEL] = imx_clk_mux("mpll_osc_sel", CCM_CSCR, 4, 1, mpll_osc_sel_clks, ARRAY_SIZE(mpll_osc_sel_clks));
 	clk[IMX27_CLK_MPLL_SEL] = imx_clk_mux("mpll_sel", CCM_CSCR, 16, 1, mpll_sel_clks, ARRAY_SIZE(mpll_sel_clks));
-	clk[IMX27_CLK_MPLL] = imx_clk_pllv1("mpll", "mpll_sel", CCM_MPCTL0);
-	clk[IMX27_CLK_SPLL] = imx_clk_pllv1("spll", "ckih_gate", CCM_SPCTL0);
+	clk[IMX27_CLK_MPLL] = imx_clk_pllv1(IMX_PLLV1_IMX27, "mpll", "mpll_sel", CCM_MPCTL0);
+	clk[IMX27_CLK_SPLL] = imx_clk_pllv1(IMX_PLLV1_IMX27, "spll", "ckih_gate", CCM_SPCTL0);
 	clk[IMX27_CLK_SPLL_GATE] = imx_clk_gate("spll_gate", "spll", CCM_CSCR, 1);
 	clk[IMX27_CLK_MPLL_MAIN2] = imx_clk_fixed_factor("mpll_main2", "mpll", 2, 3);
 
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 2aaccadb9e13..caa26ec32152 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -59,9 +59,9 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", fref);
 	clk[ckil] = imx_clk_fixed("ckil", 32768);
-	clk[mpll] = imx_clk_pllv1("mpll", "ckih", base + MXC_CCM_MPCTL);
-	clk[spll] = imx_clk_pllv1("spll", "ckih", base + MXC_CCM_SRPCTL);
-	clk[upll] = imx_clk_pllv1("upll", "ckih", base + MXC_CCM_UPCTL);
+	clk[mpll] = imx_clk_pllv1(IMX_PLLV1_IMX31, "mpll", "ckih", base + MXC_CCM_MPCTL);
+	clk[spll] = imx_clk_pllv1(IMX_PLLV1_IMX31, "spll", "ckih", base + MXC_CCM_SRPCTL);
+	clk[upll] = imx_clk_pllv1(IMX_PLLV1_IMX31, "upll", "ckih", base + MXC_CCM_UPCTL);
 	clk[mcu_main] = imx_clk_mux("mcu_main", base + MXC_CCM_PMCR0, 31, 1, mcu_main_sel, ARRAY_SIZE(mcu_main_sel));
 	clk[hsp] = imx_clk_divider("hsp", "mcu_main", base + MXC_CCM_PDR0, 11, 3);
 	clk[ahb] = imx_clk_divider("ahb", "mcu_main", base + MXC_CCM_PDR0, 3, 3);
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 14f33ec049bc..f53d2b502479 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -92,8 +92,8 @@ int __init mx35_clocks_init(void)
 	}
 
 	clk[ckih] = imx_clk_fixed("ckih", 24000000);
-	clk[mpll] = imx_clk_pllv1("mpll", "ckih", base + MX35_CCM_MPCTL);
-	clk[ppll] = imx_clk_pllv1("ppll", "ckih", base + MX35_CCM_PPCTL);
+	clk[mpll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "mpll", "ckih", base + MX35_CCM_MPCTL);
+	clk[ppll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "ppll", "ckih", base + MX35_CCM_PPCTL);
 
 	clk[mpll] = imx_clk_fixed_factor("mpll_075", "mpll", 3, 4);
 
diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index d21d14ca46c1..4e1cb9f39a29 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -26,13 +26,29 @@
 struct clk_pllv1 {
 	struct clk_hw	hw;
 	void __iomem	*base;
+	enum imx_pllv1_type type;
 };
 
 #define to_clk_pllv1(clk) (container_of(clk, struct clk_pllv1, clk))
 
-static inline bool mfn_is_negative(unsigned int mfn)
+static inline bool is_imx1_pllv1(struct clk_pllv1 *pll)
 {
-	return !cpu_is_mx1() && !cpu_is_mx21() && (mfn & MFN_SIGN);
+	return pll->type == IMX_PLLV1_IMX1;
+}
+
+static inline bool is_imx21_pllv1(struct clk_pllv1 *pll)
+{
+	return pll->type == IMX_PLLV1_IMX21;
+}
+
+static inline bool is_imx27_pllv1(struct clk_pllv1 *pll)
+{
+	return pll->type == IMX_PLLV1_IMX27;
+}
+
+static inline bool mfn_is_negative(struct clk_pllv1 *pll, unsigned int mfn)
+{
+	return !is_imx1_pllv1(pll) && !is_imx21_pllv1(pll) && (mfn & MFN_SIGN);
 }
 
 static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
@@ -71,8 +87,8 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 	 * 2's complements number.
 	 * On i.MX27 the bit 9 is the sign bit.
 	 */
-	if (mfn_is_negative(mfn)) {
-		if (cpu_is_mx27())
+	if (mfn_is_negative(pll, mfn)) {
+		if (is_imx27_pllv1(pll))
 			mfn_abs = mfn & MFN_MASK;
 		else
 			mfn_abs = BIT(MFN_BITS) - mfn;
@@ -85,7 +101,7 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 
 	do_div(ll, mfd + 1);
 
-	if (mfn_is_negative(mfn))
+	if (mfn_is_negative(pll, mfn))
 		ll = -ll;
 
 	ll = (rate * mfi) + ll;
@@ -97,8 +113,8 @@ static struct clk_ops clk_pllv1_ops = {
 	.recalc_rate = clk_pllv1_recalc_rate,
 };
 
-struct clk *imx_clk_pllv1(const char *name, const char *parent,
-		void __iomem *base)
+struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
+		const char *parent, void __iomem *base)
 {
 	struct clk_pllv1 *pll;
 	struct clk *clk;
@@ -109,6 +125,7 @@ struct clk *imx_clk_pllv1(const char *name, const char *parent,
 		return ERR_PTR(-ENOMEM);
 
 	pll->base = base;
+	pll->type = type;
 
 	init.name = name;
 	init.ops = &clk_pllv1_ops;
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 6a07903a28bc..b5297e457a8e 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -10,8 +10,17 @@ void imx_check_clocks(struct clk *clks[], unsigned int count);
 
 extern void imx_cscmr1_fixup(u32 *val);
 
-struct clk *imx_clk_pllv1(const char *name, const char *parent,
-		void __iomem *base);
+enum imx_pllv1_type {
+	IMX_PLLV1_IMX1,
+	IMX_PLLV1_IMX21,
+	IMX_PLLV1_IMX25,
+	IMX_PLLV1_IMX27,
+	IMX_PLLV1_IMX31,
+	IMX_PLLV1_IMX35,
+};
+
+struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
+		const char *parent, void __iomem *base);
 
 struct clk *imx_clk_pllv2(const char *name, const char *parent,
 		void __iomem *base);
-- 
1.9.1
