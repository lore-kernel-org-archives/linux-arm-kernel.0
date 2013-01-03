From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:27 -0600
Subject: [PATCH v4 18/19] ARM: picoxcell: use common irqchip_init function
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-19-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/common.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index b17401ac..35ee214 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -9,6 +9,7 @@
  */
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -17,7 +18,6 @@
 #include <linux/dw_apb_timer.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach/map.h>
 
 #include "common.h"
@@ -70,16 +70,6 @@ static const char *picoxcell_dt_match[] = {
 	NULL
 };
 
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,pl192-vic", .data = vic_of_init, },
-	{ /* Sentinel */ }
-};
-
-static void __init picoxcell_init_irq(void)
-{
-	of_irq_init(vic_of_match);
-}
-
 static void picoxcell_wdt_restart(char mode, const char *cmd)
 {
 	/*
@@ -97,7 +87,7 @@ static void picoxcell_wdt_restart(char mode, const char *cmd)
 DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.map_io		= picoxcell_map_io,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= picoxcell_init_irq,
+	.init_irq	= irqchip_init,
 	.timer		= &dw_apb_timer,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
-- 
1.7.10.4
