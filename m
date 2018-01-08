From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:22 -0600
Subject: [PATCH v5 23/44] ARM: da830: add new clock init using common clock
 framework
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-24-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new board-specfic clock init in mach-davinci/da830.c using
the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da830.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 350d767..cbb351d 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -8,23 +8,29 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/clk/davinci.h>
+#include <linux/clkdev.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
-#include <linux/clk.h>
 #include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach/map.h>
 
-#include "psc.h"
-#include <mach/irqs.h>
-#include <mach/cputype.h>
 #include <mach/common.h>
-#include <mach/time.h>
+#include <mach/cputype.h>
 #include <mach/da8xx.h>
+#include <mach/irqs.h>
+#include <mach/time.h>
 
-#include "clock.h"
 #include "mux.h"
 
+#ifndef CONFIG_COMMON_CLK
+#include "clock.h"
+#include "psc.h"
+#endif
+
 /* Offsets of the 8 compare registers on the da830 */
 #define DA830_CMP12_0		0x60
 #define DA830_CMP12_1		0x64
@@ -37,6 +43,7 @@
 
 #define DA830_REF_FREQ		24000000
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll0_data = {
 	.num		= 1,
 	.phys_base	= DA8XX_PLL0_BASE,
@@ -432,6 +439,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK(NULL,		"rmii",		&rmii_clk),
 	CLK(NULL,		NULL,		NULL),
 };
+#endif
 
 /*
  * Device specific mux setup
@@ -1223,6 +1231,27 @@ void __init da830_init(void)
 
 void __init da830_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll0, *psc0, *psc1;
+	struct clk *clk;
+
+	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
+	psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
+	psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
+	da830_pll_clk_init(pll0);
+	da830_psc_clk_init(psc0, psc1);
+	clk = clk_register_fixed_factor(NULL, "i2c0", "pll0_aux_clk", 0, 1, 1);
+	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
+	clk = clk_register_fixed_factor(NULL, "timer0", "pll0_aux_clk", 0, 1, 1);
+	clk_register_clkdev(clk, "timer0", NULL);
+	clk = clk_register_fixed_factor(NULL, "timer1", "pll0_aux_clk", 0, 1, 1);
+	clk_register_clkdev(clk, NULL, "davinci-wdt");
+	clk = clk_register_fixed_factor(NULL, "rmii", "pll0_sysclk7", 0, 1, 1);
+	clk_register_clkdev(clk, "rmii", NULL);
+#else
 	davinci_clk_init(da830_clks);
+#endif
 	davinci_timer_init();
 }
-- 
2.7.4
