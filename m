From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Mon, 16 Jul 2012 09:55:40 +0530
Subject: [PATCH v2 3/4] Clk:spear3xx:Fix: Rename clk ids within predefined
 limit
In-Reply-To: <cover.1342411982.git.vipulkumar.samar@st.com>
References: <cover.1342411982.git.vipulkumar.samar@st.com>
Message-ID: <a428a2728185d0c713dc0624600f0b348267a46f.1342411982.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The max limit of con_id is 16 and dev_id is 20. As of now for spear3xx, many clk
ids are exceeding this predefined limit.

This patch is intended to rename clk ids like:
    mux_clk -> _mclk
    gate_clk -> _gclk
    synth_clk -> syn_clk
    ras_gen1_synth_gate_clk -> ras_syn1_gclk
    ras_pll3_48m -> ras_pll3_
    pll3_48m -> pll3_

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/mach-spear3xx/spear3xx.c  |    2 +-
 drivers/clk/spear/spear3xx_clock.c |  180 +++++++++++++++++-------------------
 2 files changed, 87 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 0f41bd1..66db5f1 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -87,7 +87,7 @@ void __init spear3xx_map_io(void)
 
 static void __init spear3xx_timer_init(void)
 {
-	char pclk_name[] = "pll3_48m_clk";
+	char pclk_name[] = "pll3_clk";
 	struct clk *gpt_clk, *pclk;
 
 	spear3xx_clk_init();
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index 01dd6da..c315745 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -122,12 +122,12 @@ static struct gpt_rate_tbl gpt_rtbl[] = {
 };
 
 /* clock parents */
-static const char *uart0_parents[] = { "pll3_48m_clk", "uart_synth_gate_clk", };
-static const char *firda_parents[] = { "pll3_48m_clk", "firda_synth_gate_clk",
+static const char *uart0_parents[] = { "pll3_clk", "uart_syn_gclk", };
+static const char *firda_parents[] = { "pll3_clk", "firda_syn_gclk",
 };
-static const char *gpt0_parents[] = { "pll3_48m_clk", "gpt0_synth_clk", };
-static const char *gpt1_parents[] = { "pll3_48m_clk", "gpt1_synth_clk", };
-static const char *gpt2_parents[] = { "pll3_48m_clk", "gpt2_synth_clk", };
+static const char *gpt0_parents[] = { "pll3_clk", "gpt0_syn_clk", };
+static const char *gpt1_parents[] = { "pll3_clk", "gpt1_syn_clk", };
+static const char *gpt2_parents[] = { "pll3_clk", "gpt2_syn_clk", };
 static const char *gen2_3_parents[] = { "pll1_clk", "pll2_clk", };
 static const char *ddr_parents[] = { "ahb_clk", "ahbmult2_clk", "none",
 	"pll2_clk", };
@@ -137,7 +137,7 @@ static void __init spear300_clk_init(void)
 {
 	struct clk *clk;
 
-	clk = clk_register_fixed_factor(NULL, "clcd_clk", "ras_pll3_48m_clk", 0,
+	clk = clk_register_fixed_factor(NULL, "clcd_clk", "ras_pll3_clk", 0,
 			1, 1);
 	clk_register_clkdev(clk, NULL, "60000000.clcd");
 
@@ -219,15 +219,11 @@ static void __init spear310_clk_init(void)
 	#define SPEAR320_UARTX_PCLK_VAL_SYNTH1		0x0
 	#define SPEAR320_UARTX_PCLK_VAL_APB		0x1
 
-static const char *i2s_ref_parents[] = { "ras_pll2_clk",
-	"ras_gen2_synth_gate_clk", };
-static const char *sdhci_parents[] = { "ras_pll3_48m_clk",
-	"ras_gen3_synth_gate_clk",
-};
+static const char *i2s_ref_parents[] = { "ras_pll2_clk", "ras_syn2_gclk", };
+static const char *sdhci_parents[] = { "ras_pll3_clk", "ras_syn3_gclk", };
 static const char *smii0_parents[] = { "smii_125m_pad", "ras_pll2_clk",
-	"ras_gen0_synth_gate_clk", };
-static const char *uartx_parents[] = { "ras_gen1_synth_gate_clk", "ras_apb_clk",
-};
+	"ras_syn0_gclk", };
+static const char *uartx_parents[] = { "ras_syn1_gclk", "ras_apb_clk", };
 
 static void __init spear320_clk_init(void)
 {
@@ -237,7 +233,7 @@ static void __init spear320_clk_init(void)
 			CLK_IS_ROOT, 125000000);
 	clk_register_clkdev(clk, "smii_125m_pad", NULL);
 
-	clk = clk_register_fixed_factor(NULL, "clcd_clk", "ras_pll3_48m_clk", 0,
+	clk = clk_register_fixed_factor(NULL, "clcd_clk", "ras_pll3_clk", 0,
 			1, 1);
 	clk_register_clkdev(clk, NULL, "90000000.clcd");
 
@@ -363,9 +359,9 @@ void __init spear3xx_clk_init(void)
 	clk_register_clkdev(clk, NULL, "fc900000.rtc");
 
 	/* clock derived from 24 MHz osc clk */
-	clk = clk_register_fixed_rate(NULL, "pll3_48m_clk", "osc_24m_clk", 0,
+	clk = clk_register_fixed_rate(NULL, "pll3_clk", "osc_24m_clk", 0,
 			48000000);
-	clk_register_clkdev(clk, "pll3_48m_clk", NULL);
+	clk_register_clkdev(clk, "pll3_clk", NULL);
 
 	clk = clk_register_fixed_factor(NULL, "wdt_clk", "osc_24m_clk", 0, 1,
 			1);
@@ -392,98 +388,98 @@ void __init spear3xx_clk_init(void)
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
 
-	clk = clk_register_mux(NULL, "uart0_mux_clk", uart0_parents,
+	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
 			ARRAY_SIZE(uart0_parents), 0, PERIP_CLK_CFG,
 			UART_CLK_SHIFT, UART_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "uart0_mux_clk", NULL);
+	clk_register_clkdev(clk, "uart0_mclk", NULL);
 
-	clk = clk_register_gate(NULL, "uart0", "uart0_mux_clk", 0,
-			PERIP1_CLK_ENB, UART_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "uart0", "uart0_mclk", 0, PERIP1_CLK_ENB,
+			UART_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "d0000000.serial");
 
-	clk = clk_register_aux("firda_synth_clk", "firda_synth_gate_clk",
-			"pll1_clk", 0, FIRDA_CLK_SYNT, NULL, aux_rtbl,
-			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "firda_synth_clk", NULL);
-	clk_register_clkdev(clk1, "firda_synth_gate_clk", NULL);
+	clk = clk_register_aux("firda_syn_clk", "firda_syn_gclk", "pll1_clk", 0,
+			FIRDA_CLK_SYNT, NULL, aux_rtbl, ARRAY_SIZE(aux_rtbl),
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
 
 	/* gpt clocks */
-	clk_register_gpt("gpt0_synth_clk", "pll1_clk", 0, PRSC0_CLK_CFG,
-			gpt_rtbl, ARRAY_SIZE(gpt_rtbl), &_lock);
+	clk_register_gpt("gpt0_syn_clk", "pll1_clk", 0, PRSC0_CLK_CFG, gpt_rtbl,
+			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt0_clk", gpt0_parents,
 			ARRAY_SIZE(gpt0_parents), 0, PERIP_CLK_CFG,
 			GPT0_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt0");
 
-	clk_register_gpt("gpt1_synth_clk", "pll1_clk", 0, PRSC1_CLK_CFG,
-			gpt_rtbl, ARRAY_SIZE(gpt_rtbl), &_lock);
-	clk = clk_register_mux(NULL, "gpt1_mux_clk", gpt1_parents,
+	clk_register_gpt("gpt1_syn_clk", "pll1_clk", 0, PRSC1_CLK_CFG, gpt_rtbl,
+			ARRAY_SIZE(gpt_rtbl), &_lock);
+	clk = clk_register_mux(NULL, "gpt1_mclk", gpt1_parents,
 			ARRAY_SIZE(gpt1_parents), 0, PERIP_CLK_CFG,
 			GPT1_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gpt1_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt1_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
 			PERIP1_CLK_ENB, GPT1_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt1");
 
-	clk_register_gpt("gpt2_synth_clk", "pll1_clk", 0, PRSC2_CLK_CFG,
-			gpt_rtbl, ARRAY_SIZE(gpt_rtbl), &_lock);
-	clk = clk_register_mux(NULL, "gpt2_mux_clk", gpt2_parents,
+	clk_register_gpt("gpt2_syn_clk", "pll1_clk", 0, PRSC2_CLK_CFG, gpt_rtbl,
+			ARRAY_SIZE(gpt_rtbl), &_lock);
+	clk = clk_register_mux(NULL, "gpt2_mclk", gpt2_parents,
 			ARRAY_SIZE(gpt2_parents), 0, PERIP_CLK_CFG,
 			GPT2_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gpt2_mux_clk", NULL);
-	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mux_clk", 0,
+	clk_register_clkdev(clk, "gpt2_mclk", NULL);
+	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
 			PERIP1_CLK_ENB, GPT2_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt2");
 
 	/* general synths clocks */
-	clk = clk_register_aux("gen0_synth_clk", "gen0_synth_gate_clk",
-			"pll1_clk", 0, GEN0_CLK_SYNT, NULL, aux_rtbl,
-			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "gen0_synth_clk", NULL);
-	clk_register_clkdev(clk1, "gen0_synth_gate_clk", NULL);
-
-	clk = clk_register_aux("gen1_synth_clk", "gen1_synth_gate_clk",
-			"pll1_clk", 0, GEN1_CLK_SYNT, NULL, aux_rtbl,
-			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "gen1_synth_clk", NULL);
-	clk_register_clkdev(clk1, "gen1_synth_gate_clk", NULL);
-
-	clk = clk_register_mux(NULL, "gen2_3_parent_clk", gen2_3_parents,
+	clk = clk_register_aux("gen0_syn_clk", "gen0_syn_gclk", "pll1_clk",
+			0, GEN0_CLK_SYNT, NULL, aux_rtbl, ARRAY_SIZE(aux_rtbl),
+			&_lock, &clk1);
+	clk_register_clkdev(clk, "gen0_syn_clk", NULL);
+	clk_register_clkdev(clk1, "gen0_syn_gclk", NULL);
+
+	clk = clk_register_aux("gen1_syn_clk", "gen1_syn_gclk", "pll1_clk",
+			0, GEN1_CLK_SYNT, NULL, aux_rtbl, ARRAY_SIZE(aux_rtbl),
+			&_lock, &clk1);
+	clk_register_clkdev(clk, "gen1_syn_clk", NULL);
+	clk_register_clkdev(clk1, "gen1_syn_gclk", NULL);
+
+	clk = clk_register_mux(NULL, "gen2_3_par_clk", gen2_3_parents,
 			ARRAY_SIZE(gen2_3_parents), 0, CORE_CLK_CFG,
 			GEN_SYNTH2_3_CLK_SHIFT, GEN_SYNTH2_3_CLK_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "gen2_3_parent_clk", NULL);
+	clk_register_clkdev(clk, "gen2_3_par_clk", NULL);
 
-	clk = clk_register_aux("gen2_synth_clk", "gen2_synth_gate_clk",
-			"gen2_3_parent_clk", 0, GEN2_CLK_SYNT, NULL, aux_rtbl,
+	clk = clk_register_aux("gen2_syn_clk", "gen2_syn_gclk",
+			"gen2_3_par_clk", 0, GEN2_CLK_SYNT, NULL, aux_rtbl,
 			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "gen2_synth_clk", NULL);
-	clk_register_clkdev(clk1, "gen2_synth_gate_clk", NULL);
+	clk_register_clkdev(clk, "gen2_syn_clk", NULL);
+	clk_register_clkdev(clk1, "gen2_syn_gclk", NULL);
 
-	clk = clk_register_aux("gen3_synth_clk", "gen3_synth_gate_clk",
-			"gen2_3_parent_clk", 0, GEN3_CLK_SYNT, NULL, aux_rtbl,
+	clk = clk_register_aux("gen3_syn_clk", "gen3_syn_gclk",
+			"gen2_3_par_clk", 0, GEN3_CLK_SYNT, NULL, aux_rtbl,
 			ARRAY_SIZE(aux_rtbl), &_lock, &clk1);
-	clk_register_clkdev(clk, "gen3_synth_clk", NULL);
-	clk_register_clkdev(clk1, "gen3_synth_gate_clk", NULL);
+	clk_register_clkdev(clk, "gen3_syn_clk", NULL);
+	clk_register_clkdev(clk1, "gen3_syn_gclk", NULL);
 
 	/* clock derived from pll3 clk */
-	clk = clk_register_gate(NULL, "usbh_clk", "pll3_48m_clk", 0,
-			PERIP1_CLK_ENB, USBH_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "usbh_clk", "pll3_clk", 0, PERIP1_CLK_ENB,
+			USBH_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, "usbh_clk", NULL);
 
 	clk = clk_register_fixed_factor(NULL, "usbh.0_clk", "usbh_clk", 0, 1,
@@ -494,8 +490,8 @@ void __init spear3xx_clk_init(void)
 			1);
 	clk_register_clkdev(clk, "usbh.1_clk", NULL);
 
-	clk = clk_register_gate(NULL, "usbd_clk", "pll3_48m_clk", 0,
-			PERIP1_CLK_ENB, USBD_CLK_ENB, 0, &_lock);
+	clk = clk_register_gate(NULL, "usbd_clk", "pll3_clk", 0, PERIP1_CLK_ENB,
+			USBD_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "designware_udc");
 
 	/* clock derived from ahb clk */
@@ -579,29 +575,25 @@ void __init spear3xx_clk_init(void)
 			RAS_CLK_ENB, RAS_PLL2_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, "ras_pll2_clk", NULL);
 
-	clk = clk_register_gate(NULL, "ras_pll3_48m_clk", "pll3_48m_clk", 0,
+	clk = clk_register_gate(NULL, "ras_pll3_clk", "pll3_clk", 0,
 			RAS_CLK_ENB, RAS_48M_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, "ras_pll3_48m_clk", NULL);
-
-	clk = clk_register_gate(NULL, "ras_gen0_synth_gate_clk",
-			"gen0_synth_gate_clk", 0, RAS_CLK_ENB,
-			RAS_SYNT0_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, "ras_gen0_synth_gate_clk", NULL);
-
-	clk = clk_register_gate(NULL, "ras_gen1_synth_gate_clk",
-			"gen1_synth_gate_clk", 0, RAS_CLK_ENB,
-			RAS_SYNT1_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, "ras_gen1_synth_gate_clk", NULL);
-
-	clk = clk_register_gate(NULL, "ras_gen2_synth_gate_clk",
-			"gen2_synth_gate_clk", 0, RAS_CLK_ENB,
-			RAS_SYNT2_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, "ras_gen2_synth_gate_clk", NULL);
-
-	clk = clk_register_gate(NULL, "ras_gen3_synth_gate_clk",
-			"gen3_synth_gate_clk", 0, RAS_CLK_ENB,
-			RAS_SYNT3_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, "ras_gen3_synth_gate_clk", NULL);
+	clk_register_clkdev(clk, "ras_pll3_clk", NULL);
+
+	clk = clk_register_gate(NULL, "ras_syn0_gclk", "gen0_syn_gclk", 0,
+			RAS_CLK_ENB, RAS_SYNT0_CLK_ENB, 0, &_lock);
+	clk_register_clkdev(clk, "ras_syn0_gclk", NULL);
+
+	clk = clk_register_gate(NULL, "ras_syn1_gclk", "gen1_syn_gclk", 0,
+			RAS_CLK_ENB, RAS_SYNT1_CLK_ENB, 0, &_lock);
+	clk_register_clkdev(clk, "ras_syn1_gclk", NULL);
+
+	clk = clk_register_gate(NULL, "ras_syn2_gclk", "gen2_syn_gclk", 0,
+			RAS_CLK_ENB, RAS_SYNT2_CLK_ENB, 0, &_lock);
+	clk_register_clkdev(clk, "ras_syn2_gclk", NULL);
+
+	clk = clk_register_gate(NULL, "ras_syn3_gclk", "gen3_syn_gclk", 0,
+			RAS_CLK_ENB, RAS_SYNT3_CLK_ENB, 0, &_lock);
+	clk_register_clkdev(clk, "ras_syn3_gclk", NULL);
 
 	if (of_machine_is_compatible("st,spear300"))
 		spear300_clk_init();
-- 
1.7.2.2
