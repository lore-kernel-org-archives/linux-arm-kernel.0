From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 23 Mar 2013 13:57:28 +0100
Subject: [PATCH 1/3] ARM: zynq: read scu base from SoC
In-Reply-To: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1364043450-18700-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of hardcoding the base address of the SCU get it from the device.
While at it, add the SCU to the DT.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi |  5 +++++
 arch/arm/mach-zynq/common.c      | 34 ++++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 88564fa..c103082 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -199,6 +199,11 @@
 			};
 		};
 
+		scu: scu at f8f000000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xf8f00000 0x58>;
+		};
+
 		timer: timer at f8f00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xf8f00600 0x20>;
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 920e20a..014131c 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -32,11 +32,14 @@
 #include <asm/mach-types.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include "common.h"
 
+void __iomem *scu_base;
+
 static struct of_device_id zynq_of_bus_ids[] __initdata = {
 	{ .compatible = "simple-bus", },
 	{}
@@ -56,17 +59,6 @@ static void __init xilinx_init_machine(void)
 	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
 }
 
-#define SCU_PERIPH_PHYS		0xF8F00000
-#define SCU_PERIPH_SIZE		SZ_8K
-#define SCU_PERIPH_VIRT		(VMALLOC_END - SCU_PERIPH_SIZE)
-
-static struct map_desc scu_desc __initdata = {
-	.virtual	= SCU_PERIPH_VIRT,
-	.pfn		= __phys_to_pfn(SCU_PERIPH_PHYS),
-	.length		= SCU_PERIPH_SIZE,
-	.type		= MT_DEVICE,
-};
-
 static void __init xilinx_zynq_timer_init(void)
 {
 	struct device_node *np;
@@ -82,13 +74,31 @@ static void __init xilinx_zynq_timer_init(void)
 	xttcps_timer_init();
 }
 
+static struct map_desc zynq_cortex_a9_scu_map __initdata = {
+	.length	= SZ_8K,
+	.type	= MT_DEVICE,
+};
+
+void __init zynq_scu_map_io(void)
+{
+	if (scu_a9_has_base()) {
+		unsigned long base;
+
+		base = scu_a9_get_base();
+		zynq_cortex_a9_scu_map.pfn = __phys_to_pfn(base);
+		zynq_cortex_a9_scu_map.virtual = base;
+		iotable_init(&zynq_cortex_a9_scu_map, 1);
+		scu_base = ioremap(base, zynq_cortex_a9_scu_map.length);
+	}
+}
+
 /**
  * xilinx_map_io() - Create memory mappings needed for early I/O.
  */
 static void __init xilinx_map_io(void)
 {
 	debug_ll_io_init();
-	iotable_init(&scu_desc, 1);
+	zynq_scu_map_io();
 }
 
 static const char *xilinx_dt_match[] = {
-- 
1.8.2.rc2
