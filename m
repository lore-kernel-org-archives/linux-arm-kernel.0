From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:26 -0600
Subject: [PATCH v5 27/44] ARM: dm644x: add new clock init using common clock
 framework
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-28-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new board-specfic clock init in mach-davinci/dm644x.c using
the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm644x.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b409801..bc2e243 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -8,28 +8,34 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/init.h>
+#include <linux/clk-provider.h>
 #include <linux/clk.h>
-#include <linux/serial_8250.h>
+#include <linux/clk/davinci.h>
+#include <linux/clkdev.h>
 #include <linux/dmaengine.h>
-#include <linux/platform_device.h>
+#include <linux/init.h>
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
 
 /*
  * Device specific clocks
@@ -43,6 +49,7 @@
 #define DM644X_EMAC_CNTRL_RAM_OFFSET	0x2000
 #define DM644X_EMAC_CNTRL_RAM_SIZE	0x2000
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
@@ -326,6 +333,7 @@ static struct clk_lookup dm644x_clks[] = {
 	CLK("davinci-wdt", NULL, &timer2_clk),
 	CLK(NULL, NULL, NULL),
 };
+#endif
 
 static struct emac_platform_data dm644x_emac_pdata = {
 	.ctrl_reg_offset	= DM644X_EMAC_CNTRL_OFFSET,
@@ -934,7 +942,19 @@ void __init dm644x_init(void)
 
 void __init dm644x_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll1, *pll2, *psc;
+
+	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_4K);
+	pll2 = ioremap(DAVINCI_PLL2_BASE, SZ_4K);
+	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
+	dm644x_pll_clk_init(pll1, pll2);
+	dm644x_psc_clk_init(psc);
+#else
 	davinci_clk_init(dm644x_clks);
+#endif
 	davinci_timer_init();
 }
 
-- 
2.7.4
