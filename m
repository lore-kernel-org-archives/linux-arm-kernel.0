From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 14 Nov 2016 15:04:40 -0800
Subject: [PATCH 1/2] ARM: davinci: PM: rework init, support DT platforms
In-Reply-To: <20161114230441.356-1-khilman@baylibre.com>
References: <20161114230441.356-1-khilman@baylibre.com>
Message-ID: <20161114230441.356-2-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove fake platform device used for PM init.  Move pdata values which
are common across all current platforms into pm.c.

Also add PM support for DT platforms (vi da8xx-dt.c)

Suggested-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c    | 17 +-------
 arch/arm/mach-davinci/board-mityomapl138.c | 16 +-------
 arch/arm/mach-davinci/common.c             |  1 -
 arch/arm/mach-davinci/da850.c              | 38 ------------------
 arch/arm/mach-davinci/da8xx-dt.c           |  1 +
 arch/arm/mach-davinci/include/mach/da8xx.h |  1 -
 arch/arm/mach-davinci/pm.c                 | 64 ++++++++++++++++++------------
 7 files changed, 41 insertions(+), 97 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 8e4539f69fdc..4e88723c23c7 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -196,18 +196,6 @@ static struct platform_device da850_evm_norflash_device = {
 	.resource	= da850_evm_norflash_resource,
 };
 
-static struct davinci_pm_config da850_pm_pdata = {
-	.sleepcount = 128,
-};
-
-static struct platform_device da850_pm_device = {
-	.name           = "pm-davinci",
-	.dev = {
-		.platform_data	= &da850_pm_pdata,
-	},
-	.id             = -1,
-};
-
 /* DA850/OMAP-L138 EVM includes a 512 MByte large-page NAND flash
  * (128K blocks). It may be used instead of the (default) SPI flash
  * to boot, using TI's tools to install the secondary boot loader
@@ -1453,10 +1441,7 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: cpuidle registration failed: %d\n", __func__, ret);
 
-	ret = da850_register_pm(&da850_pm_device);
-	if (ret)
-		pr_warn("%s: suspend registration failed: %d\n", __func__, ret);
-
+	davinci_pm_init();
 	da850_vpif_init();
 
 	ret = spi_register_board_info(da850evm_spi_info,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index bc4e63fa9808..9e7388ba413c 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -498,18 +498,6 @@ static void __init mityomapl138_config_emac(void)
 		pr_warn("emac registration failed: %d\n", ret);
 }
 
-static struct davinci_pm_config da850_pm_pdata = {
-	.sleepcount = 128,
-};
-
-static struct platform_device da850_pm_device = {
-	.name	= "pm-davinci",
-	.dev = {
-		.platform_data  = &da850_pm_pdata,
-	},
-	.id	= -1,
-};
-
 static void __init mityomapl138_init(void)
 {
 	int ret;
@@ -555,9 +543,7 @@ static void __init mityomapl138_init(void)
 	if (ret)
 		pr_warn("cpuidle registration failed: %d\n", ret);
 
-	ret = da850_register_pm(&da850_pm_device);
-	if (ret)
-		pr_warn("suspend registration failed: %d\n", ret);
+	davinci_pm_init();
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index 049025f6d531..9f9fbfa6da0d 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -118,6 +118,5 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
 void __init davinci_init_late(void)
 {
 	davinci_cpufreq_init();
-	davinci_pm_init();
 	davinci_clk_disable_unused();
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index ed3d0e9f72ac..28771923199f 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1172,44 +1172,6 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 }
 #endif
 
-int __init da850_register_pm(struct platform_device *pdev)
-{
-	int ret;
-	struct davinci_pm_config *pdata = pdev->dev.platform_data;
-
-	ret = davinci_cfg_reg(DA850_RTC_ALARM);
-	if (ret)
-		return ret;
-
-	pdata->ddr2_ctlr_base = da8xx_get_mem_ctlr();
-	pdata->deepsleep_reg = DA8XX_SYSCFG1_VIRT(DA8XX_DEEPSLEEP_REG);
-	pdata->ddrpsc_num = DA8XX_LPSC1_EMIF3C;
-
-	pdata->cpupll_reg_base = ioremap(DA8XX_PLL0_BASE, SZ_4K);
-	if (!pdata->cpupll_reg_base)
-		return -ENOMEM;
-
-	pdata->ddrpll_reg_base = ioremap(DA850_PLL1_BASE, SZ_4K);
-	if (!pdata->ddrpll_reg_base) {
-		ret = -ENOMEM;
-		goto no_ddrpll_mem;
-	}
-
-	pdata->ddrpsc_reg_base = ioremap(DA8XX_PSC1_BASE, SZ_4K);
-	if (!pdata->ddrpsc_reg_base) {
-		ret = -ENOMEM;
-		goto no_ddrpsc_mem;
-	}
-
-	return platform_device_register(pdev);
-
-no_ddrpsc_mem:
-	iounmap(pdata->ddrpll_reg_base);
-no_ddrpll_mem:
-	iounmap(pdata->cpupll_reg_base);
-	return ret;
-}
-
 /* VPIF resource, platform data */
 static u64 da850_vpif_dma_mask = DMA_BIT_MASK(32);
 
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c9f7e9274aa8..aed44dcdfd30 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -46,6 +46,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 static void __init da850_init_machine(void)
 {
 	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
+	davinci_pm_init();
 }
 
 static const char *const da850_boards_compat[] __initconst = {
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index f9f9713aacdd..3d7a13789661 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -101,7 +101,6 @@ int da8xx_register_gpio(void *pdata);
 int da850_register_cpufreq(char *async_clk);
 int da8xx_register_cpuidle(void);
 void __iomem *da8xx_get_mem_ctlr(void);
-int da850_register_pm(struct platform_device *pdev);
 int da850_register_sata(unsigned long refclkpn);
 int da850_register_vpif(void);
 int da850_register_vpif_display
diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 8929569b1f8a..fc6a5710b3fa 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -23,13 +23,18 @@
 #include <mach/da8xx.h>
 #include "sram.h"
 #include <mach/pm.h>
+#include <mach/mux.h>
 
 #include "clock.h"
+#include "psc.h"
 
+#define DA850_PLL1_BASE		0x01e1a000
 #define DEEPSLEEP_SLEEPCOUNT_MASK	0xFFFF
+#define DEEPSLEEP_SLEEPCOUNT		128
 
 static void (*davinci_sram_suspend) (struct davinci_pm_config *);
-static struct davinci_pm_config *pdata;
+static struct davinci_pm_config pm_config;
+static struct davinci_pm_config *pdata = &pm_config;
 
 static void davinci_sram_push(void *dest, void *src, unsigned int size)
 {
@@ -117,17 +122,38 @@ static const struct platform_suspend_ops davinci_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
-static int __init davinci_pm_probe(struct platform_device *pdev)
+int __init davinci_pm_init(void)
 {
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "cannot get platform data\n");
-		return -ENOENT;
+	int ret;
+
+	ret = davinci_cfg_reg(DA850_RTC_ALARM);
+	if (ret)
+		return ret;
+
+	pdata->sleepcount = DEEPSLEEP_SLEEPCOUNT;
+	pdata->ddr2_ctlr_base = da8xx_get_mem_ctlr();
+	pdata->deepsleep_reg = DA8XX_SYSCFG1_VIRT(DA8XX_DEEPSLEEP_REG);
+	pdata->ddrpsc_num = DA8XX_LPSC1_EMIF3C;
+
+	pdata->cpupll_reg_base = ioremap(DA8XX_PLL0_BASE, SZ_4K);
+	if (!pdata->cpupll_reg_base)
+		return -ENOMEM;
+
+	pdata->ddrpll_reg_base = ioremap(DA850_PLL1_BASE, SZ_4K);
+	if (!pdata->ddrpll_reg_base) {
+		ret = -ENOMEM;
+		goto no_ddrpll_mem;
+	}
+
+	pdata->ddrpsc_reg_base = ioremap(DA8XX_PSC1_BASE, SZ_4K);
+	if (!pdata->ddrpsc_reg_base) {
+		ret = -ENOMEM;
+		goto no_ddrpsc_mem;
 	}
 
 	davinci_sram_suspend = sram_alloc(davinci_cpu_suspend_sz, NULL);
 	if (!davinci_sram_suspend) {
-		dev_err(&pdev->dev, "cannot allocate SRAM memory\n");
+		pr_err("PM: cannot allocate SRAM memory\n");
 		return -ENOMEM;
 	}
 
@@ -136,23 +162,9 @@ static int __init davinci_pm_probe(struct platform_device *pdev)
 
 	suspend_set_ops(&davinci_pm_ops);
 
-	return 0;
-}
-
-static int __exit davinci_pm_remove(struct platform_device *pdev)
-{
-	sram_free(davinci_sram_suspend, davinci_cpu_suspend_sz);
-	return 0;
-}
-
-static struct platform_driver davinci_pm_driver = {
-	.driver = {
-		.name	 = "pm-davinci",
-	},
-	.remove = __exit_p(davinci_pm_remove),
-};
-
-int __init davinci_pm_init(void)
-{
-	return platform_driver_probe(&davinci_pm_driver, davinci_pm_probe);
+no_ddrpsc_mem:
+	iounmap(pdata->ddrpll_reg_base);
+no_ddrpll_mem:
+	iounmap(pdata->cpupll_reg_base);
+	return ret;
 }
-- 
2.9.3
