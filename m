From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:14 -0500
Subject: [PATCH v2 04/11] ARM: integrator: convert to use irqchip_init
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Now that versatile-fpga irqchip has IRQCHIP_DECLARE support, the interrupt
related initialization can be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
v2:
- New patch
 arch/arm/mach-integrator/integrator_ap.c | 10 ++--------
 arch/arm/mach-integrator/integrator_cp.c | 10 ++--------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index dd0cc67..645da16 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -31,7 +31,7 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/irqchip/versatile-fpga.h>
+#include <linux/irqchip.h>
 #include <linux/mtd/physmap.h>
 #include <linux/clk.h>
 #include <linux/platform_data/clk-integrator.h>
@@ -439,15 +439,10 @@ static void __init ap_of_timer_init(void)
 	integrator_clockevent_init(rate, base, irq);
 }
 
-static const struct of_device_id fpga_irq_of_match[] __initconst = {
-	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
-	{ /* Sentinel */ }
-};
-
 static void __init ap_init_irq_of(void)
 {
 	cm_init();
-	of_irq_init(fpga_irq_of_match);
+	irqchip_init();
 }
 
 /* For the Device Tree, add in the UART callbacks as AUXDATA */
@@ -570,7 +565,6 @@ DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
 	.map_io		= ap_map_io,
 	.init_early	= ap_init_early,
 	.init_irq	= ap_init_irq_of,
-	.handle_irq	= fpga_handle_irq,
 	.init_time	= ap_of_timer_init,
 	.init_machine	= ap_init_of,
 	.restart	= integrator_restart,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index a938242..7ade590 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -20,7 +20,7 @@
 #include <linux/amba/clcd.h>
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
-#include <linux/irqchip/versatile-fpga.h>
+#include <linux/irqchip.h>
 #include <linux/gfp.h>
 #include <linux/mtd/physmap.h>
 #include <linux/of_irq.h>
@@ -235,15 +235,10 @@ static void __init intcp_init_early(void)
 	sched_clock_register(intcp_read_sched_clock, 32, 24000000);
 }
 
-static const struct of_device_id fpga_irq_of_match[] __initconst = {
-	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
-	{ /* Sentinel */ }
-};
-
 static void __init intcp_init_irq_of(void)
 {
 	cm_init();
-	of_irq_init(fpga_irq_of_match);
+	irqchip_init();
 }
 
 /*
@@ -340,7 +335,6 @@ DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
 	.map_io		= intcp_map_io,
 	.init_early	= intcp_init_early,
 	.init_irq	= intcp_init_irq_of,
-	.handle_irq	= fpga_handle_irq,
 	.init_machine	= intcp_init_of,
 	.restart	= integrator_restart,
 	.dt_compat      = intcp_dt_board_compat,
-- 
1.9.1
