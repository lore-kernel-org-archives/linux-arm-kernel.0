From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:17 +0530
Subject: [PATCH 54/74] ST SPEAr: SDHCI- selecting SD_MMC from misc and fixing
	sdhci_synth rate to 48 MHz
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <46c9d6b60cbdaf3f7d5a5f1bcce8db6bf69ad738.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/clock.c                  |    9 +++++----
 arch/arm/mach-spear13xx/include/mach/misc_regs.h |    5 +++++
 arch/arm/mach-spear13xx/spear13xx.c              |   12 +++++++++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 7f07911..33ec3ab 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -354,6 +354,7 @@ static struct aux_clk_config uart_synth_config = {
 /* aux rate configuration table, in ascending order of rates */
 struct aux_rate_tbl aux_rtbl[] = {
 	/* For PLL1div2 = 500 MHz */
+	{.xscale = 2, .yscale = 21, .eq = 1}, /* 48 MHz */
 	{.xscale = 1, .yscale = 6, .eq = 1}, /* 83 MHz */
 	{.xscale = 1, .yscale = 4, .eq = 1}, /* 125 MHz */
 	{.xscale = 1, .yscale = 3, .eq = 1}, /* 166 MHz */
@@ -368,7 +369,7 @@ static struct clk uart_synth_clk = {
 	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
 	.set_rate = &aux_clk_set_rate,
-	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 1},
 	.private_data = &uart_synth_config,
 };
 
@@ -414,7 +415,7 @@ static struct clk sdhci_synth_clk = {
 	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
 	.set_rate = &aux_clk_set_rate,
-	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
 	.private_data = &sdhci_synth_config,
 };
 
@@ -440,7 +441,7 @@ static struct clk cfxd_synth_clk = {
 	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
 	.set_rate = &aux_clk_set_rate,
-	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 2},
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
 	.private_data = &cfxd_synth_config,
 };
 
@@ -466,7 +467,7 @@ static struct clk c3_synth_clk = {
 	.calc_rate = &aux_calc_rate,
 	.recalc = &aux_clk_recalc,
 	.set_rate = &aux_clk_set_rate,
-	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 1},
 	.private_data = &c3_synth_config,
 };
 
diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
index 2db1ffe..3cfd4fc 100644
--- a/arch/arm/mach-spear13xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
@@ -228,6 +228,11 @@
 
 #define PCIE_MIPHY_CFG		((unsigned int *)(MISC_BASE + 0x328))
 #define PERIP_CFG		((unsigned int *)(MISC_BASE + 0x32c))
+	#define MCIF_SEL_SHIFT	3
+	#define MCIF_SEL_MASK	0x3
+	#define SD_MMC_ACTIVE	0x1
+	#define CF_MMC_ACTIVE	0x2
+	#define XD_MMC_ACTIVE	0x3
 #define FSMC_CFG		((unsigned int *)(MISC_BASE + 0x330))
 	/* FSMC_CFG register masks */
 	#define FSMC_MEMSEL_MASK	0x3
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 0f42522..48cdff2 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -369,6 +369,16 @@ struct platform_device smi_device = {
 	.resource = smi_resources,
 };
 
+static void sdhci_enable(void)
+{
+	unsigned val = readl(PERIP_CFG);
+
+	/* This function enables SD/MMC interface out of SD/MMC, CF, XD */
+	val &= ~(MCIF_SEL_MASK << MCIF_SEL_SHIFT);
+	val |= SD_MMC_ACTIVE << MCIF_SEL_SHIFT;
+	writel(val, PERIP_CFG);
+}
+
 #ifdef CONFIG_PCIEPORTBUS
 /* PCIE0 clock always needs to be enabled if any of the three PCIE port
  * have to be used. So call this function from the board initilization
@@ -516,7 +526,7 @@ struct platform_device pcie_gadget2_device = {
 /* Do spear13xx familiy common initialization part here */
 void __init spear13xx_init(void)
 {
-	/* nothing to do for now */
+	sdhci_enable();
 }
 
 /* This will initialize vic */
-- 
1.7.2.2
