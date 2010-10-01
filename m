From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:32 +0530
Subject: [PATCH V2 12/69] ST SPEAr: Updating Clock Support
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <0d9d33ce9793f97ab3c942916ed6f9865abc5bac.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Adding support for divisor per parent clock
- Adding ENABLED_ON_INIT feature in clk
- Adding clk_set_rate
- Simplified clk_recalc functions
- Added/updating clock definitions

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear13xx/clock.c                  |  621 +++++++++++++++++++-
 arch/arm/mach-spear13xx/include/mach/misc_regs.h |  101 ++--
 arch/arm/mach-spear3xx/clock.c                   |  431 ++++++++++++--
 arch/arm/mach-spear3xx/include/mach/misc_regs.h  |    5 +-
 arch/arm/mach-spear6xx/clock.c                   |  331 ++++++++---
 arch/arm/mach-spear6xx/include/mach/misc_regs.h  |    5 +-
 arch/arm/plat-spear/clock.c                      |  675 +++++++++++++++++-----
 arch/arm/plat-spear/include/plat/clock.h         |   94 +++-
 8 files changed, 1888 insertions(+), 375 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 722f634..ca80c46 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -53,10 +53,10 @@ static struct clk rtc_clk = {
 static struct pclk_info pll_pclk_info[] = {
 	{
 		.pclk = &osc1_24m_clk,
-		.pclk_mask = OSC_24M_MASK,
+		.pclk_val = OSC_24M_VAL,
 	}, {
 		.pclk = &osc3_25m_clk,
-		.pclk_mask = OSC_25M_MASK,
+		.pclk_val = OSC_25M_VAL,
 	},
 };
 
@@ -88,16 +88,45 @@ static struct pll_clk_config pll1_config = {
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
+	.flags = ENABLED_ON_INIT,
 	.pclk_sel = &pll_pclk_sel,
 	.pclk_sel_shift = PLL1_CLK_SHIFT,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
 	.private_data = &pll1_config,
 };
 
+/* pll1div2 clock */
+static struct clk pll1div2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.div_factor = 2,
+	.recalc = &follow_parent,
+};
+
+/* pll1div4 clock */
+static struct clk pll1div4_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.div_factor = 4,
+	.recalc = &follow_parent,
+};
+
 /* pll2 configuration structure */
 static struct pll_clk_config pll2_config = {
 	.mode_reg = PLL2_CTR,
@@ -111,7 +140,10 @@ static struct clk pll2_clk = {
 	.pclk_sel_shift = PLL2_CLK_SHIFT,
 	.en_reg = PLL2_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
 	.private_data = &pll2_config,
 };
 
@@ -128,7 +160,10 @@ static struct clk pll3_clk = {
 	.pclk_sel_shift = PLL3_CLK_SHIFT,
 	.en_reg = PLL3_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
 	.private_data = &pll3_config,
 };
 
@@ -139,12 +174,24 @@ static struct pll_clk_config pll4_config = {
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
+	.flags = ENABLED_ON_INIT,
 	.pclk = &osc1_24m_clk,
 	.en_reg = PLL4_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll4_rtbl, ARRAY_SIZE(pll4_rtbl), 3},
 	.private_data = &pll4_config,
 };
 
@@ -192,10 +239,10 @@ static struct clk apb_clk = {
 static struct pclk_info gpt_pclk_info[] = {
 	{
 		.pclk = &osc1_24m_clk,
-		.pclk_mask = GPT_OSC24_MASK,
+		.pclk_val = GPT_OSC24_VAL,
 	}, {
 		.pclk = &apb_clk,
-		.pclk_mask = GPT_APB_MASK,
+		.pclk_val = GPT_APB_VAL,
 	},
 };
 
@@ -246,15 +293,8 @@ static struct clk gpt3_clk = {
 /* watch dog timer clock */
 static struct clk wdt_clk = {
 	.flags = ALWAYS_ENABLED,
-	.pclk = &apb_clk,
-	.recalc = &follow_parent,
-};
-
-/* smi clock */
-static struct clk smi_clk = {
-	.pclk = &ahb_clk,
-	.en_reg = PERIP1_CLK_ENB,
-	.en_reg_bit = SMI_CLK_ENB,
+	.pclk = &cpu_clk,
+	.div_factor = 2,
 	.recalc = &follow_parent,
 };
 
@@ -270,22 +310,42 @@ static struct aux_clk_masks aux_masks = {
 	.yscale_sel_shift = AUX_YSCALE_SHIFT,
 };
 
+/* clocks derived multiple parents (pll1, pll5, synthesizers or others) */
 /* uart configurations */
-static struct aux_clk_config uart_config = {
+static struct aux_clk_config uart_synth_config = {
 	.synth_reg = UART_CLK_SYNT,
 	.masks = &aux_masks,
 };
 
-/* clocks derived from pll1 or pll5 */
+/* aux rate configuration table, in ascending order of rates */
+struct aux_rate_tbl aux_rtbl[] = {
+	/* For PLL1div2 = 500 MHz */
+	{.xscale = 1, .yscale = 6, .eq = 1}, /* 83 MHz */
+	{.xscale = 1, .yscale = 4, .eq = 1}, /* 125 MHz */
+	{.xscale = 1, .yscale = 3, .eq = 1}, /* 166 MHz */
+	{.xscale = 1, .yscale = 2, .eq = 1}, /* 250 MHz */
+};
+
+/* uart synth clock */
+static struct clk uart_synth_clk = {
+	.en_reg = UART_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
+	.private_data = &uart_synth_config,
+};
+
 /* uart parents */
 static struct pclk_info uart_pclk_info[] = {
 	{
 		.pclk = &pll5_clk,
-		.pclk_mask = AUX_CLK_PLL5_MASK,
+		.pclk_val = AUX_CLK_PLL5_VAL,
 	}, {
-		.pclk = &pll1_clk,
-		.pclk_mask = AUX_CLK_PLL1_MASK,
-		.scalable = 1,
+		.pclk = &uart_synth_clk,
+		.pclk_val = AUX_CLK_SYNT_VAL,
 	},
 };
 
@@ -303,10 +363,469 @@ static struct clk uart_clk = {
 	.en_reg_bit = UART_CLK_ENB,
 	.pclk_sel = &uart_pclk_sel,
 	.pclk_sel_shift = UART_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* sdhci configurations */
+static struct aux_clk_config sdhci_synth_config = {
+	.synth_reg = SDHCI_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* sdhci synth clock */
+static struct clk sdhci_synth_clk = {
+	.en_reg = SDHCI_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
-	.private_data = &uart_config,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
+	.private_data = &sdhci_synth_config,
+};
+
+/* sdhci clock */
+static struct clk sdhci_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SDHCI_CLK_ENB,
+	.pclk = &sdhci_synth_clk,
+	.recalc = &follow_parent,
+};
+
+/* cfxd configurations */
+static struct aux_clk_config cfxd_synth_config = {
+	.synth_reg = CFXD_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* cfxd synth clock */
+static struct clk cfxd_synth_clk = {
+	.en_reg = CFXD_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
+	.private_data = &cfxd_synth_config,
+};
+
+/* cfxd clock */
+static struct clk cfxd_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = CFXD_CLK_ENB,
+	.pclk = &cfxd_synth_clk,
+	.recalc = &follow_parent,
 };
 
+/* C3 clk configurations */
+static struct aux_clk_config c3_synth_config = {
+	.synth_reg = C3_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* c3 synth clock */
+static struct clk c3_synth_clk = {
+	.en_reg = C3_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
+	.private_data = &c3_synth_config,
+};
+
+/* c3 parents */
+static struct pclk_info c3_pclk_info[] = {
+	{
+		.pclk = &pll5_clk,
+		.pclk_val = AUX_CLK_PLL5_VAL,
+	}, {
+		.pclk = &c3_synth_clk,
+		.pclk_val = AUX_CLK_SYNT_VAL,
+	},
+};
+
+/* c3 parent select structure */
+static struct pclk_sel c3_pclk_sel = {
+	.pclk_info = c3_pclk_info,
+	.pclk_count = ARRAY_SIZE(c3_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = C3_CLK_MASK,
+};
+
+/* c3 clock */
+static struct clk c3_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = C3_CLK_ENB,
+	.pclk_sel = &c3_pclk_sel,
+	.pclk_sel_shift = C3_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* gmac phy clk configurations */
+static struct aux_clk_config gmac_phy_synth_config = {
+	.synth_reg = GMAC_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* gmii external pad clock for phy operation */
+static struct clk gmii_txclk125_pad = {
+	.flags = ALWAYS_ENABLED,
+	.rate = 125000000,
+};
+
+/* gmac phy set of input clks*/
+static struct pclk_info gmac_phy_input_pclk_info[] = {
+	{
+		.pclk = &gmii_txclk125_pad,
+		.pclk_val = GMAC_PHY_PAD_VAL,
+	}, {
+		.pclk = &pll2_clk,
+		.pclk_val = GMAC_PHY_PLL2_VAL,
+	}, {
+		.pclk = &osc3_25m_clk,
+		.pclk_val = GMAC_PHY_OSC3_VAL,
+	},
+};
+
+static struct pclk_sel gmac_phy_input_pclk_sel = {
+	.pclk_info = gmac_phy_input_pclk_info,
+	.pclk_count = ARRAY_SIZE(gmac_phy_input_pclk_info),
+	.pclk_sel_reg = GMAC_CLK_CFG,
+	.pclk_sel_mask = GMAC_PHY_INPUT_CLK_MASK,
+};
+
+static struct clk gmac_phy_input_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &gmac_phy_input_pclk_sel,
+	.pclk_sel_shift = GMAC_PHY_INPUT_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* gmac rate configuration table, in ascending order of rates */
+struct aux_rate_tbl gmac_rtbl[] = {
+	/* For gmac phy input clk */
+	{.xscale = 1, .yscale = 6, .eq = 1}, /* divided by 6 */
+	{.xscale = 1, .yscale = 4, .eq = 1}, /* divided by 4 */
+	{.xscale = 1, .yscale = 3, .eq = 1}, /* divided by 3 */
+	{.xscale = 1, .yscale = 2, .eq = 1}, /* divided by 2 */
+};
+
+static struct clk gmac_phy_synth_clk = {
+	.en_reg = GMAC_CLK_CFG,
+	.en_reg_bit = GMAC_PHY_SYNT_ENB,
+	.pclk = &gmac_phy_input_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {gmac_rtbl, ARRAY_SIZE(gmac_rtbl), 0},
+	.private_data = &gmac_phy_synth_config,
+};
+
+/* gmac phy parents */
+static struct pclk_info gmac_phy_pclk_info[] = {
+	{
+		.pclk = &gmac_phy_input_clk,
+		.pclk_val = 0,
+	}, {
+		.pclk = &gmac_phy_synth_clk,
+		.pclk_val = 1,
+	}
+};
+
+/* gmac phy parent select structure */
+static struct pclk_sel gmac_phy_pclk_sel = {
+	.pclk_info = gmac_phy_pclk_info,
+	.pclk_count = ARRAY_SIZE(gmac_phy_pclk_info),
+	.pclk_sel_reg = GMAC_CLK_CFG,
+	.pclk_sel_mask = GMAC_PHY_CLK_MASK,
+};
+
+/* gmac phy clock */
+static struct clk gmac_phy_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &gmac_phy_pclk_sel,
+	.pclk_sel_shift = GMAC_PHY_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* clcd synthesizers masks */
+static struct clcd_synth_masks clcd_masks = {
+	.div_factor_mask = CLCD_SYNT_DIV_FACTOR_MASK,
+	.div_factor_shift = CLCD_SYNT_DIV_FACTOR_SHIFT,
+};
+
+static struct clcd_clk_config clcd_synth_config = {
+	.synth_reg = CLCD_CLK_SYNT,
+	.masks = &clcd_masks,
+};
+
+/* clcd synth parents */
+static struct pclk_info clcd_synth_pclk_info[] = {
+	{
+		.pclk = &pll1div4_clk,
+		.pclk_val = CLCD_SYNT_PLL1_DIV4_VAL,
+	}, {
+		.pclk = &pll2_clk,
+		.pclk_val = CLCD_SYNT_PLL2_VAL,
+	},
+};
+
+/* clcd synth parent select structure */
+static struct pclk_sel clcd_synth_pclk_sel = {
+	.pclk_info = clcd_synth_pclk_info,
+	.pclk_count = ARRAY_SIZE(clcd_synth_pclk_info),
+	.pclk_sel_reg = PLL_CFG,
+	.pclk_sel_mask = CLCD_SYNT_CLK_MASK,
+};
+
+/* clcd rate configuration table, in ascending order of rates */
+struct clcd_rate_tbl clcd_rtbl[] = {
+	/* For pll1div4 = 250 MHz */
+	{.div = 0x4000}, /* 62.5 MHz */
+	{.div = 0x2000}, /* 125 MHz */
+};
+
+/* clcd synth clock */
+static struct clk clcd_synth_clk = {
+	.en_reg = CLCD_CLK_SYNT,
+	.en_reg_bit = CLCD_SYNT_ENB,
+	.pclk_sel = &clcd_synth_pclk_sel,
+	.pclk_sel_shift = CLCD_SYNT_CLK_SHIFT,
+	.calc_rate = &clcd_calc_rate,
+	.recalc = &clcd_clk_recalc,
+	.set_rate = &clcd_clk_set_rate,
+	.rate_config = {clcd_rtbl, ARRAY_SIZE(clcd_rtbl), 1},
+	.private_data = &clcd_synth_config,
+};
+
+/* clcd clock parents */
+static struct pclk_info clcd_pclk_info[] = {
+	{
+		.pclk = &pll5_clk,
+		.pclk_val = AUX_CLK_PLL5_VAL,
+	}, {
+		.pclk = &clcd_synth_clk,
+		.pclk_val = AUX_CLK_SYNT_VAL,
+	},
+};
+
+/* clcd parent select structure */
+static struct pclk_sel clcd_pclk_sel = {
+	.pclk_info = clcd_pclk_info,
+	.pclk_count = ARRAY_SIZE(clcd_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = CLCD_CLK_MASK,
+};
+
+/* clcd clock */
+static struct clk clcd_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = CLCD_CLK_ENB,
+	.pclk_sel = &clcd_pclk_sel,
+	.pclk_sel_shift = CLCD_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* clock derived from ahb clk */
+
+/* i2c clock */
+static struct clk i2c_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = I2C_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* dma clock */
+static struct clk dma0_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = DMA0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+static struct clk dma1_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = DMA1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* jpeg clock */
+static struct clk jpeg_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = JPEG_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* gmac clock */
+static struct clk gmac_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = GMAC_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* fsmc clock */
+static struct clk fsmc_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SMI_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* smi clock */
+static struct clk smi_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SMI_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* uhc0 clock */
+static struct clk uhci0_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = UHC0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* uhc1 clock */
+static struct clk uhci1_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = UHC1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* usbd clock */
+static struct clk usbd_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = USBD_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* pci clocks */
+static struct clk pcie0_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = PCIE0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+static struct clk pcie1_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = PCIE1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+static struct clk pcie2_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = PCIE2_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* sysram clocks */
+static struct clk sysram0_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SYSRAM0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+static struct clk sysram1_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SYSRAM1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* clock derived from apb clk */
+/* adc clock */
+static struct clk adc_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = ADC_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* ssp clock */
+static struct clk ssp_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SSP_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* gpio clock */
+static struct clk gpio0_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = GPIO0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* gpio clock */
+static struct clk gpio1_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = GPIO1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* i2s0 clock */
+static struct clk i2s0_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = I2S0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* i2s1 clock */
+static struct clk i2s1_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = I2S1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* keyboard clock */
+static struct clk kbd_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP2_CLK_ENB,
+	.en_reg_bit = KBD_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* spear1300 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1300
+
+#endif
+
+/* spear1310 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1310
+/* can0 clock */
+static struct clk can0_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* can1 clock */
+static struct clk can1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+#endif
+
 /* array of all spear 13xx clock lookups */
 static struct clk_lookup spear_clk_lookups[] = {
 	/* root clks */
@@ -315,7 +834,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{.con_id = "osc3_25m_clk",	.clk = &osc3_25m_clk},
 
 	/* clock derived from 32 KHz osc clk */
-	{.dev_id = "rtc",		.clk = &rtc_clk},
+	{.dev_id = "rtc-spear",		.clk = &rtc_clk},
 
 	/* clock derived from 24/25 MHz osc1/osc3 clk */
 	{.con_id = "pll1_clk",		.clk = &pll1_clk},
@@ -328,18 +847,68 @@ static struct clk_lookup spear_clk_lookups[] = {
 	/* clock derived from pll1 clk */
 	{.con_id = "cpu_clk",		.clk = &cpu_clk},
 	{.con_id = "ahb_clk",		.clk = &ahb_clk},
-	{ .con_id = "apb_clk",		.clk = &apb_clk},
+	{.con_id = "apb_clk",		.clk = &apb_clk},
+
+	/* synthesizers/prescaled clocks */
+	{.con_id = "pll1div2_clk",		.clk = &pll1div2_clk},
+	{.con_id = "pll1div4_clk",		.clk = &pll1div4_clk},
+	{.con_id = "c3_synth_clk",		.clk = &c3_synth_clk},
+	{.con_id = "gmii_txclk123_pad_clk",	.clk = &gmii_txclk125_pad},
+	{.con_id = "clcd_synth_clk",		.clk = &clcd_synth_clk},
+	{.con_id = "uart_synth_clk",		.clk = &uart_synth_clk},
+	{.con_id = "sdhci_synth_clk",		.clk = &sdhci_synth_clk},
+	{.con_id = "cfxd_synth_clk",		.clk = &cfxd_synth_clk},
+	{.con_id = "gmac_phy_input_clk",	.clk = &gmac_phy_input_clk},
+	{.con_id = "gmac_phy_synth_clk",	.clk = &gmac_phy_synth_clk},
+	{.con_id = "gmac_phy_clk",		.clk = &gmac_phy_clk},
 
 	/* clocks having multiple parent source from above clocks */
-	{.dev_id = "uart",		.clk = &uart_clk},
+	{.dev_id = "clcd",		.clk = &clcd_clk},
 	{.dev_id = "gpt0",		.clk = &gpt0_clk},
 	{.dev_id = "gpt1",		.clk = &gpt1_clk},
 	{.dev_id = "gpt2",		.clk = &gpt2_clk},
 	{.dev_id = "gpt3",		.clk = &gpt3_clk},
+	{.dev_id = "uart",		.clk = &uart_clk},
 
-	/* clock derived from ahb/apb clk */
-	{ .dev_id = "smi",		.clk = &smi_clk},
-	{ .dev_id = "wdt",		.clk = &wdt_clk},
+	/* clock derived from ahb clk */
+	{.dev_id = "smi",		.clk = &smi_clk},
+	{.con_id = "usbh.0_clk",	.clk = &uhci0_clk},
+	{.con_id = "usbh.1_clk",	.clk = &uhci1_clk},
+	{.dev_id = "usbd",		.clk = &usbd_clk},
+	{.dev_id = "i2c_designware.0",	.clk = &i2c_clk},
+	{.dev_id = "dma0",		.clk = &dma0_clk},
+	{.dev_id = "dma1",		.clk = &dma1_clk},
+	{.dev_id = "jpeg",		.clk = &jpeg_clk},
+	{.dev_id = "gmac",		.clk = &gmac_clk},
+	{.dev_id = "c3",		.clk = &c3_clk},
+	{.dev_id = "pcie0",		.clk = &pcie0_clk},
+	{.dev_id = "pcie1",		.clk = &pcie1_clk},
+	{.dev_id = "pcie2",		.clk = &pcie2_clk},
+	{.dev_id = "cfxd",		.clk = &cfxd_clk},
+	{.dev_id = "sdhci",		.clk = &sdhci_clk},
+	{.con_id = "fsmc",		.clk = &fsmc_clk},
+	{.dev_id = "sysram0",		.clk = &sysram0_clk},
+	{.dev_id = "sysram1",		.clk = &sysram1_clk},
+
+	/* clock derived from apb clk */
+	{.dev_id = "i2s0",		.clk = &i2s0_clk},
+	{.dev_id = "i2s1",		.clk = &i2s1_clk},
+	{.dev_id = "adc",		.clk = &adc_clk},
+	{.dev_id = "ssp-pl022",		.clk = &ssp_clk},
+	{.dev_id = "gpio0",		.clk = &gpio0_clk},
+	{.dev_id = "gpio1",		.clk = &gpio1_clk},
+	{.dev_id = "keyboard",		.clk = &kbd_clk},
+	{.dev_id = "wdt",		.clk = &wdt_clk},
+
+	/* spear1300 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1300
+#endif
+
+	/* spear1310 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1310
+	{.dev_id = "spear_can.0",	.clk = &can0_clk},
+	{.dev_id = "spear_can.1",	.clk = &can1_clk},
+#endif
 };
 
 void __init clk_init(void)
diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
index 1f6028f..a8a1119 100644
--- a/arch/arm/mach-spear13xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
@@ -36,12 +36,16 @@
 /* PLL related registers and bit values */
 #define PLL_CFG			((unsigned int *)(MISC_BASE + 0x210))
 	/* PLL_CFG bit values */
-	#define OSC_24M_MASK	0
-	#define OSC_25M_MASK	1
-	#define PLL_CLK_MASK	3
-	#define PLL1_CLK_SHIFT	20
-	#define PLL2_CLK_SHIFT	22
-	#define PLL3_CLK_SHIFT	24
+	#define OSC_24M_VAL			0
+	#define OSC_25M_VAL			1
+	#define PLL_CLK_MASK			3
+	#define PLL1_CLK_SHIFT			20
+	#define PLL2_CLK_SHIFT			22
+	#define PLL3_CLK_SHIFT			24
+	#define CLCD_SYNT_PLL1_DIV4_VAL		0
+	#define CLCD_SYNT_PLL2_VAL		1
+	#define CLCD_SYNT_CLK_MASK		1
+	#define CLCD_SYNT_CLK_SHIFT		31
 
 #define PLL1_CTR		((unsigned int *)(MISC_BASE + 0x214))
 #define PLL1_FRQ		((unsigned int *)(MISC_BASE + 0x218))
@@ -77,30 +81,53 @@
 
 #define PERIP_CLK_CFG		((unsigned int *)(MISC_BASE + 0x244))
 	/* PERIP_CLK_CFG bit values */
-	#define GPT_OSC24_MASK	0
-	#define GPT_APB_MASK	1
-	#define GPT_CLK_MASK	1
-	#define GPT0_CLK_SHIFT	8
-	#define GPT1_CLK_SHIFT	9
-	#define GPT2_CLK_SHIFT	12
-	#define GPT3_CLK_SHIFT	13
-	#define AUX_CLK_PLL1_MASK	1
-	#define AUX_CLK_PLL5_MASK	0
+	#define GPT_OSC24_VAL		0
+	#define GPT_APB_VAL		1
+	#define GPT_CLK_MASK		1
+	#define GPT0_CLK_SHIFT		8
+	#define GPT1_CLK_SHIFT		9
+	#define GPT2_CLK_SHIFT		12
+	#define GPT3_CLK_SHIFT		13
+	#define AUX_CLK_PLL5_VAL	0
+	#define AUX_CLK_SYNT_VAL	1
 	#define UART_CLK_MASK		1
 	#define UART_CLK_SHIFT		4
+	#define CLCD_PLL5_VAL		0
+	#define CLCD_SYNT_MASK		1
+	#define CLCD_CLK_MASK		3
+	#define CLCD_CLK_SHIFT		2
+	#define C3_CLK_MASK		1
+	#define C3_CLK_SHIFT		1
 
 #define GMAC_CLK_CFG		((unsigned int *)(MISC_BASE + 0x248))
-#define C3_CLK_SYNTH		((unsigned int *)(MISC_BASE + 0x24c))
+
+	#define GMAC_PHY_PAD_VAL		0
+	#define GMAC_PHY_PLL2_VAL		1
+	#define GMAC_PHY_OSC3_VAL		2
+	#define GMAC_PHY_INPUT_CLK_MASK		3
+	#define GMAC_PHY_INPUT_CLK_SHIFT	1
+	#define GMAC_PHY_SYNT_ENB		3
+	#define GMAC_PHY_CLK_MASK		1
+	#define GMAC_PHY_CLK_SHIFT		3
+	#define GMAC_PHY_SYNT_ENB_VAL		4
+
+#define C3_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x24c))
 #define CLCD_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x250))
+	/* CLCD synth reg masks */
+	#define CLCD_SYNT_ENB			31
+	#define CLCD_SYNT_DIV_FACTOR_MASK	0x1ffff
+	#define CLCD_SYNT_DIV_FACTOR_SHIFT	0
+
 #define UART_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x254))
 #define GMAC_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x258))
-#define MCIF_SD_CLK_SYNT	((unsigned int *)(MISC_BASE + 0x25c))
-#define MCIF_CFXD_CLK_SYNT	((unsigned int *)(MISC_BASE + 0x260))
+#define SDHCI_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x25c))
+#define CFXD_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x260))
 #define RAS_CLK_SYNT0		((unsigned int *)(MISC_BASE + 0x264))
 #define RAS_CLK_SYNT1		((unsigned int *)(MISC_BASE + 0x268))
 #define RAS_CLK_SYNT2		((unsigned int *)(MISC_BASE + 0x26c))
 #define RAS_CLK_SYNT3		((unsigned int *)(MISC_BASE + 0x270))
 	/* aux clk synthesizer register masks */
+	#define AUX_SYNT_ENB		31
 	#define AUX_EQ_SEL_SHIFT	30
 	#define AUX_EQ_SEL_MASK		1
 	#define AUX_EQ1_SEL		0
@@ -114,32 +141,32 @@
 	/* PERIP1_CLK_ENB register masks */
 	#define BUS_CLK_ENB		0
 	#define SYSROM_CLK_ENB		1
-	#define AORAM_CLK_ENB		2
-	#define SYSRAM_CLK_ENB		3
+	#define SYSRAM1_CLK_ENB		2
+	#define SYSRAM0_CLK_ENB		3
 	#define FSMC_CLK_ENB		4
 	#define SMI_CLK_ENB		5
-	#define SD_CLK_ENB		6
-	#define CF_XD_CLK_ENB		7
-	#define GETH_CLK_ENB		8
+	#define SDHCI_CLK_ENB		6
+	#define CFXD_CLK_ENB		7
+	#define GMAC_CLK_ENB		8
 	#define UHC0_CLK_ENB		9
 	#define UHC1_CLK_ENB		10
-	#define UDC_UPD_CLK_ENB		11
-	#define PCI0_CLK_ENB		12
-	#define PCI1_CLK_ENB		13
-	#define PCI2_CLK_ENB		14
+	#define USBD_CLK_ENB		11
+	#define PCIE0_CLK_ENB		12
+	#define PCIE1_CLK_ENB		13
+	#define PCIE2_CLK_ENB		14
 	#define UART_CLK_ENB		15
 	#define SSP_CLK_ENB		17
 	#define I2C_CLK_ENB		18
-	#define I2S_SLV_CLK_ENB		19
-	#define I2S_MST_CLK_ENB		20
+	#define I2S0_CLK_ENB		19
+	#define I2S1_CLK_ENB		20
 	#define GPT0_CLK_ENB		21
 	#define GPT1_CLK_ENB		22
-	#define GPIOA_CLK_ENB		23
-	#define GPIOB_CLK_ENB		24
+	#define GPIO0_CLK_ENB		23
+	#define GPIO1_CLK_ENB		24
 	#define DMA0_CLK_ENB		25
 	#define DMA1_CLK_ENB		26
 	#define CLCD_CLK_ENB		27
-	#define JPEGC_CLK_ENB		28
+	#define JPEG_CLK_ENB		28
 	#define C3_CLK_ENB		29
 	#define ADC_CLK_ENB		30
 	#define RTC_CLK_ENB		31
@@ -219,11 +246,11 @@
 #define THSENS_CFG		((unsigned int *)(MISC_BASE + 0x6c4))
 
 /* Compensation Configuration Registers */
-#define COMP_1V8_2V5_3V3__1_CFG		((unsigned int *)(MISC_BASE + 0x700))
-#define COMP_1V8_2V5_3V3__2_CFG		((unsigned int *)(MISC_BASE + 0x704))
-#define COMP_3V3_1_CFG			((unsigned int *)(MISC_BASE + 0x708))
-#define COMP_3V3_2_CFG			((unsigned int *)(MISC_BASE + 0x70c))
-#define COMP_DDR_CFG			((unsigned int *)(MISC_BASE + 0x710))
+#define COMP_1V8_2V5_3V3__1_CFG	((unsigned int *)(MISC_BASE + 0x700))
+#define COMP_1V8_2V5_3V3__2_CFG	((unsigned int *)(MISC_BASE + 0x704))
+#define COMP_3V3_1_CFG		((unsigned int *)(MISC_BASE + 0x708))
+#define COMP_3V3_2_CFG		((unsigned int *)(MISC_BASE + 0x70c))
+#define COMP_DDR_CFG		((unsigned int *)(MISC_BASE + 0x710))
 
 /* OTP Programming Registers */
 #define OTP_PROG_CTR		((unsigned int *)(MISC_BASE + 0x800))
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 7ea8749..0a7a548 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -60,12 +60,22 @@ static struct pll_clk_config pll1_config = {
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
+	.flags = ENABLED_ON_INIT,
 	.pclk = &osc_24m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
 	.private_data = &pll1_config,
 };
 
@@ -103,11 +113,22 @@ static struct bus_clk_config ahb_config = {
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
 
@@ -123,22 +144,40 @@ static struct aux_clk_masks aux_masks = {
 	.yscale_sel_shift = AUX_YSCALE_SHIFT,
 };
 
-/* uart configurations */
-static struct aux_clk_config uart_config = {
+/* uart synth configurations */
+static struct aux_clk_config uart_synth_config = {
 	.synth_reg = UART_CLK_SYNT,
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
+/* uart synth clock */
+static struct clk uart_synth_clk = {
+	.en_reg = UART_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 1},
+	.private_data = &uart_synth_config,
+};
+
 /* uart parents */
 static struct pclk_info uart_pclk_info[] = {
 	{
-		.pclk = &pll1_clk,
-		.pclk_mask = AUX_CLK_PLL1_MASK,
-		.scalable = 1,
+		.pclk = &uart_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
 	}, {
 		.pclk = &pll3_48m_clk,
-		.pclk_mask = AUX_CLK_PLL3_MASK,
-		.scalable = 0,
+		.pclk_val = AUX_CLK_PLL3_VAL,
 	},
 };
 
@@ -156,26 +195,35 @@ static struct clk uart_clk = {
 	.en_reg_bit = UART_CLK_ENB,
 	.pclk_sel = &uart_pclk_sel,
 	.pclk_sel_shift = UART_CLK_SHIFT,
-	.recalc = &aux_clk_recalc,
-	.private_data = &uart_config,
+	.recalc = &follow_parent,
 };
 
 /* firda configurations */
-static struct aux_clk_config firda_config = {
+static struct aux_clk_config firda_synth_config = {
 	.synth_reg = FIRDA_CLK_SYNT,
 	.masks = &aux_masks,
 };
 
+/* firda synth clock */
+static struct clk firda_synth_clk = {
+	.en_reg = FIRDA_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 1},
+	.private_data = &firda_synth_config,
+};
+
 /* firda parents */
 static struct pclk_info firda_pclk_info[] = {
 	{
-		.pclk = &pll1_clk,
-		.pclk_mask = AUX_CLK_PLL1_MASK,
-		.scalable = 1,
+		.pclk = &firda_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
 	}, {
 		.pclk = &pll3_48m_clk,
-		.pclk_mask = AUX_CLK_PLL3_MASK,
-		.scalable = 0,
+		.pclk_val = AUX_CLK_PLL3_VAL,
 	},
 };
 
@@ -193,84 +241,155 @@ static struct clk firda_clk = {
 	.en_reg_bit = FIRDA_CLK_ENB,
 	.pclk_sel = &firda_pclk_sel,
 	.pclk_sel_shift = FIRDA_CLK_SHIFT,
-	.recalc = &aux_clk_recalc,
-	.private_data = &firda_config,
+	.recalc = &follow_parent,
+};
+
+/* gpt synthesizer masks */
+static struct gpt_clk_masks gpt_masks = {
+	.mscale_sel_mask = GPT_MSCALE_MASK,
+	.mscale_sel_shift = GPT_MSCALE_SHIFT,
+	.nscale_sel_mask = GPT_NSCALE_MASK,
+	.nscale_sel_shift = GPT_NSCALE_SHIFT,
+};
+
+/* gpt rate configuration table, in ascending order of rates */
+struct gpt_rate_tbl gpt_rtbl[] = {
+	/* For pll1 = 332 MHz */
+	{.mscale = 4, .nscale = 0}, /* 41.5 MHz */
+	{.mscale = 2, .nscale = 0}, /* 55.3 MHz */
+	{.mscale = 1, .nscale = 0}, /* 83 MHz */
+};
+
+/* gpt0 synth clk config*/
+static struct gpt_clk_config gpt0_synth_config = {
+	.synth_reg = PRSC1_CLK_CFG,
+	.masks = &gpt_masks,
+};
+
+/* gpt synth clock */
+static struct clk gpt0_synth_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
+	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
+	.private_data = &gpt0_synth_config,
 };
 
 /* gpt parents */
-static struct pclk_info gpt_pclk_info[] = {
+static struct pclk_info gpt0_pclk_info[] = {
 	{
-		.pclk = &pll1_clk,
-		.pclk_mask = AUX_CLK_PLL1_MASK,
-		.scalable = 1,
+		.pclk = &gpt0_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
 	}, {
 		.pclk = &pll3_48m_clk,
-		.pclk_mask = AUX_CLK_PLL3_MASK,
-		.scalable = 0,
+		.pclk_val = AUX_CLK_PLL3_VAL,
 	},
 };
 
 /* gpt parent select structure */
-static struct pclk_sel gpt_pclk_sel = {
-	.pclk_info = gpt_pclk_info,
-	.pclk_count = ARRAY_SIZE(gpt_pclk_info),
+static struct pclk_sel gpt0_pclk_sel = {
+	.pclk_info = gpt0_pclk_info,
+	.pclk_count = ARRAY_SIZE(gpt0_pclk_info),
 	.pclk_sel_reg = PERIP_CLK_CFG,
 	.pclk_sel_mask = GPT_CLK_MASK,
 };
 
-/* gpt synthesizer masks */
-static struct gpt_clk_masks gpt_masks = {
-	.mscale_sel_mask = GPT_MSCALE_MASK,
-	.mscale_sel_shift = GPT_MSCALE_SHIFT,
-	.nscale_sel_mask = GPT_NSCALE_MASK,
-	.nscale_sel_shift = GPT_NSCALE_SHIFT,
+/* gpt0 timer clock */
+static struct clk gpt0_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &gpt0_pclk_sel,
+	.pclk_sel_shift = GPT0_CLK_SHIFT,
+	.recalc = &follow_parent,
 };
 
-/* gpt0 configurations */
-static struct gpt_clk_config gpt0_config = {
-	.synth_reg = PRSC1_CLK_CFG,
+/* gpt1 synth clk configurations */
+static struct gpt_clk_config gpt1_synth_config = {
+	.synth_reg = PRSC2_CLK_CFG,
 	.masks = &gpt_masks,
 };
 
-/* gpt0 timer clock */
-static struct clk gpt0_clk = {
+/* gpt1 synth clock */
+static struct clk gpt1_synth_clk = {
 	.flags = ALWAYS_ENABLED,
-	.pclk_sel = &gpt_pclk_sel,
-	.pclk_sel_shift = GPT0_CLK_SHIFT,
+	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
 	.recalc = &gpt_clk_recalc,
-	.private_data = &gpt0_config,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
+	.private_data = &gpt1_synth_config,
 };
 
-/* gpt1 configurations */
-static struct gpt_clk_config gpt1_config = {
-	.synth_reg = PRSC2_CLK_CFG,
-	.masks = &gpt_masks,
+static struct pclk_info gpt1_pclk_info[] = {
+	{
+		.pclk = &gpt1_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
+	}, {
+		.pclk = &pll3_48m_clk,
+		.pclk_val = AUX_CLK_PLL3_VAL,
+	},
+};
+
+/* gpt parent select structure */
+static struct pclk_sel gpt1_pclk_sel = {
+	.pclk_info = gpt1_pclk_info,
+	.pclk_count = ARRAY_SIZE(gpt1_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = GPT_CLK_MASK,
 };
 
 /* gpt1 timer clock */
 static struct clk gpt1_clk = {
 	.en_reg = PERIP1_CLK_ENB,
 	.en_reg_bit = GPT1_CLK_ENB,
-	.pclk_sel = &gpt_pclk_sel,
+	.pclk_sel = &gpt1_pclk_sel,
 	.pclk_sel_shift = GPT1_CLK_SHIFT,
-	.recalc = &gpt_clk_recalc,
-	.private_data = &gpt1_config,
+	.recalc = &follow_parent,
 };
 
-/* gpt2 configurations */
-static struct gpt_clk_config gpt2_config = {
+/* gpt2 synth clk configurations */
+static struct gpt_clk_config gpt2_synth_config = {
 	.synth_reg = PRSC3_CLK_CFG,
 	.masks = &gpt_masks,
 };
 
+/* gpt1 synth clock */
+static struct clk gpt2_synth_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
+	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
+	.private_data = &gpt2_synth_config,
+};
+
+static struct pclk_info gpt2_pclk_info[] = {
+	{
+		.pclk = &gpt2_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
+	}, {
+		.pclk = &pll3_48m_clk,
+		.pclk_val = AUX_CLK_PLL3_VAL,
+	},
+};
+
+/* gpt parent select structure */
+static struct pclk_sel gpt2_pclk_sel = {
+	.pclk_info = gpt2_pclk_info,
+	.pclk_count = ARRAY_SIZE(gpt2_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = GPT_CLK_MASK,
+};
+
 /* gpt2 timer clock */
 static struct clk gpt2_clk = {
 	.en_reg = PERIP1_CLK_ENB,
 	.en_reg_bit = GPT2_CLK_ENB,
-	.pclk_sel = &gpt_pclk_sel,
+	.pclk_sel = &gpt2_pclk_sel,
 	.pclk_sel_shift = GPT2_CLK_SHIFT,
-	.recalc = &gpt_clk_recalc,
-	.private_data = &gpt2_config,
+	.recalc = &follow_parent,
 };
 
 /* clock derived from pll3 clk */
@@ -290,13 +409,6 @@ static struct clk usbd_clk = {
 	.recalc = &follow_parent,
 };
 
-/* clcd clock */
-static struct clk clcd_clk = {
-	.flags = ALWAYS_ENABLED,
-	.pclk = &pll3_48m_clk,
-	.recalc = &follow_parent,
-};
-
 /* clock derived from ahb clk */
 /* apb masks structure */
 static struct bus_clk_masks apb_masks = {
@@ -314,7 +426,10 @@ static struct bus_clk_config apb_config = {
 static struct clk apb_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &ahb_clk,
+	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
+	.set_rate = &bus_clk_set_rate,
+	.rate_config = {bus_rtbl, ARRAY_SIZE(bus_rtbl), 2},
 	.private_data = &apb_config,
 };
 
@@ -375,8 +490,17 @@ static struct clk adc_clk = {
 	.recalc = &follow_parent,
 };
 
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+/* emi clock */
+static struct clk emi_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ahb_clk,
+	.recalc = &follow_parent,
+};
+#endif
+
 /* ssp clock */
-static struct clk ssp_clk = {
+static struct clk ssp0_clk = {
 	.pclk = &apb_clk,
 	.en_reg = PERIP1_CLK_ENB,
 	.en_reg_bit = SSP_CLK_ENB,
@@ -393,6 +517,137 @@ static struct clk gpio_clk = {
 
 static struct clk dummy_apb_pclk;
 
+#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR310) || \
+	defined(CONFIG_MACH_SPEAR320)
+/* fsmc clock */
+static struct clk fsmc_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ahb_clk,
+	.recalc = &follow_parent,
+};
+#endif
+
+/* common clocks to spear310 and spear320 */
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+/* uart1 clock */
+static struct clk uart1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart2 clock */
+static struct clk uart2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+#endif /* CONFIG_MACH_SPEAR310 || CONFIG_MACH_SPEAR320 */
+
+/* common clocks to spear300 and spear320 */
+#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR320)
+/* clcd clock */
+static struct clk clcd_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll3_48m_clk,
+	.recalc = &follow_parent,
+};
+
+/* sdhci clock */
+static struct clk sdhci_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ahb_clk,
+	.recalc = &follow_parent,
+};
+#endif /* CONFIG_MACH_SPEAR300 || CONFIG_MACH_SPEAR320 */
+
+/* spear300 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR300
+/* gpio1 clock */
+static struct clk gpio1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* keyboard clock */
+static struct clk kbd_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+#endif
+
+/* spear310 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR310
+/* uart3 clock */
+static struct clk uart3_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart4 clock */
+static struct clk uart4_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart5 clock */
+static struct clk uart5_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+#endif
+
+/* spear320 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR320
+/* can0 clock */
+static struct clk can0_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* can1 clock */
+static struct clk can1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* i2c1 clock */
+static struct clk i2c1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ahb_clk,
+	.recalc = &follow_parent,
+};
+
+/* ssp1 clock */
+static struct clk ssp1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* ssp2 clock */
+static struct clk ssp2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* pwm clock */
+static struct clk pwm_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+#endif
+
 /* array of all spear 3xx clock lookups */
 static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "apb_pclk",	.clk = &dummy_apb_pclk},
@@ -400,7 +655,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "osc_32k_clk",	.clk = &osc_32k_clk},
 	{ .con_id = "osc_24m_clk",	.clk = &osc_24m_clk},
 	/* clock derived from 32 KHz osc clk */
-	{ .dev_id = "rtc",		.clk = &rtc_clk},
+	{ .dev_id = "rtc-spear",	.clk = &rtc_clk},
 	/* clock derived from 24 MHz osc clk */
 	{ .con_id = "pll1_clk",		.clk = &pll1_clk},
 	{ .con_id = "pll3_48m_clk",	.clk = &pll3_48m_clk},
@@ -408,18 +663,22 @@ static struct clk_lookup spear_clk_lookups[] = {
 	/* clock derived from pll1 clk */
 	{ .con_id = "cpu_clk",		.clk = &cpu_clk},
 	{ .con_id = "ahb_clk",		.clk = &ahb_clk},
+	{ .con_id = "uart_synth_clk",	.clk = &uart_synth_clk},
+	{ .con_id = "firda_synth_clk",	.clk = &firda_synth_clk},
+	{ .con_id = "gpt0_synth_clk",	.clk = &gpt0_synth_clk},
+	{ .con_id = "gpt1_synth_clk",	.clk = &gpt1_synth_clk},
+	{ .con_id = "gpt2_synth_clk",	.clk = &gpt2_synth_clk},
 	{ .dev_id = "uart",		.clk = &uart_clk},
 	{ .dev_id = "firda",		.clk = &firda_clk},
 	{ .dev_id = "gpt0",		.clk = &gpt0_clk},
 	{ .dev_id = "gpt1",		.clk = &gpt1_clk},
 	{ .dev_id = "gpt2",		.clk = &gpt2_clk},
 	/* clock derived from pll3 clk */
-	{ .dev_id = "usbh",		.clk = &usbh_clk},
+	{ .con_id = "usbh_clk",		.clk = &usbh_clk},
 	{ .dev_id = "usbd",		.clk = &usbd_clk},
-	{ .dev_id = "clcd",		.clk = &clcd_clk},
 	/* clock derived from ahb clk */
 	{ .con_id = "apb_clk",		.clk = &apb_clk},
-	{ .dev_id = "i2c",		.clk = &i2c_clk},
+	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
 	{ .dev_id = "dma",		.clk = &dma_clk},
 	{ .dev_id = "jpeg",		.clk = &jpeg_clk},
 	{ .dev_id = "gmac",		.clk = &gmac_clk},
@@ -427,8 +686,50 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "c3",		.clk = &c3_clk},
 	/* clock derived from apb clk */
 	{ .dev_id = "adc",		.clk = &adc_clk},
-	{ .dev_id = "ssp",		.clk = &ssp_clk},
+	{ .dev_id = "ssp-pl022.0",	.clk = &ssp0_clk},
 	{ .dev_id = "gpio",		.clk = &gpio_clk},
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+	{ .dev_id = "physmap-flash",	.clk = &emi_clk},
+#endif
+#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR310) || \
+	defined(CONFIG_MACH_SPEAR320)
+	{ .con_id = "fsmc",		.clk = &fsmc_clk},
+#endif
+
+/* common clocks to spear310 and spear320 */
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+	{ .dev_id = "uart1",		.clk = &uart1_clk},
+	{ .dev_id = "uart2",		.clk = &uart2_clk},
+#endif
+
+	/* common clock to spear300 and spear320 */
+#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR320)
+	{ .dev_id = "clcd",		.clk = &clcd_clk},
+	{ .dev_id = "sdhci",		.clk = &sdhci_clk},
+#endif /* CONFIG_MACH_SPEAR300 || CONFIG_MACH_SPEAR320 */
+
+	/* spear300 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR300
+	{ .dev_id = "gpio1",		.clk = &gpio1_clk},
+	{ .dev_id = "keyboard",		.clk = &kbd_clk},
+#endif
+
+	/* spear310 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR310
+	{ .dev_id = "uart3",		.clk = &uart3_clk},
+	{ .dev_id = "uart4",		.clk = &uart4_clk},
+	{ .dev_id = "uart5",		.clk = &uart5_clk},
+
+#endif
+	/* spear320 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR320
+	{ .dev_id = "spear_can.0",	.clk = &can0_clk},
+	{ .dev_id = "spear_can.1",	.clk = &can1_clk},
+	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
+	{ .dev_id = "ssp-pl022.1",	.clk = &ssp1_clk},
+	{ .dev_id = "ssp-pl022.2",	.clk = &ssp2_clk},
+	{ .dev_id = "pwm",		.clk = &pwm_clk},
+#endif
 };
 
 void __init clk_init(void)
diff --git a/arch/arm/mach-spear3xx/include/mach/misc_regs.h b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
index 38d767a..6cb4f3c 100644
--- a/arch/arm/mach-spear3xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
@@ -63,8 +63,8 @@
 #define GPT1_CLK_SHIFT		11
 #define GPT2_CLK_SHIFT		12
 #define GPT_CLK_MASK		0x1
-#define AUX_CLK_PLL3_MASK	0
-#define AUX_CLK_PLL1_MASK	1
+#define AUX_CLK_PLL3_VAL	0
+#define AUX_CLK_PLL1_VAL	1
 
 #define PERIP1_CLK_ENB		((unsigned int *)(MISC_BASE + 0x02C))
 /* PERIP1_CLK_ENB register masks */
@@ -113,6 +113,7 @@
 #define RAS3_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x074))
 #define RAS4_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x078))
 /* aux clk synthesiser register masks for irda to ras4 */
+#define AUX_SYNT_ENB		31
 #define AUX_EQ_SEL_SHIFT	30
 #define AUX_EQ_SEL_MASK		1
 #define AUX_EQ1_SEL		0
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index ef88922..9171952 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -60,12 +60,22 @@ static struct pll_clk_config pll1_config = {
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
+	.flags = ENABLED_ON_INIT,
 	.pclk = &osc_30m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
 	.private_data = &pll1_config,
 };
 
@@ -103,35 +113,25 @@ static struct bus_clk_config ahb_config = {
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
 
-/* uart parents */
-static struct pclk_info uart_pclk_info[] = {
-	{
-		.pclk = &pll1_clk,
-		.pclk_mask = AUX_CLK_PLL1_MASK,
-		.scalable = 1,
-	}, {
-		.pclk = &pll3_48m_clk,
-		.pclk_mask = AUX_CLK_PLL3_MASK,
-		.scalable = 0,
-	},
-};
-
-/* uart parent select structure */
-static struct pclk_sel uart_pclk_sel = {
-	.pclk_info = uart_pclk_info,
-	.pclk_count = ARRAY_SIZE(uart_pclk_info),
-	.pclk_sel_reg = PERIP_CLK_CFG,
-	.pclk_sel_mask = UART_CLK_MASK,
-};
-
 /* auxiliary synthesizers masks */
 static struct aux_clk_masks aux_masks = {
 	.eq_sel_mask = AUX_EQ_SEL_MASK,
@@ -145,19 +145,57 @@ static struct aux_clk_masks aux_masks = {
 };
 
 /* uart configurations */
-static struct aux_clk_config uart_config = {
+static struct aux_clk_config uart_synth_config = {
 	.synth_reg = UART_CLK_SYNT,
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
+/* uart synth clock */
+static struct clk uart_synth_clk = {
+	.en_reg = UART_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
+	.private_data = &uart_synth_config,
+};
+
+/* uart parents */
+static struct pclk_info uart_pclk_info[] = {
+	{
+		.pclk = &uart_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
+	}, {
+		.pclk = &pll3_48m_clk,
+		.pclk_val = AUX_CLK_PLL3_VAL,
+	},
+};
+
+/* uart parent select structure */
+static struct pclk_sel uart_pclk_sel = {
+	.pclk_info = uart_pclk_info,
+	.pclk_count = ARRAY_SIZE(uart_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = UART_CLK_MASK,
+};
+
 /* uart0 clock */
 static struct clk uart0_clk = {
 	.en_reg = PERIP1_CLK_ENB,
 	.en_reg_bit = UART0_CLK_ENB,
 	.pclk_sel = &uart_pclk_sel,
 	.pclk_sel_shift = UART_CLK_SHIFT,
-	.recalc = &aux_clk_recalc,
-	.private_data = &uart_config,
+	.recalc = &follow_parent,
 };
 
 /* uart1 clock */
@@ -166,26 +204,35 @@ static struct clk uart1_clk = {
 	.en_reg_bit = UART1_CLK_ENB,
 	.pclk_sel = &uart_pclk_sel,
 	.pclk_sel_shift = UART_CLK_SHIFT,
-	.recalc = &aux_clk_recalc,
-	.private_data = &uart_config,
+	.recalc = &follow_parent,
 };
 
 /* firda configurations */
-static struct aux_clk_config firda_config = {
+static struct aux_clk_config firda_synth_config = {
 	.synth_reg = FIRDA_CLK_SYNT,
 	.masks = &aux_masks,
 };
 
+/* firda synth clock */
+static struct clk firda_synth_clk = {
+	.en_reg = FIRDA_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
+	.private_data = &firda_synth_config,
+};
+
 /* firda parents */
 static struct pclk_info firda_pclk_info[] = {
 	{
-		.pclk = &pll1_clk,
-		.pclk_mask = AUX_CLK_PLL1_MASK,
-		.scalable = 1,
+		.pclk = &firda_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
 	}, {
 		.pclk = &pll3_48m_clk,
-		.pclk_mask = AUX_CLK_PLL3_MASK,
-		.scalable = 0,
+		.pclk_val = AUX_CLK_PLL3_VAL,
 	},
 };
 
@@ -203,26 +250,35 @@ static struct clk firda_clk = {
 	.en_reg_bit = FIRDA_CLK_ENB,
 	.pclk_sel = &firda_pclk_sel,
 	.pclk_sel_shift = FIRDA_CLK_SHIFT,
-	.recalc = &aux_clk_recalc,
-	.private_data = &firda_config,
+	.recalc = &follow_parent,
 };
 
 /* clcd configurations */
-static struct aux_clk_config clcd_config = {
+static struct aux_clk_config clcd_synth_config = {
 	.synth_reg = CLCD_CLK_SYNT,
 	.masks = &aux_masks,
 };
 
+/* firda synth clock */
+static struct clk clcd_synth_clk = {
+	.en_reg = CLCD_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
+	.private_data = &clcd_synth_config,
+};
+
 /* clcd parents */
 static struct pclk_info clcd_pclk_info[] = {
 	{
-		.pclk = &pll1_clk,
-		.pclk_mask = AUX_CLK_PLL1_MASK,
-		.scalable = 1,
+		.pclk = &clcd_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
 	}, {
 		.pclk = &pll3_48m_clk,
-		.pclk_mask = AUX_CLK_PLL3_MASK,
-		.scalable = 0,
+		.pclk_val = AUX_CLK_PLL3_VAL,
 	},
 };
 
@@ -240,29 +296,7 @@ static struct clk clcd_clk = {
 	.en_reg_bit = CLCD_CLK_ENB,
 	.pclk_sel = &clcd_pclk_sel,
 	.pclk_sel_shift = CLCD_CLK_SHIFT,
-	.recalc = &aux_clk_recalc,
-	.private_data = &clcd_config,
-};
-
-/* gpt parents */
-static struct pclk_info gpt_pclk_info[] = {
-	{
-		.pclk = &pll1_clk,
-		.pclk_mask = AUX_CLK_PLL1_MASK,
-		.scalable = 1,
-	}, {
-		.pclk = &pll3_48m_clk,
-		.pclk_mask = AUX_CLK_PLL3_MASK,
-		.scalable = 0,
-	},
-};
-
-/* gpt parent select structure */
-static struct pclk_sel gpt_pclk_sel = {
-	.pclk_info = gpt_pclk_info,
-	.pclk_count = ARRAY_SIZE(gpt_pclk_info),
-	.pclk_sel_reg = PERIP_CLK_CFG,
-	.pclk_sel_mask = GPT_CLK_MASK,
+	.recalc = &follow_parent,
 };
 
 /* gpt synthesizer masks */
@@ -273,60 +307,162 @@ static struct gpt_clk_masks gpt_masks = {
 	.nscale_sel_shift = GPT_NSCALE_SHIFT,
 };
 
-/* gpt0_1 configurations */
-static struct gpt_clk_config gpt0_1_config = {
+/* gpt rate configuration table, in ascending order of rates */
+struct gpt_rate_tbl gpt_rtbl[] = {
+	/* For pll1 = 332 MHz */
+	{.mscale = 4, .nscale = 0}, /* 41.5 MHz */
+	{.mscale = 2, .nscale = 0}, /* 55.3 MHz */
+	{.mscale = 1, .nscale = 0}, /* 83 MHz */
+};
+
+/* gpt0 synth clk config*/
+static struct gpt_clk_config gpt0_synth_config = {
 	.synth_reg = PRSC1_CLK_CFG,
 	.masks = &gpt_masks,
 };
 
+/* gpt synth clock */
+static struct clk gpt0_synth_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
+	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
+	.private_data = &gpt0_synth_config,
+};
+
+/* gpt parents */
+static struct pclk_info gpt0_pclk_info[] = {
+	{
+		.pclk = &gpt0_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
+	}, {
+		.pclk = &pll3_48m_clk,
+		.pclk_val = AUX_CLK_PLL3_VAL,
+	},
+};
+
+/* gpt parent select structure */
+static struct pclk_sel gpt0_pclk_sel = {
+	.pclk_info = gpt0_pclk_info,
+	.pclk_count = ARRAY_SIZE(gpt0_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = GPT_CLK_MASK,
+};
+
 /* gpt0 ARM1 subsystem timer clock */
 static struct clk gpt0_clk = {
 	.flags = ALWAYS_ENABLED,
-	.pclk_sel = &gpt_pclk_sel,
+	.pclk_sel = &gpt0_pclk_sel,
 	.pclk_sel_shift = GPT0_CLK_SHIFT,
-	.recalc = &gpt_clk_recalc,
-	.private_data = &gpt0_1_config,
+	.recalc = &follow_parent,
+};
+
+
+/* Note: gpt0 and gpt1 share same parent clocks */
+/* gpt parent select structure */
+static struct pclk_sel gpt1_pclk_sel = {
+	.pclk_info = gpt0_pclk_info,
+	.pclk_count = ARRAY_SIZE(gpt0_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = GPT_CLK_MASK,
 };
 
 /* gpt1 timer clock */
 static struct clk gpt1_clk = {
 	.flags = ALWAYS_ENABLED,
-	.pclk_sel = &gpt_pclk_sel,
+	.pclk_sel = &gpt1_pclk_sel,
 	.pclk_sel_shift = GPT1_CLK_SHIFT,
-	.recalc = &gpt_clk_recalc,
-	.private_data = &gpt0_1_config,
+	.recalc = &follow_parent,
 };
 
-/* gpt2 configurations */
-static struct gpt_clk_config gpt2_config = {
+/* gpt2 synth clk config*/
+static struct gpt_clk_config gpt2_synth_config = {
 	.synth_reg = PRSC2_CLK_CFG,
 	.masks = &gpt_masks,
 };
 
+/* gpt synth clock */
+static struct clk gpt2_synth_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
+	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
+	.private_data = &gpt2_synth_config,
+};
+
+/* gpt parents */
+static struct pclk_info gpt2_pclk_info[] = {
+	{
+		.pclk = &gpt2_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
+	}, {
+		.pclk = &pll3_48m_clk,
+		.pclk_val = AUX_CLK_PLL3_VAL,
+	},
+};
+
+/* gpt parent select structure */
+static struct pclk_sel gpt2_pclk_sel = {
+	.pclk_info = gpt2_pclk_info,
+	.pclk_count = ARRAY_SIZE(gpt2_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = GPT_CLK_MASK,
+};
+
 /* gpt2 timer clock */
 static struct clk gpt2_clk = {
-	.en_reg = PERIP1_CLK_ENB,
-	.en_reg_bit = GPT2_CLK_ENB,
-	.pclk_sel = &gpt_pclk_sel,
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &gpt2_pclk_sel,
 	.pclk_sel_shift = GPT2_CLK_SHIFT,
-	.recalc = &gpt_clk_recalc,
-	.private_data = &gpt2_config,
+	.recalc = &follow_parent,
 };
 
-/* gpt3 configurations */
-static struct gpt_clk_config gpt3_config = {
+/* gpt3 synth clk config*/
+static struct gpt_clk_config gpt3_synth_config = {
 	.synth_reg = PRSC3_CLK_CFG,
 	.masks = &gpt_masks,
 };
 
+/* gpt synth clock */
+static struct clk gpt3_synth_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.calc_rate = &gpt_calc_rate,
+	.recalc = &gpt_clk_recalc,
+	.set_rate = &gpt_clk_set_rate,
+	.rate_config = {gpt_rtbl, ARRAY_SIZE(gpt_rtbl), 2},
+	.private_data = &gpt3_synth_config,
+};
+
+/* gpt parents */
+static struct pclk_info gpt3_pclk_info[] = {
+	{
+		.pclk = &gpt3_synth_clk,
+		.pclk_val = AUX_CLK_PLL1_VAL,
+	}, {
+		.pclk = &pll3_48m_clk,
+		.pclk_val = AUX_CLK_PLL3_VAL,
+	},
+};
+
+/* gpt parent select structure */
+static struct pclk_sel gpt3_pclk_sel = {
+	.pclk_info = gpt3_pclk_info,
+	.pclk_count = ARRAY_SIZE(gpt3_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = GPT_CLK_MASK,
+};
+
 /* gpt3 timer clock */
 static struct clk gpt3_clk = {
-	.en_reg = PERIP1_CLK_ENB,
-	.en_reg_bit = GPT3_CLK_ENB,
-	.pclk_sel = &gpt_pclk_sel,
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &gpt3_pclk_sel,
 	.pclk_sel_shift = GPT3_CLK_SHIFT,
-	.recalc = &gpt_clk_recalc,
-	.private_data = &gpt3_config,
+	.recalc = &follow_parent,
 };
 
 /* clock derived from pll3 clk */
@@ -371,7 +507,10 @@ static struct bus_clk_config apb_config = {
 static struct clk apb_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk = &ahb_clk,
+	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
+	.set_rate = &bus_clk_set_rate,
+	.rate_config = {bus_rtbl, ARRAY_SIZE(bus_rtbl), 2},
 	.private_data = &apb_config,
 };
 
@@ -488,7 +627,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "osc_32k_clk",	.clk = &osc_32k_clk},
 	{ .con_id = "osc_30m_clk",	.clk = &osc_30m_clk},
 	/* clock derived from 32 KHz os		 clk */
-	{ .dev_id = "rtc",		.clk = &rtc_clk},
+	{ .dev_id = "rtc-spear",	.clk = &rtc_clk},
 	/* clock derived from 30 MHz os		 clk */
 	{ .con_id = "pll1_clk",		.clk = &pll1_clk},
 	{ .con_id = "pll3_48m_clk",	.clk = &pll3_48m_clk},
@@ -496,6 +635,12 @@ static struct clk_lookup spear_clk_lookups[] = {
 	/* clock derived from pll1 clk */
 	{ .con_id = "cpu_clk",		.clk = &cpu_clk},
 	{ .con_id = "ahb_clk",		.clk = &ahb_clk},
+	{ .con_id = "uart_synth_clk",	.clk = &uart_synth_clk},
+	{ .con_id = "firda_synth_clk",	.clk = &firda_synth_clk},
+	{ .con_id = "clcd_synth_clk",	.clk = &clcd_synth_clk},
+	{ .con_id = "gpt0_synth_clk",	.clk = &gpt0_synth_clk},
+	{ .con_id = "gpt2_synth_clk",	.clk = &gpt2_synth_clk},
+	{ .con_id = "gpt3_synth_clk",	.clk = &gpt3_synth_clk},
 	{ .dev_id = "uart0",		.clk = &uart0_clk},
 	{ .dev_id = "uart1",		.clk = &uart1_clk},
 	{ .dev_id = "firda",		.clk = &firda_clk},
@@ -505,22 +650,22 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "gpt2",		.clk = &gpt2_clk},
 	{ .dev_id = "gpt3",		.clk = &gpt3_clk},
 	/* clock derived from pll3 clk */
-	{ .dev_id = "usbh0",		.clk = &usbh0_clk},
-	{ .dev_id = "usbh1",		.clk = &usbh1_clk},
+	{ .con_id = "usbh.0_clk",	.clk = &usbh0_clk},
+	{ .con_id = "usbh.1_clk",	.clk = &usbh1_clk},
 	{ .dev_id = "usbd",		.clk = &usbd_clk},
 	/* clock derived from ahb clk */
 	{ .con_id = "apb_clk",		.clk = &apb_clk},
-	{ .dev_id = "i2c",		.clk = &i2c_clk},
+	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
 	{ .dev_id = "dma",		.clk = &dma_clk},
 	{ .dev_id = "jpeg",		.clk = &jpeg_clk},
 	{ .dev_id = "gmac",		.clk = &gmac_clk},
 	{ .dev_id = "smi",		.clk = &smi_clk},
-	{ .dev_id = "fsmc",		.clk = &fsmc_clk},
+	{ .con_id = "fsmc",		.clk = &fsmc_clk},
 	/* clock derived from apb clk */
 	{ .dev_id = "adc",		.clk = &adc_clk},
-	{ .dev_id = "ssp0",		.clk = &ssp0_clk},
-	{ .dev_id = "ssp1",		.clk = &ssp1_clk},
-	{ .dev_id = "ssp2",		.clk = &ssp2_clk},
+	{ .dev_id = "ssp-pl022.0",	.clk = &ssp0_clk},
+	{ .dev_id = "ssp-pl022.1",	.clk = &ssp1_clk},
+	{ .dev_id = "ssp-pl022.2",	.clk = &ssp2_clk},
 	{ .dev_id = "gpio0",		.clk = &gpio0_clk},
 	{ .dev_id = "gpio1",		.clk = &gpio1_clk},
 	{ .dev_id = "gpio2",		.clk = &gpio2_clk},
diff --git a/arch/arm/mach-spear6xx/include/mach/misc_regs.h b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
index 0390803..bd71e72 100644
--- a/arch/arm/mach-spear6xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
@@ -66,8 +66,8 @@
 #define GPT2_CLK_SHIFT		11
 #define GPT3_CLK_SHIFT		12
 #define GPT_CLK_MASK		0x1
-#define AUX_CLK_PLL3_MASK	0
-#define AUX_CLK_PLL1_MASK	1
+#define AUX_CLK_PLL3_VAL	0
+#define AUX_CLK_PLL1_VAL	1
 
 #define PERIP1_CLK_ENB		((unsigned int *)(MISC_BASE + 0x02C))
 /* PERIP1_CLK_ENB register masks */
@@ -123,6 +123,7 @@
 #define RAS3_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x074))
 #define RAS4_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x078))
 /* aux clk synthesiser register masks for irda to ras4 */
+#define AUX_SYNT_ENB		31
 #define AUX_EQ_SEL_SHIFT	30
 #define AUX_EQ_SEL_MASK		1
 #define AUX_EQ1_SEL		0
diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index f1cf832..8de7cf6 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/list.h>
@@ -22,7 +23,7 @@
 static DEFINE_SPINLOCK(clocks_lock);
 static LIST_HEAD(root_clks);
 
-static void propagate_rate(struct list_head *);
+static void propagate_rate(struct clk *, int on_init);
 
 static int generic_clk_enable(struct clk *clk)
 {
@@ -64,6 +65,100 @@ static struct clkops generic_clkops = {
 	.disable = generic_clk_disable,
 };
 
+/* returns current programmed clocks clock info structure */
+static struct pclk_info *pclk_info_get(struct clk *clk)
+{
+	unsigned int val, i;
+	struct pclk_info *info = NULL;
+
+	val = (readl(clk->pclk_sel->pclk_sel_reg) >> clk->pclk_sel_shift)
+		& clk->pclk_sel->pclk_sel_mask;
+
+	for (i = 0; i < clk->pclk_sel->pclk_count; i++) {
+		if (clk->pclk_sel->pclk_info[i].pclk_val == val)
+			info = &clk->pclk_sel->pclk_info[i];
+	}
+
+	return info;
+}
+
+/*
+ * Set Update pclk, and pclk_info of clk and add clock sibling node to current
+ * parents children list
+ */
+static void clk_reparent(struct clk *clk, struct pclk_info *pclk_info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	list_del(&clk->sibling);
+	list_add(&clk->sibling, &pclk_info->pclk->children);
+
+	clk->pclk = pclk_info->pclk;
+	spin_unlock_irqrestore(&clocks_lock, flags);
+}
+
+static void do_clk_disable(struct clk *clk)
+{
+	if (!clk)
+		return;
+
+	if (!clk->usage_count) {
+		WARN_ON(1);
+		return;
+	}
+
+	clk->usage_count--;
+
+	if (clk->usage_count == 0) {
+		/*
+		 * Surely, there are no active childrens or direct users
+		 * of this clock
+		 */
+		if (clk->pclk)
+			do_clk_disable(clk->pclk);
+
+		if (clk->ops && clk->ops->disable)
+			clk->ops->disable(clk);
+	}
+}
+
+static int do_clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (!clk)
+		return -EFAULT;
+
+	if (clk->usage_count == 0) {
+		if (clk->pclk) {
+			ret = do_clk_enable(clk->pclk);
+			if (ret)
+				goto err;
+		}
+		if (clk->ops && clk->ops->enable) {
+			ret = clk->ops->enable(clk);
+			if (ret) {
+				if (clk->pclk)
+					do_clk_disable(clk->pclk);
+				goto err;
+			}
+		}
+		/*
+		 * Since the clock is going to be used for the first
+		 * time please reclac
+		 */
+		if (clk->recalc) {
+			ret = clk->recalc(clk);
+			if (ret)
+				goto err;
+		}
+	}
+	clk->usage_count++;
+err:
+	return ret;
+}
+
 /*
  * clk_enable - inform the system when the clock source should be running.
  * @clk: clock source
@@ -77,17 +172,9 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 	int ret = 0;
 
-	if (!clk || IS_ERR(clk))
-		return -EFAULT;
-
 	spin_lock_irqsave(&clocks_lock, flags);
-	if (clk->usage_count == 0) {
-		if (clk->ops && clk->ops->enable)
-			ret = clk->ops->enable(clk);
-	}
-	clk->usage_count++;
+	ret = do_clk_enable(clk);
 	spin_unlock_irqrestore(&clocks_lock, flags);
-
 	return ret;
 }
 EXPORT_SYMBOL(clk_enable);
@@ -108,17 +195,8 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (!clk || IS_ERR(clk))
-		return;
-
-	WARN_ON(clk->usage_count == 0);
-
 	spin_lock_irqsave(&clocks_lock, flags);
-	clk->usage_count--;
-	if (clk->usage_count == 0) {
-		if (clk->ops && clk->ops->disable)
-			clk->ops->disable(clk);
-	}
+	do_clk_disable(clk);
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
@@ -152,15 +230,14 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	int i, found = 0, val = 0;
 	unsigned long flags;
 
-	if (!clk || IS_ERR(clk) || !parent || IS_ERR(parent))
+	if (!clk || !parent)
 		return -EFAULT;
-	if (clk->usage_count)
-		return -EBUSY;
-	if (!clk->pclk_sel)
-		return -EPERM;
 	if (clk->pclk == parent)
 		return 0;
+	if (!clk->pclk_sel)
+		return -EPERM;
 
+	/* check if requested parent is in clk parent list */
 	for (i = 0; i < clk->pclk_sel->pclk_count; i++) {
 		if (clk->pclk_sel->pclk_info[i].pclk == parent) {
 			found = 1;
@@ -175,13 +252,14 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	/* reflect parent change in hardware */
 	val = readl(clk->pclk_sel->pclk_sel_reg);
 	val &= ~(clk->pclk_sel->pclk_sel_mask << clk->pclk_sel_shift);
-	val |= clk->pclk_sel->pclk_info[i].pclk_mask << clk->pclk_sel_shift;
+	val |= clk->pclk_sel->pclk_info[i].pclk_val << clk->pclk_sel_shift;
 	writel(val, clk->pclk_sel->pclk_sel_reg);
 	spin_unlock_irqrestore(&clocks_lock, flags);
 
 	/* reflect parent change in software */
-	clk->recalc(clk);
-	propagate_rate(&clk->children);
+	clk_reparent(clk, &clk->pclk_sel->pclk_info[i]);
+
+	propagate_rate(clk, 0);
 	return 0;
 }
 EXPORT_SYMBOL(clk_set_parent);
@@ -195,19 +273,37 @@ EXPORT_SYMBOL(clk_set_parent);
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
 
 /* registers clock in platform clock framework */
 void clk_register(struct clk_lookup *cl)
 {
-	struct clk *clk = cl->clk;
+	struct clk *clk;
 	unsigned long flags;
 
-	if (!clk || IS_ERR(clk))
+	if (!cl || !cl->clk)
 		return;
+	clk = cl->clk;
 
 	spin_lock_irqsave(&clocks_lock, flags);
 
@@ -220,15 +316,24 @@ void clk_register(struct clk_lookup *cl)
 	/* root clock don't have any parents */
 	if (!clk->pclk && !clk->pclk_sel) {
 		list_add(&clk->sibling, &root_clks);
-		/* add clocks with only one parent to parent's children list */
 	} else if (clk->pclk && !clk->pclk_sel) {
+		/* add clocks with only one parent to parent's children list */
 		list_add(&clk->sibling, &clk->pclk->children);
 	} else {
-		/* add clocks with > 1 parent to 1st parent's children list */
-		clk->pclk = clk->pclk_sel->pclk_info[0].pclk;
-		list_add(&clk->sibling,
-			 &clk->pclk_sel->pclk_info[0].pclk->children);
+		/* clocks with more than one parent */
+		struct pclk_info *pclk_info;
+
+		pclk_info = pclk_info_get(clk);
+		if (!pclk_info) {
+			pr_err("CLKDEV: invalid pclk info of clk with"
+					" %s dev_id and %s con_id\n",
+					cl->dev_id, cl->con_id);
+		} else {
+			clk->pclk = pclk_info->pclk;
+			list_add(&clk->sibling, &pclk_info->pclk->children);
+		}
 	}
+
 	spin_unlock_irqrestore(&clocks_lock, flags);
 
 	/* add clock to arm clockdev framework */
@@ -236,56 +341,112 @@ void clk_register(struct clk_lookup *cl)
 }
 
 /**
- * propagate_rate - recalculate and propagate all clocks in list head
+ * propagate_rate - recalculate and propagate all clocks to children
+ * @pclk: parent clock required to be propogated
+ * @on_init: flag for enabling clocks which are ENABLED_ON_INIT.
  *
- * Recalculates all root clocks in list head, which if the clock's .recalc is
- * set correctly, should also propagate their rates.
+ * Recalculates all children clocks
  */
-static void propagate_rate(struct list_head *lhead)
+void propagate_rate(struct clk *pclk, int on_init)
 {
-	struct clk *clkp, *_temp;
+	struct clk *clk, *_temp;
+	int ret = 0;
+
+	list_for_each_entry_safe(clk, _temp, &pclk->children, sibling) {
+		if (clk->recalc) {
+			ret = clk->recalc(clk);
+			/*
+			 * recalc will return error if clk out is not programmed
+			 * In this case configure default rate.
+			 */
+			if (ret && clk->set_rate)
+				clk->set_rate(clk, 0);
+		}
+		propagate_rate(clk, on_init);
+
+		if (!on_init)
+			continue;
 
-	list_for_each_entry_safe(clkp, _temp, lhead, sibling) {
-		if (clkp->recalc)
-			clkp->recalc(clkp);
-		propagate_rate(&clkp->children);
+		/* Enable clks enabled on init, in software view */
+		if (clk->flags & ENABLED_ON_INIT)
+			do_clk_enable(clk);
 	}
 }
 
-/* returns current programmed clocks clock info structure */
-static struct pclk_info *pclk_info_get(struct clk *clk)
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
 {
-	unsigned int mask, i;
-	unsigned long flags;
-	struct pclk_info *info = NULL;
+	unsigned long tmp = 0, prev_rate = 0;
+	int index;
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	mask = (readl(clk->pclk_sel->pclk_sel_reg) >> clk->pclk_sel_shift)
-			& clk->pclk_sel->pclk_sel_mask;
+	if (!clk->calc_rate)
+		return -EFAULT;
 
-	for (i = 0; i < clk->pclk_sel->pclk_count; i++) {
-		if (clk->pclk_sel->pclk_info[i].pclk_mask == mask)
-			info = &clk->pclk_sel->pclk_info[i];
+	/* Set default rate if desired rate is 0 */
+	if (!drate) {
+		index = clk->rate_config.default_index;
+		*rate = clk->calc_rate(clk, index);
+		return index;
 	}
-	spin_unlock_irqrestore(&clocks_lock, flags);
 
-	return info;
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
 }
 
+/*All below functions are called with lock held */
+
 /*
- * Set pclk as cclk's parent and add clock sibling node to current parents
- * children list
+ * Calculates pll clk rate for specific value of mode, m, n and p
+ *
+ * In normal mode
+ * rate = (2 * M[15:8] * Fin)/(N * 2^P)
+ *
+ * In Dithered mode
+ * rate = (2 * M[15:0] * Fin)/(256 * N * 2^P)
  */
-static void change_parent(struct clk *cclk, struct clk *pclk)
+unsigned long pll_calc_rate(struct clk *clk, int index)
 {
-	unsigned long flags;
+	unsigned long rate = clk->pclk->rate;
+	struct pll_rate_tbl *tbls = clk->rate_config.tbls;
+	unsigned int mode;
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	list_del(&cclk->sibling);
-	list_add(&cclk->sibling, &pclk->children);
-
-	cclk->pclk = pclk;
-	spin_unlock_irqrestore(&clocks_lock, flags);
+	mode = tbls[index].mode ? 256 : 1;
+	return (((2 * rate / 10000) * tbls[index].m) /
+			(mode * tbls[index].n * (1 << tbls[index].p))) * 10000;
 }
 
 /*
@@ -297,13 +458,11 @@ static void change_parent(struct clk *cclk, struct clk *pclk)
  * In Dithered mode
  * rate = (2 * M[15:0] * Fin)/(256 * N * 2^P)
  */
-void pll_clk_recalc(struct clk *clk)
+int pll_clk_recalc(struct clk *clk)
 {
 	struct pll_clk_config *config = clk->private_data;
 	unsigned int num = 2, den = 0, val, mode = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&clocks_lock, flags);
 	mode = (readl(config->mode_reg) >> config->masks->mode_shift) &
 		config->masks->mode_mask;
 
@@ -325,22 +484,120 @@ void pll_clk_recalc(struct clk *clk)
 		den *= 256;
 	}
 
+	if (!den)
+		return -EINVAL;
+
 	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
-	spin_unlock_irqrestore(&clocks_lock, flags);
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
-	unsigned long flags;
 
-	spin_lock_irqsave(&clocks_lock, flags);
 	div = ((readl(config->reg) >> config->masks->shift) &
 			config->masks->mask) + 1;
+
+	if (!div)
+		return -EINVAL;
+
 	clk->rate = (unsigned long)clk->pclk->rate / div;
-	spin_unlock_irqrestore(&clocks_lock, flags);
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
@@ -353,47 +610,76 @@ void bus_clk_recalc(struct clk *clk)
  *
  * Selection of eqn 1 or 2 is programmed in register
  */
-void aux_clk_recalc(struct clk *clk)
+int aux_clk_recalc(struct clk *clk)
 {
 	struct aux_clk_config *config = clk->private_data;
-	struct pclk_info *pclk_info = NULL;
 	unsigned int num = 1, den = 1, val, eqn;
-	unsigned long flags;
 
-	/* get current programmed parent */
-	pclk_info = pclk_info_get(clk);
-	if (!pclk_info) {
-		spin_lock_irqsave(&clocks_lock, flags);
-		clk->pclk = NULL;
-		clk->rate = 0;
-		spin_unlock_irqrestore(&clocks_lock, flags);
-		return;
-	}
+	val = readl(config->synth_reg);
 
-	change_parent(clk, pclk_info->pclk);
+	eqn = (val >> config->masks->eq_sel_shift) &
+		config->masks->eq_sel_mask;
+	if (eqn == config->masks->eq1_mask)
+		den *= 2;
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	if (pclk_info->scalable) {
-		val = readl(config->synth_reg);
-
-		eqn = (val >> config->masks->eq_sel_shift) &
-			config->masks->eq_sel_mask;
-		if (eqn == config->masks->eq1_mask)
-			den *= 2;
-
-		/* calculate numerator */
-		num = (val >> config->masks->xscale_sel_shift) &
-			config->masks->xscale_sel_mask;
-
-		/* calculate denominator */
-		den *= (val >> config->masks->yscale_sel_shift) &
-			config->masks->yscale_sel_mask;
-		val = (((clk->pclk->rate/10000) * num) / den) * 10000;
-	} else
-		val = clk->pclk->rate;
+	/* calculate numerator */
+	num = (val >> config->masks->xscale_sel_shift) &
+		config->masks->xscale_sel_mask;
 
-	clk->rate = val;
-	spin_unlock_irqrestore(&clocks_lock, flags);
+	/* calculate denominator */
+	den *= (val >> config->masks->yscale_sel_shift) &
+		config->masks->yscale_sel_mask;
+
+	if (!den)
+		return -EINVAL;
+
+	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
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
@@ -401,49 +687,142 @@ void aux_clk_recalc(struct clk *clk)
  * Fout from synthesizer can be given from below equations:
  * Fout= Fin/((2 ^ (N+1)) * (M+1))
  */
-void gpt_clk_recalc(struct clk *clk)
+int gpt_clk_recalc(struct clk *clk)
 {
 	struct gpt_clk_config *config = clk->private_data;
-	struct pclk_info *pclk_info = NULL;
 	unsigned int div = 1, val;
-	unsigned long flags;
-
-	pclk_info = pclk_info_get(clk);
-	if (!pclk_info) {
-		spin_lock_irqsave(&clocks_lock, flags);
-		clk->pclk = NULL;
-		clk->rate = 0;
-		spin_unlock_irqrestore(&clocks_lock, flags);
-		return;
-	}
 
-	change_parent(clk, pclk_info->pclk);
+	val = readl(config->synth_reg);
+	div += (val >> config->masks->mscale_sel_shift) &
+		config->masks->mscale_sel_mask;
+	div *= 1 << (((val >> config->masks->nscale_sel_shift) &
+				config->masks->nscale_sel_mask) + 1);
 
-	spin_lock_irqsave(&clocks_lock, flags);
-	if (pclk_info->scalable) {
-		val = readl(config->synth_reg);
-		div += (val >> config->masks->mscale_sel_shift) &
-			config->masks->mscale_sel_mask;
-		div *= 1 << (((val >> config->masks->nscale_sel_shift) &
-					config->masks->nscale_sel_mask) + 1);
-	}
+	if (!div)
+		return -EINVAL;
 
 	clk->rate = (unsigned long)clk->pclk->rate / div;
-	spin_unlock_irqrestore(&clocks_lock, flags);
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
+}
+
+/*
+ * calculates current programmed rate of clcd synthesizer
+ * Fout from synthesizer can be given from below equation:
+ * Fout= Fin/2*div (division factor)
+ * div is 17 bits:-
+ *	0-13 (fractional part)
+ *	14-16 (integer part)
+ * To calculate Fout we left shift val by 14 bits and divide Fin by
+ * complete div (including fractional part) and then right shift the
+ * result by 14 places.
+ */
+int clcd_clk_recalc(struct clk *clk)
+{
+	struct clcd_clk_config *config = clk->private_data;
+	unsigned int div = 1;
+	unsigned long prate;
+	unsigned int val;
+
+	val = readl(config->synth_reg);
+	div = (val >> config->masks->div_factor_shift) &
+		config->masks->div_factor_mask;
+
+	if (!div)
+		return -EINVAL;
+
+	prate = clk->pclk->rate / 1000; /* first level division, make it KHz */
+
+	clk->rate = (((unsigned long)prate << 12) / (2 * div)) >> 12;
+	clk->rate *= 1000;
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
-	unsigned long flags;
 	unsigned int div_factor = (clk->div_factor < 1) ? 1 : clk->div_factor;
 
-	spin_lock_irqsave(&clocks_lock, flags);
 	clk->rate = clk->pclk->rate/div_factor;
-	spin_unlock_irqrestore(&clocks_lock, flags);
+	return 0;
 }
 
 /**
@@ -454,5 +833,25 @@ void follow_parent(struct clk *clk)
  */
 void recalc_root_clocks(void)
 {
-	propagate_rate(&root_clks);
+	struct clk *pclk;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	list_for_each_entry(pclk, &root_clks, sibling) {
+		if (pclk->recalc) {
+			ret = pclk->recalc(pclk);
+			/*
+			 * recalc will return error if clk out is not programmed
+			 * In this case configure default clock.
+			 */
+			if (ret && pclk->set_rate)
+				pclk->set_rate(pclk, 0);
+		}
+		propagate_rate(pclk, 1);
+		/* Enable clks enabled on init, in software view */
+		if (pclk->flags & ENABLED_ON_INIT)
+			do_clk_enable(pclk);
+	}
+	spin_unlock_irqrestore(&clocks_lock, flags);
 }
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index 4788669..f7b4b5a 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -21,6 +21,7 @@
 /* clk structure flags */
 #define	ALWAYS_ENABLED		(1 << 0) /* clock always enabled */
 #define	RESET_TO_ENABLE		(1 << 1) /* reset register bit to enable clk */
+#define	ENABLED_ON_INIT		(1 << 2) /* clocks enabled@init */
 
 /**
  * struct clkops - clock operations
@@ -35,13 +36,11 @@ struct clkops {
 /**
  * struct pclk_info - parents info
  * @pclk: pointer to parent clk
- * @pclk_mask: value to be written for selecting this parent
- * @scalable: Is parent scalable (1 - YES, 0 - NO)
+ * @pclk_val: value to be written for selecting this parent
  */
 struct pclk_info {
 	struct clk *pclk;
-	u8 pclk_mask;
-	u8 scalable;
+	u8 pclk_val;
 };
 
 /**
@@ -59,6 +58,18 @@ struct pclk_sel {
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
@@ -67,7 +78,10 @@ struct pclk_sel {
  * @en_reg_bit: clk enable/disable bit
  * @ops: clk enable/disable ops - generic_clkops selected if NULL
  * @recalc: pointer to clock rate recalculate function
- * @div_factor: division factor to parent clock. Only for recalc = follow_parent
+ * @set_rate: pointer to clock set rate function
+ * @calc_rate: pointer to clock get rate function for index
+ * @rate_config: rate configuration information, used by set_rate
+ * @div_factor: division factor to parent clock.
  * @pclk: current parent clk
  * @pclk_sel: pointer to parent selection structure
  * @pclk_sel_shift: register shift for selecting parent of this clock
@@ -82,7 +96,10 @@ struct clk {
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
@@ -115,6 +132,14 @@ struct pll_clk_config {
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
@@ -126,6 +151,11 @@ struct bus_clk_config {
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
@@ -143,6 +173,13 @@ struct aux_clk_config {
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
@@ -156,15 +193,48 @@ struct gpt_clk_config {
 	struct gpt_clk_masks *masks;
 };
 
+/* gpt clk rate config structure */
+struct gpt_rate_tbl {
+	u16 mscale;
+	u16 nscale;
+};
+
+/* clcd clk configuration structure */
+struct clcd_synth_masks {
+	u32 div_factor_mask;
+	u32 div_factor_shift;
+};
+
+struct clcd_clk_config {
+	u32 *synth_reg;
+	struct clcd_synth_masks *masks;
+};
+
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
