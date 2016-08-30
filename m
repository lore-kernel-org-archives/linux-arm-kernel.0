From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 15:59:29 +0200
Subject: [PATCH 3/3] ARM: integrator: read counter using syscon/regmap
In-Reply-To: <1472565569-11414-1-git-send-email-linus.walleij@linaro.org>
References: <1472565569-11414-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1472565569-11414-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Look up the core module base address from the device tree and
register a sched_clock() using the regmap to the core module
on the Integrator/CP.

MFD_SYSCON is selected by the arch so it is always available.

This further makes it possible to remove one more static map.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_cp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 8db029fa6052..772a7cf2010e 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -15,6 +15,8 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sched_clock.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -23,12 +25,15 @@
 #include "cm.h"
 #include "common.h"
 
+/* Base address to the core module header */
+static struct regmap *cm_map;
 /* Base address to the CP controller */
 static void __iomem *intcp_con_base;
 
+#define CM_COUNTER_OFFSET 0x28
+
 /*
  * Logical      Physical
- * f1000000	10000000	Core module registers
  * f1400000	14000000	Interrupt controller
  * f1600000	16000000	UART 0
  * fca00000	ca000000	SIC
@@ -36,11 +41,6 @@ static void __iomem *intcp_con_base;
 
 static struct map_desc intcp_io_desc[] __initdata __maybe_unused = {
 	{
-		.virtual	= IO_ADDRESS(INTEGRATOR_HDR_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_HDR_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_IC_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_IC_BASE),
 		.length		= SZ_4K,
@@ -84,15 +84,20 @@ static struct mmci_platform_data mmc_data = {
 	.gpio_cd	= -1,
 };
 
-#define REFCOUNTER (__io_address(INTEGRATOR_HDR_BASE) + 0x28)
-
 static u64 notrace intcp_read_sched_clock(void)
 {
-	return readl(REFCOUNTER);
+	unsigned int val;
+
+	/* MMIO so discard return code */
+	regmap_read(cm_map, CM_COUNTER_OFFSET, &val);
+	return val;
 }
 
 static void __init intcp_init_early(void)
 {
+	cm_map = syscon_regmap_lookup_by_compatible("arm,core-module-integrator");
+	if (IS_ERR(cm_map))
+		return;
 	sched_clock_register(intcp_read_sched_clock, 32, 24000000);
 }
 
-- 
2.7.4
