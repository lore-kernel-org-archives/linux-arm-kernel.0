From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:25 -0600
Subject: [PATCH v5 26/44] ARM: dm365: add new clock init using common clock
 framework
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-27-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new board-specfic clock init in mach-davinci/dm365.c using
the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm365.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1e3df9d..fbbe31c 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -12,32 +12,38 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
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
 #include <linux/platform_data/keyscan-davinci.h>
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
 
 #define DM365_REF_FREQ		24000000	/* 24 MHz on the DM365 EVM */
 #define DM365_RTC_BASE			0x01c69000
@@ -54,6 +60,7 @@
 #define DM365_EMAC_CNTRL_RAM_OFFSET	0x1000
 #define DM365_EMAC_CNTRL_RAM_SIZE	0x2000
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num		= 1,
 	.phys_base	= DAVINCI_PLL1_BASE,
@@ -485,7 +492,7 @@ static struct clk_lookup dm365_clks[] = {
 	CLK(NULL, "mjcp", &mjcp_clk),
 	CLK(NULL, NULL, NULL),
 };
-
+#endif
 /*----------------------------------------------------------------------*/
 
 #define INTMUX		0x18
@@ -1171,7 +1178,19 @@ void __init dm365_init(void)
 
 void __init dm365_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll1, *pll2, *psc;
+
+	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_4K);
+	pll2 = ioremap(DAVINCI_PLL2_BASE, SZ_4K);
+	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM365_REF_FREQ);
+	dm365_pll_clk_init(pll1, pll2);
+	dm365_psc_clk_init(psc);
+#else
 	davinci_clk_init(dm365_clks);
+#endif
 	davinci_timer_init();
 }
 
-- 
2.7.4
