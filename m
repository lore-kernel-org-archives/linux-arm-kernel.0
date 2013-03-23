From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 23 Mar 2013 13:57:29 +0100
Subject: [PATCH 2/3] ARM: zynq: get slcr base earlier
In-Reply-To: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1364043450-18700-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The slcr is needed for pinctrl, clocks and reset. Therefore we want it as early
as possible. As there is no driver that handles it and instead a pointer needs
to be passed around, rename the variable to something a little more obvious.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/common.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 014131c..1b9bb3d 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -38,6 +38,7 @@
 
 #include "common.h"
 
+void __iomem *slcr_base_addr;
 void __iomem *scu_base;
 
 static struct of_device_id zynq_of_bus_ids[] __initdata = {
@@ -61,19 +62,21 @@ static void __init xilinx_init_machine(void)
 
 static void __init xilinx_zynq_timer_init(void)
 {
-	struct device_node *np;
-	void __iomem *slcr;
-
-	np = of_find_compatible_node(NULL, NULL, "xlnx,zynq-slcr");
-	slcr = of_iomap(np, 0);
-	WARN_ON(!slcr);
-
-	xilinx_zynq_clocks_init(slcr);
+	xilinx_zynq_clocks_init(slcr_base_addr);
 
 	twd_local_timer_of_register();
 	xttcps_timer_init();
 }
 
+static void zynq_slcr_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynq-slcr");
+	slcr_base_addr = of_iomap(np, 0);
+	WARN_ON(!slcr_base_addr);
+}
+
 static struct map_desc zynq_cortex_a9_scu_map __initdata = {
 	.length	= SZ_8K,
 	.type	= MT_DEVICE,
@@ -101,6 +104,12 @@ static void __init xilinx_map_io(void)
 	zynq_scu_map_io();
 }
 
+static void __init xilinx_irqchip_init(void)
+{
+	irqchip_init();
+	zynq_slcr_init();
+}
+
 static const char *xilinx_dt_match[] = {
 	"xlnx,zynq-zc702",
 	"xlnx,zynq-7000",
@@ -109,7 +118,7 @@ static const char *xilinx_dt_match[] = {
 
 MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.map_io		= xilinx_map_io,
-	.init_irq	= irqchip_init,
+	.init_irq	= xilinx_irqchip_init,
 	.init_machine	= xilinx_init_machine,
 	.init_time	= xilinx_zynq_timer_init,
 	.dt_compat	= xilinx_dt_match,
-- 
1.8.2.rc2
