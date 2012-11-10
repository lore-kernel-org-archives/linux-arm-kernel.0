From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Nov 2012 12:13:43 +0530
Subject: [PATCH 4/8] CLK: SPEAr: Set CLK_SET_RATE_PARENT for few clocks
In-Reply-To: <cover.1352529508.git.viresh.kumar@linaro.org>
References: <cover.1352529508.git.viresh.kumar@linaro.org>
Message-ID: <1204d39edd3e30d50cd244df4db663f43df5e3f1.1352529508.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

Flag CLK_SET_RATE_PARENT is required for a clock, where we want to
propagate clk_set_rate to its parent. This patch adds this to multiple clocks.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Vijay Kumar Mishra <vijay.kumar@st.com>
Signed-off-by: Vijay Kumar Mishra <vijay.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/clk-aux-synth.c   |   3 +-
 drivers/clk/spear/spear1310_clock.c |  49 +++++++--------
 drivers/clk/spear/spear1340_clock.c |  73 +++++++++++-----------
 drivers/clk/spear/spear3xx_clock.c  | 119 ++++++++++++++++++++----------------
 drivers/clk/spear/spear6xx_clock.c  |   3 +-
 5 files changed, 133 insertions(+), 114 deletions(-)

diff --git a/drivers/clk/spear/clk-aux-synth.c b/drivers/clk/spear/clk-aux-synth.c
index 6756e7c..bdfb442 100644
--- a/drivers/clk/spear/clk-aux-synth.c
+++ b/drivers/clk/spear/clk-aux-synth.c
@@ -179,7 +179,8 @@ struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
 	if (gate_name) {
 		struct clk *tgate_clk;
 
-		tgate_clk = clk_register_gate(NULL, gate_name, aux_name, 0, reg,
+		tgate_clk = clk_register_gate(NULL, gate_name, aux_name,
+				CLK_SET_RATE_PARENT, reg,
 				aux->masks->enable_bit, 0, lock);
 		if (IS_ERR_OR_NULL(tgate_clk))
 			goto free_aux;
diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index e84b1fb..2809b67 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -483,7 +483,8 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, "ddr_clk", NULL);
 
 	/* clock derived from pll1 clk */
-	clk = clk_register_fixed_factor(NULL, "cpu_clk", "pll1_clk", 0, 1, 2);
+	clk = clk_register_fixed_factor(NULL, "cpu_clk", "pll1_clk",
+			CLK_SET_RATE_PARENT, 1, 2);
 	clk_register_clkdev(clk, "cpu_clk", NULL);
 
 	clk = clk_register_fixed_factor(NULL, "wdt_clk", "cpu_clk", 0, 1,
@@ -547,14 +548,14 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk1, "uart_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
-			ARRAY_SIZE(uart0_parents), 0, SPEAR1310_PERIP_CLK_CFG,
-			SPEAR1310_UART_CLK_SHIFT, SPEAR1310_UART_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(uart0_parents), CLK_SET_RATE_PARENT,
+			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_UART_CLK_SHIFT,
+			SPEAR1310_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart0_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart0_clk", "uart0_mclk", 0,
-			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_UART_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "uart0_clk", "uart0_mclk",
+			CLK_SET_RATE_PARENT, SPEAR1310_PERIP1_CLK_ENB,
+			SPEAR1310_UART_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "e0000000.serial");
 
 	clk = clk_register_aux("sdhci_syn_clk", "sdhci_syn_gclk",
@@ -563,9 +564,9 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, "sdhci_syn_clk", NULL);
 	clk_register_clkdev(clk1, "sdhci_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "sdhci_clk", "sdhci_syn_gclk", 0,
-			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_SDHCI_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "sdhci_clk", "sdhci_syn_gclk",
+			CLK_SET_RATE_PARENT, SPEAR1310_PERIP1_CLK_ENB,
+			SPEAR1310_SDHCI_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "b3000000.sdhci");
 
 	clk = clk_register_aux("cfxd_syn_clk", "cfxd_syn_gclk", "vco1div2_clk",
@@ -574,9 +575,9 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, "cfxd_syn_clk", NULL);
 	clk_register_clkdev(clk1, "cfxd_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "cfxd_clk", "cfxd_syn_gclk", 0,
-			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_CFXD_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "cfxd_clk", "cfxd_syn_gclk",
+			CLK_SET_RATE_PARENT, SPEAR1310_PERIP1_CLK_ENB,
+			SPEAR1310_CFXD_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "b2800000.cf");
 	clk_register_clkdev(clk, NULL, "arasan_xd");
 
@@ -587,9 +588,9 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk1, "c3_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "c3_mclk", c3_parents,
-			ARRAY_SIZE(c3_parents), 0, SPEAR1310_PERIP_CLK_CFG,
-			SPEAR1310_C3_CLK_SHIFT, SPEAR1310_C3_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(c3_parents), CLK_SET_RATE_PARENT,
+			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_C3_CLK_SHIFT,
+			SPEAR1310_C3_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "c3_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "c3_clk", "c3_mclk", 0,
@@ -630,7 +631,7 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, "clcd_syn_clk", NULL);
 
 	clk = clk_register_mux(NULL, "clcd_pixel_mclk", clcd_pixel_parents,
-			ARRAY_SIZE(clcd_pixel_parents), 0,
+			ARRAY_SIZE(clcd_pixel_parents), CLK_SET_RATE_PARENT,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_CLCD_CLK_SHIFT,
 			SPEAR1310_CLCD_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_pixel_mclk", NULL);
@@ -653,10 +654,10 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, "i2s_prs1_clk", NULL);
 
 	clk = clk_register_mux(NULL, "i2s_ref_mclk", i2s_ref_parents,
-			ARRAY_SIZE(i2s_ref_parents), 0, SPEAR1310_I2S_CLK_CFG,
-			SPEAR1310_I2S_REF_SHIFT, SPEAR1310_I2S_REF_SEL_MASK, 0,
-			&_lock);
-	clk_register_clkdev(clk, "i2s_ref_clk", NULL);
+			ARRAY_SIZE(i2s_ref_parents), CLK_SET_RATE_PARENT,
+			SPEAR1310_I2S_CLK_CFG, SPEAR1310_I2S_REF_SHIFT,
+			SPEAR1310_I2S_REF_SEL_MASK, 0, &_lock);
+	clk_register_clkdev(clk, "i2s_ref_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2s_ref_pad_clk", "i2s_ref_mclk", 0,
 			SPEAR1310_PERIP2_CLK_ENB, SPEAR1310_I2S_REF_PAD_CLK_ENB,
@@ -753,9 +754,9 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, "adc_syn_clk", NULL);
 	clk_register_clkdev(clk1, "adc_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "adc_clk", "adc_syn_gclk", 0,
-			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_ADC_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "adc_clk", "adc_syn_gclk",
+			CLK_SET_RATE_PARENT, SPEAR1310_PERIP1_CLK_ENB,
+			SPEAR1310_ADC_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "e0080000.adc");
 
 	/* clock derived from apb clk */
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 020431a..aa5ed43 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -594,14 +594,14 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk1, "uart0_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
-			ARRAY_SIZE(uart0_parents), 0, SPEAR1340_PERIP_CLK_CFG,
-			SPEAR1340_UART0_CLK_SHIFT, SPEAR1340_UART_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(uart0_parents), CLK_SET_RATE_PARENT,
+			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_UART0_CLK_SHIFT,
+			SPEAR1340_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart0_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart0_clk", "uart0_mclk", 0,
-			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_UART0_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "uart0_clk", "uart0_mclk",
+			CLK_SET_RATE_PARENT, SPEAR1340_PERIP1_CLK_ENB,
+			SPEAR1340_UART0_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "e0000000.serial");
 
 	clk = clk_register_aux("uart1_syn_clk", "uart1_syn_gclk",
@@ -627,9 +627,9 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, "sdhci_syn_clk", NULL);
 	clk_register_clkdev(clk1, "sdhci_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "sdhci_clk", "sdhci_syn_gclk", 0,
-			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_SDHCI_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "sdhci_clk", "sdhci_syn_gclk",
+			CLK_SET_RATE_PARENT, SPEAR1340_PERIP1_CLK_ENB,
+			SPEAR1340_SDHCI_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "b3000000.sdhci");
 
 	clk = clk_register_aux("cfxd_syn_clk", "cfxd_syn_gclk", "vco1div2_clk",
@@ -638,9 +638,9 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, "cfxd_syn_clk", NULL);
 	clk_register_clkdev(clk1, "cfxd_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "cfxd_clk", "cfxd_syn_gclk", 0,
-			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_CFXD_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "cfxd_clk", "cfxd_syn_gclk",
+			CLK_SET_RATE_PARENT, SPEAR1340_PERIP1_CLK_ENB,
+			SPEAR1340_CFXD_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "b2800000.cf");
 	clk_register_clkdev(clk, NULL, "arasan_xd");
 
@@ -651,12 +651,12 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk1, "c3_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "c3_mclk", c3_parents,
-			ARRAY_SIZE(c3_parents), 0, SPEAR1340_PERIP_CLK_CFG,
-			SPEAR1340_C3_CLK_SHIFT, SPEAR1340_C3_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(c3_parents), CLK_SET_RATE_PARENT,
+			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_C3_CLK_SHIFT,
+			SPEAR1340_C3_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "c3_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "c3_clk", "c3_mclk", 0,
+	clk = clk_register_gate(NULL, "c3_clk", "c3_mclk", CLK_SET_RATE_PARENT,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_C3_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "e1800000.c3");
@@ -694,7 +694,7 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, "clcd_syn_clk", NULL);
 
 	clk = clk_register_mux(NULL, "clcd_pixel_mclk", clcd_pixel_parents,
-			ARRAY_SIZE(clcd_pixel_parents), 0,
+			ARRAY_SIZE(clcd_pixel_parents), CLK_SET_RATE_PARENT,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_CLCD_CLK_SHIFT,
 			SPEAR1340_CLCD_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_pixel_mclk", NULL);
@@ -711,15 +711,16 @@ void __init spear1340_clk_init(void)
 			0, &_lock);
 	clk_register_clkdev(clk, "i2s_src_mclk", NULL);
 
-	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mclk", 0,
-			SPEAR1340_I2S_CLK_CFG, &i2s_prs1_masks, i2s_prs1_rtbl,
+	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mclk",
+			CLK_SET_RATE_PARENT, SPEAR1340_I2S_CLK_CFG,
+			&i2s_prs1_masks, i2s_prs1_rtbl,
 			ARRAY_SIZE(i2s_prs1_rtbl), &_lock, NULL);
 	clk_register_clkdev(clk, "i2s_prs1_clk", NULL);
 
 	clk = clk_register_mux(NULL, "i2s_ref_mclk", i2s_ref_parents,
-			ARRAY_SIZE(i2s_ref_parents), 0, SPEAR1340_I2S_CLK_CFG,
-			SPEAR1340_I2S_REF_SHIFT, SPEAR1340_I2S_REF_SEL_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(i2s_ref_parents), CLK_SET_RATE_PARENT,
+			SPEAR1340_I2S_CLK_CFG, SPEAR1340_I2S_REF_SHIFT,
+			SPEAR1340_I2S_REF_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2s_ref_pad_clk", "i2s_ref_mclk", 0,
@@ -805,9 +806,9 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, "adc_syn_clk", NULL);
 	clk_register_clkdev(clk1, "adc_syn_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "adc_clk", "adc_syn_gclk", 0,
-			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_ADC_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "adc_clk", "adc_syn_gclk",
+			CLK_SET_RATE_PARENT, SPEAR1340_PERIP1_CLK_ENB,
+			SPEAR1340_ADC_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "e0080000.adc");
 
 	/* clock derived from apb clk */
@@ -874,9 +875,9 @@ void __init spear1340_clk_init(void)
 			&_lock);
 	clk_register_clkdev(clk, "gen_syn3_clk", NULL);
 
-	clk = clk_register_gate(NULL, "mali_clk", "gen_syn3_clk", 0,
-			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_MALI_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "mali_clk", "gen_syn3_clk",
+			CLK_SET_RATE_PARENT, SPEAR1340_PERIP3_CLK_ENB,
+			SPEAR1340_MALI_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "mali");
 
 	clk = clk_register_gate(NULL, "cec0_clk", "ahb_clk", 0,
@@ -890,25 +891,25 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, NULL, "spear_cec.1");
 
 	clk = clk_register_mux(NULL, "spdif_out_mclk", spdif_out_parents,
-			ARRAY_SIZE(spdif_out_parents), 0,
+			ARRAY_SIZE(spdif_out_parents), CLK_SET_RATE_PARENT,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_SPDIF_OUT_CLK_SHIFT,
 			SPEAR1340_SPDIF_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "spdif_out_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "spdif_out_clk", "spdif_out_mclk", 0,
-			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_SPDIF_OUT_CLK_ENB,
-			0, &_lock);
+	clk = clk_register_gate(NULL, "spdif_out_clk", "spdif_out_mclk",
+			CLK_SET_RATE_PARENT, SPEAR1340_PERIP3_CLK_ENB,
+			SPEAR1340_SPDIF_OUT_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "d0000000.spdif-out");
 
 	clk = clk_register_mux(NULL, "spdif_in_mclk", spdif_in_parents,
-			ARRAY_SIZE(spdif_in_parents), 0,
+			ARRAY_SIZE(spdif_in_parents), CLK_SET_RATE_PARENT,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_SPDIF_IN_CLK_SHIFT,
 			SPEAR1340_SPDIF_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "spdif_in_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "spdif_in_clk", "spdif_in_mclk", 0,
-			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_SPDIF_IN_CLK_ENB, 0,
-			&_lock);
+	clk = clk_register_gate(NULL, "spdif_in_clk", "spdif_in_mclk",
+			CLK_SET_RATE_PARENT, SPEAR1340_PERIP3_CLK_ENB,
+			SPEAR1340_SPDIF_IN_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "d0100000.spdif-in");
 
 	clk = clk_register_gate(NULL, "acp_clk", "acp_mclk", 0,
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index e6461f7..de28152 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -274,23 +274,26 @@ static void __init spear320_clk_init(void)
 	clk_register_clkdev(clk, NULL, "a9400000.i2s");
 
 	clk = clk_register_mux(NULL, "i2s_ref_clk", i2s_ref_parents,
-			ARRAY_SIZE(i2s_ref_parents), 0, SPEAR320_CONTROL_REG,
-			I2S_REF_PCLK_SHIFT, I2S_REF_PCLK_MASK, 0, &_lock);
+			ARRAY_SIZE(i2s_ref_parents), CLK_SET_RATE_PARENT,
+			SPEAR320_CONTROL_REG, I2S_REF_PCLK_SHIFT,
+			I2S_REF_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_clk", NULL);
 
-	clk = clk_register_fixed_factor(NULL, "i2s_sclk", "i2s_ref_clk", 0, 1,
+	clk = clk_register_fixed_factor(NULL, "i2s_sclk", "i2s_ref_clk",
+			CLK_SET_RATE_PARENT, 1,
 			4);
 	clk_register_clkdev(clk, "i2s_sclk", NULL);
 
 	clk = clk_register_mux(NULL, "rs485_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), 0, SPEAR320_EXT_CTRL_REG,
-			SPEAR320_RS485_PCLK_SHIFT, SPEAR320_UARTX_PCLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			SPEAR320_EXT_CTRL_REG, SPEAR320_RS485_PCLK_SHIFT,
+			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a9300000.serial");
 
 	clk = clk_register_mux(NULL, "sdhci_clk", sdhci_parents,
-			ARRAY_SIZE(sdhci_parents), 0, SPEAR320_CONTROL_REG,
-			SDHCI_PCLK_SHIFT, SDHCI_PCLK_MASK, 0, &_lock);
+			ARRAY_SIZE(sdhci_parents), CLK_SET_RATE_PARENT,
+			SPEAR320_CONTROL_REG, SDHCI_PCLK_SHIFT, SDHCI_PCLK_MASK,
+			0, &_lock);
 	clk_register_clkdev(clk, NULL, "70000000.sdhci");
 
 	clk = clk_register_mux(NULL, "smii_pclk", smii0_parents,
@@ -302,38 +305,39 @@ static void __init spear320_clk_init(void)
 	clk_register_clkdev(clk, NULL, "smii");
 
 	clk = clk_register_mux(NULL, "uart1_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), 0, SPEAR320_CONTROL_REG,
-			UART1_PCLK_SHIFT, UART1_PCLK_MASK, 0, &_lock);
+			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			SPEAR320_CONTROL_REG, UART1_PCLK_SHIFT, UART1_PCLK_MASK,
+			0, &_lock);
 	clk_register_clkdev(clk, NULL, "a3000000.serial");
 
 	clk = clk_register_mux(NULL, "uart2_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), 0, SPEAR320_EXT_CTRL_REG,
-			SPEAR320_UART2_PCLK_SHIFT, SPEAR320_UARTX_PCLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			SPEAR320_EXT_CTRL_REG, SPEAR320_UART2_PCLK_SHIFT,
+			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a4000000.serial");
 
 	clk = clk_register_mux(NULL, "uart3_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), 0, SPEAR320_EXT_CTRL_REG,
-			SPEAR320_UART3_PCLK_SHIFT, SPEAR320_UARTX_PCLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			SPEAR320_EXT_CTRL_REG, SPEAR320_UART3_PCLK_SHIFT,
+			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a9100000.serial");
 
 	clk = clk_register_mux(NULL, "uart4_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), 0, SPEAR320_EXT_CTRL_REG,
-			SPEAR320_UART4_PCLK_SHIFT, SPEAR320_UARTX_PCLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			SPEAR320_EXT_CTRL_REG, SPEAR320_UART4_PCLK_SHIFT,
+			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a9200000.serial");
 
 	clk = clk_register_mux(NULL, "uart5_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), 0, SPEAR320_EXT_CTRL_REG,
-			SPEAR320_UART5_PCLK_SHIFT, SPEAR320_UARTX_PCLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			SPEAR320_EXT_CTRL_REG, SPEAR320_UART5_PCLK_SHIFT,
+			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "60000000.serial");
 
 	clk = clk_register_mux(NULL, "uart6_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), 0, SPEAR320_EXT_CTRL_REG,
-			SPEAR320_UART6_PCLK_SHIFT, SPEAR320_UARTX_PCLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			SPEAR320_EXT_CTRL_REG, SPEAR320_UART6_PCLK_SHIFT,
+			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "60100000.serial");
 }
 #endif
@@ -380,7 +384,8 @@ void __init spear3xx_clk_init(void)
 	clk_register_clkdev(clk1, "pll2_clk", NULL);
 
 	/* clock derived from pll1 clk */
-	clk = clk_register_fixed_factor(NULL, "cpu_clk", "pll1_clk", 0, 1, 1);
+	clk = clk_register_fixed_factor(NULL, "cpu_clk", "pll1_clk",
+			CLK_SET_RATE_PARENT, 1, 1);
 	clk_register_clkdev(clk, "cpu_clk", NULL);
 
 	clk = clk_register_divider(NULL, "ahb_clk", "pll1_clk",
@@ -395,12 +400,14 @@ void __init spear3xx_clk_init(void)
 	clk_register_clkdev(clk1, "uart_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
-			ARRAY_SIZE(uart0_parents), 0, PERIP_CLK_CFG,
-			UART_CLK_SHIFT, UART_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(uart0_parents), CLK_SET_RATE_PARENT,
+			PERIP_CLK_CFG, UART_CLK_SHIFT, UART_CLK_MASK, 0,
+			&_lock);
 	clk_register_clkdev(clk, "uart0_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart0", "uart0_mclk", 0, PERIP1_CLK_ENB,
-			UART_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "uart0", "uart0_mclk",
+			CLK_SET_RATE_PARENT, PERIP1_CLK_ENB, UART_CLK_ENB, 0,
+			&_lock);
 	clk_register_clkdev(clk, NULL, "d0000000.serial");
 
 	clk = clk_register_aux("firda_syn_clk", "firda_syn_gclk", "pll1_clk", 0,
@@ -410,40 +417,44 @@ void __init spear3xx_clk_init(void)
 	clk_register_clkdev(clk1, "firda_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "firda_mclk", firda_parents,
-			ARRAY_SIZE(firda_parents), 0, PERIP_CLK_CFG,
-			FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(firda_parents), CLK_SET_RATE_PARENT,
+			PERIP_CLK_CFG, FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0,
+			&_lock);
 	clk_register_clkdev(clk, "firda_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "firda_clk", "firda_mclk", 0,
-			PERIP1_CLK_ENB, FIRDA_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "firda_clk", "firda_mclk",
+			CLK_SET_RATE_PARENT, PERIP1_CLK_ENB, FIRDA_CLK_ENB, 0,
+			&_lock);
 	clk_register_clkdev(clk, NULL, "firda");
 
 	/* gpt clocks */
 	clk_register_gpt("gpt0_syn_clk", "pll1_clk", 0, PRSC0_CLK_CFG, gpt_rtbl,
 			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt0_clk", gpt0_parents,
-			ARRAY_SIZE(gpt0_parents), 0, PERIP_CLK_CFG,
-			GPT0_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(gpt0_parents), CLK_SET_RATE_PARENT,
+			PERIP_CLK_CFG, GPT0_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt0");
 
 	clk_register_gpt("gpt1_syn_clk", "pll1_clk", 0, PRSC1_CLK_CFG, gpt_rtbl,
 			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt1_mclk", gpt1_parents,
-			ARRAY_SIZE(gpt1_parents), 0, PERIP_CLK_CFG,
-			GPT1_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(gpt1_parents), CLK_SET_RATE_PARENT,
+			PERIP_CLK_CFG, GPT1_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt1_mclk", NULL);
-	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
-			PERIP1_CLK_ENB, GPT1_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk",
+			CLK_SET_RATE_PARENT, PERIP1_CLK_ENB, GPT1_CLK_ENB, 0,
+			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt1");
 
 	clk_register_gpt("gpt2_syn_clk", "pll1_clk", 0, PRSC2_CLK_CFG, gpt_rtbl,
 			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt2_mclk", gpt2_parents,
-			ARRAY_SIZE(gpt2_parents), 0, PERIP_CLK_CFG,
-			GPT2_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(gpt2_parents), CLK_SET_RATE_PARENT,
+			PERIP_CLK_CFG, GPT2_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt2_mclk", NULL);
-	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
-			PERIP1_CLK_ENB, GPT2_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk",
+			CLK_SET_RATE_PARENT, PERIP1_CLK_ENB, GPT2_CLK_ENB, 0,
+			&_lock);
 	clk_register_clkdev(clk, NULL, "gpt2");
 
 	/* general synths clocks */
@@ -581,20 +592,24 @@ void __init spear3xx_clk_init(void)
 			RAS_CLK_ENB, RAS_48M_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, "ras_pll3_clk", NULL);
 
-	clk = clk_register_gate(NULL, "ras_syn0_gclk", "gen0_syn_gclk", 0,
-			RAS_CLK_ENB, RAS_SYNT0_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "ras_syn0_gclk", "gen0_syn_gclk",
+			CLK_SET_RATE_PARENT, RAS_CLK_ENB, RAS_SYNT0_CLK_ENB, 0,
+			&_lock);
 	clk_register_clkdev(clk, "ras_syn0_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "ras_syn1_gclk", "gen1_syn_gclk", 0,
-			RAS_CLK_ENB, RAS_SYNT1_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "ras_syn1_gclk", "gen1_syn_gclk",
+			CLK_SET_RATE_PARENT, RAS_CLK_ENB, RAS_SYNT1_CLK_ENB, 0,
+			&_lock);
 	clk_register_clkdev(clk, "ras_syn1_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "ras_syn2_gclk", "gen2_syn_gclk", 0,
-			RAS_CLK_ENB, RAS_SYNT2_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "ras_syn2_gclk", "gen2_syn_gclk",
+			CLK_SET_RATE_PARENT, RAS_CLK_ENB, RAS_SYNT2_CLK_ENB, 0,
+			&_lock);
 	clk_register_clkdev(clk, "ras_syn2_gclk", NULL);
 
-	clk = clk_register_gate(NULL, "ras_syn3_gclk", "gen3_syn_gclk", 0,
-			RAS_CLK_ENB, RAS_SYNT3_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "ras_syn3_gclk", "gen3_syn_gclk",
+			CLK_SET_RATE_PARENT, RAS_CLK_ENB, RAS_SYNT3_CLK_ENB, 0,
+			&_lock);
 	clk_register_clkdev(clk, "ras_syn3_gclk", NULL);
 
 	if (of_machine_is_compatible("st,spear300"))
diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index c7fa67c..e8d2b31 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -156,7 +156,8 @@ void __init spear6xx_clk_init(void)
 	clk_register_clkdev(clk, NULL, "wdt");
 
 	/* clock derived from pll1 clk */
-	clk = clk_register_fixed_factor(NULL, "cpu_clk", "pll1_clk", 0, 1, 1);
+	clk = clk_register_fixed_factor(NULL, "cpu_clk", "pll1_clk",
+			CLK_SET_RATE_PARENT, 1, 1);
 	clk_register_clkdev(clk, "cpu_clk", NULL);
 
 	clk = clk_register_divider(NULL, "ahb_clk", "pll1_clk",
-- 
1.7.12.rc2.18.g61b472e
