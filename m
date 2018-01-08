From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:23 -0600
Subject: [PATCH v5 24/44] ARM: da850: add new clock init using common clock
 framework
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-25-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new board-specfic clock init in mach-davinci/da850.c using
the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Some CFGCHIP* #defines are removed since they are included in the
linux/mfd/da8xx-cfgchip.h header file.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da850.c | 74 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 34117e61..4804096 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -11,39 +11,44 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/clk/davinci.h>
 #include <linux/clkdev.h>
+#include <linux/cpufreq.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
-#include <linux/clk.h>
+#include <linux/log2.h>
+#include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_device.h>
-#include <linux/cpufreq.h>
 #include <linux/regulator/consumer.h>
-#include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach/map.h>
 
-#include "psc.h"
-#include <mach/irqs.h>
-#include <mach/cputype.h>
 #include <mach/common.h>
-#include <mach/time.h>
-#include <mach/da8xx.h>
 #include <mach/cpufreq.h>
+#include <mach/cputype.h>
+#include <mach/da8xx.h>
+#include <mach/irqs.h>
 #include <mach/pm.h>
+#include <mach/time.h>
 
-#include "clock.h"
 #include "mux.h"
 
+#ifndef CONFIG_COMMON_CLK
+#include "clock.h"
+#include "psc.h"
+#endif
+
 #define DA850_PLL1_BASE		0x01e1a000
 #define DA850_TIMER64P2_BASE	0x01f0c000
 #define DA850_TIMER64P3_BASE	0x01f0d000
 
 #define DA850_REF_FREQ		24000000
 
-#define CFGCHIP3_ASYNC3_CLKSRC	BIT(4)
-#define CFGCHIP3_PLL1_MASTER_LOCK	BIT(5)
-#define CFGCHIP0_PLL_MASTER_LOCK	BIT(4)
-
+#ifndef CONFIG_COMMON_CLK
 static int da850_set_armrate(struct clk *clk, unsigned long rate);
 static int da850_round_armrate(struct clk *clk, unsigned long rate);
 static int da850_set_pll0rate(struct clk *clk, unsigned long armrate);
@@ -583,6 +588,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("ecap.2",		"fck",		&ecap2_clk),
 	CLK(NULL,		NULL,		NULL),
 };
+#endif
 
 /*
  * Device specific mux setup
@@ -1170,6 +1176,7 @@ int da850_register_cpufreq(char *async_clk)
 	return platform_device_register(&da850_cpufreq_device);
 }
 
+#ifndef CONFIG_COMMON_CLK
 static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
 	int ret = 0, diff;
@@ -1232,12 +1239,14 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long rate)
 
 	return 0;
 }
+#endif /* CONFIG_COMMON_CLK */
 #else
 int __init da850_register_cpufreq(char *async_clk)
 {
 	return 0;
 }
 
+#ifndef CONFIG_COMMON_CLK
 static int da850_set_armrate(struct clk *clk, unsigned long rate)
 {
 	return -EINVAL;
@@ -1252,6 +1261,7 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
 	return clk->rate;
 }
+#endif /* CONFIG_COMMON_CLK */
 #endif
 
 /* VPIF resource, platform data */
@@ -1395,6 +1405,44 @@ void __init da850_init(void)
 
 void __init da850_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll0, *pll1, *psc0, *psc1;
+	struct clk *clk;
+	struct clk_hw *parent;
+
+	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
+	pll1 = ioremap(DA850_PLL1_BASE, SZ_4K);
+	psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
+	psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
+	da850_pll_clk_init(pll0, pll1);
+	clk = clk_register_mux(NULL, "async3",
+		(const char * const[]){ "pll0_sysclk2", "pll1_sysclk2" },
+		2, 0, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG),
+		ilog2(CFGCHIP3_ASYNC3_CLKSRC), 1, 0, NULL);
+	/* pll1_sysclk2 is not affected by CPU scaling, so use it for async3 */
+	parent = clk_hw_get_parent_by_index(__clk_get_hw(clk), 1);
+	if (parent)
+		clk_set_parent(clk, parent->clk);
+	else
+		pr_warn("%s: Failed to find async3 parent clock\n", __func__);
+	da850_psc_clk_init(psc0, psc1);
+	clk = clk_register_fixed_factor(NULL, "i2c0", "pll0_aux_clk", 0, 1, 1);
+	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
+	clk = clk_register_fixed_factor(NULL, "timer0", "pll0_aux_clk", 0, 1, 1);
+	clk_register_clkdev(clk, "timer0", NULL);
+	clk = clk_register_fixed_factor(NULL, "timer1", "pll0_aux_clk", 0, 1, 1);
+	clk_register_clkdev(clk, NULL, "davinci-wdt");
+	clk = clk_register_fixed_factor(NULL, "rmii", "pll0_sysclk7", 0, 1, 1);
+	clk_register_clkdev(clk, "rmii", NULL);
+	clk = clk_register_gate(NULL, "ehrpwm_tbclk", "ehrpwm", 0,
+				DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP1_REG),
+				ilog2(CFGCHIP1_TBCLKSYNC), 0, NULL);
+	clk_register_clkdev(clk, "tbclk", "ehrpwm.0");
+	clk_register_clkdev(clk, "tbclk", "ehrpwm.1");
+#else
 	davinci_clk_init(da850_clks);
+#endif
 	davinci_timer_init();
 }
-- 
2.7.4
