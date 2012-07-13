From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 11:53:47 +0530
Subject: [PATCH 4/4] Clk:spear6xx:Fix: Rename clk ids within predefined limit
In-Reply-To: <cover.1342160220.git.vipulkumar.samar@st.com>
References: <cover.1342160220.git.vipulkumar.samar@st.com>
Message-ID: <6eca564c1a65a99549b210f70e35d2d1f108acda.1342160220.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The max limit of con_id is 16 and dev_id is 20. As of now for spear6xx, many clk
ids are exceeding this predefined limit.

This patch is intended to rename clk ids like:
    mux_clk -> _mclk
    gate_clk -> _gclk
    synth_clk -> syn_clk
    ras_gen1_synth_gate_clk -> ras_syn1_gclk

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 drivers/clk/spear/spear6xx_clock.c |  122 ++++++++++++++++++------------------
 1 files changed, 60 insertions(+), 62 deletions(-)

diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index 61026ae..a98d086 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -97,13 +97,12 @@ static struct aux_rate_tbl aux_rtbl[] = {
 	{.xscale = 1, .yscale = 2, .eq = 1}, /* 166 MHz */
 };
 
-static const char *clcd_parents[] = { "pll3_48m_clk", "clcd_synth_gate_clk", };
-static const char *firda_parents[] = { "pll3_48m_clk", "firda_synth_gate_clk",
-};
-static const char *uart_parents[] = { "pll3_48m_clk", "uart_synth_gate_clk", };
-static const char *gpt0_1_parents[] = { "pll3_48m_clk", "gpt0_1_synth_clk", };
-static const char *gpt2_parents[] = { "pll3_48m_clk", "gpt2_synth_clk", };
-static const char *gpt3_parents[] = { "pll3_48m_clk", "gpt3_synth_clk", };
+static const char *clcd_parents[] = { "pll3_clk", "clcd_syn_gclk", };
+static const char *firda_parents[] = { "pll3_clk", "firda_syn_gclk", };
+static const char *uart_parents[] = { "pll3_clk", "uart_syn_gclk", };
+static const char *gpt0_1_parents[] = { "pll3_clk", "gpt0_1_syn_clk", };
+static const char *gpt2_parents[] = { "pll3_clk", "gpt2_syn_clk", };
+static const char *gpt3_parents[] = { "pll3_clk", "gpt3_syn_clk", };
 static const char *ddr_parents[] = { "ahb_clk", "ahbmult2_clk", "none",
 	"pll2_clk", };
 
@@ -136,9 +135,9 @@ void __init spear6xx_clk_init(void)
 	clk_register_clkdev(clk, NULL, "rtc-spear");
 
 	/* clock derived from 30 MHz osc clk */
-	clk = clk_register_fixed_rate(NULL, "pll3_48m_clk", "osc_24m_clk", 0,
+	clk = clk_register_fixed_rate(NULL, "pll3_clk", "osc_24m_clk", 0,
 			48000000);
-	clk_register_clkdev(clk, "pll3_48m_clk", NULL);
+	clk_register_clkdev(clk, "pll3_clk", NULL);
 
 	clk = clk_register_vco_pll("vco1_clk", "pll1_clk", NULL, "osc_30m_clk",
 			0, PLL1_CTR, PLL1_FRQ, pll_rtbl, ARRAY_SIZE(pll_rtbl),
@@ -146,9 +145,9 @@ void __init spear6xx_clk_init(void)
 	clk_register_clkdev(clk, "vco1_clk", NULL);
 	clk_register_clkdev(clk1, "pll1_clk", NULL);
 
-	clk = clk_register_vco_pll("vco2_clk", "pll2_clk", NULL,
-			"osc_30m_clk", 0, PLL2_CTR, PLL2_FRQ, pll_rtbl,
-			ARRAY_SIZE(pll_rtbl), &_lock, &clk1, NULL);
+	clk = clk_register_vco_pll("vco2_clk", "pll2_clk", NULL, "osc_30m_clk",
+			0, PLL2_CTR, PLL2_FRQ, pll_rtbl, ARRAY_SIZE(pll_rtbl),
+			&_lock, &clk1, NULL);
 	clk_register_clkdev(clk, "vco2_clk", NULL);
 	clk_register_clkdev(clk1, "pll2_clk", NULL);
 
@@ -165,111 +164,111 @@ void __init spear6xx_clk_init(void)
 			HCLK_RATIO_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ahb_clk", NULL);
 
-	clk = clk_register_aux("uart_synth_clk", "uart_synth_gate_clk",
-			"pll1_clk", 0, UART_CLK_SYNT, NULL, aux_rtbl,
-			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "uart_synth_clk", NULL);
-	clk_register_clkdev(clk1, "uart_synth_gate_clk", NULL);
+	clk = clk_register_aux("uart_syn_clk", "uart_syn_gclk", "pll1_clk", 0,
+			UART_CLK_SYNT, NULL, aux_rtbl, ARRAY_SIZE(aux_rtbl),
+			&_lock, &clk1);
+	clk_register_clkdev(clk, "uart_syn_clk", NULL);
+	clk_register_clkdev(clk1, "uart_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "uart_mux_clk", uart_parents,
+	clk = clk_register_mux(NULL, "uart_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), 0, PERIP_CLK_CFG,
 			UART_CLK_SHIFT, UART_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "uart_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart0", "uart_mux_clk", 0,
-			PERIP1_CLK_ENB, UART0_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "uart0", "uart_mclk", 0, PERIP1_CLK_ENB,
+			UART0_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "d0000000.serial");
 
-	clk = clk_register_gate(NULL, "uart1", "uart_mux_clk", 0,
-			PERIP1_CLK_ENB, UART1_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "uart1", "uart_mclk", 0, PERIP1_CLK_ENB,
+			UART1_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "d0080000.serial");
 
-	clk = clk_register_aux("firda_synth_clk", "firda_synth_gate_clk",
-			"pll1_clk", 0, FIRDA_CLK_SYNT, NULL, aux_rtbl,
-			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "firda_synth_clk", NULL);
-	clk_register_clkdev(clk1, "firda_synth_gate_clk", NULL);
+	clk = clk_register_aux("firda_syn_clk", "firda_syn_gclk", "pll1_clk",
+			0, FIRDA_CLK_SYNT, NULL, aux_rtbl, ARRAY_SIZE(aux_rtbl),
+			&_lock, &clk1);
+	clk_register_clkdev(clk, "firda_syn_clk", NULL);
+	clk_register_clkdev(clk1, "firda_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "firda_mux_clk", firda_parents,
+	clk = clk_register_mux(NULL, "firda_mclk", firda_parents,
 			ARRAY_SIZE(firda_parents), 0, PERIP_CLK_CFG,
 			FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "firda_mux_clk", NULL);
+	clk_register_clkdev(clk, "firda_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "firda_clk", "firda_mux_clk", 0,
+	clk = clk_register_gate(NULL, "firda_clk", "firda_mclk", 0,
 			PERIP1_CLK_ENB, FIRDA_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "firda");
 
-	clk = clk_register_aux("clcd_synth_clk", "clcd_synth_gate_clk",
-			"pll1_clk", 0, CLCD_CLK_SYNT, NULL, aux_rtbl,
-			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "clcd_synth_clk", NULL);
-	clk_register_clkdev(clk1, "clcd_synth_gate_clk", NULL);
+	clk = clk_register_aux("clcd_syn_clk", "clcd_syn_gclk", "pll1_clk",
+			0, CLCD_CLK_SYNT, NULL, aux_rtbl, ARRAY_SIZE(aux_rtbl),
+			&_lock, &clk1);
+	clk_register_clkdev(clk, "clcd_syn_clk", NULL);
+	clk_register_clkdev(clk1, "clcd_syn_gclk", NULL);
 
-	clk = clk_register_mux(NULL, "clcd_mux_clk", clcd_parents,
+	clk = clk_register_mux(NULL, "clcd_mclk", clcd_parents,
 			ARRAY_SIZE(clcd_parents), 0, PERIP_CLK_CFG,
 			CLCD_CLK_SHIFT, CLCD_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "clcd_mux_clk", NULL);
+	clk_register_clkdev(clk, "clcd_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "clcd_clk", "clcd_mux_clk", 0,
+	clk = clk_register_gate(NULL, "clcd_clk", "clcd_mclk", 0,
 			PERIP1_CLK_ENB, CLCD_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "clcd");
 
 	/* gpt clocks */
-	clk = clk_register_gpt("gpt0_1_synth_clk", "pll1_clk", 0, PRSC0_CLK_CFG,
+	clk = clk_register_gpt("gpt0_1_syn_clk", "pll1_clk", 0, PRSC0_CLK_CFG,
 			gpt_rtbl, ARRAY_SIZE(gpt_rtbl), &_lock);
-	clk_register_clkdev(clk, "gpt0_1_synth_clk", NULL);
+	clk_register_clkdev(clk, "gpt0_1_syn_clk", NULL);
 
-	clk = clk_register_mux(NULL, "gpt0_mux_clk", gpt0_1_parents,
+	clk = clk_register_mux(NULL, "gpt0_mclk", gpt0_1_parents,
 			ARRAY_SIZE(gpt0_1_parents), 0, PERIP_CLK_CFG,
 			GPT0_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt0");
 
-	clk = clk_register_mux(NULL, "gpt1_mux_clk", gpt0_1_parents,
+	clk = clk_register_mux(NULL, "gpt1_mclk", gpt0_1_parents,
 			ARRAY_SIZE(gpt0_1_parents), 0, PERIP_CLK_CFG,
 			GPT1_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gpt1_mux_clk", NULL);
+	clk_register_clkdev(clk, "gpt1_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mux_clk", 0,
+	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
 			PERIP1_CLK_ENB, GPT1_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt1");
 
-	clk = clk_register_gpt("gpt2_synth_clk", "pll1_clk", 0, PRSC1_CLK_CFG,
+	clk = clk_register_gpt("gpt2_syn_clk", "pll1_clk", 0, PRSC1_CLK_CFG,
 			gpt_rtbl, ARRAY_SIZE(gpt_rtbl), &_lock);
-	clk_register_clkdev(clk, "gpt2_synth_clk", NULL);
+	clk_register_clkdev(clk, "gpt2_syn_clk", NULL);
 
-	clk = clk_register_mux(NULL, "gpt2_mux_clk", gpt2_parents,
+	clk = clk_register_mux(NULL, "gpt2_mclk", gpt2_parents,
 			ARRAY_SIZE(gpt2_parents), 0, PERIP_CLK_CFG,
 			GPT2_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gpt2_mux_clk", NULL);
+	clk_register_clkdev(clk, "gpt2_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mux_clk", 0,
+	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
 			PERIP1_CLK_ENB, GPT2_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt2");
 
-	clk = clk_register_gpt("gpt3_synth_clk", "pll1_clk", 0, PRSC2_CLK_CFG,
+	clk = clk_register_gpt("gpt3_syn_clk", "pll1_clk", 0, PRSC2_CLK_CFG,
 			gpt_rtbl, ARRAY_SIZE(gpt_rtbl), &_lock);
-	clk_register_clkdev(clk, "gpt3_synth_clk", NULL);
+	clk_register_clkdev(clk, "gpt3_syn_clk", NULL);
 
-	clk = clk_register_mux(NULL, "gpt3_mux_clk", gpt3_parents,
+	clk = clk_register_mux(NULL, "gpt3_mclk", gpt3_parents,
 			ARRAY_SIZE(gpt3_parents), 0, PERIP_CLK_CFG,
 			GPT3_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gpt3_mux_clk", NULL);
+	clk_register_clkdev(clk, "gpt3_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mux_clk", 0,
+	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mclk", 0,
 			PERIP1_CLK_ENB, GPT3_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt3");
 
 	/* clock derived from pll3 clk */
-	clk = clk_register_gate(NULL, "usbh0_clk", "pll3_48m_clk", 0,
+	clk = clk_register_gate(NULL, "usbh0_clk", "pll3_clk", 0,
 			PERIP1_CLK_ENB, USBH0_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "usbh.0_clk");
 
-	clk = clk_register_gate(NULL, "usbh1_clk", "pll3_48m_clk", 0,
+	clk = clk_register_gate(NULL, "usbh1_clk", "pll3_clk", 0,
 			PERIP1_CLK_ENB, USBH1_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "usbh.1_clk");
 
-	clk = clk_register_gate(NULL, "usbd_clk", "pll3_48m_clk", 0,
-			PERIP1_CLK_ENB, USBD_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "usbd_clk", "pll3_clk", 0, PERIP1_CLK_ENB,
+			USBD_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "designware_udc");
 
 	/* clock derived from ahb clk */
@@ -278,9 +277,8 @@ void __init spear6xx_clk_init(void)
 	clk_register_clkdev(clk, "ahbmult2_clk", NULL);
 
 	clk = clk_register_mux(NULL, "ddr_clk", ddr_parents,
-			ARRAY_SIZE(ddr_parents),
-			0, PLL_CLK_CFG, MCTR_CLK_SHIFT, MCTR_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(ddr_parents), 0, PLL_CLK_CFG, MCTR_CLK_SHIFT,
+			MCTR_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ddr_clk", NULL);
 
 	clk = clk_register_divider(NULL, "apb_clk", "ahb_clk",
-- 
1.7.2.2
