From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Mon, 16 Jul 2012 09:55:38 +0530
Subject: [PATCH v2 1/4] clk:spear1340:Fix: Rename clk ids within predefined
 limit
In-Reply-To: <cover.1342411982.git.vipulkumar.samar@st.com>
References: <cover.1342411982.git.vipulkumar.samar@st.com>
Message-ID: <b43c4e64ed61d4c18f5c3326539f7f03e9604ef1.1342411982.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The max limit of con_id is 16 and dev_id is 20. As of now for spear1340, many
clk ids are exceeding this predefined limit.

This patch rename clk ids like:
    mux_clk -> _mclk
    gate_clk -> _gclk
    synth_clk -> syn_clk
    gmac_phy -> phy_
    gmii_125m_pad_ -> gmii_pad

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Acked-by: Viiresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1340_clock.c |  273 +++++++++++++++++------------------
 1 files changed, 135 insertions(+), 138 deletions(-)

diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index e3ea721..0f2324b 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -370,26 +370,24 @@ static struct frac_rate_tbl gen_rtbl[] = {
 /* clock parents */
 static const char *vco_parents[] = { "osc_24m_clk", "osc_25m_clk", };
 static const char *sys_parents[] = { "none", "pll1_clk", "none", "none",
-	"sys_synth_clk", "none", "pll2_clk", "pll3_clk", };
-static const char *ahb_parents[] = { "cpu_div3_clk", "amba_synth_clk", };
+	"sys_syn_clk", "none", "pll2_clk", "pll3_clk", };
+static const char *ahb_parents[] = { "cpu_div3_clk", "amba_syn_clk", };
 static const char *gpt_parents[] = { "osc_24m_clk", "apb_clk", };
 static const char *uart0_parents[] = { "pll5_clk", "osc_24m_clk",
-	"uart0_synth_gate_clk", };
+	"uart0_syn_gclk", };
 static const char *uart1_parents[] = { "pll5_clk", "osc_24m_clk",
-	"uart1_synth_gate_clk", };
-static const char *c3_parents[] = { "pll5_clk", "c3_synth_gate_clk", };
-static const char *gmac_phy_input_parents[] = { "gmii_125m_pad_clk", "pll2_clk",
+	"uart1_syn_gclk", };
+static const char *c3_parents[] = { "pll5_clk", "c3_syn_gclk", };
+static const char *gmac_phy_input_parents[] = { "gmii_pad_clk", "pll2_clk",
 	"osc_25m_clk", };
-static const char *gmac_phy_parents[] = { "gmac_phy_input_mux_clk",
-	"gmac_phy_synth_gate_clk", };
+static const char *gmac_phy_parents[] = { "phy_input_mclk", "phy_syn_gclk", };
 static const char *clcd_synth_parents[] = { "vco1div4_clk", "pll2_clk", };
-static const char *clcd_pixel_parents[] = { "pll5_clk", "clcd_synth_clk", };
+static const char *clcd_pixel_parents[] = { "pll5_clk", "clcd_syn_clk", };
 static const char *i2s_src_parents[] = { "vco1div2_clk", "pll2_clk", "pll3_clk",
 	"i2s_src_pad_clk", };
-static const char *i2s_ref_parents[] = { "i2s_src_mux_clk", "i2s_prs1_clk", };
-static const char *spdif_out_parents[] = { "i2s_src_pad_clk", "gen_synth2_clk",
-};
-static const char *spdif_in_parents[] = { "pll2_clk", "gen_synth3_clk", };
+static const char *i2s_ref_parents[] = { "i2s_src_mclk", "i2s_prs1_clk", };
+static const char *spdif_out_parents[] = { "i2s_src_pad_clk", "gen_syn2_clk", };
+static const char *spdif_in_parents[] = { "pll2_clk", "gen_syn3_clk", };
 
 static const char *gen_synth0_1_parents[] = { "vco1div4_clk", "vco3div2_clk",
 	"pll3_clk", };
@@ -415,9 +413,9 @@ void __init spear1340_clk_init(void)
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
@@ -431,35 +429,35 @@ void __init spear1340_clk_init(void)
 
 	/* clock derived from 24 or 25 MHz osc clk */
 	/* vco-pll */
-	clk = clk_register_mux(NULL, "vco1_mux_clk", vco_parents,
+	clk = clk_register_mux(NULL, "vco1_mclk", vco_parents,
 			ARRAY_SIZE(vco_parents), 0, SPEAR1340_PLL_CFG,
 			SPEAR1340_PLL1_CLK_SHIFT, SPEAR1340_PLL_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "vco1_mux_clk", NULL);
-	clk = clk_register_vco_pll("vco1_clk", "pll1_clk", NULL, "vco1_mux_clk",
-			0, SPEAR1340_PLL1_CTR, SPEAR1340_PLL1_FRQ, pll_rtbl,
+	clk_register_clkdev(clk, "vco1_mclk", NULL);
+	clk = clk_register_vco_pll("vco1_clk", "pll1_clk", NULL, "vco1_mclk", 0,
+			SPEAR1340_PLL1_CTR, SPEAR1340_PLL1_FRQ, pll_rtbl,
 			ARRAY_SIZE(pll_rtbl), &_lock, &clk1, NULL);
 	clk_register_clkdev(clk, "vco1_clk", NULL);
 	clk_register_clkdev(clk1, "pll1_clk", NULL);
 
-	clk = clk_register_mux(NULL, "vco2_mux_clk", vco_parents,
+	clk = clk_register_mux(NULL, "vco2_mclk", vco_parents,
 			ARRAY_SIZE(vco_parents), 0, SPEAR1340_PLL_CFG,
 			SPEAR1340_PLL2_CLK_SHIFT, SPEAR1340_PLL_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "vco2_mux_clk", NULL);
-	clk = clk_register_vco_pll("vco2_clk", "pll2_clk", NULL, "vco2_mux_clk",
-			0, SPEAR1340_PLL2_CTR, SPEAR1340_PLL2_FRQ, pll_rtbl,
+	clk_register_clkdev(clk, "vco2_mclk", NULL);
+	clk = clk_register_vco_pll("vco2_clk", "pll2_clk", NULL, "vco2_mclk", 0,
+			SPEAR1340_PLL2_CTR, SPEAR1340_PLL2_FRQ, pll_rtbl,
 			ARRAY_SIZE(pll_rtbl), &_lock, &clk1, NULL);
 	clk_register_clkdev(clk, "vco2_clk", NULL);
 	clk_register_clkdev(clk1, "pll2_clk", NULL);
 
-	clk = clk_register_mux(NULL, "vco3_mux_clk", vco_parents,
+	clk = clk_register_mux(NULL, "vco3_mclk", vco_parents,
 			ARRAY_SIZE(vco_parents), 0, SPEAR1340_PLL_CFG,
 			SPEAR1340_PLL3_CLK_SHIFT, SPEAR1340_PLL_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "vco3_mux_clk", NULL);
-	clk = clk_register_vco_pll("vco3_clk", "pll3_clk", NULL, "vco3_mux_clk",
-			0, SPEAR1340_PLL3_CTR, SPEAR1340_PLL3_FRQ, pll_rtbl,
+	clk_register_clkdev(clk, "vco3_mclk", NULL);
+	clk = clk_register_vco_pll("vco3_clk", "pll3_clk", NULL, "vco3_mclk", 0,
+			SPEAR1340_PLL3_CTR, SPEAR1340_PLL3_FRQ, pll_rtbl,
 			ARRAY_SIZE(pll_rtbl), &_lock, &clk1, NULL);
 	clk_register_clkdev(clk, "vco3_clk", NULL);
 	clk_register_clkdev(clk1, "pll3_clk", NULL);
@@ -498,7 +496,7 @@ void __init spear1340_clk_init(void)
 	/* peripherals */
 	clk_register_fixed_factor(NULL, "thermal_clk", "osc_24m_clk", 0, 1,
 			128);
-	clk = clk_register_gate(NULL, "thermal_gate_clk", "thermal_clk", 0,
+	clk = clk_register_gate(NULL, "thermal_gclk", "thermal_clk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_THSENS_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spear_thermal");
@@ -509,23 +507,23 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, "ddr_clk", NULL);
 
 	/* clock derived from pll1 clk */
-	clk = clk_register_frac("sys_synth_clk", "vco1div2_clk", 0,
+	clk = clk_register_frac("sys_syn_clk", "vco1div2_clk", 0,
 			SPEAR1340_SYS_CLK_SYNT, sys_synth_rtbl,
 			ARRAY_SIZE(sys_synth_rtbl), &_lock);
-	clk_register_clkdev(clk, "sys_synth_clk", NULL);
+	clk_register_clkdev(clk, "sys_syn_clk", NULL);
 
-	clk = clk_register_frac("amba_synth_clk", "vco1div2_clk", 0,
+	clk = clk_register_frac("amba_syn_clk", "vco1div2_clk", 0,
 			SPEAR1340_AMBA_CLK_SYNT, amba_synth_rtbl,
 			ARRAY_SIZE(amba_synth_rtbl), &_lock);
-	clk_register_clkdev(clk, "amba_synth_clk", NULL);
+	clk_register_clkdev(clk, "amba_syn_clk", NULL);
 
-	clk = clk_register_mux(NULL, "sys_mux_clk", sys_parents,
+	clk = clk_register_mux(NULL, "sys_mclk", sys_parents,
 			ARRAY_SIZE(sys_parents), 0, SPEAR1340_SYS_CLK_CTRL,
 			SPEAR1340_SCLK_SRC_SEL_SHIFT,
 			SPEAR1340_SCLK_SRC_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "sys_clk", NULL);
 
-	clk = clk_register_fixed_factor(NULL, "cpu_clk", "sys_mux_clk", 0, 1,
+	clk = clk_register_fixed_factor(NULL, "cpu_clk", "sys_mclk", 0, 1,
 			2);
 	clk_register_clkdev(clk, "cpu_clk", NULL);
 
@@ -548,194 +546,193 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, "apb_clk", NULL);
 
 	/* gpt clocks */
-	clk = clk_register_mux(NULL, "gpt0_mux_clk", gpt_parents,
+	clk = clk_register_mux(NULL, "gpt0_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), 0, SPEAR1340_PERIP_CLK_CFG,
 			SPEAR1340_GPT0_CLK_SHIFT, SPEAR1340_GPT_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "gpt0_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt0_clk", "gpt0_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt0_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt0_clk", "gpt0_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_GPT0_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt0");
 
-	clk = clk_register_mux(NULL, "gpt1_mux_clk", gpt_parents,
+	clk = clk_register_mux(NULL, "gpt1_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), 0, SPEAR1340_PERIP_CLK_CFG,
 			SPEAR1340_GPT1_CLK_SHIFT, SPEAR1340_GPT_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "gpt1_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt1_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_GPT1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt1");
 
-	clk = clk_register_mux(NULL, "gpt2_mux_clk", gpt_parents,
+	clk = clk_register_mux(NULL, "gpt2_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), 0, SPEAR1340_PERIP_CLK_CFG,
 			SPEAR1340_GPT2_CLK_SHIFT, SPEAR1340_GPT_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "gpt2_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt2_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_GPT2_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt2");
 
-	clk = clk_register_mux(NULL, "gpt3_mux_clk", gpt_parents,
+	clk = clk_register_mux(NULL, "gpt3_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), 0, SPEAR1340_PERIP_CLK_CFG,
 			SPEAR1340_GPT3_CLK_SHIFT, SPEAR1340_GPT_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "gpt3_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt3_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mclk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_GPT3_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt3");
 
 	/* others */
-	clk = clk_register_aux("uart0_synth_clk", "uart0_synth_gate_clk",
+	clk = clk_register_aux("uart0_syn_clk", "uart0_syn_gclk",
 			"vco1div2_clk", 0, SPEAR1340_UART0_CLK_SYNT, NULL,
 			aux_rtbl, ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "uart0_synth_clk", NULL);
-	clk_register_clkdev(clk1, "uart0_synth_gate_clk", NULL);
+	clk_register_clkdev(clk, "uart0_syn_clk", NULL);
+	clk_register_clkdev(clk1, "uart0_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "uart0_mux_clk", uart0_parents,
+	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
 			ARRAY_SIZE(uart0_parents), 0, SPEAR1340_PERIP_CLK_CFG,
 			SPEAR1340_UART0_CLK_SHIFT, SPEAR1340_UART_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "uart0_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart0_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart0_clk", "uart0_mux_clk", 0,
+	clk = clk_register_gate(NULL, "uart0_clk", "uart0_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_UART0_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "e0000000.serial");
 
-	clk = clk_register_aux("uart1_synth_clk", "uart1_synth_gate_clk",
+	clk = clk_register_aux("uart1_syn_clk", "uart1_syn_gclk",
 			"vco1div2_clk", 0, SPEAR1340_UART1_CLK_SYNT, NULL,
 			aux_rtbl, ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "uart1_synth_clk", NULL);
-	clk_register_clkdev(clk1, "uart1_synth_gate_clk", NULL);
+	clk_register_clkdev(clk, "uart1_syn_clk", NULL);
+	clk_register_clkdev(clk1, "uart1_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "uart1_mux_clk", uart1_parents,
+	clk = clk_register_mux(NULL, "uart1_mclk", uart1_parents,
 			ARRAY_SIZE(uart1_parents), 0, SPEAR1340_PERIP_CLK_CFG,
 			SPEAR1340_UART1_CLK_SHIFT, SPEAR1340_UART_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "uart1_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart1_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart1_clk", "uart1_mux_clk", 0,
+	clk = clk_register_gate(NULL, "uart1_clk", "uart1_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_UART1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "b4100000.serial");
 
-	clk = clk_register_aux("sdhci_synth_clk", "sdhci_synth_gate_clk",
+	clk = clk_register_aux("sdhci_syn_clk", "sdhci_syn_gclk",
 			"vco1div2_clk", 0, SPEAR1340_SDHCI_CLK_SYNT, NULL,
 			aux_rtbl, ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "sdhci_synth_clk", NULL);
-	clk_register_clkdev(clk1, "sdhci_synth_gate_clk", NULL);
+	clk_register_clkdev(clk, "sdhci_syn_clk", NULL);
+	clk_register_clkdev(clk1, "sdhci_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "sdhci_clk", "sdhci_synth_gate_clk", 0,
+	clk = clk_register_gate(NULL, "sdhci_clk", "sdhci_syn_gclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_SDHCI_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "b3000000.sdhci");
 
-	clk = clk_register_aux("cfxd_synth_clk", "cfxd_synth_gate_clk",
-			"vco1div2_clk", 0, SPEAR1340_CFXD_CLK_SYNT, NULL,
-			aux_rtbl, ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "cfxd_synth_clk", NULL);
-	clk_register_clkdev(clk1, "cfxd_synth_gate_clk", NULL);
+	clk = clk_register_aux("cfxd_syn_clk", "cfxd_syn_gclk", "vco1div2_clk",
+			0, SPEAR1340_CFXD_CLK_SYNT, NULL, aux_rtbl,
+			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
+	clk_register_clkdev(clk, "cfxd_syn_clk", NULL);
+	clk_register_clkdev(clk1, "cfxd_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "cfxd_clk", "cfxd_synth_gate_clk", 0,
+	clk = clk_register_gate(NULL, "cfxd_clk", "cfxd_syn_gclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_CFXD_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "b2800000.cf");
 	clk_register_clkdev(clk, NULL, "arasan_xd");
 
-	clk = clk_register_aux("c3_synth_clk", "c3_synth_gate_clk",
-			"vco1div2_clk", 0, SPEAR1340_C3_CLK_SYNT, NULL,
-			aux_rtbl, ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "c3_synth_clk", NULL);
-	clk_register_clkdev(clk1, "c3_synth_gate_clk", NULL);
+	clk = clk_register_aux("c3_syn_clk", "c3_syn_gclk", "vco1div2_clk", 0,
+			SPEAR1340_C3_CLK_SYNT, NULL, aux_rtbl,
+			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
+	clk_register_clkdev(clk, "c3_syn_clk", NULL);
+	clk_register_clkdev(clk1, "c3_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "c3_mux_clk", c3_parents,
+	clk = clk_register_mux(NULL, "c3_mclk", c3_parents,
 			ARRAY_SIZE(c3_parents), 0, SPEAR1340_PERIP_CLK_CFG,
 			SPEAR1340_C3_CLK_SHIFT, SPEAR1340_C3_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "c3_mux_clk", NULL);
+	clk_register_clkdev(clk, "c3_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "c3_clk", "c3_mux_clk", 0,
+	clk = clk_register_gate(NULL, "c3_clk", "c3_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_C3_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "c3");
 
 	/* gmac */
-	clk = clk_register_mux(NULL, "gmac_phy_input_mux_clk",
-			gmac_phy_input_parents,
+	clk = clk_register_mux(NULL, "phy_input_mclk", gmac_phy_input_parents,
 			ARRAY_SIZE(gmac_phy_input_parents), 0,
 			SPEAR1340_GMAC_CLK_CFG,
 			SPEAR1340_GMAC_PHY_INPUT_CLK_SHIFT,
 			SPEAR1340_GMAC_PHY_INPUT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gmac_phy_input_mux_clk", NULL);
+	clk_register_clkdev(clk, "phy_input_mclk", NULL);
 
-	clk = clk_register_aux("gmac_phy_synth_clk", "gmac_phy_synth_gate_clk",
-			"gmac_phy_input_mux_clk", 0, SPEAR1340_GMAC_CLK_SYNT,
-			NULL, gmac_rtbl, ARRAY_SIZE(gmac_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "gmac_phy_synth_clk", NULL);
-	clk_register_clkdev(clk1, "gmac_phy_synth_gate_clk", NULL);
+	clk = clk_register_aux("phy_syn_clk", "phy_syn_gclk", "phy_input_mclk",
+			0, SPEAR1340_GMAC_CLK_SYNT, NULL, gmac_rtbl,
+			ARRAY_SIZE(gmac_rtbl), &_lock, &clk1);
+	clk_register_clkdev(clk, "phy_syn_clk", NULL);
+	clk_register_clkdev(clk1, "phy_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "gmac_phy_mux_clk", gmac_phy_parents,
+	clk = clk_register_mux(NULL, "phy_mclk", gmac_phy_parents,
 			ARRAY_SIZE(gmac_phy_parents), 0,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GMAC_PHY_CLK_SHIFT,
 			SPEAR1340_GMAC_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "stmmacphy.0");
 
 	/* clcd */
-	clk = clk_register_mux(NULL, "clcd_synth_mux_clk", clcd_synth_parents,
+	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
 			ARRAY_SIZE(clcd_synth_parents), 0,
 			SPEAR1340_CLCD_CLK_SYNT, SPEAR1340_CLCD_SYNT_CLK_SHIFT,
 			SPEAR1340_CLCD_SYNT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "clcd_synth_mux_clk", NULL);
+	clk_register_clkdev(clk, "clcd_syn_mclk", NULL);
 
-	clk = clk_register_frac("clcd_synth_clk", "clcd_synth_mux_clk", 0,
+	clk = clk_register_frac("clcd_syn_clk", "clcd_syn_mclk", 0,
 			SPEAR1340_CLCD_CLK_SYNT, clcd_rtbl,
 			ARRAY_SIZE(clcd_rtbl), &_lock);
-	clk_register_clkdev(clk, "clcd_synth_clk", NULL);
+	clk_register_clkdev(clk, "clcd_syn_clk", NULL);
 
-	clk = clk_register_mux(NULL, "clcd_pixel_mux_clk", clcd_pixel_parents,
+	clk = clk_register_mux(NULL, "clcd_pixel_mclk", clcd_pixel_parents,
 			ARRAY_SIZE(clcd_pixel_parents), 0,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_CLCD_CLK_SHIFT,
 			SPEAR1340_CLCD_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_pixel_clk", NULL);
 
-	clk = clk_register_gate(NULL, "clcd_clk", "clcd_pixel_mux_clk", 0,
+	clk = clk_register_gate(NULL, "clcd_clk", "clcd_pixel_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_CLCD_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, "clcd_clk", NULL);
 
 	/* i2s */
-	clk = clk_register_mux(NULL, "i2s_src_mux_clk", i2s_src_parents,
+	clk = clk_register_mux(NULL, "i2s_src_mclk", i2s_src_parents,
 			ARRAY_SIZE(i2s_src_parents), 0, SPEAR1340_I2S_CLK_CFG,
 			SPEAR1340_I2S_SRC_CLK_SHIFT, SPEAR1340_I2S_SRC_CLK_MASK,
 			0, &_lock);
 	clk_register_clkdev(clk, "i2s_src_clk", NULL);
 
-	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mux_clk", 0,
+	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mclk", 0,
 			SPEAR1340_I2S_CLK_CFG, &i2s_prs1_masks, i2s_prs1_rtbl,
 			ARRAY_SIZE(i2s_prs1_rtbl), &_lock, NULL);
 	clk_register_clkdev(clk, "i2s_prs1_clk", NULL);
 
-	clk = clk_register_mux(NULL, "i2s_ref_mux_clk", i2s_ref_parents,
+	clk = clk_register_mux(NULL, "i2s_ref_mclk", i2s_ref_parents,
 			ARRAY_SIZE(i2s_ref_parents), 0, SPEAR1340_I2S_CLK_CFG,
 			SPEAR1340_I2S_REF_SHIFT, SPEAR1340_I2S_REF_SEL_MASK, 0,
 			&_lock);
 	clk_register_clkdev(clk, "i2s_ref_clk", NULL);
 
-	clk = clk_register_gate(NULL, "i2s_ref_pad_clk", "i2s_ref_mux_clk", 0,
+	clk = clk_register_gate(NULL, "i2s_ref_pad_clk", "i2s_ref_mclk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_I2S_REF_PAD_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_pad_clk", NULL);
 
-	clk = clk_register_aux("i2s_sclk_clk", "i2s_sclk_gate_clk",
-			"i2s_ref_mux_clk", 0, SPEAR1340_I2S_CLK_CFG,
-			&i2s_sclk_masks, i2s_sclk_rtbl,
-			ARRAY_SIZE(i2s_sclk_rtbl), &_lock, &clk1);
+	clk = clk_register_aux("i2s_sclk_clk", "i2s_sclk_gclk", "i2s_ref_mclk",
+			0, SPEAR1340_I2S_CLK_CFG, &i2s_sclk_masks,
+			i2s_sclk_rtbl, ARRAY_SIZE(i2s_sclk_rtbl), &_lock,
+			&clk1);
 	clk_register_clkdev(clk, "i2s_sclk_clk", NULL);
-	clk_register_clkdev(clk1, "i2s_sclk_gate_clk", NULL);
+	clk_register_clkdev(clk1, "i2s_sclk_gclk", NULL);
 
 	/* clock derived from ahb clk */
 	clk = clk_register_gate(NULL, "i2c0_clk", "ahb_clk", 0,
@@ -800,13 +797,13 @@ void __init spear1340_clk_init(void)
 			&_lock);
 	clk_register_clkdev(clk, "sysram1_clk", NULL);
 
-	clk = clk_register_aux("adc_synth_clk", "adc_synth_gate_clk", "ahb_clk",
+	clk = clk_register_aux("adc_syn_clk", "adc_syn_gclk", "ahb_clk",
 			0, SPEAR1340_ADC_CLK_SYNT, NULL, adc_rtbl,
 			ARRAY_SIZE(adc_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "adc_synth_clk", NULL);
-	clk_register_clkdev(clk1, "adc_synth_gate_clk", NULL);
+	clk_register_clkdev(clk, "adc_syn_clk", NULL);
+	clk_register_clkdev(clk1, "adc_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "adc_clk", "adc_synth_gate_clk", 0,
+	clk = clk_register_gate(NULL, "adc_clk", "adc_syn_gclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_ADC_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "adc_clk");
@@ -843,39 +840,39 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, NULL, "e0300000.kbd");
 
 	/* RAS clks */
-	clk = clk_register_mux(NULL, "gen_synth0_1_mux_clk",
-			gen_synth0_1_parents, ARRAY_SIZE(gen_synth0_1_parents),
-			0, SPEAR1340_PLL_CFG, SPEAR1340_GEN_SYNT0_1_CLK_SHIFT,
+	clk = clk_register_mux(NULL, "gen_syn0_1_mclk", gen_synth0_1_parents,
+			ARRAY_SIZE(gen_synth0_1_parents), 0, SPEAR1340_PLL_CFG,
+			SPEAR1340_GEN_SYNT0_1_CLK_SHIFT,
 			SPEAR1340_GEN_SYNT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gen_synth0_1_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn0_1_clk", NULL);
 
-	clk = clk_register_mux(NULL, "gen_synth2_3_mux_clk",
-			gen_synth2_3_parents, ARRAY_SIZE(gen_synth2_3_parents),
-			0, SPEAR1340_PLL_CFG, SPEAR1340_GEN_SYNT2_3_CLK_SHIFT,
+	clk = clk_register_mux(NULL, "gen_syn2_3_mclk", gen_synth2_3_parents,
+			ARRAY_SIZE(gen_synth2_3_parents), 0, SPEAR1340_PLL_CFG,
+			SPEAR1340_GEN_SYNT2_3_CLK_SHIFT,
 			SPEAR1340_GEN_SYNT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gen_synth2_3_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn2_3_clk", NULL);
 
-	clk = clk_register_frac("gen_synth0_clk", "gen_synth0_1_clk", 0,
+	clk = clk_register_frac("gen_syn0_clk", "gen_syn0_1_clk", 0,
 			SPEAR1340_GEN_CLK_SYNT0, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
-	clk_register_clkdev(clk, "gen_synth0_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn0_clk", NULL);
 
-	clk = clk_register_frac("gen_synth1_clk", "gen_synth0_1_clk", 0,
+	clk = clk_register_frac("gen_syn1_clk", "gen_syn0_1_clk", 0,
 			SPEAR1340_GEN_CLK_SYNT1, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
-	clk_register_clkdev(clk, "gen_synth1_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn1_clk", NULL);
 
-	clk = clk_register_frac("gen_synth2_clk", "gen_synth2_3_clk", 0,
+	clk = clk_register_frac("gen_syn2_clk", "gen_syn2_3_clk", 0,
 			SPEAR1340_GEN_CLK_SYNT2, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
-	clk_register_clkdev(clk, "gen_synth2_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn2_clk", NULL);
 
-	clk = clk_register_frac("gen_synth3_clk", "gen_synth2_3_clk", 0,
+	clk = clk_register_frac("gen_syn3_clk", "gen_syn2_3_clk", 0,
 			SPEAR1340_GEN_CLK_SYNT3, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
-	clk_register_clkdev(clk, "gen_synth3_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn3_clk", NULL);
 
-	clk = clk_register_gate(NULL, "mali_clk", "gen_synth3_clk", 0,
+	clk = clk_register_gate(NULL, "mali_clk", "gen_syn3_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_MALI_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "mali");
@@ -890,74 +887,74 @@ void __init spear1340_clk_init(void)
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spear_cec.1");
 
-	clk = clk_register_mux(NULL, "spdif_out_mux_clk", spdif_out_parents,
+	clk = clk_register_mux(NULL, "spdif_out_mclk", spdif_out_parents,
 			ARRAY_SIZE(spdif_out_parents), 0,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_SPDIF_OUT_CLK_SHIFT,
 			SPEAR1340_SPDIF_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "spdif_out_mux_clk", NULL);
+	clk_register_clkdev(clk, "spdif_out_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "spdif_out_clk", "spdif_out_mux_clk", 0,
+	clk = clk_register_gate(NULL, "spdif_out_clk", "spdif_out_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_SPDIF_OUT_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "spdif-out");
 
-	clk = clk_register_mux(NULL, "spdif_in_mux_clk", spdif_in_parents,
+	clk = clk_register_mux(NULL, "spdif_in_mclk", spdif_in_parents,
 			ARRAY_SIZE(spdif_in_parents), 0,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_SPDIF_IN_CLK_SHIFT,
 			SPEAR1340_SPDIF_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "spdif_in_mux_clk", NULL);
+	clk_register_clkdev(clk, "spdif_in_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "spdif_in_clk", "spdif_in_mux_clk", 0,
+	clk = clk_register_gate(NULL, "spdif_in_clk", "spdif_in_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_SPDIF_IN_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spdif-in");
 
-	clk = clk_register_gate(NULL, "acp_clk", "acp_mux_clk", 0,
+	clk = clk_register_gate(NULL, "acp_clk", "acp_mclk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_ACP_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "acp_clk");
 
-	clk = clk_register_gate(NULL, "plgpio_clk", "plgpio_mux_clk", 0,
+	clk = clk_register_gate(NULL, "plgpio_clk", "plgpio_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_PLGPIO_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "plgpio");
 
-	clk = clk_register_gate(NULL, "video_dec_clk", "video_dec_mux_clk", 0,
+	clk = clk_register_gate(NULL, "video_dec_clk", "video_dec_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_VIDEO_DEC_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "video_dec");
 
-	clk = clk_register_gate(NULL, "video_enc_clk", "video_enc_mux_clk", 0,
+	clk = clk_register_gate(NULL, "video_enc_clk", "video_enc_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_VIDEO_ENC_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "video_enc");
 
-	clk = clk_register_gate(NULL, "video_in_clk", "video_in_mux_clk", 0,
+	clk = clk_register_gate(NULL, "video_in_clk", "video_in_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_VIDEO_IN_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spear_vip");
 
-	clk = clk_register_gate(NULL, "cam0_clk", "cam0_mux_clk", 0,
+	clk = clk_register_gate(NULL, "cam0_clk", "cam0_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM0_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spear_camif.0");
 
-	clk = clk_register_gate(NULL, "cam1_clk", "cam1_mux_clk", 0,
+	clk = clk_register_gate(NULL, "cam1_clk", "cam1_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spear_camif.1");
 
-	clk = clk_register_gate(NULL, "cam2_clk", "cam2_mux_clk", 0,
+	clk = clk_register_gate(NULL, "cam2_clk", "cam2_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM2_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spear_camif.2");
 
-	clk = clk_register_gate(NULL, "cam3_clk", "cam3_mux_clk", 0,
+	clk = clk_register_gate(NULL, "cam3_clk", "cam3_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM3_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spear_camif.3");
 
-	clk = clk_register_gate(NULL, "pwm_clk", "pwm_mux_clk", 0,
+	clk = clk_register_gate(NULL, "pwm_clk", "pwm_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_PWM_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "pwm");
-- 
1.7.2.2
