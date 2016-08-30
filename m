From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 15:59:28 +0200
Subject: [PATCH 2/3] ARM: integrator: cut down on static maps
In-Reply-To: <1472565569-11414-1-git-send-email-linus.walleij@linaro.org>
References: <1472565569-11414-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1472565569-11414-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes all the unused static maps on the Integrator/AP
and Integrator/CP and also take this opportunity to strip down
a big list of unused #includes from each boardfile.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c | 30 -----------------------------
 arch/arm/mach-integrator/integrator_cp.c | 33 --------------------------------
 2 files changed, 63 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index b17c68ff1b3e..a1af634f8709 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -17,35 +17,21 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/list.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/string.h>
 #include <linux/syscore_ops.h>
 #include <linux/amba/bus.h>
-#include <linux/amba/kmi.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
-#include <linux/platform_data/clk-integrator.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/stat.h>
 #include <linux/termios.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
-#include <asm/setup.h>
-#include <asm/param.h>		/* HZ */
-#include <asm/mach-types.h>
-
 #include <asm/mach/arch.h>
-#include <asm/mach/irq.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 
 #include "hardware.h"
 #include "cm.h"
@@ -67,14 +53,8 @@ static struct regmap *ap_syscon_map;
 
 /*
  * Logical      Physical
- * ef000000			Cache flush
- * f1100000	11000000	System controller registers
- * f1300000	13000000	Counter/Timer
  * f1400000	14000000	Interrupt controller
  * f1600000	16000000	UART 0
- * f1700000	17000000	UART 1
- * f1a00000	1a000000	Debug LEDs
- * f1b00000	1b000000	GPIO
  */
 
 static struct map_desc ap_io_desc[] __initdata __maybe_unused = {
@@ -88,16 +68,6 @@ static struct map_desc ap_io_desc[] __initdata __maybe_unused = {
 		.pfn		= __phys_to_pfn(INTEGRATOR_UART0_BASE),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
-	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_DBG_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_DBG_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_AP_GPIO_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_AP_GPIO_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
 	}
 };
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 1742bc76ccef..8db029fa6052 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -7,31 +7,17 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License.
  */
-#include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/list.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/string.h>
-#include <linux/device.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/kmi.h>
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
-#include <linux/gfp.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sched_clock.h>
 
-#include <asm/setup.h>
-#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/irq.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 
 #include "hardware.h"
 #include "cm.h"
@@ -43,12 +29,8 @@ static void __iomem *intcp_con_base;
 /*
  * Logical      Physical
  * f1000000	10000000	Core module registers
- * f1300000	13000000	Counter/Timer
  * f1400000	14000000	Interrupt controller
  * f1600000	16000000	UART 0
- * f1700000	17000000	UART 1
- * f1a00000	1a000000	Debug LEDs
- * fc900000	c9000000	GPIO
  * fca00000	ca000000	SIC
  */
 
@@ -59,11 +41,6 @@ static struct map_desc intcp_io_desc[] __initdata __maybe_unused = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_CT_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_CT_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_IC_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_IC_BASE),
 		.length		= SZ_4K,
@@ -74,16 +51,6 @@ static struct map_desc intcp_io_desc[] __initdata __maybe_unused = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_DBG_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_DBG_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_CP_GPIO_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_CP_GPIO_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_CP_SIC_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_CP_SIC_BASE),
 		.length		= SZ_4K,
-- 
2.7.4
