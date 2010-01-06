From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:05 -0800
Subject: [PATCH 23/35] davinci: da850/omap-l138: add support for SoC suspend
In-Reply-To: <1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-24-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch adds support for registering for suspend-to-RAM
functionality on da850/omap-l138 SoCs.

da850 supports wakeup based on external event and RTC
alarm.

Currently only RTC alarm based wakeup is supported.
Support for wakeup based on external event will be
added as later improvements.

For scheduling an alarm event on RTC some useful code
is present in Documentation/rtc.txt

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da850.c              |   39 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    4 +++
 arch/arm/mach-davinci/include/mach/mux.h   |    1 +
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 5c6dd97..f4d4da5 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -26,6 +26,7 @@
 #include <mach/time.h>
 #include <mach/da8xx.h>
 #include <mach/cpufreq.h>
+#include <mach/pm.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -536,6 +537,7 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, GPIO2_15,	5,	0,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_1,		10,	24,	15,	8,	false)
+	MUX_CFG(DA850, RTC_ALARM,	0,	28,	15,	2,	false)
 #endif
 };
 
@@ -1029,6 +1031,43 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 }
 #endif
 
+int da850_register_pm(struct platform_device *pdev)
+{
+	int ret;
+	struct davinci_pm_config *pdata = pdev->dev.platform_data;
+
+	ret = davinci_cfg_reg(DA850_RTC_ALARM);
+	if (ret)
+		return ret;
+
+	pdata->ddr2_ctlr_base = da8xx_get_mem_ctlr();
+	pdata->deepsleep_reg = DA8XX_SYSCFG1_VIRT(DA8XX_DEEPSLEEP_REG);
+	pdata->ddrpsc_num = DA8XX_LPSC1_EMIF3C;
+
+	pdata->cpupll_reg_base = ioremap(DA8XX_PLL0_BASE, SZ_4K);
+	if (!pdata->cpupll_reg_base)
+		return -ENOMEM;
+
+	pdata->ddrpll_reg_base = ioremap(DA8XX_PLL1_BASE, SZ_4K);
+	if (!pdata->ddrpll_reg_base) {
+		ret = -ENOMEM;
+		goto no_ddrpll_mem;
+	}
+
+	pdata->ddrpsc_reg_base = ioremap(DA8XX_PSC1_BASE, SZ_4K);
+	if (!pdata->ddrpsc_reg_base) {
+		ret = -ENOMEM;
+		goto no_ddrpsc_mem;
+	}
+
+	return platform_device_register(pdev);
+
+no_ddrpsc_mem:
+	iounmap(pdata->ddrpll_reg_base);
+no_ddrpll_mem:
+	iounmap(pdata->cpupll_reg_base);
+	return ret;
+}
 
 static struct davinci_soc_info davinci_soc_info_da850 = {
 	.io_desc		= da850_io_desc,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index d9a7f11..cc9be7f 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -20,6 +20,7 @@
 #include <mach/asp.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
+#include <mach/pm.h>
 
 extern void __iomem *da8xx_syscfg0_base;
 extern void __iomem *da8xx_syscfg1_base;
@@ -44,6 +45,7 @@ extern void __iomem *da8xx_syscfg1_base;
 
 #define DA8XX_SYSCFG1_BASE	(IO_PHYS + 0x22C000)
 #define DA8XX_SYSCFG1_VIRT(x)	(da8xx_syscfg1_base + (x))
+#define DA8XX_DEEPSLEEP_REG	0x8
 
 #define DA8XX_PSC0_BASE		0x01c10000
 #define DA8XX_PLL0_BASE		0x01c11000
@@ -52,6 +54,7 @@ extern void __iomem *da8xx_syscfg1_base;
 #define DA8XX_GPIO_BASE		0x01e26000
 #define DA8XX_PSC1_BASE		0x01e27000
 #define DA8XX_LCD_CNTRL_BASE	0x01e13000
+#define DA8XX_PLL1_BASE		0x01e1a000
 #define DA8XX_MMCSD0_BASE	0x01c40000
 #define DA8XX_AEMIF_CS2_BASE	0x60000000
 #define DA8XX_AEMIF_CS3_BASE	0x62000000
@@ -96,6 +99,7 @@ int da8xx_register_rtc(void);
 int da850_register_cpufreq(void);
 int da8xx_register_cpuidle(void);
 void __iomem * __init da8xx_get_mem_ctlr(void);
+int da850_register_pm(struct platform_device *pdev);
 
 extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index b60c693..137bfba 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -899,6 +899,7 @@ enum davinci_da850_index {
 	DA850_GPIO2_15,
 	DA850_GPIO4_0,
 	DA850_GPIO4_1,
+	DA850_RTC_ALARM,
 };
 
 #ifdef CONFIG_DAVINCI_MUX
-- 
1.6.6.rc2.1.g42108
