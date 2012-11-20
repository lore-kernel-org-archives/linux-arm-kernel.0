From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:01:04 +0100
Subject: [PATCH 13/16] ARM: spear6xx: use common irqchip_init
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-14-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a common irqchip infrastructure, use it on the
spear6xx platform:

 * Use irqchip_init() as the ->irq_init() machine function. The
   irqchip infrastructure already knows about the compatible strings
   for the VIC IRQ controller driver.

 * No longer needed to set ->handle_irq() in the machine structure, as
   it will be set by the VIC IRQ controller driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-spear6xx/spear6xx.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 5a5a52d..1892b64 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -16,6 +16,7 @@
 #include <linux/amba/pl08x.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -425,20 +426,9 @@ static const char *spear600_dt_board_compat[] = {
 	NULL
 };
 
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
-	{ /* Sentinel */ }
-};
-
-static void __init spear6xx_dt_init_irq(void)
-{
-	of_irq_init(vic_of_match);
-}
-
 DT_MACHINE_START(SPEAR600_DT, "ST SPEAr600 (Flattened Device Tree)")
 	.map_io		=	spear6xx_map_io,
-	.init_irq	=	spear6xx_dt_init_irq,
-	.handle_irq	=	vic_handle_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear6xx_timer,
 	.init_machine	=	spear600_dt_init,
 	.restart	=	spear_restart,
-- 
1.7.9.5
