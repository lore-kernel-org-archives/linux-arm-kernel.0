From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:14:04 -0600
Subject: [PATCH v6 25/41] ARM: dm646x: add new clock init using common clock
 framework
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-26-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new board-specific clock init in mach-davinci/dm646x.c
using the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- add blank lines between function calls

 arch/arm/mach-davinci/dm646x.c | 44 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 109ab1f..ee07e41 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -8,29 +8,35 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/clk/davinci.h>
+#include <linux/clkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/serial_8250.h>
-#include <linux/platform_device.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
 
 #include <asm/mach/map.h>
 
+#include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include "psc.h"
 #include <mach/mux.h>
-#include <mach/time.h>
 #include <mach/serial.h>
-#include <mach/common.h>
+#include <mach/time.h>
 
+#include "asp.h"
 #include "davinci.h"
-#include "clock.h"
 #include "mux.h"
-#include "asp.h"
+
+#ifndef CONFIG_COMMON_CLK
+#include "clock.h"
+#include "psc.h"
+#endif
 
 #define DAVINCI_VPIF_BASE       (0x01C12000)
 
@@ -46,6 +52,7 @@
 #define DM646X_EMAC_CNTRL_RAM_OFFSET	0x2000
 #define DM646X_EMAC_CNTRL_RAM_SIZE	0x2000
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
@@ -356,6 +363,7 @@ static struct clk_lookup dm646x_clks[] = {
 	CLK(NULL, "vpif1", &vpif1_clk),
 	CLK(NULL, NULL, NULL),
 };
+#endif
 
 static struct emac_platform_data dm646x_emac_pdata = {
 	.ctrl_reg_offset	= DM646X_EMAC_CNTRL_OFFSET,
@@ -953,9 +961,29 @@ void __init dm646x_init(void)
 void __init dm646x_init_time(unsigned long ref_clk_rate,
 			     unsigned long aux_clkin_rate)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll1, *pll2, *psc;
+	struct clk *clk;
+
+	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_4K);
+	pll2 = ioremap(DAVINCI_PLL2_BASE, SZ_4K);
+	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
+	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
+
+	dm646x_pll_clk_init(pll1, pll2);
+
+	dm646x_psc_clk_init(psc);
+
+	/* no LPSC, always enabled; c.f. spruep9a */
+	clk = clk_register_fixed_factor(NULL, "timer2", "pll1_sysclk3", 0, 1, 1);
+	clk_register_clkdev(clk, NULL, "davinci-wdt");
+#else
 	ref_clk.rate = ref_clk_rate;
 	aux_clkin.rate = aux_clkin_rate;
 	davinci_clk_init(dm646x_clks);
+#endif
 	davinci_timer_init();
 }
 
-- 
2.7.4
