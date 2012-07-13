From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 11:53:45 +0530
Subject: [PATCH 2/4] clk:spear1310:Fix: Rename clk ids within predefined limit
In-Reply-To: <cover.1342160220.git.vipulkumar.samar@st.com>
References: <cover.1342160220.git.vipulkumar.samar@st.com>
Message-ID: <3d0063867179e19bfcb845c93b1e00f57bfbcb77.1342160220.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The max limit of con_id is 16 and dev_id is 20. As of now for spear1310, many
clk ids are exceeding this predefined limit.

This patch is intended to rename clk ids like:
    mux_clk -> _mclk
    gate_clk -> _gclk
    synth_clk -> syn_clk
    gmac_phy -> phy_
    gmii_125m_pad -> gmii_pad

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 drivers/clk/spear/spear1310_clock.c |  312 +++++++++++++++++------------------
 1 files changed, 155 insertions(+), 157 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 8f05652..0fcec2a 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -345,31 +345,30 @@ static struct frac_rate_tbl gen_rtbl[] = {
 /* clock parents */
 static const char *vco_parents[] = { "osc_24m_clk", "osc_25m_clk", };
 static const char *gpt_parents[] = { "osc_24m_clk", "apb_clk", };
-static const char *uart0_parents[] = { "pll5_clk", "uart_synth_gate_clk", };
-static const char *c3_parents[] = { "pll5_clk", "c3_synth_gate_clk", };
-static const char *gmac_phy_input_parents[] = { "gmii_125m_pad_clk", "pll2_clk",
+static const char *uart0_parents[] = { "pll5_clk", "uart_syn_gclk", };
+static const char *c3_parents[] = { "pll5_clk", "c3_syn_gclk", };
+static const char *gmac_phy_input_parents[] = { "gmii_pad_clk", "pll2_clk",
 	"osc_25m_clk", };
-static const char *gmac_phy_parents[] = { "gmac_phy_input_mux_clk",
-	"gmac_phy_synth_gate_clk", };
+static const char *gmac_phy_parents[] = { "phy_input_mclk", "phy_syn_gclk", };
 static const char *clcd_synth_parents[] = { "vco1div4_clk", "pll2_clk", };
-static const char *clcd_pixel_parents[] = { "pll5_clk", "clcd_synth_clk", };
+static const char *clcd_pixel_parents[] = { "pll5_clk", "clcd_syn_clk", };
 static const char *i2s_src_parents[] = { "vco1div2_clk", "none", "pll3_clk",
 	"i2s_src_pad_clk", };
-static const char *i2s_ref_parents[] = { "i2s_src_mux_clk", "i2s_prs1_clk", };
+static const char *i2s_ref_parents[] = { "i2s_src_mclk", "i2s_prs1_clk", };
 static const char *gen_synth0_1_parents[] = { "vco1div4_clk", "vco3div2_clk",
 	"pll3_clk", };
 static const char *gen_synth2_3_parents[] = { "vco1div4_clk", "vco3div2_clk",
 	"pll2_clk", };
 static const char *rmii_phy_parents[] = { "ras_tx50_clk", "none",
-	"ras_pll2_clk", "ras_synth0_clk", };
+	"ras_pll2_clk", "ras_syn0_clk", };
 static const char *smii_rgmii_phy_parents[] = { "none", "ras_tx125_clk",
-	"ras_pll2_clk", "ras_synth0_clk", };
-static const char *uart_parents[] = { "ras_apb_clk", "gen_synth3_clk", };
-static const char *i2c_parents[] = { "ras_apb_clk", "gen_synth1_clk", };
-static const char *ssp1_parents[] = { "ras_apb_clk", "gen_synth1_clk",
+	"ras_pll2_clk", "ras_syn0_clk", };
+static const char *uart_parents[] = { "ras_apb_clk", "gen_syn3_clk", };
+static const char *i2c_parents[] = { "ras_apb_clk", "gen_syn1_clk", };
+static const char *ssp1_parents[] = { "ras_apb_clk", "gen_syn1_clk",
 	"ras_plclk0_clk", };
-static const char *pci_parents[] = { "ras_pll3_clk", "gen_synth2_clk", };
-static const char *tdm_parents[] = { "ras_pll3_clk", "gen_synth1_clk", };
+static const char *pci_parents[] = { "ras_pll3_clk", "gen_syn2_clk", };
+static const char *tdm_parents[] = { "ras_pll3_clk", "gen_syn1_clk", };
 
 void __init spear1310_clk_init(void)
 {
@@ -390,9 +389,9 @@ void __init spear1310_clk_init(void)
 			25000000);
 	clk_register_clkdev(clk, "osc_25m_clk", NULL);
 
-	clk = clk_register_fixed_rate(NULL, "gmii_125m_pad_clk", NULL,
-			CLK_IS_ROOT, 125000000);
-	clk_register_clkdev(clk, "gmii_125m_pad_clk", NULL);
+	clk = clk_register_fixed_rate(NULL, "gmii_pad_clk", NULL, CLK_IS_ROOT,
+			125000000);
+	clk_register_clkdev(clk, "gmii_pad_clk", NULL);
 
 	clk = clk_register_fixed_rate(NULL, "i2s_src_pad_clk", NULL,
 			CLK_IS_ROOT, 12288000);
@@ -406,34 +405,34 @@ void __init spear1310_clk_init(void)
 
 	/* clock derived from 24 or 25 MHz osc clk */
 	/* vco-pll */
-	clk = clk_register_mux(NULL, "vco1_mux_clk", vco_parents,
+	clk = clk_register_mux(NULL, "vco1_mclk", vco_parents,
 			ARRAY_SIZE(vco_parents), 0, SPEAR1310_PLL_CFG,
 			SPEAR1310_PLL1_CLK_SHIFT, SPEAR1310_PLL_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "vco1_mux_clk", NULL);
-	clk = clk_register_vco_pll("vco1_clk", "pll1_clk", NULL, "vco1_mux_clk",
+	clk_register_clkdev(clk, "vco1_mclk", NULL);
+	clk = clk_register_vco_pll("vco1_clk", "pll1_clk", NULL, "vco1_mclk",
 			0, SPEAR1310_PLL1_CTR, SPEAR1310_PLL1_FRQ, pll_rtbl,
 			ARRAY_SIZE(pll_rtbl), &_lock, &clk1, NULL);
 	clk_register_clkdev(clk, "vco1_clk", NULL);
 	clk_register_clkdev(clk1, "pll1_clk", NULL);
 
-	clk = clk_register_mux(NULL, "vco2_mux_clk", vco_parents,
+	clk = clk_register_mux(NULL, "vco2_mclk", vco_parents,
 			ARRAY_SIZE(vco_parents), 0, SPEAR1310_PLL_CFG,
 			SPEAR1310_PLL2_CLK_SHIFT, SPEAR1310_PLL_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "vco2_mux_clk", NULL);
-	clk = clk_register_vco_pll("vco2_clk", "pll2_clk", NULL, "vco2_mux_clk",
+	clk_register_clkdev(clk, "vco2_mclk", NULL);
+	clk = clk_register_vco_pll("vco2_clk", "pll2_clk", NULL, "vco2_mclk",
 			0, SPEAR1310_PLL2_CTR, SPEAR1310_PLL2_FRQ, pll_rtbl,
 			ARRAY_SIZE(pll_rtbl), &_lock, &clk1, NULL);
 	clk_register_clkdev(clk, "vco2_clk", NULL);
 	clk_register_clkdev(clk1, "pll2_clk", NULL);
 
-	clk = clk_register_mux(NULL, "vco3_mux_clk", vco_parents,
+	clk = clk_register_mux(NULL, "vco3_mclk", vco_parents,
 			ARRAY_SIZE(vco_parents), 0, SPEAR1310_PLL_CFG,
 			SPEAR1310_PLL3_CLK_SHIFT, SPEAR1310_PLL_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "vco3_mux_clk", NULL);
-	clk = clk_register_vco_pll("vco3_clk", "pll3_clk", NULL, "vco3_mux_clk",
+	clk_register_clkdev(clk, "vco3_mclk", NULL);
+	clk = clk_register_vco_pll("vco3_clk", "pll3_clk", NULL, "vco3_mclk",
 			0, SPEAR1310_PLL3_CTR, SPEAR1310_PLL3_FRQ, pll_rtbl,
 			ARRAY_SIZE(pll_rtbl), &_lock, &clk1, NULL);
 	clk_register_clkdev(clk, "vco3_clk", NULL);
@@ -473,7 +472,7 @@ void __init spear1310_clk_init(void)
 	/* peripherals */
 	clk_register_fixed_factor(NULL, "thermal_clk", "osc_24m_clk", 0, 1,
 			128);
-	clk = clk_register_gate(NULL, "thermal_gate_clk", "thermal_clk", 0,
+	clk = clk_register_gate(NULL, "thermal_gclk", "thermal_clk", 0,
 			SPEAR1310_PERIP2_CLK_ENB, SPEAR1310_THSENS_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spear_thermal");
@@ -500,177 +499,176 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, "apb_clk", NULL);
 
 	/* gpt clocks */
-	clk = clk_register_mux(NULL, "gpt0_mux_clk", gpt_parents,
+	clk = clk_register_mux(NULL, "gpt0_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), 0, SPEAR1310_PERIP_CLK_CFG,
 			SPEAR1310_GPT0_CLK_SHIFT, SPEAR1310_GPT_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "gpt0_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt0_clk", "gpt0_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt0_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt0_clk", "gpt0_mclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_GPT0_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt0");
 
-	clk = clk_register_mux(NULL, "gpt1_mux_clk", gpt_parents,
+	clk = clk_register_mux(NULL, "gpt1_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), 0, SPEAR1310_PERIP_CLK_CFG,
 			SPEAR1310_GPT1_CLK_SHIFT, SPEAR1310_GPT_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "gpt1_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt1_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_GPT1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt1");
 
-	clk = clk_register_mux(NULL, "gpt2_mux_clk", gpt_parents,
+	clk = clk_register_mux(NULL, "gpt2_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), 0, SPEAR1310_PERIP_CLK_CFG,
 			SPEAR1310_GPT2_CLK_SHIFT, SPEAR1310_GPT_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "gpt2_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt2_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
 			SPEAR1310_PERIP2_CLK_ENB, SPEAR1310_GPT2_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt2");
 
-	clk = clk_register_mux(NULL, "gpt3_mux_clk", gpt_parents,
+	clk = clk_register_mux(NULL, "gpt3_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), 0, SPEAR1310_PERIP_CLK_CFG,
 			SPEAR1310_GPT3_CLK_SHIFT, SPEAR1310_GPT_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "gpt3_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt3_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mclk", 0,
 			SPEAR1310_PERIP2_CLK_ENB, SPEAR1310_GPT3_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt3");
 
 	/* others */
-	clk = clk_register_aux("uart_synth_clk", "uart_synth_gate_clk",
-			"vco1div2_clk", 0, SPEAR1310_UART_CLK_SYNT, NULL,
-			aux_rtbl, ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "uart_synth_clk", NULL);
-	clk_register_clkdev(clk1, "uart_synth_gate_clk", NULL);
+	clk = clk_register_aux("uart_syn_clk", "uart_syn_gclk", "vco1div2_clk",
+			0, SPEAR1310_UART_CLK_SYNT, NULL, aux_rtbl,
+			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
+	clk_register_clkdev(clk, "uart_syn_clk", NULL);
+	clk_register_clkdev(clk1, "uart_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "uart0_mux_clk", uart0_parents,
+	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
 			ARRAY_SIZE(uart0_parents), 0, SPEAR1310_PERIP_CLK_CFG,
 			SPEAR1310_UART_CLK_SHIFT, SPEAR1310_UART_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "uart0_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart0_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart0_clk", "uart0_mux_clk", 0,
+	clk = clk_register_gate(NULL, "uart0_clk", "uart0_mclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_UART_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "e0000000.serial");
 
-	clk = clk_register_aux("sdhci_synth_clk", "sdhci_synth_gate_clk",
+	clk = clk_register_aux("sdhci_syn_clk", "sdhci_syn_gclk",
 			"vco1div2_clk", 0, SPEAR1310_SDHCI_CLK_SYNT, NULL,
 			aux_rtbl, ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "sdhci_synth_clk", NULL);
-	clk_register_clkdev(clk1, "sdhci_synth_gate_clk", NULL);
+	clk_register_clkdev(clk, "sdhci_syn_clk", NULL);
+	clk_register_clkdev(clk1, "sdhci_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "sdhci_clk", "sdhci_synth_gate_clk", 0,
+	clk = clk_register_gate(NULL, "sdhci_clk", "sdhci_syn_gclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_SDHCI_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "b3000000.sdhci");
 
-	clk = clk_register_aux("cfxd_synth_clk", "cfxd_synth_gate_clk",
-			"vco1div2_clk", 0, SPEAR1310_CFXD_CLK_SYNT, NULL,
-			aux_rtbl, ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "cfxd_synth_clk", NULL);
-	clk_register_clkdev(clk1, "cfxd_synth_gate_clk", NULL);
+	clk = clk_register_aux("cfxd_syn_clk", "cfxd_syn_gclk", "vco1div2_clk",
+			0, SPEAR1310_CFXD_CLK_SYNT, NULL, aux_rtbl,
+			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
+	clk_register_clkdev(clk, "cfxd_syn_clk", NULL);
+	clk_register_clkdev(clk1, "cfxd_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "cfxd_clk", "cfxd_synth_gate_clk", 0,
+	clk = clk_register_gate(NULL, "cfxd_clk", "cfxd_syn_gclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_CFXD_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "b2800000.cf");
 	clk_register_clkdev(clk, NULL, "arasan_xd");
 
-	clk = clk_register_aux("c3_synth_clk", "c3_synth_gate_clk",
-			"vco1div2_clk", 0, SPEAR1310_C3_CLK_SYNT, NULL,
-			aux_rtbl, ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "c3_synth_clk", NULL);
-	clk_register_clkdev(clk1, "c3_synth_gate_clk", NULL);
+	clk = clk_register_aux("c3_syn_clk", "c3_syn_gclk", "vco1div2_clk",
+			0, SPEAR1310_C3_CLK_SYNT, NULL, aux_rtbl,
+			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
+	clk_register_clkdev(clk, "c3_syn_clk", NULL);
+	clk_register_clkdev(clk1, "c3_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "c3_mux_clk", c3_parents,
+	clk = clk_register_mux(NULL, "c3_mclk", c3_parents,
 			ARRAY_SIZE(c3_parents), 0, SPEAR1310_PERIP_CLK_CFG,
 			SPEAR1310_C3_CLK_SHIFT, SPEAR1310_C3_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "c3_mux_clk", NULL);
+	clk_register_clkdev(clk, "c3_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "c3_clk", "c3_mux_clk", 0,
+	clk = clk_register_gate(NULL, "c3_clk", "c3_mclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_C3_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "c3");
 
 	/* gmac */
-	clk = clk_register_mux(NULL, "gmac_phy_input_mux_clk",
-			gmac_phy_input_parents,
+	clk = clk_register_mux(NULL, "phy_input_mclk", gmac_phy_input_parents,
 			ARRAY_SIZE(gmac_phy_input_parents), 0,
 			SPEAR1310_GMAC_CLK_CFG,
 			SPEAR1310_GMAC_PHY_INPUT_CLK_SHIFT,
 			SPEAR1310_GMAC_PHY_INPUT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gmac_phy_input_mux_clk", NULL);
+	clk_register_clkdev(clk, "phy_input_mclk", NULL);
 
-	clk = clk_register_aux("gmac_phy_synth_clk", "gmac_phy_synth_gate_clk",
-			"gmac_phy_input_mux_clk", 0, SPEAR1310_GMAC_CLK_SYNT,
-			NULL, gmac_rtbl, ARRAY_SIZE(gmac_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "gmac_phy_synth_clk", NULL);
-	clk_register_clkdev(clk1, "gmac_phy_synth_gate_clk", NULL);
+	clk = clk_register_aux("phy_syn_clk", "phy_syn_gclk", "phy_input_mclk",
+			0, SPEAR1310_GMAC_CLK_SYNT, NULL, gmac_rtbl,
+			ARRAY_SIZE(gmac_rtbl), &_lock, &clk1);
+	clk_register_clkdev(clk, "phy_syn_clk", NULL);
+	clk_register_clkdev(clk1, "phy_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "gmac_phy_mux_clk", gmac_phy_parents,
+	clk = clk_register_mux(NULL, "phy_mclk", gmac_phy_parents,
 			ARRAY_SIZE(gmac_phy_parents), 0,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GMAC_PHY_CLK_SHIFT,
 			SPEAR1310_GMAC_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "stmmacphy.0");
 
 	/* clcd */
-	clk = clk_register_mux(NULL, "clcd_synth_mux_clk", clcd_synth_parents,
+	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
 			ARRAY_SIZE(clcd_synth_parents), 0,
 			SPEAR1310_CLCD_CLK_SYNT, SPEAR1310_CLCD_SYNT_CLK_SHIFT,
 			SPEAR1310_CLCD_SYNT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "clcd_synth_mux_clk", NULL);
+	clk_register_clkdev(clk, "clcd_syn_mclk", NULL);
 
-	clk = clk_register_frac("clcd_synth_clk", "clcd_synth_mux_clk", 0,
+	clk = clk_register_frac("clcd_syn_clk", "clcd_syn_mclk", 0,
 			SPEAR1310_CLCD_CLK_SYNT, clcd_rtbl,
 			ARRAY_SIZE(clcd_rtbl), &_lock);
-	clk_register_clkdev(clk, "clcd_synth_clk", NULL);
+	clk_register_clkdev(clk, "clcd_syn_clk", NULL);
 
-	clk = clk_register_mux(NULL, "clcd_pixel_mux_clk", clcd_pixel_parents,
+	clk = clk_register_mux(NULL, "clcd_pixel_mclk", clcd_pixel_parents,
 			ARRAY_SIZE(clcd_pixel_parents), 0,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_CLCD_CLK_SHIFT,
 			SPEAR1310_CLCD_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_pixel_clk", NULL);
 
-	clk = clk_register_gate(NULL, "clcd_clk", "clcd_pixel_mux_clk", 0,
+	clk = clk_register_gate(NULL, "clcd_clk", "clcd_pixel_mclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_CLCD_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, "clcd_clk", NULL);
 
 	/* i2s */
-	clk = clk_register_mux(NULL, "i2s_src_mux_clk", i2s_src_parents,
+	clk = clk_register_mux(NULL, "i2s_src_mclk", i2s_src_parents,
 			ARRAY_SIZE(i2s_src_parents), 0, SPEAR1310_I2S_CLK_CFG,
 			SPEAR1310_I2S_SRC_CLK_SHIFT, SPEAR1310_I2S_SRC_CLK_MASK,
 			0, &_lock);
 	clk_register_clkdev(clk, "i2s_src_clk", NULL);
 
-	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mux_clk", 0,
+	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mclk", 0,
 			SPEAR1310_I2S_CLK_CFG, &i2s_prs1_masks, i2s_prs1_rtbl,
 			ARRAY_SIZE(i2s_prs1_rtbl), &_lock, NULL);
 	clk_register_clkdev(clk, "i2s_prs1_clk", NULL);
 
-	clk = clk_register_mux(NULL, "i2s_ref_mux_clk", i2s_ref_parents,
+	clk = clk_register_mux(NULL, "i2s_ref_mclk", i2s_ref_parents,
 			ARRAY_SIZE(i2s_ref_parents), 0, SPEAR1310_I2S_CLK_CFG,
 			SPEAR1310_I2S_REF_SHIFT, SPEAR1310_I2S_REF_SEL_MASK, 0,
 			&_lock);
 	clk_register_clkdev(clk, "i2s_ref_clk", NULL);
 
-	clk = clk_register_gate(NULL, "i2s_ref_pad_clk", "i2s_ref_mux_clk", 0,
+	clk = clk_register_gate(NULL, "i2s_ref_pad_clk", "i2s_ref_mclk", 0,
 			SPEAR1310_PERIP2_CLK_ENB, SPEAR1310_I2S_REF_PAD_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_pad_clk", NULL);
 
-	clk = clk_register_aux("i2s_sclk_clk", "i2s_sclk_gate_clk",
+	clk = clk_register_aux("i2s_sclk_clk", "i2s_sclk_gclk",
 			"i2s_ref_pad_clk", 0, SPEAR1310_I2S_CLK_CFG,
 			&i2s_sclk_masks, i2s_sclk_rtbl,
 			ARRAY_SIZE(i2s_sclk_rtbl), &_lock, &clk1);
 	clk_register_clkdev(clk, "i2s_sclk_clk", NULL);
-	clk_register_clkdev(clk1, "i2s_sclk_gate_clk", NULL);
+	clk_register_clkdev(clk1, "i2s_sclk_gclk", NULL);
 
 	/* clock derived from ahb clk */
 	clk = clk_register_gate(NULL, "i2c0_clk", "ahb_clk", 0,
@@ -747,13 +745,13 @@ void __init spear1310_clk_init(void)
 			&_lock);
 	clk_register_clkdev(clk, "sysram1_clk", NULL);
 
-	clk = clk_register_aux("adc_synth_clk", "adc_synth_gate_clk", "ahb_clk",
+	clk = clk_register_aux("adc_syn_clk", "adc_syn_gclk", "ahb_clk",
 			0, SPEAR1310_ADC_CLK_SYNT, NULL, adc_rtbl,
 			ARRAY_SIZE(adc_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "adc_synth_clk", NULL);
-	clk_register_clkdev(clk1, "adc_synth_gate_clk", NULL);
+	clk_register_clkdev(clk, "adc_syn_clk", NULL);
+	clk_register_clkdev(clk1, "adc_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "adc_clk", "adc_synth_gate_clk", 0,
+	clk = clk_register_gate(NULL, "adc_clk", "adc_syn_gclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_ADC_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "adc_clk");
@@ -790,37 +788,37 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, NULL, "e0300000.kbd");
 
 	/* RAS clks */
-	clk = clk_register_mux(NULL, "gen_synth0_1_mux_clk",
-			gen_synth0_1_parents, ARRAY_SIZE(gen_synth0_1_parents),
-			0, SPEAR1310_PLL_CFG, SPEAR1310_RAS_SYNT0_1_CLK_SHIFT,
+	clk = clk_register_mux(NULL, "gen_syn0_1_mclk", gen_synth0_1_parents,
+			ARRAY_SIZE(gen_synth0_1_parents), 0, SPEAR1310_PLL_CFG,
+			SPEAR1310_RAS_SYNT0_1_CLK_SHIFT,
 			SPEAR1310_RAS_SYNT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gen_synth0_1_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn0_1_clk", NULL);
 
-	clk = clk_register_mux(NULL, "gen_synth2_3_mux_clk",
-			gen_synth2_3_parents, ARRAY_SIZE(gen_synth2_3_parents),
-			0, SPEAR1310_PLL_CFG, SPEAR1310_RAS_SYNT2_3_CLK_SHIFT,
+	clk = clk_register_mux(NULL, "gen_syn2_3_mclk", gen_synth2_3_parents,
+			ARRAY_SIZE(gen_synth2_3_parents), 0, SPEAR1310_PLL_CFG,
+			SPEAR1310_RAS_SYNT2_3_CLK_SHIFT,
 			SPEAR1310_RAS_SYNT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gen_synth2_3_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn2_3_clk", NULL);
 
-	clk = clk_register_frac("gen_synth0_clk", "gen_synth0_1_clk", 0,
+	clk = clk_register_frac("gen_syn0_clk", "gen_syn0_1_clk", 0,
 			SPEAR1310_RAS_CLK_SYNT0, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
-	clk_register_clkdev(clk, "gen_synth0_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn0_clk", NULL);
 
-	clk = clk_register_frac("gen_synth1_clk", "gen_synth0_1_clk", 0,
+	clk = clk_register_frac("gen_syn1_clk", "gen_syn0_1_clk", 0,
 			SPEAR1310_RAS_CLK_SYNT1, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
-	clk_register_clkdev(clk, "gen_synth1_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn1_clk", NULL);
 
-	clk = clk_register_frac("gen_synth2_clk", "gen_synth2_3_clk", 0,
+	clk = clk_register_frac("gen_syn2_clk", "gen_syn2_3_clk", 0,
 			SPEAR1310_RAS_CLK_SYNT2, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
-	clk_register_clkdev(clk, "gen_synth2_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn2_clk", NULL);
 
-	clk = clk_register_frac("gen_synth3_clk", "gen_synth2_3_clk", 0,
+	clk = clk_register_frac("gen_syn3_clk", "gen_syn2_3_clk", 0,
 			SPEAR1310_RAS_CLK_SYNT3, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
-	clk_register_clkdev(clk, "gen_synth3_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn3_clk", NULL);
 
 	clk = clk_register_gate(NULL, "ras_osc_24m_clk", "osc_24m_clk", 0,
 			SPEAR1310_RAS_CLK_ENB, SPEAR1310_OSC_24M_CLK_ENB, 0,
@@ -847,7 +845,7 @@ void __init spear1310_clk_init(void)
 			&_lock);
 	clk_register_clkdev(clk, "ras_pll3_clk", NULL);
 
-	clk = clk_register_gate(NULL, "ras_tx125_clk", "gmii_125m_pad_clk", 0,
+	clk = clk_register_gate(NULL, "ras_tx125_clk", "gmii_pad_clk", 0,
 			SPEAR1310_RAS_CLK_ENB, SPEAR1310_C125M_PAD_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, "ras_tx125_clk", NULL);
@@ -912,7 +910,7 @@ void __init spear1310_clk_init(void)
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5c700000.eth");
 
-	clk = clk_register_mux(NULL, "smii_rgmii_phy_mux_clk",
+	clk = clk_register_mux(NULL, "smii_rgmii_phy_mclk",
 			smii_rgmii_phy_parents,
 			ARRAY_SIZE(smii_rgmii_phy_parents), 0,
 			SPEAR1310_RAS_CTRL_REG1,
@@ -922,184 +920,184 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, NULL, "stmmacphy.2");
 	clk_register_clkdev(clk, NULL, "stmmacphy.4");
 
-	clk = clk_register_mux(NULL, "rmii_phy_mux_clk", rmii_phy_parents,
+	clk = clk_register_mux(NULL, "rmii_phy_mclk", rmii_phy_parents,
 			ARRAY_SIZE(rmii_phy_parents), 0,
 			SPEAR1310_RAS_CTRL_REG1, SPEAR1310_RMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "stmmacphy.3");
 
-	clk = clk_register_mux(NULL, "uart1_mux_clk", uart_parents,
+	clk = clk_register_mux(NULL, "uart1_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_UART1_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
 			0, &_lock);
-	clk_register_clkdev(clk, "uart1_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart1_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart1_clk", "uart1_mux_clk", 0,
+	clk = clk_register_gate(NULL, "uart1_clk", "uart1_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_UART1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5c800000.serial");
 
-	clk = clk_register_mux(NULL, "uart2_mux_clk", uart_parents,
+	clk = clk_register_mux(NULL, "uart2_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_UART2_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
 			0, &_lock);
-	clk_register_clkdev(clk, "uart2_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart2_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart2_clk", "uart2_mux_clk", 0,
+	clk = clk_register_gate(NULL, "uart2_clk", "uart2_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_UART2_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5c900000.serial");
 
-	clk = clk_register_mux(NULL, "uart3_mux_clk", uart_parents,
+	clk = clk_register_mux(NULL, "uart3_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_UART3_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
 			0, &_lock);
-	clk_register_clkdev(clk, "uart3_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart3_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart3_clk", "uart3_mux_clk", 0,
+	clk = clk_register_gate(NULL, "uart3_clk", "uart3_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_UART3_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5ca00000.serial");
 
-	clk = clk_register_mux(NULL, "uart4_mux_clk", uart_parents,
+	clk = clk_register_mux(NULL, "uart4_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_UART4_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
 			0, &_lock);
-	clk_register_clkdev(clk, "uart4_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart4_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart4_clk", "uart4_mux_clk", 0,
+	clk = clk_register_gate(NULL, "uart4_clk", "uart4_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_UART4_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5cb00000.serial");
 
-	clk = clk_register_mux(NULL, "uart5_mux_clk", uart_parents,
+	clk = clk_register_mux(NULL, "uart5_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_UART5_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
 			0, &_lock);
-	clk_register_clkdev(clk, "uart5_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart5_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart5_clk", "uart5_mux_clk", 0,
+	clk = clk_register_gate(NULL, "uart5_clk", "uart5_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_UART5_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5cc00000.serial");
 
-	clk = clk_register_mux(NULL, "i2c1_mux_clk", i2c_parents,
+	clk = clk_register_mux(NULL, "i2c1_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_I2C1_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "i2c1_mux_clk", NULL);
+	clk_register_clkdev(clk, "i2c1_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "i2c1_clk", "i2c1_mux_clk", 0,
+	clk = clk_register_gate(NULL, "i2c1_clk", "i2c1_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_I2C1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5cd00000.i2c");
 
-	clk = clk_register_mux(NULL, "i2c2_mux_clk", i2c_parents,
+	clk = clk_register_mux(NULL, "i2c2_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_I2C2_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "i2c2_mux_clk", NULL);
+	clk_register_clkdev(clk, "i2c2_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "i2c2_clk", "i2c2_mux_clk", 0,
+	clk = clk_register_gate(NULL, "i2c2_clk", "i2c2_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_I2C2_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5ce00000.i2c");
 
-	clk = clk_register_mux(NULL, "i2c3_mux_clk", i2c_parents,
+	clk = clk_register_mux(NULL, "i2c3_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_I2C3_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "i2c3_mux_clk", NULL);
+	clk_register_clkdev(clk, "i2c3_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "i2c3_clk", "i2c3_mux_clk", 0,
+	clk = clk_register_gate(NULL, "i2c3_clk", "i2c3_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_I2C3_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5cf00000.i2c");
 
-	clk = clk_register_mux(NULL, "i2c4_mux_clk", i2c_parents,
+	clk = clk_register_mux(NULL, "i2c4_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_I2C4_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "i2c4_mux_clk", NULL);
+	clk_register_clkdev(clk, "i2c4_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "i2c4_clk", "i2c4_mux_clk", 0,
+	clk = clk_register_gate(NULL, "i2c4_clk", "i2c4_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_I2C4_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5d000000.i2c");
 
-	clk = clk_register_mux(NULL, "i2c5_mux_clk", i2c_parents,
+	clk = clk_register_mux(NULL, "i2c5_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_I2C5_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "i2c5_mux_clk", NULL);
+	clk_register_clkdev(clk, "i2c5_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "i2c5_clk", "i2c5_mux_clk", 0,
+	clk = clk_register_gate(NULL, "i2c5_clk", "i2c5_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_I2C5_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5d100000.i2c");
 
-	clk = clk_register_mux(NULL, "i2c6_mux_clk", i2c_parents,
+	clk = clk_register_mux(NULL, "i2c6_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_I2C6_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "i2c6_mux_clk", NULL);
+	clk_register_clkdev(clk, "i2c6_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "i2c6_clk", "i2c6_mux_clk", 0,
+	clk = clk_register_gate(NULL, "i2c6_clk", "i2c6_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_I2C6_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5d200000.i2c");
 
-	clk = clk_register_mux(NULL, "i2c7_mux_clk", i2c_parents,
+	clk = clk_register_mux(NULL, "i2c7_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_I2C7_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "i2c7_mux_clk", NULL);
+	clk_register_clkdev(clk, "i2c7_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "i2c7_clk", "i2c7_mux_clk", 0,
+	clk = clk_register_gate(NULL, "i2c7_clk", "i2c7_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_I2C7_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5d300000.i2c");
 
-	clk = clk_register_mux(NULL, "ssp1_mux_clk", ssp1_parents,
+	clk = clk_register_mux(NULL, "ssp1_mclk", ssp1_parents,
 			ARRAY_SIZE(ssp1_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_SSP1_CLK_SHIFT, SPEAR1310_SSP1_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "ssp1_mux_clk", NULL);
+	clk_register_clkdev(clk, "ssp1_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "ssp1_clk", "ssp1_mux_clk", 0,
+	clk = clk_register_gate(NULL, "ssp1_clk", "ssp1_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_SSP1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "5d400000.spi");
 
-	clk = clk_register_mux(NULL, "pci_mux_clk", pci_parents,
+	clk = clk_register_mux(NULL, "pci_mclk", pci_parents,
 			ARRAY_SIZE(pci_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_PCI_CLK_SHIFT, SPEAR1310_PCI_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "pci_mux_clk", NULL);
+	clk_register_clkdev(clk, "pci_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "pci_clk", "pci_mux_clk", 0,
+	clk = clk_register_gate(NULL, "pci_clk", "pci_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_PCI_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "pci");
 
-	clk = clk_register_mux(NULL, "tdm1_mux_clk", tdm_parents,
+	clk = clk_register_mux(NULL, "tdm1_mclk", tdm_parents,
 			ARRAY_SIZE(tdm_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_TDM1_CLK_SHIFT, SPEAR1310_TDM_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "tdm1_mux_clk", NULL);
+	clk_register_clkdev(clk, "tdm1_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "tdm1_clk", "tdm1_mux_clk", 0,
+	clk = clk_register_gate(NULL, "tdm1_clk", "tdm1_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_TDM1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "tdm_hdlc.0");
 
-	clk = clk_register_mux(NULL, "tdm2_mux_clk", tdm_parents,
+	clk = clk_register_mux(NULL, "tdm2_mclk", tdm_parents,
 			ARRAY_SIZE(tdm_parents), 0, SPEAR1310_RAS_CTRL_REG0,
 			SPEAR1310_TDM2_CLK_SHIFT, SPEAR1310_TDM_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "tdm2_mux_clk", NULL);
+	clk_register_clkdev(clk, "tdm2_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "tdm2_clk", "tdm2_mux_clk", 0,
+	clk = clk_register_gate(NULL, "tdm2_clk", "tdm2_mclk", 0,
 			SPEAR1310_RAS_SW_CLK_CTRL, SPEAR1310_TDM2_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "tdm_hdlc.1");
-- 
1.7.2.2
