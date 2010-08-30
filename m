From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:56 +0530
Subject: [PATCH 32/74] ST SPEAr: Adding clk_set_rate support
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <89c9cebf76e54242ec0d2cb0b7e90b2305db1b39.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/clock.c          |   74 +++++-
 arch/arm/mach-spear3xx/clock.c           |   54 ++++
 arch/arm/mach-spear6xx/clock.c           |   58 ++++
 arch/arm/plat-spear/clock.c              |  423 ++++++++++++++++++++++++++----
 arch/arm/plat-spear/include/plat/clock.h |   75 +++++-
 5 files changed, 620 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 8399c15..630ab65 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -87,6 +87,15 @@ static struct pll_clk_config pll1_config = {
 	.masks = &pll_masks,
 };
 
+/* pll rate configuration table, in ascending order of rates */
+struct pll_rate_tbl pll_rtbl[] = {
+	/* PCLK 24MHz */
+	{.mode = 0, .m = 0x7D, .n = 0x03, .p = 0x2}, /* 500 MHz */
+	{.mode = 0, .m = 0xA6, .n = 0x03, .p = 0x2}, /* 664 MHz */
+	{.mode = 0, .m = 0xC8, .n = 0x03, .p = 0x2}, /* 800 MHz */
+	{.mode = 0, .m = 0xFA, .n = 0x06, .p = 0x1}, /* 1000 MHz */
+};
+
 /* pll1 clock */
 static struct clk pll1_clk = {
 	.flags = ENABLED_ON_INIT,
@@ -94,7 +103,10 @@ static struct clk pll1_clk = {
 	.pclk_sel_shift = PLL1_CLK_SHIFT,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
 	.private_data = &pll1_config,
 };
 
@@ -127,7 +139,10 @@ static struct clk pll2_clk = {
 	.pclk_sel_shift = PLL2_CLK_SHIFT,
 	.en_reg = PLL2_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
 	.private_data = &pll2_config,
 };
 
@@ -144,7 +159,10 @@ static struct clk pll3_clk = {
 	.pclk_sel_shift = PLL3_CLK_SHIFT,
 	.en_reg = PLL3_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
 	.private_data = &pll3_config,
 };
 
@@ -155,13 +173,24 @@ static struct pll_clk_config pll4_config = {
 	.masks = &pll_masks,
 };
 
+/* pll4 rate configuration table, in ascending order of rates */
+struct pll_rate_tbl pll4_rtbl[] = {
+	{.mode = 0, .m = 0x7D, .n = 0x03, .p = 0x2}, /* 500 MHz */
+	{.mode = 0, .m = 0xA6, .n = 0x03, .p = 0x2}, /* 664 MHz */
+	{.mode = 0, .m = 0xC8, .n = 0x03, .p = 0x2}, /* 800 MHz */
+	{.mode = 0, .m = 0xFA, .n = 0x06, .p = 0x1}, /* 1000 MHz */
+};
+
 /* pll4 (DDR) clock */
 static struct clk pll4_clk = {
 	.flags = ENABLED_ON_INIT,
 	.pclk = &osc1_24m_clk,
 	.en_reg = PLL4_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll4_rtbl, ARRAY_SIZE(pll4_rtbl), 3},
 	.private_data = &pll4_config,
 };
 
@@ -287,12 +316,24 @@ static struct aux_clk_config uart_synth_config = {
 	.masks = &aux_masks,
 };
 
+/* aux rate configuration table, in ascending order of rates */
+struct aux_rate_tbl aux_rtbl[] = {
+	/* For PLL1div2 = 500 MHz */
+	{.xscale = 1, .yscale = 6, .eq = 1}, /* 83 MHz */
+	{.xscale = 1, .yscale = 4, .eq = 1}, /* 125 MHz */
+	{.xscale = 1, .yscale = 3, .eq = 1}, /* 166 MHz */
+	{.xscale = 1, .yscale = 2, .eq = 1}, /* 250 MHz */
+};
+
 /* uart synth clock */
 static struct clk uart_synth_clk = {
 	.en_reg = UART_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
 	.private_data = &uart_synth_config,
 };
 
@@ -335,8 +376,11 @@ static struct clk sd_synth_clk = {
 	.en_reg = SD_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
-	.private_data = &sd_synth_config,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
+	.private_data = &sdhci_synth_config,
 };
 
 /* sd clock */
@@ -358,7 +402,10 @@ static struct clk cfxd_synth_clk = {
 	.en_reg = CFXD_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
 	.private_data = &cfxd_synth_config,
 };
 
@@ -381,7 +428,10 @@ static struct clk c3_synth_clk = {
 	.en_reg = C3_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
 	.private_data = &c3_synth_config,
 };
 
@@ -453,11 +503,23 @@ static struct clk gmac_phy_input_clk = {
 	.recalc = &follow_parent,
 };
 
+/* gmac rate configuration table, in ascending order of rates */
+struct aux_rate_tbl gmac_rtbl[] = {
+	/* For gmac phy input clk */
+	{.xscale = 1, .yscale = 6, .eq = 1}, /* divided by 6 */
+	{.xscale = 1, .yscale = 4, .eq = 1}, /* divided by 4 */
+	{.xscale = 1, .yscale = 3, .eq = 1}, /* divided by 3 */
+	{.xscale = 1, .yscale = 2, .eq = 1}, /* divided by 2 */
+};
+
 static struct clk gmac_phy_synth_clk = {
 	.en_reg = GMAC_CLK_CFG,
 	.en_reg_bit = GMAC_PHY_SYNT_ENB,
 	.pclk = &gmac_phy_input_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {gmac_rtbl, ARRAY_SIZE(gmac_rtbl), 0},
 	.private_data = &gmac_phy_synth_config,
 };
 
@@ -518,13 +580,23 @@ static struct pclk_sel clcd_synth_pclk_sel = {
 	.pclk_sel_mask = CLCD_SYNT_CLK_MASK,
 };
 
+/* clcd rate configuration table, in ascending order of rates */
+struct clcd_rate_tbl clcd_rtbl[] = {
+	/* For pll1div4 = 250 MHz */
+	{.div = 0x4000}, /* 62.5 MHz */
+	{.div = 0x2000}, /* 125 MHz */
+};
+
 /* clcd synth clock */
 static struct clk clcd_synth_clk = {
 	.en_reg = CLCD_CLK_SYNT,
 	.en_reg_bit = CLCD_SYNT_ENB,
 	.pclk_sel = &clcd_synth_pclk_sel,
 	.pclk_sel_shift = CLCD_SYNT_CLK_SHIFT,
+	.calc_rate = &clcd_calc_rate,
 	.recalc = &clcd_clk_recalc,
+	.set_rate = &clcd_clk_set_rate,
+	.rate_config = {clcd_rtbl, ARRAY_SIZE(clcd_rtbl), 1},
 	.private_data = &clcd_synth_config,
 };
 
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index f7dedc6..51cf304 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -60,13 +60,22 @@ static struct pll_clk_config pll1_config = {
 	.masks = &pll1_masks,
 };
 
+/* pll rate configuration table, in ascending order of rates */
+struct pll_rate_tbl pll_rtbl[] = {
+	{.mode = 0, .m = 0x85, .n = 0x0C, .p = 0x1}, /* 266 MHz */
+	{.mode = 0, .m = 0xA6, .n = 0x0C, .p = 0x1}, /* 332 MHz */
+};
+
 /* PLL1 clock */
 static struct clk pll1_clk = {
 	.flags = ENABLED_ON_INIT,
 	.pclk = &osc_24m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
 	.private_data = &pll1_config,
 };
 
@@ -104,11 +113,22 @@ static struct bus_clk_config ahb_config = {
 	.masks = &ahb_masks,
 };
 
+/* ahb rate configuration table, in ascending order of rates */
+struct bus_rate_tbl bus_rtbl[] = {
+	{.div = 3}, /* == parent divided by 4 */
+	{.div = 2}, /* == parent divided by 3 */
+	{.div = 1}, /* == parent divided by 2 */
+	{.div = 0}, /* == parent divided by 1 */
+};
+
 /* ahb clock */
 static struct clk ahb_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &pll1_clk,
+	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
+	.set_rate = &bus_clk_set_rate,
+	.rate_config = {bus_rtbl, ARRAY_SIZE(bus_rtbl), 2},
 	.private_data = &ahb_config,
 };
 
@@ -130,12 +150,23 @@ static struct aux_clk_config uart_synth_config = {
 	.masks = &aux_masks,
 };
 
+/* aux rate configuration table, in ascending order of rates */
+struct aux_rate_tbl aux_rtbl[] = {
+	/* For PLL1 = 332 MHz */
+	{.xscale = 1, .yscale = 8, .eq = 1}, /* 41.5 MHz */
+	{.xscale = 1, .yscale = 4, .eq = 1}, /* 83 MHz */
+	{.xscale = 1, .yscale = 2, .eq = 1}, /* 166 MHz */
+};
+
 /* uart synth clock */
 static struct clk uart_synth_clk = {
 	.en_reg = UART_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 1},
 	.private_data = &uart_synth_config,
 };
 
@@ -178,7 +209,10 @@ static struct clk firda_synth_clk = {
 	.en_reg = FIRDA_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 1},
 	.private_data = &firda_synth_config,
 };
 
@@ -218,6 +252,14 @@ static struct gpt_clk_masks gpt_masks = {
 	.nscale_sel_shift = GPT_NSCALE_SHIFT,
 };
 
+/* gpt rate configuration table, in ascending order of rates */
+struct gpt_rate_tbl gpt_rtbl[] = {
+	/* For pll1 = 332 MHz */
+	{.mscale = 4, .nscale = 0}, /* 41.5 MHz */
+	{.mscale = 2, .nscale = 0}, /* 55.3 MHz */
+	{.mscale = 1, .nscale = 0}, /* 83 MHz */
+};
+
 /* gpt0 synth clk config*/
 static struct gpt_clk_config gpt0_synth_config = {
 	.synth_reg = PRSC1_CLK_CFG,
@@ -228,7 +270,10 @@ static struct gpt_clk_config gpt0_synth_config = {
 static struct clk gpt0_synth_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
 	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
 	.private_data = &gpt0_synth_config,
 };
 
@@ -269,7 +314,10 @@ static struct gpt_clk_config gpt1_synth_config = {
 static struct clk gpt1_synth_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
 	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
 	.private_data = &gpt1_synth_config,
 };
 
@@ -310,7 +358,10 @@ static struct gpt_clk_config gpt2_synth_config = {
 static struct clk gpt2_synth_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
 	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
 	.private_data = &gpt2_synth_config,
 };
 
@@ -382,7 +433,10 @@ static struct bus_clk_config apb_config = {
 static struct clk apb_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &ahb_clk,
+	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
+	.set_rate = &bus_clk_set_rate,
+	.rate_config = {bus_rtbl, ARRAY_SIZE(bus_rtbl), 2},
 	.private_data = &apb_config,
 };
 
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 52d5bff..9171952 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -60,13 +60,22 @@ static struct pll_clk_config pll1_config = {
 	.masks = &pll1_masks,
 };
 
+/* pll rate configuration table, in ascending order of rates */
+struct pll_rate_tbl pll_rtbl[] = {
+	{.mode = 0, .m = 0x85, .n = 0x0C, .p = 0x1}, /* 266 MHz */
+	{.mode = 0, .m = 0xA6, .n = 0x0C, .p = 0x1}, /* 332 MHz */
+};
+
 /* PLL1 clock */
 static struct clk pll1_clk = {
 	.flags = ENABLED_ON_INIT,
 	.pclk = &osc_30m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
 	.private_data = &pll1_config,
 };
 
@@ -104,11 +113,22 @@ static struct bus_clk_config ahb_config = {
 	.masks = &ahb_masks,
 };
 
+/* ahb rate configuration table, in ascending order of rates */
+struct bus_rate_tbl bus_rtbl[] = {
+	{.div = 3}, /* == parent divided by 4 */
+	{.div = 2}, /* == parent divided by 3 */
+	{.div = 1}, /* == parent divided by 2 */
+	{.div = 0}, /* == parent divided by 1 */
+};
+
 /* ahb clock */
 static struct clk ahb_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &pll1_clk,
+	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
+	.set_rate = &bus_clk_set_rate,
+	.rate_config = {bus_rtbl, ARRAY_SIZE(bus_rtbl), 2},
 	.private_data = &ahb_config,
 };
 
@@ -130,12 +150,23 @@ static struct aux_clk_config uart_synth_config = {
 	.masks = &aux_masks,
 };
 
+/* aux rate configuration table, in ascending order of rates */
+struct aux_rate_tbl aux_rtbl[] = {
+	/* For PLL1 = 332 MHz */
+	{.xscale = 1, .yscale = 8, .eq = 1}, /* 41.5 MHz */
+	{.xscale = 1, .yscale = 4, .eq = 1}, /* 83 MHz */
+	{.xscale = 1, .yscale = 2, .eq = 1}, /* 166 MHz */
+};
+
 /* uart synth clock */
 static struct clk uart_synth_clk = {
 	.en_reg = UART_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
 	.private_data = &uart_synth_config,
 };
 
@@ -187,7 +218,10 @@ static struct clk firda_synth_clk = {
 	.en_reg = FIRDA_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
 	.private_data = &firda_synth_config,
 };
 
@@ -230,7 +264,10 @@ static struct clk clcd_synth_clk = {
 	.en_reg = CLCD_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
 	.private_data = &clcd_synth_config,
 };
 
@@ -270,6 +307,14 @@ static struct gpt_clk_masks gpt_masks = {
 	.nscale_sel_shift = GPT_NSCALE_SHIFT,
 };
 
+/* gpt rate configuration table, in ascending order of rates */
+struct gpt_rate_tbl gpt_rtbl[] = {
+	/* For pll1 = 332 MHz */
+	{.mscale = 4, .nscale = 0}, /* 41.5 MHz */
+	{.mscale = 2, .nscale = 0}, /* 55.3 MHz */
+	{.mscale = 1, .nscale = 0}, /* 83 MHz */
+};
+
 /* gpt0 synth clk config*/
 static struct gpt_clk_config gpt0_synth_config = {
 	.synth_reg = PRSC1_CLK_CFG,
@@ -280,7 +325,10 @@ static struct gpt_clk_config gpt0_synth_config = {
 static struct clk gpt0_synth_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
 	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
 	.private_data = &gpt0_synth_config,
 };
 
@@ -339,7 +387,10 @@ static struct gpt_clk_config gpt2_synth_config = {
 static struct clk gpt2_synth_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
 	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
 	.private_data = &gpt2_synth_config,
 };
 
@@ -380,7 +431,10 @@ static struct gpt_clk_config gpt3_synth_config = {
 static struct clk gpt3_synth_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
 	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
 	.private_data = &gpt3_synth_config,
 };
 
@@ -453,7 +507,10 @@ static struct bus_clk_config apb_config = {
 static struct clk apb_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &ahb_clk,
+	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
+	.set_rate = &bus_clk_set_rate,
+	.rate_config = {bus_rtbl, ARRAY_SIZE(bus_rtbl), 2},
 	.private_data = &apb_config,
 };
 
@@ -580,6 +637,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "ahb_clk",		.clk = &ahb_clk},
 	{ .con_id = "uart_synth_clk",	.clk = &uart_synth_clk},
 	{ .con_id = "firda_synth_clk",	.clk = &firda_synth_clk},
+	{ .con_id = "clcd_synth_clk",	.clk = &clcd_synth_clk},
 	{ .con_id = "gpt0_synth_clk",	.clk = &gpt0_synth_clk},
 	{ .con_id = "gpt2_synth_clk",	.clk = &gpt2_synth_clk},
 	{ .con_id = "gpt3_synth_clk",	.clk = &gpt3_synth_clk},
diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index e871016..7d3338f 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -27,28 +27,11 @@ static LIST_HEAD(root_clks);
 static LIST_HEAD(clocks);
 #endif
 
-static void propagate_rate(struct clk *);
+static void propagate_rate(struct clk *, int on_init);
 #ifdef CONFIG_DEBUG_FS
 static int clk_debugfs_reparent(struct clk *);
 #endif
 
-static int clk_is_enabled(struct clk *clk)
-{
-	unsigned int val;
-
-	if (clk->flags & ALWAYS_ENABLED)
-		return 1;
-
-	BUG_ON(!clk->en_reg);
-	val = readl(clk->en_reg);
-	val = val & (1 << clk->en_reg_bit);
-
-	if (unlikely(clk->flags & RESET_TO_ENABLE))
-		return !val;
-	else
-		return !!val;
-}
-
 static int generic_clk_enable(struct clk *clk)
 {
 	unsigned int val;
@@ -126,7 +109,7 @@ static void clk_reparent(struct clk *clk, struct pclk_info *pclk_info)
 #endif
 }
 
-void do_clk_disable(struct clk *clk)
+static void do_clk_disable(struct clk *clk)
 {
 	if (!clk)
 		return;
@@ -151,7 +134,7 @@ void do_clk_disable(struct clk *clk)
 	}
 }
 
-int do_clk_enable(struct clk *clk)
+static int do_clk_enable(struct clk *clk)
 {
 	int ret = 0;
 
@@ -176,8 +159,11 @@ int do_clk_enable(struct clk *clk)
 		 * Since the clock is going to be used for the first
 		 * time please reclac
 		 */
-		if (clk->recalc)
-			clk->recalc(clk);
+		if (clk->recalc) {
+			ret = clk->recalc(clk);
+			if (ret)
+				goto err;
+		}
 	}
 	clk->usage_count++;
 err:
@@ -248,8 +234,7 @@ EXPORT_SYMBOL(clk_get_rate);
  * @clk: clock source
  * @parent: parent clock source
  *
- * Returns success (0) or negative errno. clk usage_count must be zero
- * before calling this function.
+ * Returns success (0) or negative errno.
  */
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
@@ -258,8 +243,6 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 
 	if (!clk || !parent)
 		return -EFAULT;
-	if (clk->usage_count)
-		return -EPERM;
 	if (clk->pclk == parent)
 		return 0;
 	if (!clk->pclk_sel)
@@ -287,6 +270,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	/* reflect parent change in software */
 	clk_reparent(clk, &clk->pclk_sel->pclk_info[i]);
 
+	propagate_rate(clk, 0);
 	return 0;
 }
 EXPORT_SYMBOL(clk_set_parent);
@@ -300,8 +284,25 @@ EXPORT_SYMBOL(clk_set_parent);
  */
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	/* TODO */
-	return -EINVAL;
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	if (!clk || !rate)
+		return -EFAULT;
+
+	if (clk->set_rate) {
+		spin_lock_irqsave(&clocks_lock, flags);
+		ret = clk->set_rate(clk, rate);
+		if (!ret)
+			/* if successful -> propagate */
+			propagate_rate(clk, 0);
+		spin_unlock_irqrestore(&clocks_lock, flags);
+	} else if (clk->pclk) {
+		u32 mult = clk->div_factor ? clk->div_factor : 1;
+		ret = clk_set_rate(clk->pclk, mult * rate);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(clk_set_rate);
 
@@ -358,27 +359,112 @@ void clk_register(struct clk_lookup *cl)
 
 /**
  * propagate_rate - recalculate and propagate all clocks to children
+ * @pclk: parent clock required to be propogated
+ * @on_init: flag for enabling clocks which are ENABLED_ON_INIT.
  *
  * Recalculates all children clocks
  */
-void propagate_rate(struct clk *pclk)
+void propagate_rate(struct clk *pclk, int on_init)
 {
 	struct clk *clk, *_temp;
+	int ret = 0;
 
 	list_for_each_entry_safe(clk, _temp, &pclk->children, sibling) {
-		/* recalc and propogate only if clk is enabled */
-		if (clk_is_enabled(clk)) {
-			if (clk->recalc)
-				clk->recalc(clk);
-			propagate_rate(clk);
+		if (clk->recalc) {
+			ret = clk->recalc(clk);
+			/*
+			 * recalc will return error if clk out is not programmed
+			 * In this case configure default rate.
+			 */
+			if (ret && clk->set_rate)
+				clk->set_rate(clk, 0);
 		}
+		propagate_rate(clk, on_init);
+
+		if (!on_init)
+			continue;
+
 		/* Enable clks enabled on init, in software view */
 		if (clk->flags & ENABLED_ON_INIT)
 			do_clk_enable(clk);
 	}
 }
 
-/*All recalc functions are called with lock held */
+/**
+ * round_rate - Returns index of closest programmable rate in rate_config tbl
+ * @clk: ptr to clock structure
+ * @drate: desired rate
+ * @rate: final rate will be returned in this variable only.
+ *
+ * Finds index in rate_config for highest clk rate which is less than
+ * requested rate. If there is no clk rate lesser than requested rate then
+ * -EINVAL is returned. This routine assumes that rate_config is written
+ * in incrementing order of clk rates.
+ * If drate passed is zero then default rate is programmed.
+ */
+static int round_rate(struct clk *clk, unsigned long drate, unsigned long *rate)
+{
+	unsigned long tmp = 0, prev_rate = 0;
+	int index;
+
+	if (!clk->calc_rate)
+		return -EFAULT;
+
+	/* Set default rate if desired rate is 0 */
+	if (!drate) {
+		index = clk->rate_config.default_index;
+		*rate = clk->calc_rate(clk, index);
+		return index;
+	}
+
+	/*
+	 * This loops ends on two conditions:
+	 * - as soon as clk is found with rate greater than requested rate.
+	 * - if all clks in rate_config are smaller than requested rate.
+	 */
+	for (index = 0; index < clk->rate_config.count; index++) {
+		prev_rate = tmp;
+		tmp = clk->calc_rate(clk, index);
+		if (drate < tmp) {
+			index--;
+			break;
+		}
+	}
+	/* return if can't find suitable clock */
+	if (index < 0) {
+		index = -EINVAL;
+		*rate = 0;
+	} else if (index == clk->rate_config.count) {
+		/* program with highest clk rate possible */
+		index = clk->rate_config.count - 1;
+		*rate = tmp;
+	} else
+		*rate = prev_rate;
+
+	return index;
+}
+
+/*All below functions are called with lock held */
+
+/*
+ * Calculates pll clk rate for specific value of mode, m, n and p
+ *
+ * In normal mode
+ * rate = (2 * M[15:8] * Fin)/(N * 2^P)
+ *
+ * In Dithered mode
+ * rate = (2 * M[15:0] * Fin)/(256 * N * 2^P)
+ */
+unsigned long pll_calc_rate(struct clk *clk, int index)
+{
+	unsigned long rate = clk->pclk->rate;
+	struct pll_rate_tbl *tbls = clk->rate_config.tbls;
+	unsigned int mode;
+
+	mode = tbls[index].mode ? 256 : 1;
+	return (((2 * rate / 10000) * tbls[index].m) /
+			(mode * tbls[index].n * (1 << tbls[index].p))) * 10000;
+}
 
 /*
  * calculates current programmed rate of pll1
@@ -389,7 +475,7 @@ void propagate_rate(struct clk *pclk)
  * In Dithered mode
  * rate = (2 * M[15:0] * Fin)/(256 * N * 2^P)
  */
-void pll_clk_recalc(struct clk *clk)
+int pll_clk_recalc(struct clk *clk)
 {
 	struct pll_clk_config *config = clk->private_data;
 	unsigned int num = 2, den = 0, val, mode = 0;
@@ -415,13 +501,69 @@ void pll_clk_recalc(struct clk *clk)
 		den *= 256;
 	}
 
-	BUG_ON(!den);
+	if (!den)
+		return -EINVAL;
 
 	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
+	return 0;
+}
+
+/*
+ * Configures new clock rate of pll
+ */
+int pll_clk_set_rate(struct clk *clk, unsigned long desired_rate)
+{
+	struct pll_rate_tbl *tbls = clk->rate_config.tbls;
+	struct pll_clk_config *config = clk->private_data;
+	unsigned long val, rate;
+	int i;
+
+	i = round_rate(clk, desired_rate, &rate);
+	if (i < 0)
+		return i;
+
+	val = readl(config->mode_reg) &
+		~(config->masks->mode_mask << config->masks->mode_shift);
+	val |= (tbls[i].mode & config->masks->mode_mask) <<
+		config->masks->mode_shift;
+	writel(val, config->mode_reg);
+
+	val = readl(config->cfg_reg) &
+		~(config->masks->div_p_mask << config->masks->div_p_shift);
+	val |= (tbls[i].p & config->masks->div_p_mask) <<
+		config->masks->div_p_shift;
+	val &= ~(config->masks->div_n_mask << config->masks->div_n_shift);
+	val |= (tbls[i].n & config->masks->div_n_mask) <<
+		config->masks->div_n_shift;
+	val &= ~(config->masks->dith_fdbk_m_mask <<
+			config->masks->dith_fdbk_m_shift);
+	if (tbls[i].mode)
+		val |= (tbls[i].m & config->masks->dith_fdbk_m_mask) <<
+			config->masks->dith_fdbk_m_shift;
+	else
+		val |= (tbls[i].m & config->masks->norm_fdbk_m_mask) <<
+			config->masks->norm_fdbk_m_shift;
+
+	writel(val, config->cfg_reg);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+/*
+ * Calculates ahb, apb clk rate for specific value of div
+ */
+unsigned long bus_calc_rate(struct clk *clk, int index)
+{
+	unsigned long rate = clk->pclk->rate;
+	struct bus_rate_tbl *tbls = clk->rate_config.tbls;
+
+	return rate / (tbls[index].div + 1);
 }
 
 /* calculates current programmed rate of ahb or apb bus */
-void bus_clk_recalc(struct clk *clk)
+int bus_clk_recalc(struct clk *clk)
 {
 	struct bus_clk_config *config = clk->private_data;
 	unsigned int div;
@@ -429,9 +571,50 @@ void bus_clk_recalc(struct clk *clk)
 	div = ((readl(config->reg) >> config->masks->shift) &
 			config->masks->mask) + 1;
 
-	BUG_ON(!div);
+	if (!div)
+		return -EINVAL;
 
 	clk->rate = (unsigned long)clk->pclk->rate / div;
+	return 0;
+}
+
+/* Configures new clock rate of AHB OR APB bus */
+int bus_clk_set_rate(struct clk *clk, unsigned long desired_rate)
+{
+	struct bus_rate_tbl *tbls = clk->rate_config.tbls;
+	struct bus_clk_config *config = clk->private_data;
+	unsigned long val, rate;
+	int i;
+
+	i = round_rate(clk, desired_rate, &rate);
+	if (i < 0)
+		return i;
+
+	val = readl(config->reg) &
+		~(config->masks->mask << config->masks->shift);
+	val |= (tbls[i].div & config->masks->mask) << config->masks->shift;
+	writel(val, config->reg);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+/*
+ * gives rate for different values of eq, x and y
+ *
+ * Fout from synthesizer can be given from two equations:
+ * Fout1 = (Fin * X/Y)/2		EQ1
+ * Fout2 = Fin * X/Y			EQ2
+ */
+unsigned long aux_calc_rate(struct clk *clk, int index)
+{
+	unsigned long rate = clk->pclk->rate;
+	struct aux_rate_tbl *tbls = clk->rate_config.tbls;
+	u8 eq = tbls[index].eq ? 1 : 2;
+
+	return (((rate/10000) * tbls[index].xscale) /
+			(tbls[index].yscale * eq)) * 10000;
 }
 
 /*
@@ -444,7 +627,7 @@ void bus_clk_recalc(struct clk *clk)
  *
  * Selection of eqn 1 or 2 is programmed in register
  */
-void aux_clk_recalc(struct clk *clk)
+int aux_clk_recalc(struct clk *clk)
 {
 	struct aux_clk_config *config = clk->private_data;
 	unsigned int num = 1, den = 1, val, eqn;
@@ -464,9 +647,56 @@ void aux_clk_recalc(struct clk *clk)
 	den *= (val >> config->masks->yscale_sel_shift) &
 		config->masks->yscale_sel_mask;
 
-	BUG_ON(!den);
+	if (!den)
+		return -EINVAL;
 
 	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
+	return 0;
+}
+
+/* Configures new clock rate of auxiliary synthesizers used by: UART, FIRDA*/
+int aux_clk_set_rate(struct clk *clk, unsigned long desired_rate)
+{
+	struct aux_rate_tbl *tbls = clk->rate_config.tbls;
+	struct aux_clk_config *config = clk->private_data;
+	unsigned long val, rate;
+	int i;
+
+	i = round_rate(clk, desired_rate, &rate);
+	if (i < 0)
+		return i;
+
+	val = readl(config->synth_reg) &
+		~(config->masks->eq_sel_mask << config->masks->eq_sel_shift);
+	val |= (tbls[i].eq & config->masks->eq_sel_mask) <<
+		config->masks->eq_sel_shift;
+	val &= ~(config->masks->xscale_sel_mask <<
+			config->masks->xscale_sel_shift);
+	val |= (tbls[i].xscale & config->masks->xscale_sel_mask) <<
+		config->masks->xscale_sel_shift;
+	val &= ~(config->masks->yscale_sel_mask <<
+			config->masks->yscale_sel_shift);
+	val |= (tbls[i].yscale & config->masks->yscale_sel_mask) <<
+		config->masks->yscale_sel_shift;
+	writel(val, config->synth_reg);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+/*
+ * Calculates gpt clk rate for different values of mscale and nscale
+ *
+ * Fout= Fin/((2 ^ (N+1)) * (M+1))
+ */
+unsigned long gpt_calc_rate(struct clk *clk, int index)
+{
+	unsigned long rate = clk->pclk->rate;
+	struct gpt_rate_tbl *tbls = clk->rate_config.tbls;
+
+	return rate / ((1 << (tbls[index].nscale + 1)) *
+			(tbls[index].mscale + 1));
 }
 
 /*
@@ -474,7 +704,7 @@ void aux_clk_recalc(struct clk *clk)
  * Fout from synthesizer can be given from below equations:
  * Fout= Fin/((2 ^ (N+1)) * (M+1))
  */
-void gpt_clk_recalc(struct clk *clk)
+int gpt_clk_recalc(struct clk *clk)
 {
 	struct gpt_clk_config *config = clk->private_data;
 	unsigned int div = 1, val;
@@ -485,9 +715,64 @@ void gpt_clk_recalc(struct clk *clk)
 	div *= 1 << (((val >> config->masks->nscale_sel_shift) &
 				config->masks->nscale_sel_mask) + 1);
 
-	BUG_ON(!div);
+	if (!div)
+		return -EINVAL;
 
 	clk->rate = (unsigned long)clk->pclk->rate / div;
+	return 0;
+}
+
+/* Configures new clock rate of gptiliary synthesizers used by: UART, FIRDA*/
+int gpt_clk_set_rate(struct clk *clk, unsigned long desired_rate)
+{
+	struct gpt_rate_tbl *tbls = clk->rate_config.tbls;
+	struct gpt_clk_config *config = clk->private_data;
+	unsigned long val, rate;
+	int i;
+
+	i = round_rate(clk, desired_rate, &rate);
+	if (i < 0)
+		return i;
+
+	val = readl(config->synth_reg) & ~(config->masks->mscale_sel_mask <<
+			config->masks->mscale_sel_shift);
+	val |= (tbls[i].mscale & config->masks->mscale_sel_mask) <<
+		config->masks->mscale_sel_shift;
+	val &= ~(config->masks->nscale_sel_mask <<
+			config->masks->nscale_sel_shift);
+	val |= (tbls[i].nscale & config->masks->nscale_sel_mask) <<
+		config->masks->nscale_sel_shift;
+	writel(val, config->synth_reg);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+/*
+ * Calculates clcd clk rate for different values of div
+ *
+ * Fout from synthesizer can be given from below equation:
+ * Fout= Fin/2*div (division factor)
+ * div is 17 bits:-
+ *	0-13 (fractional part)
+ *	14-16 (integer part)
+ * To calculate Fout we left shift val by 14 bits and divide Fin by
+ * complete div (including fractional part) and then right shift the
+ * result by 14 places.
+ */
+unsigned long clcd_calc_rate(struct clk *clk, int index)
+{
+	unsigned long rate = clk->pclk->rate;
+	struct clcd_rate_tbl *tbls = clk->rate_config.tbls;
+
+	rate /= 1000;
+	rate <<= 12;
+	rate /= (2 * tbls[index].div);
+	rate >>= 12;
+	rate *= 1000;
+
+	return rate;
 }
 
 /*
@@ -501,7 +786,7 @@ void gpt_clk_recalc(struct clk *clk)
  * complete div (including fractional part) and then right shift the
  * result by 14 places.
  */
-void clcd_clk_recalc(struct clk *clk)
+int clcd_clk_recalc(struct clk *clk)
 {
 	struct clcd_clk_config *config = clk->private_data;
 	unsigned int div = 1;
@@ -512,23 +797,49 @@ void clcd_clk_recalc(struct clk *clk)
 	div = (val >> config->masks->div_factor_shift) &
 		config->masks->div_factor_mask;
 
-	prate = clk->pclk->rate / 1000; /* first level division, make it KHz */
+	if (!div)
+		return -EINVAL;
 
-	BUG_ON(!div);
+	prate = clk->pclk->rate / 1000; /* first level division, make it KHz */
 
 	clk->rate = (((unsigned long)prate << 12) / (2 * div)) >> 12;
 	clk->rate *= 1000;
+	return 0;
+}
+
+/* Configures new clock rate of auxiliary synthesizers used by: UART, FIRDA*/
+int clcd_clk_set_rate(struct clk *clk, unsigned long desired_rate)
+{
+	struct clcd_rate_tbl *tbls = clk->rate_config.tbls;
+	struct clcd_clk_config *config = clk->private_data;
+	unsigned long val, rate;
+	int i;
+
+	i = round_rate(clk, desired_rate, &rate);
+	if (i < 0)
+		return i;
+
+	val = readl(config->synth_reg) & ~(config->masks->div_factor_mask <<
+			config->masks->div_factor_shift);
+	val |= (tbls[i].div & config->masks->div_factor_mask) <<
+		config->masks->div_factor_shift;
+	writel(val, config->synth_reg);
+
+	clk->rate = rate;
+
+	return 0;
 }
 
 /*
  * Used for clocks that always have value as the parent clock divided by a
  * fixed divisor
  */
-void follow_parent(struct clk *clk)
+int follow_parent(struct clk *clk)
 {
 	unsigned int div_factor = (clk->div_factor < 1) ? 1 : clk->div_factor;
 
 	clk->rate = clk->pclk->rate/div_factor;
+	return 0;
 }
 
 /**
@@ -541,18 +852,20 @@ void recalc_root_clocks(void)
 {
 	struct clk *pclk;
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&clocks_lock, flags);
 	list_for_each_entry(pclk, &root_clks, sibling) {
-		/*
-		 * It doesn't make a sense to recalc and propogate rate
-		 * if clk is not enabled in hw.
-		 */
-		if (clk_is_enabled(pclk)) {
-			if (pclk->recalc)
-				pclk->recalc(pclk);
-			propagate_rate(pclk);
+		if (pclk->recalc) {
+			ret = pclk->recalc(pclk);
+			/*
+			 * recalc will return error if clk out is not programmed
+			 * In this case configure default clock.
+			 */
+			if (ret && pclk->set_rate)
+				pclk->set_rate(pclk, 0);
 		}
+		propagate_rate(pclk, 1);
 		/* Enable clks enabled on init, in software view */
 		if (pclk->flags & ENABLED_ON_INIT)
 			do_clk_enable(pclk);
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index 91f8e3f..30938ea 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -58,6 +58,18 @@ struct pclk_sel {
 };
 
 /**
+ * struct rate_config - clk rate configurations
+ * @tbls: array of device specific clk rate tables, in ascending order of rates
+ * @count: size of tbls array
+ * @default_index: default setting when originally disabled
+ */
+struct rate_config {
+	void *tbls;
+	u8 count;
+	u8 default_index;
+};
+
+/**
  * struct clk - clock structure
  * @usage_count: num of users who enabled this clock
  * @flags: flags for clock properties
@@ -66,6 +78,9 @@ struct pclk_sel {
  * @en_reg_bit: clk enable/disable bit
  * @ops: clk enable/disable ops - generic_clkops selected if NULL
  * @recalc: pointer to clock rate recalculate function
+ * @set_rate: pointer to clock set rate function
+ * @calc_rate: pointer to clock get rate function for index
+ * @rate_config: rate configuration information, used by set_rate
  * @div_factor: division factor to parent clock.
  * @pclk: current parent clk
  * @pclk_sel: pointer to parent selection structure
@@ -84,7 +99,10 @@ struct clk {
 	unsigned int *en_reg;
 	u8 en_reg_bit;
 	const struct clkops *ops;
-	void (*recalc) (struct clk *);
+	int (*recalc) (struct clk *);
+	int (*set_rate) (struct clk *, unsigned long rate);
+	unsigned long (*calc_rate)(struct clk *, int index);
+	struct rate_config rate_config;
 	unsigned int div_factor;
 
 	struct clk *pclk;
@@ -122,6 +140,14 @@ struct pll_clk_config {
 	struct pll_clk_masks *masks;
 };
 
+/* pll clk rate config structure */
+struct pll_rate_tbl {
+	u8 mode;
+	u16 m;
+	u8 n;
+	u8 p;
+};
+
 /* ahb and apb bus configuration structure */
 struct bus_clk_masks {
 	u32 mask;
@@ -133,6 +159,11 @@ struct bus_clk_config {
 	struct bus_clk_masks *masks;
 };
 
+/* ahb and apb clk bus rate config structure */
+struct bus_rate_tbl {
+	u8 div;
+};
+
 /* Aux clk configuration structure: applicable to UART and FIRDA */
 struct aux_clk_masks {
 	u32 eq_sel_mask;
@@ -150,6 +181,13 @@ struct aux_clk_config {
 	struct aux_clk_masks *masks;
 };
 
+/* aux clk rate config structure */
+struct aux_rate_tbl {
+	u16 xscale;
+	u16 yscale;
+	u8 eq;
+};
+
 /* GPT clk configuration structure */
 struct gpt_clk_masks {
 	u32 mscale_sel_mask;
@@ -163,6 +201,12 @@ struct gpt_clk_config {
 	struct gpt_clk_masks *masks;
 };
 
+/* gpt clk rate config structure */
+struct gpt_rate_tbl {
+	u16 mscale;
+	u16 nscale;
+};
+
 /* clcd clk configuration structure */
 struct clcd_synth_masks {
 	u32 div_factor_mask;
@@ -174,16 +218,31 @@ struct clcd_clk_config {
 	struct clcd_synth_masks *masks;
 };
 
+/* clcd clk rate config structure */
+struct clcd_rate_tbl {
+	u16 div;
+};
+
 /* platform specific clock functions */
 void clk_register(struct clk_lookup *cl);
 void recalc_root_clocks(void);
 
-/* clock recalc functions */
-void follow_parent(struct clk *clk);
-void pll_clk_recalc(struct clk *clk);
-void bus_clk_recalc(struct clk *clk);
-void gpt_clk_recalc(struct clk *clk);
-void aux_clk_recalc(struct clk *clk);
-void clcd_clk_recalc(struct clk *clk);
+/* clock recalc & set rate functions */
+int follow_parent(struct clk *clk);
+unsigned long pll_calc_rate(struct clk *clk, int index);
+int pll_clk_recalc(struct clk *clk);
+int pll_clk_set_rate(struct clk *clk, unsigned long desired_rate);
+unsigned long bus_calc_rate(struct clk *clk, int index);
+int bus_clk_recalc(struct clk *clk);
+int bus_clk_set_rate(struct clk *clk, unsigned long desired_rate);
+unsigned long gpt_calc_rate(struct clk *clk, int index);
+int gpt_clk_recalc(struct clk *clk);
+int gpt_clk_set_rate(struct clk *clk, unsigned long desired_rate);
+unsigned long aux_calc_rate(struct clk *clk, int index);
+int aux_clk_recalc(struct clk *clk);
+int aux_clk_set_rate(struct clk *clk, unsigned long desired_rate);
+unsigned long clcd_calc_rate(struct clk *clk, int index);
+int clcd_clk_recalc(struct clk *clk);
+int clcd_clk_set_rate(struct clk *clk, unsigned long desired_rate);
 
 #endif /* __PLAT_CLOCK_H */
-- 
1.7.2.2
