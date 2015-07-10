From: b18965@freescale.com (Alison Wang)
Date: Fri, 10 Jul 2015 17:39:05 +0800
Subject: [PATCH] arm: ls1021a: utilize hrtimer based broadcast mode
Message-ID: <1436521145-21055-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hrtimer based broadcast mode is used instead of
periodic tick broadcast to provide high resolution
clock in SMP.

Signed-off-by: Alison Wang <alison.wang@freescale.com>
---
 arch/arm/mach-imx/mach-ls1021a.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-imx/mach-ls1021a.c b/arch/arm/mach-imx/mach-ls1021a.c
index b89c858..1a1a115 100644
--- a/arch/arm/mach-imx/mach-ls1021a.c
+++ b/arch/arm/mach-imx/mach-ls1021a.c
@@ -8,9 +8,19 @@
  */
 
 #include <asm/mach/arch.h>
+#include <linux/clk-provider.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
 
 #include "common.h"
 
+static void __init ls1021a_init_time(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+	tick_setup_hrtimer_broadcast();
+}
+
 static const char * const ls1021a_dt_compat[] __initconst = {
 	"fsl,ls1021a",
 	NULL,
@@ -18,5 +28,6 @@ static const char * const ls1021a_dt_compat[] __initconst = {
 
 DT_MACHINE_START(LS1021A, "Freescale LS1021A")
 	.smp		= smp_ops(ls1021a_smp_ops),
+	.init_time	= ls1021a_init_time,
 	.dt_compat	= ls1021a_dt_compat,
 MACHINE_END
-- 
2.1.0.27.g96db324
