From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:49 -0800
Subject: [PATCH 07/35] davinci: da850/omap-l138: unlock PLL registers during
	init
In-Reply-To: <1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

On omap-l1 devices the PLL registers can be locked from
writes. Currently the cpufreq rate setting code unlocks
PLL0 before the write actually happens. With suspend
support getting added PLL1 registers need be be unlocked
as well.

To facilitate this, unlock both PLLs during the init time
itself.

This also obviates the need to unlock PLL registers for
each CPUFreq transtition.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da850.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 4f84ab4..fcfde2a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -40,6 +40,7 @@
 #define DA850_REF_FREQ		24000000
 
 #define CFGCHIP3_ASYNC3_CLKSRC	BIT(4)
+#define CFGCHIP3_PLL1_MASTER_LOCK	BIT(5)
 #define CFGCHIP0_PLL_MASTER_LOCK	BIT(4)
 
 static int da850_set_armrate(struct clk *clk, unsigned long rate);
@@ -987,7 +988,6 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long index)
 	unsigned int prediv, mult, postdiv;
 	struct da850_opp *opp;
 	struct pll_data *pll = clk->pll_data;
-	unsigned int v;
 	int ret;
 
 	opp = (struct da850_opp *) da850_freq_table[index].index;
@@ -995,11 +995,6 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long index)
 	mult = opp->mult;
 	postdiv = opp->postdiv;
 
-	/* Unlock writing to PLL registers */
-	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
-	v &= ~CFGCHIP0_PLL_MASTER_LOCK;
-	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
-
 	ret = davinci_set_pllrate(pll, prediv, mult, postdiv);
 	if (WARN_ON(ret))
 		return ret;
@@ -1053,6 +1048,8 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 
 void __init da850_init(void)
 {
+	unsigned int v;
+
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
 	if (WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module"))
 		return;
@@ -1075,4 +1072,14 @@ void __init da850_init(void)
 	 * be any noticible change even in non-DVFS use cases.
 	 */
 	da850_set_async3_src(1);
+
+	/* Unlock writing to PLL0 registers */
+	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
+	v &= ~CFGCHIP0_PLL_MASTER_LOCK;
+	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
+
+	/* Unlock writing to PLL1 registers */
+	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
+	v &= ~CFGCHIP3_PLL1_MASTER_LOCK;
+	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 }
-- 
1.6.6.rc2.1.g42108
