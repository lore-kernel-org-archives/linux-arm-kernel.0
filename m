From: david@lechnology.com (David Lechner)
Date: Thu, 15 Mar 2018 21:52:44 -0500
Subject: [PATCH v8 28/42] ARM: davinci: da8xx: add new sata_refclk init using
 common clock framework
In-Reply-To: <1521168778-27236-1-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
Message-ID: <1521168778-27236-29-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new SATA REFCLK clock init in mach-davinci/devices-da8xx.c
using the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also, the #includes are sorted since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v8 changes:
- none

v7 changes:
- none

v6 changes:
- none

 arch/arm/mach-davinci/devices-da8xx.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 78390c6..73de449 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -10,25 +10,30 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/dma-contiguous.h>
-#include <linux/serial_8250.h>
 #include <linux/ahci_platform.h>
+#include <linux/clk-provider.h>
 #include <linux/clk.h>
-#include <linux/reboot.h>
+#include <linux/clkdev.h>
+#include <linux/dma-contiguous.h>
 #include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/serial_8250.h>
 
-#include <mach/cputype.h>
 #include <mach/common.h>
-#include <mach/time.h>
+#include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/clock.h>
+#include <mach/time.h>
+
+#include "asp.h"
 #include "cpuidle.h"
 #include "sram.h"
 
+#ifndef CONFIG_COMMON_CLK
+#include <mach/clock.h>
 #include "clock.h"
-#include "asp.h"
+#endif
 
 #define DA8XX_TPCC_BASE			0x01c00000
 #define DA8XX_TPTC0_BASE		0x01c08000
@@ -1040,6 +1045,7 @@ int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
 }
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
+#ifndef CONFIG_COMMON_CLK
 static struct clk sata_refclk = {
 	.name		= "sata_refclk",
 	.set_rate	= davinci_simple_set_rate,
@@ -1061,6 +1067,18 @@ int __init da850_register_sata_refclk(int rate)
 
 	return 0;
 }
+#else
+int __init da850_register_sata_refclk(int rate)
+{
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "sata_refclk", NULL, 0, rate);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	return clk_register_clkdev(clk, "refclk", "ahci_da850");
+}
+#endif
 
 static struct resource da850_sata_resources[] = {
 	{
-- 
2.7.4
