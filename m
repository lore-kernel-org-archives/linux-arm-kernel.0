From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:24 -0600
Subject: [PATCH v5 25/44] ARM: dm355: add new clock init using common clock
 framework
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-26-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new board-specfic clock init in mach-davinci/dm355.c using
the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm355.c | 47 +++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index f294804..f087840 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -8,31 +8,37 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/init.h>
+#include <linux/clk-provider.h>
 #include <linux/clk.h>
-#include <linux/serial_8250.h>
-#include <linux/platform_device.h>
+#include <linux/clk/davinci.h>
+#include <linux/clkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/spi/spi.h>
+#include <linux/init.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/spi-davinci.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach/map.h>
 
+#include <mach/common.h>
 #include <mach/cputype.h>
-#include "psc.h"
-#include <mach/mux.h>
 #include <mach/irqs.h>
-#include <mach/time.h>
+#include <mach/mux.h>
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
 
 #define DM355_UART2_BASE	(IO_PHYS + 0x206000)
 #define DM355_OSD_BASE		(IO_PHYS + 0x70200)
@@ -43,6 +49,7 @@
  */
 #define DM355_REF_FREQ		24000000	/* 24 or 36 MHz */
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
@@ -382,7 +389,7 @@ static struct clk_lookup dm355_clks[] = {
 	CLK(NULL, "usb", &usb_clk),
 	CLK(NULL, NULL, NULL),
 };
-
+#endif
 /*----------------------------------------------------------------------*/
 
 static u64 dm355_spi0_dma_mask = DMA_BIT_MASK(32);
@@ -1046,7 +1053,25 @@ void __init dm355_init(void)
 
 void __init dm355_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll1, *pll2, *psc;
+
+	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_4K);
+	pll2 = ioremap(DAVINCI_PLL2_BASE, SZ_4K);
+	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM355_REF_FREQ);
+	dm355_pll_clk_init(pll1, pll2);
+	dm355_psc_clk_init(psc);
+
+	/* NOTE:  clkout1 can be externally gated by muxing GPIO-18 */
+	clk_register_fixed_factor(NULL, "clkout1", "pll1_aux_clk", 0, 1, 1);
+	clk_register_fixed_factor(NULL, "clkout2", "pll1_sysclkbp", 0, 1, 1);
+	/* NOTE:  clkout3 can be externally gated by muxing GPIO-16 */
+	clk_register_fixed_factor(NULL, "clkout3", "pll2_sysclkbp", 0, 1, 1);
+#else
 	davinci_clk_init(dm355_clks);
+#endif
 	davinci_timer_init();
 }
 
-- 
2.7.4
