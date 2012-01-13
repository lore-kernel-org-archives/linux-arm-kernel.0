From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 13 Jan 2012 00:44:01 +0000
Subject: [PATCH 2/2] versatile: dt: register interrupt controllers from dt
In-Reply-To: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
References: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1326415441-17695-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the versatile_dt board to instantiate both interrupt controllers
from the device tree using the of_irq_init() helper.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-versatile/core.c         |   27 ++++++++-------------------
 arch/arm/mach-versatile/core.h         |    1 +
 arch/arm/mach-versatile/versatile_dt.c |   15 ++++++++++++++-
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index cbcda61..1ad2447 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -86,27 +86,9 @@ static struct fpga_irq_data sic_irq = {
 #define PIC_MASK	0
 #endif
 
-/* Lookup table for finding a DT node that represents the vic instance */
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,versatile-vic", },
-	{}
-};
-
-static const struct of_device_id sic_of_match[] __initconst = {
-	{ .compatible = "arm,versatile-sic", },
-	{}
-};
-
-void __init versatile_init_irq(void)
+void __init versatile_route_irqs(void)
 {
-	vic_init(VA_VIC_BASE, IRQ_VIC_START, ~0, 0);
-	irq_domain_generate_simple(vic_of_match, VERSATILE_VIC_BASE, IRQ_VIC_START);
-
 	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
-
-	fpga_irq_init(IRQ_VICSOURCE31, ~PIC_MASK, &sic_irq);
-	irq_domain_generate_simple(sic_of_match, VERSATILE_SIC_BASE, IRQ_SIC_START);
-
 	/*
 	 * Interrupts on secondary controller from 0 to 8 are routed to
 	 * source 31 on PIC.
@@ -117,6 +99,13 @@ void __init versatile_init_irq(void)
 	writel(PIC_MASK, VA_SIC_BASE + SIC_INT_PIC_ENABLE);
 }
 
+void __init versatile_init_irq(void)
+{
+	versatile_route_irqs();
+	vic_init(VA_VIC_BASE, IRQ_VIC_START, ~0, 0);
+	fpga_irq_init(IRQ_VICSOURCE31, ~PIC_MASK, &sic_irq);
+}
+
 static struct map_desc versatile_io_desc[] __initdata = {
 	{
 		.virtual	=  IO_ADDRESS(VERSATILE_SYS_BASE),
diff --git a/arch/arm/mach-versatile/core.h b/arch/arm/mach-versatile/core.h
index 2ef2f55..1117e32 100644
--- a/arch/arm/mach-versatile/core.h
+++ b/arch/arm/mach-versatile/core.h
@@ -29,6 +29,7 @@ extern void __init versatile_init(void);
 extern void __init versatile_init_early(void);
 extern void __init versatile_init_irq(void);
 extern void __init versatile_map_io(void);
+extern void __init versatile_route_irqs(void);
 extern struct sys_timer versatile_timer;
 extern void versatile_restart(char, const char *);
 extern unsigned int mmc_status(struct device *dev);
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index ae5ad3c..abb310d 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -27,6 +27,7 @@
 #include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <plat/fpga-irq.h>
 
 #include "core.h"
 
@@ -36,6 +37,18 @@ static void __init versatile_dt_init(void)
 			     versatile_auxdata_lookup, NULL);
 }
 
+static const struct of_device_id versatile_intc_of_match[] = {
+	{ .compatible = "arm,versatile-vic", .data = vic_of_init, },
+	{ .compatible = "arm,versatile-sic", .data = sic_of_init, },
+	{ /* Sentinel */ }
+};
+
+static void __init versatile_dt_init_irq(void)
+{
+	versatile_route_irqs();
+	of_irq_init(versatile_intc_of_match);
+}
+
 static const char *versatile_dt_match[] __initconst = {
 	"arm,versatile-ab",
 	"arm,versatile-pb",
@@ -45,7 +58,7 @@ static const char *versatile_dt_match[] __initconst = {
 DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
-	.init_irq	= versatile_init_irq,
+	.init_irq	= versatile_dt_init_irq,
 	.handle_irq	= vic_handle_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_dt_init,
-- 
1.7.5.4
