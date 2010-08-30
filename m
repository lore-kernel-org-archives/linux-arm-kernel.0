From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:44 +0530
Subject: [PATCH 13/74] ST SPEAr: Update clock framework and definitions
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <a15d1fca5a6e663c1fee4602013b6160512eb2dd.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

- Defined clks for synthesizers and prescalers as they were shared among IPs
- Simplified clk_recalc functions
- Keep divisor only at 1 level i.e. during clk defn
- Added missing clock definitions

Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/clock.c                  |  510 +++++++++++++++++++++-
 arch/arm/mach-spear13xx/include/mach/misc_regs.h |   99 +++--
 arch/arm/mach-spear3xx/clock.c                   |  176 ++++++---
 arch/arm/mach-spear3xx/include/mach/misc_regs.h  |    5 +-
 arch/arm/mach-spear6xx/clock.c                   |  256 ++++++++----
 arch/arm/mach-spear6xx/include/mach/misc_regs.h  |    5 +-
 arch/arm/plat-spear/clock.c                      |  208 ++++------
 arch/arm/plat-spear/include/plat/clock.h         |   24 +-
 8 files changed, 940 insertions(+), 343 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 280eb5b..cef3b13 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -52,10 +52,10 @@ static struct clk rtc_clk = {
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
 
@@ -97,6 +97,22 @@ static struct clk pll1_clk = {
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
@@ -191,10 +207,10 @@ static struct clk apb_clk = {
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
 
@@ -249,14 +265,6 @@ static struct clk wdt_clk = {
 	.recalc = &follow_parent,
 };
 
-/* smi clock */
-static struct clk smi_clk = {
-	.pclk = &ahb_clk,
-	.en_reg = PERIP1_CLK_ENB,
-	.en_reg_bit = SMI_CLK_ENB,
-	.recalc = &follow_parent,
-};
-
 /* auxiliary synthesizers masks */
 static struct aux_clk_masks aux_masks = {
 	.eq_sel_mask = AUX_EQ_SEL_MASK,
@@ -269,22 +277,30 @@ static struct aux_clk_masks aux_masks = {
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
+/* uart synth clock */
+static struct clk uart_synth_clk = {
+	.en_reg = UART_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.recalc = &aux_clk_recalc,
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
 
@@ -302,8 +318,414 @@ static struct clk uart_clk = {
 	.en_reg_bit = UART_CLK_ENB,
 	.pclk_sel = &uart_pclk_sel,
 	.pclk_sel_shift = UART_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* sd configurations */
+static struct aux_clk_config sd_synth_config = {
+	.synth_reg = SD_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* sd synth clock */
+static struct clk sd_synth_clk = {
+	.en_reg = SD_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.recalc = &aux_clk_recalc,
+	.private_data = &sd_synth_config,
+};
+
+/* sd clock */
+static struct clk sd_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SD_CLK_ENB,
+	.pclk = &sd_synth_clk,
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
+	.recalc = &aux_clk_recalc,
+	.private_data = &cfxd_synth_config,
+};
+
+/* cfxd clock */
+static struct clk cfxd_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = CFXD_CLK_ENB,
+	.pclk = &cfxd_synth_clk,
+	.recalc = &follow_parent,
+};
+
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
 	.recalc = &aux_clk_recalc,
-	.private_data = &uart_config,
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
+static struct clk gmac_phy_synth_clk = {
+	.en_reg = GMAC_CLK_CFG,
+	.en_reg_bit = GMAC_PHY_SYNT_ENB,
+	.pclk = &gmac_phy_input_clk,
+	.recalc = &aux_clk_recalc,
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
+/* clcd synth clock */
+static struct clk clcd_synth_clk = {
+	.en_reg = CLCD_CLK_SYNT,
+	.en_reg_bit = CLCD_SYNT_ENB,
+	.pclk_sel = &clcd_synth_pclk_sel,
+	.pclk_sel_shift = CLCD_SYNT_CLK_SHIFT,
+	.recalc = &clcd_clk_recalc,
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
 };
 
 /* array of all spear 13xx clock lookups */
@@ -327,18 +749,58 @@ static struct clk_lookup spear_clk_lookups[] = {
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
+	{.con_id = "sd_synth_clk",		.clk = &sd_synth_clk},
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
+	{.dev_id = "uhci0",		.clk = &uhci0_clk},
+	{.dev_id = "uhci1",		.clk = &uhci1_clk},
+	{.dev_id = "usbd",		.clk = &usbd_clk},
+	{.dev_id = "i2c",		.clk = &i2c_clk},
+	{.dev_id = "dma0",		.clk = &dma0_clk},
+	{.dev_id = "dma1",		.clk = &dma1_clk},
+	{.dev_id = "jpeg",		.clk = &jpeg_clk},
+	{.dev_id = "gmac",		.clk = &gmac_clk},
+	{.dev_id = "c3",		.clk = &c3_clk},
+	{.dev_id = "pcie0",		.clk = &pcie0_clk},
+	{.dev_id = "pcie1",		.clk = &pcie1_clk},
+	{.dev_id = "pcie2",		.clk = &pcie2_clk},
+	{.dev_id = "cfxd",		.clk = &cfxd_clk},
+	{.dev_id = "sd",		.clk = &sd_clk},
+	{.dev_id = "fsmc",		.clk = &fsmc_clk},
+	{.dev_id = "sysram0",		.clk = &sysram0_clk},
+	{.dev_id = "sysram1",		.clk = &sysram1_clk},
+
+	/* clock derived from apb clk */
+	{.dev_id = "i2s0",		.clk = &i2s0_clk},
+	{.dev_id = "i2s1",		.clk = &i2s1_clk},
+	{.dev_id = "adc",		.clk = &adc_clk},
+	{.dev_id = "ssp",		.clk = &ssp_clk},
+	{.dev_id = "gpio0",		.clk = &gpio0_clk},
+	{.dev_id = "gpio1",		.clk = &gpio1_clk},
+	{.dev_id = "kbd",		.clk = &kbd_clk},
+	{.dev_id = "wdt",		.clk = &wdt_clk},
 };
 
 void __init clk_init(void)
diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
index 2e87a07..c4dcab2 100644
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
+#define SD_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x25c))
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
 	#define SD_CLK_ENB		6
-	#define CF_XD_CLK_ENB		7
-	#define GETH_CLK_ENB		8
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
@@ -214,11 +241,11 @@
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
index 7ea8749..dc19666 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -123,22 +123,29 @@ static struct aux_clk_masks aux_masks = {
 	.yscale_sel_shift = AUX_YSCALE_SHIFT,
 };
 
-/* uart configurations */
-static struct aux_clk_config uart_config = {
+/* uart synth configurations */
+static struct aux_clk_config uart_synth_config = {
 	.synth_reg = UART_CLK_SYNT,
 	.masks = &aux_masks,
 };
 
+/* uart synth clock */
+static struct clk uart_synth_clk = {
+	.en_reg = UART_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1_clk,
+	.recalc = &aux_clk_recalc,
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
 
@@ -156,26 +163,32 @@ static struct clk uart_clk = {
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
+	.recalc = &aux_clk_recalc,
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
 
@@ -193,84 +206,138 @@ static struct clk firda_clk = {
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
+	.recalc = &gpt_clk_recalc,
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
 	.recalc = &gpt_clk_recalc,
-	.private_data = &gpt0_config,
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
+	.recalc = &gpt_clk_recalc,
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
@@ -408,6 +475,11 @@ static struct clk_lookup spear_clk_lookups[] = {
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
index ef88922..4a91991 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -111,27 +111,6 @@ static struct clk ahb_clk = {
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
@@ -145,19 +124,46 @@ static struct aux_clk_masks aux_masks = {
 };
 
 /* uart configurations */
-static struct aux_clk_config uart_config = {
+static struct aux_clk_config uart_synth_config = {
 	.synth_reg = UART_CLK_SYNT,
 	.masks = &aux_masks,
 };
 
+/* uart synth clock */
+static struct clk uart_synth_clk = {
+	.en_reg = UART_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1_clk,
+	.recalc = &aux_clk_recalc,
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
@@ -166,26 +172,32 @@ static struct clk uart1_clk = {
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
+	.recalc = &aux_clk_recalc,
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
 
@@ -203,26 +215,32 @@ static struct clk firda_clk = {
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
+	.recalc = &aux_clk_recalc,
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
 
@@ -240,29 +258,7 @@ static struct clk clcd_clk = {
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
@@ -273,60 +269,145 @@ static struct gpt_clk_masks gpt_masks = {
 	.nscale_sel_shift = GPT_NSCALE_SHIFT,
 };
 
-/* gpt0_1 configurations */
-static struct gpt_clk_config gpt0_1_config = {
+/* gpt0 synth clk config*/
+static struct gpt_clk_config gpt0_synth_config = {
 	.synth_reg = PRSC1_CLK_CFG,
 	.masks = &gpt_masks,
 };
 
+/* gpt synth clock */
+static struct clk gpt0_synth_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.recalc = &gpt_clk_recalc,
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
+	.recalc = &gpt_clk_recalc,
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
+	.recalc = &gpt_clk_recalc,
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
@@ -496,6 +577,11 @@ static struct clk_lookup spear_clk_lookups[] = {
 	/* clock derived from pll1 clk */
 	{ .con_id = "cpu_clk",		.clk = &cpu_clk},
 	{ .con_id = "ahb_clk",		.clk = &ahb_clk},
+	{ .con_id = "uart_synth_clk",	.clk = &uart_synth_clk},
+	{ .con_id = "firda_synth_clk",	.clk = &firda_synth_clk},
+	{ .con_id = "gpt0_synth_clk",	.clk = &gpt0_synth_clk},
+	{ .con_id = "gpt2_synth_clk",	.clk = &gpt2_synth_clk},
+	{ .con_id = "gpt3_synth_clk",	.clk = &gpt3_synth_clk},
 	{ .dev_id = "uart0",		.clk = &uart0_clk},
 	{ .dev_id = "uart1",		.clk = &uart1_clk},
 	{ .dev_id = "firda",		.clk = &firda_clk},
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
index ab29353..89a0434 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -67,14 +67,14 @@ static struct clkops generic_clkops = {
 /* returns current programmed clocks clock info structure */
 static struct pclk_info *pclk_info_get(struct clk *clk)
 {
-	unsigned int mask, i;
+	unsigned int val, i;
 	struct pclk_info *info = NULL;
 
-	mask = (readl(clk->pclk_sel->pclk_sel_reg) >> clk->pclk_sel_shift)
+	val = (readl(clk->pclk_sel->pclk_sel_reg) >> clk->pclk_sel_shift)
 		& clk->pclk_sel->pclk_sel_mask;
 
 	for (i = 0; i < clk->pclk_sel->pclk_count; i++) {
-		if (clk->pclk_sel->pclk_info[i].pclk_mask == mask)
+		if (clk->pclk_sel->pclk_info[i].pclk_val == val)
 			info = &clk->pclk_sel->pclk_info[i];
 	}
 
@@ -94,7 +94,6 @@ static void update_clk_tree(struct clk *clk, struct pclk_info *pclk_info)
 	list_add(&clk->sibling, &pclk_info->pclk->children);
 
 	clk->pclk = pclk_info->pclk;
-	clk->pclk_info = pclk_info;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
@@ -210,7 +209,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	/* reflect parent change in hardware */
 	val = readl(clk->pclk_sel->pclk_sel_reg);
 	val &= ~(clk->pclk_sel->pclk_sel_mask << clk->pclk_sel_shift);
-	val |= clk->pclk_sel->pclk_info[i].pclk_mask << clk->pclk_sel_shift;
+	val |= clk->pclk_sel->pclk_info[i].pclk_val << clk->pclk_sel_shift;
 	writel(val, clk->pclk_sel->pclk_sel_reg);
 	spin_unlock_irqrestore(&clocks_lock, flags);
 
@@ -219,7 +218,6 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 
 	clk->recalc(clk);
 	propagate_rate(&clk->children);
-
 	return 0;
 }
 EXPORT_SYMBOL(clk_set_parent);
@@ -272,7 +270,6 @@ void clk_register(struct clk_lookup *cl)
 					cl->dev_id, cl->con_id);
 		} else {
 			clk->pclk = pclk_info->pclk;
-			clk->pclk_info = pclk_info;
 			list_add(&clk->sibling, &pclk_info->pclk->children);
 		}
 	}
@@ -315,53 +312,28 @@ void pll_clk_recalc(struct clk *clk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-
-	/*
-	 * read divisor from hardware, only in two cases:
-	 * - There is only parent to clk and it requires *_clk_recalc
-	 * - There are two parents of a clock and current pclk requires
-	 *   *_clk_recalc
-	 */
-	if (!clk->pclk_info || clk->pclk_info->scalable) {
-		mode = (readl(config->mode_reg) >> config->masks->mode_shift) &
-			config->masks->mode_mask;
-
-		val = readl(config->cfg_reg);
-		spin_unlock_irqrestore(&clocks_lock, flags);
-
-		/* calculate denominator */
-		den = (val >> config->masks->div_p_shift) &
-			config->masks->div_p_mask;
-		den = 1 << den;
-		den *= (val >> config->masks->div_n_shift) &
-			config->masks->div_n_mask;
-
-		/* calculate numerator & denominator */
-		if (!mode) {
-			/* Normal mode */
-			num *= (val >> config->masks->norm_fdbk_m_shift) &
-				config->masks->norm_fdbk_m_mask;
-		} else {
-			/* Dithered mode */
-			num *= (val >> config->masks->dith_fdbk_m_shift) &
-				config->masks->dith_fdbk_m_mask;
-			den *= 256;
-		}
-
-		spin_lock_irqsave(&clocks_lock, flags);
-		val = (((clk->pclk->rate/10000) * num) / den) * 10000;
+	mode = (readl(config->mode_reg) >> config->masks->mode_shift) &
+		config->masks->mode_mask;
+
+	val = readl(config->cfg_reg);
+	/* calculate denominator */
+	den = (val >> config->masks->div_p_shift) & config->masks->div_p_mask;
+	den = 1 << den;
+	den *= (val >> config->masks->div_n_shift) & config->masks->div_n_mask;
+
+	/* calculate numerator & denominator */
+	if (!mode) {
+		/* Normal mode */
+		num *= (val >> config->masks->norm_fdbk_m_shift) &
+			config->masks->norm_fdbk_m_mask;
 	} else {
-		int div = 0;
-		/*
-		 * only if there are two parents and current parent requires
-		 * simple division
-		 */
-		div = (clk->pclk_info->div_factor < 1) ? 1 :
-			clk->pclk_info->div_factor;
-		val = clk->pclk->rate/div;
+		/* Dithered mode */
+		num *= (val >> config->masks->dith_fdbk_m_shift) &
+			config->masks->dith_fdbk_m_mask;
+		den *= 256;
 	}
 
-	clk->rate = val;
+	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
@@ -373,23 +345,8 @@ void bus_clk_recalc(struct clk *clk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	/*
-	 * read divisor from hardware, only in two cases:
-	 * - There is only parent to clk and it requires *_clk_recalc
-	 * - There are two parents of a clock and current pclk requires
-	 *   *_clk_recalc
-	 */
-	if (!clk->pclk_info || clk->pclk_info->scalable) {
-		div = ((readl(config->reg) >> config->masks->shift) &
-				config->masks->mask) + 1;
-	} else {
-		/*
-		 * only if there are two parents and current parent requires
-		 * simple division
-		 */
-		div = (clk->pclk_info->div_factor < 1) ? 1 :
-			clk->pclk_info->div_factor;
-	}
+	div = ((readl(config->reg) >> config->masks->shift) &
+			config->masks->mask) + 1;
 	clk->rate = (unsigned long)clk->pclk->rate / div;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
@@ -411,41 +368,21 @@ void aux_clk_recalc(struct clk *clk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	/*
-	 * read divisor from hardware, only in two cases:
-	 * - There is only parent to clk and it requires *_clk_recalc
-	 * - There are two parents of a clock and current pclk requires
-	 *   *_clk_recalc
-	 */
-	if (!clk->pclk_info || clk->pclk_info->scalable) {
-		val = readl(config->synth_reg);
-		spin_unlock_irqrestore(&clocks_lock, flags);
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
-
-		spin_lock_irqsave(&clocks_lock, flags);
-		val = (((clk->pclk->rate/10000) * num) / den) * 10000;
-	} else {
-		/*
-		 * only if there are two parents and current parent requires
-		 * simple division
-		 */
-		int div_factor = (clk->pclk_info->div_factor < 1) ? 1 :
-			clk->pclk_info->div_factor;
-
-		val = clk->pclk->rate/div_factor;
-	}
+	val = readl(config->synth_reg);
+
+	eqn = (val >> config->masks->eq_sel_shift) &
+		config->masks->eq_sel_mask;
+	if (eqn == config->masks->eq1_mask)
+		den *= 2;
+
+	/* calculate numerator */
+	num = (val >> config->masks->xscale_sel_shift) &
+		config->masks->xscale_sel_mask;
+
+	/* calculate denominator */
+	den *= (val >> config->masks->yscale_sel_shift) &
+		config->masks->yscale_sel_mask;
+	val = (((clk->pclk->rate/10000) * num) / den) * 10000;
 
 	clk->rate = val;
 	spin_unlock_irqrestore(&clocks_lock, flags);
@@ -463,50 +400,55 @@ void gpt_clk_recalc(struct clk *clk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	/*
-	 * read divisor from hardware, only in two cases:
-	 * - There is only parent to clk and it requires *_clk_recalc
-	 * - There are two parents of a clock and current pclk requires
-	 *   *_clk_recalc
-	 */
-	if (!clk->pclk_info || clk->pclk_info->scalable) {
-		val = readl(config->synth_reg);
-		spin_unlock_irqrestore(&clocks_lock, flags);
-
-		div += (val >> config->masks->mscale_sel_shift) &
-			config->masks->mscale_sel_mask;
-		div *= 1 << (((val >> config->masks->nscale_sel_shift) &
-					config->masks->nscale_sel_mask) + 1);
-		spin_lock_irqsave(&clocks_lock, flags);
-	} else {
-		/*
-		 * only if there are two parents and current parent requires
-		 * simple division
-		 */
-		div = (clk->pclk_info->div_factor < 1) ? 1 :
-			clk->pclk_info->div_factor;
-	}
+	val = readl(config->synth_reg);
+	div += (val >> config->masks->mscale_sel_shift) &
+		config->masks->mscale_sel_mask;
+	div *= 1 << (((val >> config->masks->nscale_sel_shift) &
+				config->masks->nscale_sel_mask) + 1);
 
 	clk->rate = (unsigned long)clk->pclk->rate / div;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
 /*
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
+void clcd_clk_recalc(struct clk *clk)
+{
+	struct clcd_clk_config *config = clk->private_data;
+	unsigned int div = 1;
+	unsigned long flags, prate;
+	unsigned int val;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	val = readl(config->synth_reg);
+	div = (val >> config->masks->div_factor_shift) &
+		config->masks->div_factor_mask;
+
+	prate = clk->pclk->rate / 1000; /* first level division, make it KHz */
+	clk->rate = ((unsigned long)prate << 14 / 2 * div) >> 14;
+	clk->rate *= 1000;
+	spin_unlock_irqrestore(&clocks_lock, flags);
+}
+
+/*
  * Used for clocks that always have value as the parent clock divided by a
  * fixed divisor
  */
 void follow_parent(struct clk *clk)
 {
 	unsigned long flags;
-	unsigned int div_factor;
+	unsigned int div_factor = (clk->div_factor < 1) ? 1 : clk->div_factor;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	if (clk->pclk_info)
-		div_factor = clk->pclk_info->div_factor;
-	else
-		div_factor = clk->div_factor;
-	div_factor = (div_factor < 1) ? 1 : div_factor;
-
 	clk->rate = clk->pclk->rate/div_factor;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index d8d0856..019d308 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -35,15 +35,11 @@ struct clkops {
 /**
  * struct pclk_info - parents info
  * @pclk: pointer to parent clk
- * @pclk_mask: value to be written for selecting this parent
- * @scalable: Is parent scalable (1 - YES, 0 - NO)
- * @div_factor: div factor for pclk
+ * @pclk_val: value to be written for selecting this parent
  */
 struct pclk_info {
 	struct clk *pclk;
-	u8 pclk_mask;
-	u8 scalable;
-	u8 div_factor;
+	u8 pclk_val;
 };
 
 /**
@@ -69,9 +65,8 @@ struct pclk_sel {
  * @en_reg_bit: clk enable/disable bit
  * @ops: clk enable/disable ops - generic_clkops selected if NULL
  * @recalc: pointer to clock rate recalculate function
- * @div_factor: division factor to parent clock. Only for clks with one parent
+ * @div_factor: division factor to parent clock.
  * @pclk: current parent clk
- * @pclk_info: current parent clk's pclk_info
  * @pclk_sel: pointer to parent selection structure
  * @pclk_sel_shift: register shift for selecting parent of this clock
  * @children: list for childrens or this clock
@@ -89,7 +84,6 @@ struct clk {
 	unsigned int div_factor;
 
 	struct clk *pclk;
-	struct pclk_info *pclk_info;
 	struct pclk_sel *pclk_sel;
 	unsigned int pclk_sel_shift;
 
@@ -160,6 +154,17 @@ struct gpt_clk_config {
 	struct gpt_clk_masks *masks;
 };
 
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
 /* platform specific clock functions */
 void clk_register(struct clk_lookup *cl);
 void recalc_root_clocks(void);
@@ -170,5 +175,6 @@ void pll_clk_recalc(struct clk *clk);
 void bus_clk_recalc(struct clk *clk);
 void gpt_clk_recalc(struct clk *clk);
 void aux_clk_recalc(struct clk *clk);
+void clcd_clk_recalc(struct clk *clk);
 
 #endif /* __PLAT_CLOCK_H */
-- 
1.7.2.2
