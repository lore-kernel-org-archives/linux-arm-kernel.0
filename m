From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:01:02 +0100
Subject: [PATCH 11/16] ARM: picoxcell: use common irqchip_init
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a common irqchip infrastructure, use it on the
picoxcell platform:

 * Use irqchip_init() as the ->irq_init() machine function. The
   irqchip infrastructure already knows about the compatible strings
   for the VIC IRQ controller driver.

 * No longer needed to set ->handle_irq() in the machine structure, as
   it will be set by the VIC IRQ controller driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-picoxcell/common.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index f6c0849..bf9f074 100644
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
@@ -70,16 +71,6 @@ static const char *picoxcell_dt_match[] = {
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
@@ -97,8 +88,7 @@ static void picoxcell_wdt_restart(char mode, const char *cmd)
 DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.map_io		= picoxcell_map_io,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= picoxcell_init_irq,
-	.handle_irq	= vic_handle_irq,
+	.init_irq	= irqchip_init,
 	.timer		= &dw_apb_timer,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
-- 
1.7.9.5
