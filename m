From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:14:00 -0600
Subject: [PATCH v6 21/41] ARM: da850: add new clock init using common clock
 framework
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-22-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new board-specific clock init in mach-davinci/da850.c
using the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- add blank lines between function calls
- include da8xx_register_cfgchip()
- add async1 and async2 clock domains

 arch/arm/mach-davinci/da850.c | 79 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 5c86d77..0fdf647 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -11,37 +11,44 @@
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
-#include <linux/platform_device.h>
-#include <linux/cpufreq.h>
 #include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/platform_data/gpio-davinci.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
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
 
+#ifndef CONFIG_COMMON_CLK
 static int da850_set_armrate(struct clk *clk, unsigned long rate);
 static int da850_round_armrate(struct clk *clk, unsigned long rate);
 static int da850_set_pll0rate(struct clk *clk, unsigned long armrate);
@@ -581,6 +588,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("ecap.2",		"fck",		&ecap2_clk),
 	CLK(NULL,		NULL,		NULL),
 };
+#endif
 
 /*
  * Device specific mux setup
@@ -1168,6 +1176,7 @@ int da850_register_cpufreq(char *async_clk)
 	return platform_device_register(&da850_cpufreq_device);
 }
 
+#ifndef CONFIG_COMMON_CLK
 static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
 	int ret = 0, diff;
@@ -1230,12 +1239,14 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long rate)
 
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
@@ -1250,6 +1261,7 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
 	return clk->rate;
 }
+#endif /* CONFIG_COMMON_CLK */
 #endif
 
 /* VPIF resource, platform data */
@@ -1381,6 +1393,52 @@ void __init da850_init(void)
 
 void __init da850_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll0, *pll1, *psc0, *psc1;
+	struct regmap *cfgchip;
+	struct clk *clk;
+	struct clk_hw *parent;
+
+	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
+	pll1 = ioremap(DA850_PLL1_BASE, SZ_4K);
+	psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
+	psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
+
+	cfgchip = da8xx_register_cfgchip();
+	if (WARN(IS_ERR(cfgchip), "failed to register CFGCHIP syscon"))
+		return;
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
+
+	da850_pll_clk_init(pll0, pll1);
+
+	da8xx_cfgchip_register_div4p5(cfgchip);
+
+	da8xx_cfgchip_register_async1(cfgchip);
+
+	clk = clk_register_fixed_factor(NULL, "async2", "pll0_auxclk", 0, 1, 1);
+	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
+	clk_register_clkdev(clk, "timer0", NULL);
+	clk_register_clkdev(clk, NULL, "davinci-wdt");
+
+	clk = da8xx_cfgchip_register_async3(cfgchip);
+
+	/* pll1_sysclk2 is not affected by CPU scaling, so use it for async3 */
+	parent = clk_hw_get_parent_by_index(__clk_get_hw(clk), 1);
+	if (parent)
+		clk_set_parent(clk, parent->clk);
+	else
+		pr_warn("%s: Failed to find async3 parent clock\n", __func__);
+
+	da850_psc_clk_init(psc0, psc1);
+
+	clk = clk_register_fixed_factor(NULL, "rmii", "pll0_sysclk7", 0, 1, 1);
+	clk_register_clkdev(clk, "rmii", NULL);
+
+	clk = da8xx_cfgchip_register_tbclk(cfgchip);
+	clk_register_clkdev(clk, "tbclk", "ehrpwm.0");
+	clk_register_clkdev(clk, "tbclk", "ehrpwm.1");
+#else
 	struct regmap *cfgchip;
 
 	cfgchip = da8xx_register_cfgchip();
@@ -1392,5 +1450,6 @@ void __init da850_init_time(void)
 	regmap_write_bits(cfgchip, CFGCHIP(3), CFGCHIP3_PLL1_MASTER_LOCK, 0);
 
 	davinci_clk_init(da850_clks);
+#endif
 	davinci_timer_init();
 }
-- 
2.7.4
