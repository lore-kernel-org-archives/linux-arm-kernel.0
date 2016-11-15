From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 15 Nov 2016 11:54:20 -0800
Subject: [PATCH v2 2/3] ARM: davinci: PM: cleanup: remove references to pdata
In-Reply-To: <20161115195421.19983-1-khilman@baylibre.com>
References: <20161115195421.19983-1-khilman@baylibre.com>
Message-ID: <20161115195421.19983-3-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the PM core code is no longer using a fake platform_device or
platform_data, remove references to 'pdata'.

No functional changes.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/pm.c | 57 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 3f1fb191c03f..0afd201ab980 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -37,7 +37,6 @@ static struct davinci_pm_config pm_config = {
 	.sleepcount = DEEPSLEEP_SLEEPCOUNT,
 	.ddrpsc_num = DA8XX_LPSC1_EMIF3C,
 };
-static struct davinci_pm_config *pdata = &pm_config;
 
 static void davinci_sram_push(void *dest, void *src, unsigned int size)
 {
@@ -49,58 +48,58 @@ static void davinci_pm_suspend(void)
 {
 	unsigned val;
 
-	if (pdata->cpupll_reg_base != pdata->ddrpll_reg_base) {
+	if (pm_config.cpupll_reg_base != pm_config.ddrpll_reg_base) {
 
 		/* Switch CPU PLL to bypass mode */
-		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val = __raw_readl(pm_config.cpupll_reg_base + PLLCTL);
 		val &= ~(PLLCTL_PLLENSRC | PLLCTL_PLLEN);
-		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+		__raw_writel(val, pm_config.cpupll_reg_base + PLLCTL);
 
 		udelay(PLL_BYPASS_TIME);
 
 		/* Powerdown CPU PLL */
-		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val = __raw_readl(pm_config.cpupll_reg_base + PLLCTL);
 		val |= PLLCTL_PLLPWRDN;
-		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+		__raw_writel(val, pm_config.cpupll_reg_base + PLLCTL);
 	}
 
 	/* Configure sleep count in deep sleep register */
-	val = __raw_readl(pdata->deepsleep_reg);
+	val = __raw_readl(pm_config.deepsleep_reg);
 	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK,
-	val |= pdata->sleepcount;
-	__raw_writel(val, pdata->deepsleep_reg);
+	val |= pm_config.sleepcount;
+	__raw_writel(val, pm_config.deepsleep_reg);
 
 	/* System goes to sleep in this call */
-	davinci_sram_suspend(pdata);
+	davinci_sram_suspend(&pm_config);
 
-	if (pdata->cpupll_reg_base != pdata->ddrpll_reg_base) {
+	if (pm_config.cpupll_reg_base != pm_config.ddrpll_reg_base) {
 
 		/* put CPU PLL in reset */
-		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val = __raw_readl(pm_config.cpupll_reg_base + PLLCTL);
 		val &= ~PLLCTL_PLLRST;
-		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+		__raw_writel(val, pm_config.cpupll_reg_base + PLLCTL);
 
 		/* put CPU PLL in power down */
-		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val = __raw_readl(pm_config.cpupll_reg_base + PLLCTL);
 		val &= ~PLLCTL_PLLPWRDN;
-		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+		__raw_writel(val, pm_config.cpupll_reg_base + PLLCTL);
 
 		/* wait for CPU PLL reset */
 		udelay(PLL_RESET_TIME);
 
 		/* bring CPU PLL out of reset */
-		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val = __raw_readl(pm_config.cpupll_reg_base + PLLCTL);
 		val |= PLLCTL_PLLRST;
-		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+		__raw_writel(val, pm_config.cpupll_reg_base + PLLCTL);
 
 		/* Wait for CPU PLL to lock */
 		udelay(PLL_LOCK_TIME);
 
 		/* Remove CPU PLL from bypass mode */
-		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val = __raw_readl(pm_config.cpupll_reg_base + PLLCTL);
 		val &= ~PLLCTL_PLLENSRC;
 		val |= PLLCTL_PLLEN;
-		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+		__raw_writel(val, pm_config.cpupll_reg_base + PLLCTL);
 	}
 }
 
@@ -133,21 +132,21 @@ int __init davinci_pm_init(void)
 	if (ret)
 		return ret;
 
-	pdata->ddr2_ctlr_base = da8xx_get_mem_ctlr();
-	pdata->deepsleep_reg = DA8XX_SYSCFG1_VIRT(DA8XX_DEEPSLEEP_REG);
+	pm_config.ddr2_ctlr_base = da8xx_get_mem_ctlr();
+	pm_config.deepsleep_reg = DA8XX_SYSCFG1_VIRT(DA8XX_DEEPSLEEP_REG);
 
-	pdata->cpupll_reg_base = ioremap(DA8XX_PLL0_BASE, SZ_4K);
-	if (!pdata->cpupll_reg_base)
+	pm_config.cpupll_reg_base = ioremap(DA8XX_PLL0_BASE, SZ_4K);
+	if (!pm_config.cpupll_reg_base)
 		return -ENOMEM;
 
-	pdata->ddrpll_reg_base = ioremap(DA850_PLL1_BASE, SZ_4K);
-	if (!pdata->ddrpll_reg_base) {
+	pm_config.ddrpll_reg_base = ioremap(DA850_PLL1_BASE, SZ_4K);
+	if (!pm_config.ddrpll_reg_base) {
 		ret = -ENOMEM;
 		goto no_ddrpll_mem;
 	}
 
-	pdata->ddrpsc_reg_base = ioremap(DA8XX_PSC1_BASE, SZ_4K);
-	if (!pdata->ddrpsc_reg_base) {
+	pm_config.ddrpsc_reg_base = ioremap(DA8XX_PSC1_BASE, SZ_4K);
+	if (!pm_config.ddrpsc_reg_base) {
 		ret = -ENOMEM;
 		goto no_ddrpsc_mem;
 	}
@@ -164,8 +163,8 @@ int __init davinci_pm_init(void)
 	suspend_set_ops(&davinci_pm_ops);
 
 no_ddrpsc_mem:
-	iounmap(pdata->ddrpll_reg_base);
+	iounmap(pm_config.ddrpll_reg_base);
 no_ddrpll_mem:
-	iounmap(pdata->cpupll_reg_base);
+	iounmap(pm_config.cpupll_reg_base);
 	return ret;
 }
-- 
2.9.3
