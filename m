From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 12 Dec 2011 21:46:54 +0000
Subject: [PATCH 5/5] ARM: picoxcell: implement watchdog restart
In-Reply-To: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
References: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1323726414-3319-6-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the platform to be restarted by triggering the watchdog to expire
with the shortest possible expiry.  This should reset the CPU core and
all on-chip peripherals.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/common.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index 88c53e0..6b39256 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -7,6 +7,7 @@
  *
  * All enquiries to support at picochip.com
  */
+#include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
@@ -23,6 +24,22 @@
 
 #include "common.h"
 
+#define WDT_CTRL_REG_EN_MASK	(1 << 0)
+#define WDT_CTRL_REG_OFFS	(0x00)
+#define WDT_TIMEOUT_REG_OFFS	(0x04)
+static void __iomem *wdt_regs;
+
+static void picoxcell_setup_restart(void)
+{
+	struct device_node *np = of_find_compatible_node(NULL, NULL,
+							 "snps,dw-apb-wdg");
+	if (WARN(!np, "unable to setup watchdog restart"))
+		return;
+
+	wdt_regs = of_iomap(np, 0);
+	WARN(!wdt_regs, "failed to remap watchdog regs");
+}
+
 static struct map_desc io_map __initdata = {
 	.virtual	= PHYS_TO_IO(PICOXCELL_PERIPH_BASE),
 	.pfn		= __phys_to_pfn(PICOXCELL_PERIPH_BASE),
@@ -38,6 +55,7 @@ static void __init picoxcell_map_io(void)
 static void __init picoxcell_init_machine(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	picoxcell_setup_restart();
 }
 
 static const char *picoxcell_dt_match[] = {
@@ -56,6 +74,19 @@ static void __init picoxcell_init_irq(void)
 	of_irq_init(vic_of_match);
 }
 
+static void picoxcell_wdt_restart(char mode, const char *cmd)
+{
+	/*
+	 * Configure the watchdog to reset with the shortest possible timeout
+	 * and give it chance to do the reset.
+	 */
+	if (wdt_regs) {
+		__raw_writel(WDT_CTRL_REG_EN_MASK, wdt_regs + WDT_CTRL_REG_OFFS);
+		__raw_writel(0, wdt_regs + WDT_TIMEOUT_REG_OFFS);
+		mdelay(500);
+	}
+}
+
 DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.map_io		= picoxcell_map_io,
 	.init_irq	= picoxcell_init_irq,
@@ -63,4 +94,5 @@ DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.timer		= &picoxcell_timer,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
+	.restart	= picoxcell_wdt_restart,
 MACHINE_END
-- 
1.7.5.4
