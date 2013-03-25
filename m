From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 25 Mar 2013 14:53:10 +0100
Subject: [PATCH 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <1364219596-4954-4-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use Cortex a9 cp15 to read scu baseaddress.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi |    5 +++++
 arch/arm/mach-zynq/common.c      |   33 +++++++++++++++++++++------------
 arch/arm/mach-zynq/common.h      |    2 ++
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 2a72339..4943568 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -22,6 +22,11 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		scu: scu at f8f000000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xf8f00000 0x58>;
+		};
+
 		intc: interrupt-controller at f8f01000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 68e0907..13f9d8b 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -33,10 +33,13 @@
 #include <asm/mach-types.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/smp_scu.h>
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
@@ -81,13 +73,30 @@ static void __init xilinx_zynq_timer_init(void)
 	clocksource_of_init();
 }
 
+static struct map_desc zynq_cortex_a9_scu_map __initdata = {
+	.length	= SZ_256,
+	.type	= MT_DEVICE,
+};
+
+static void __init scu_init(void)
+{
+	unsigned long base;
+
+	base = scu_a9_get_base();
+	zynq_cortex_a9_scu_map.pfn = __phys_to_pfn(base);
+	zynq_cortex_a9_scu_map.virtual = base;
+	iotable_init(&zynq_cortex_a9_scu_map, 1);
+	scu_base = ioremap(base, zynq_cortex_a9_scu_map.length);
+	BUG_ON(!scu_base);
+}
+
 /**
  * xilinx_map_io() - Create memory mappings needed for early I/O.
  */
 static void __init xilinx_map_io(void)
 {
 	debug_ll_io_init();
-	iotable_init(&scu_desc, 1);
+	scu_init();
 }
 
 static const char *xilinx_dt_match[] = {
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 5050bb1..38727a2 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -17,4 +17,6 @@
 #ifndef __MACH_ZYNQ_COMMON_H__
 #define __MACH_ZYNQ_COMMON_H__
 
+extern void __iomem *scu_base;
+
 #endif
-- 
1.7.9.7
