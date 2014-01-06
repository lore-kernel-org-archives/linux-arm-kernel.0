From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Jan 2014 15:36:38 +0100
Subject: [PATCH 2/7] ARM: zynq: Split slcr in two parts
In-Reply-To: <cover.1389018985.git.michal.simek@xilinx.com>
References: <cover.1389018985.git.michal.simek@xilinx.com>
Message-ID: <a350cc21baf4ab36c96b7f21e9507d6390b01de0.1389018985.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split the slcr into an early part for unlocking and cpu starting
and a later syscon driver.
Also add "syscon" compatible property for slcr.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi |  2 +-
 arch/arm/mach-zynq/Kconfig       |  1 +
 arch/arm/mach-zynq/common.c      |  4 +++-
 arch/arm/mach-zynq/common.h      |  1 +
 arch/arm/mach-zynq/slcr.c        | 20 ++++++++++++++++++++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 93d1980..81e5677 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -123,7 +123,7 @@
 		} ;

 		slcr: slcr at f8000000 {
-			compatible = "xlnx,zynq-slcr";
+			compatible = "xlnx,zynq-slcr", "syscon";
 			reg = <0xF8000000 0x1000>;

 			clocks {
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 6b04260..323e505 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -14,5 +14,6 @@ config ARCH_ZYNQ
 	select SPARSE_IRQ
 	select CADENCE_TTC_TIMER
 	select ARM_GLOBAL_TIMER
+	select MFD_SYSCON
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index bf6717f..38401cf 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -59,11 +59,13 @@ static void __init zynq_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);

 	platform_device_register(&zynq_cpuidle_device);
+
+	zynq_slcr_init();
 }

 static void __init zynq_timer_init(void)
 {
-	zynq_slcr_init();
+	zynq_early_slcr_init();

 	zynq_clock_init(zynq_slcr_base);
 	clocksource_of_init();
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index c22c92c..1548b85 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -20,6 +20,7 @@
 void zynq_secondary_startup(void);

 extern int zynq_slcr_init(void);
+extern int zynq_early_slcr_init(void);
 extern void zynq_slcr_system_reset(void);
 extern void zynq_slcr_cpu_stop(int cpu);
 extern void zynq_slcr_cpu_start(int cpu);
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 59ad09f..9746de7 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -15,7 +15,9 @@
  */

 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/clk/zynq.h>
 #include "common.h"

@@ -30,6 +32,7 @@
 #define SLCR_A9_CPU_RST			0x1

 void __iomem *zynq_slcr_base;
+static struct regmap *zynq_slcr_regmap;

 /**
  * zynq_slcr_system_reset - Reset the entire system.
@@ -87,6 +90,23 @@ void zynq_slcr_cpu_stop(int cpu)
  */
 int __init zynq_slcr_init(void)
 {
+	zynq_slcr_regmap = syscon_regmap_lookup_by_compatible("xlnx,zynq-slcr");
+	if (IS_ERR(zynq_slcr_regmap)) {
+		pr_err("%s: failed to find zynq-slcr\n", __func__);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/**
+ * zynq_early_slcr_init
+ * Returns 0 on success, negative errno otherwise.
+ *
+ * Called very early during boot from platform code to unlock SLCR.
+ */
+int __init zynq_early_slcr_init(void)
+{
 	struct device_node *np;

 	np = of_find_compatible_node(NULL, NULL, "xlnx,zynq-slcr");
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/963a3065/attachment.sig>
