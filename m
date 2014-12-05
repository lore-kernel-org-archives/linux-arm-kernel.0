From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 5 Dec 2014 17:07:29 +0800
Subject: [PATCH] arm: ls1021a: setup hrtimer based tick broadcast
Message-ID: <1417770449-3492-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds setup of hrtimer based tick broadcast to utilize
the hrtimer in SMP without other broadcast tick devices.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 arch/arm/mach-imx/mach-ls1021a.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-imx/mach-ls1021a.c b/arch/arm/mach-imx/mach-ls1021a.c
index b89c858..4d074cf 100644
--- a/arch/arm/mach-imx/mach-ls1021a.c
+++ b/arch/arm/mach-imx/mach-ls1021a.c
@@ -7,6 +7,10 @@
  * (at your option) any later version.
  */
 
+#include <linux/clockchips.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+
 #include <asm/mach/arch.h>
 
 #include "common.h"
@@ -16,7 +20,15 @@ static const char * const ls1021a_dt_compat[] __initconst = {
 	NULL,
 };
 
+static void __init ls1021a_init_time(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+	tick_setup_hrtimer_broadcast();
+}
+
 DT_MACHINE_START(LS1021A, "Freescale LS1021A")
 	.smp		= smp_ops(ls1021a_smp_ops),
+	.init_time	= ls1021a_init_time,
 	.dt_compat	= ls1021a_dt_compat,
 MACHINE_END
-- 
1.8.0
