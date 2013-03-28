From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Mar 2013 17:38:05 +0100
Subject: [PATCH v3 05/12] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
References: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <f83f076bba0504a971707773627fecc42f592e2e.1364488495.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use Cortex a9 cp15 to read scu baseaddress.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>

---
v3: Rename scu_base to zynq_scu_base

v2: Remove dynamic mapping because it is probably not needed
    (code taken from vexpress platsmp code)
    Remove scu node from DTS
    Use zynq_scu_map_io() instead of scu_init() as Steffen suggested
    Add comment to scu_init to be sure that we know what we are doing here
---
 arch/arm/mach-zynq/common.c |   34 ++++++++++++++++++++++------------
 arch/arm/mach-zynq/common.h |    2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 68e0907..f9e5f3a 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -33,10 +33,13 @@
 #include <asm/mach-types.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/smp_scu.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include "common.h"
 
+void __iomem *zynq_scu_base;
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
@@ -81,13 +73,31 @@ static void __init xilinx_zynq_timer_init(void)
 	clocksource_of_init();
 }
 
+static struct map_desc zynq_cortex_a9_scu_map __initdata = {
+	.length	= SZ_256,
+	.type	= MT_DEVICE,
+};
+
+static void __init zynq_scu_map_io(void)
+{
+	unsigned long base;
+
+	base = scu_a9_get_base();
+	zynq_cortex_a9_scu_map.pfn = __phys_to_pfn(base);
+	/* Expected address is in vmalloc area that's why simple assign here */
+	zynq_cortex_a9_scu_map.virtual = base;
+	iotable_init(&zynq_cortex_a9_scu_map, 1);
+	zynq_scu_base = (void __iomem *)base;
+	BUG_ON(!zynq_scu_base);
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
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 5050bb1..d7164d5 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -17,4 +17,6 @@
 #ifndef __MACH_ZYNQ_COMMON_H__
 #define __MACH_ZYNQ_COMMON_H__
 
+extern void __iomem *zynq_scu_base;
+
 #endif
-- 
1.7.9.7
