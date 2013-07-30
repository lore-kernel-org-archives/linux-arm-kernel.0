From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 30 Jul 2013 17:05:59 +0800
Subject: [PATCH v2] arm: prima2: move to generic reset controller driver
 framework
Message-ID: <1375175159-13953-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this moves to generic IP module reset framework, and make other drivers
use common device_reset() API.

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2: rebase againest 3.11-rc;
 move the init function to init_machine to avoid redundant calling
 for non-csr platforms of multi-platform;

 arch/arm/boot/dts/atlas6.dtsi |  3 +-
 arch/arm/boot/dts/marco.dtsi  |  3 +-
 arch/arm/boot/dts/prima2.dtsi |  3 +-
 arch/arm/mach-prima2/Kconfig  |  1 +
 arch/arm/mach-prima2/common.c | 12 +++++++-
 arch/arm/mach-prima2/common.h |  1 +
 arch/arm/mach-prima2/rstc.c   | 72 +++++++++++++++++++++++++------------------
 7 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 9866cd7..e3f3ec8 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -56,9 +56,10 @@
 				#clock-cells = <1>;
 			};
 
-			reset-controller at 88010000 {
+			rstc: reset-controller at 88010000 {
 				compatible = "sirf,prima2-rstc";
 				reg = <0x88010000 0x1000>;
+				#reset-cells = <1>;
 			};
 
 			rsc-controller at 88020000 {
diff --git a/arch/arm/boot/dts/marco.dtsi b/arch/arm/boot/dts/marco.dtsi
index 1579c34..0c9647d 100644
--- a/arch/arm/boot/dts/marco.dtsi
+++ b/arch/arm/boot/dts/marco.dtsi
@@ -58,9 +58,10 @@
 			#size-cells = <1>;
 			ranges = <0xc2000000 0xc2000000 0x1000000>;
 
-			reset-controller at c2000000 {
+			rstc: reset-controller at c2000000 {
 				compatible = "sirf,marco-rstc";
 				reg = <0xc2000000 0x10000>;
+				#reset-cells = <1>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 05e9489..3560ad3 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -67,9 +67,10 @@
 				#clock-cells = <1>;
 			};
 
-			reset-controller at 88010000 {
+			rstc: reset-controller at 88010000 {
 				compatible = "sirf,prima2-rstc";
 				reg = <0x88010000 0x1000>;
+				#reset-cells = <1>;
 			};
 
 			rsc-controller at 88020000 {
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 6988b11..f37a1de 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_SIRF
 	bool "CSR SiRF" if ARCH_MULTI_V7
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 2c70f74..73db0dc 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -16,7 +16,14 @@
 #include <linux/of_platform.h>
 #include "common.h"
 
-void __init sirfsoc_init_late(void)
+static void __init sirfsoc_init_mach(void)
+{
+        sirfsoc_of_rstc_init();
+        of_platform_populate(NULL, of_default_bus_match_table,
+                NULL, NULL);
+}
+
+static void __init sirfsoc_init_late(void)
 {
 	sirfsoc_pm_init();
 }
@@ -45,6 +52,7 @@ DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	.nr_irqs	= 128,
 	.map_io         = sirfsoc_map_io,
 	.init_time	= sirfsoc_init_time,
+	.init_machine   = sirfsoc_init_mach,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = atlas6_dt_match,
 	.restart	= sirfsoc_restart,
@@ -62,6 +70,7 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	.nr_irqs	= 128,
 	.map_io         = sirfsoc_map_io,
 	.init_time	= sirfsoc_init_time,
+	.init_machine   = sirfsoc_init_mach,
 	.dma_zone_size	= SZ_256M,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = prima2_dt_match,
@@ -80,6 +89,7 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	.smp            = smp_ops(sirfsoc_smp_ops),
 	.map_io         = sirfsoc_map_io,
 	.init_time	= sirfsoc_init_time,
+	.init_machine   = sirfsoc_init_mach,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = marco_dt_match,
 	.restart	= sirfsoc_restart,
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index a630485..aaf8d5a 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -22,6 +22,7 @@ extern struct smp_operations   sirfsoc_smp_ops;
 extern void sirfsoc_secondary_startup(void);
 extern void sirfsoc_cpu_die(unsigned int cpu);
 
+extern void __init sirfsoc_of_rstc_init(void);
 extern void __init sirfsoc_of_irq_init(void);
 extern void __init sirfsoc_of_clk_init(void);
 extern void sirfsoc_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index ccb5339..fee28d8 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -14,46 +14,24 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/reboot.h>
+#include <linux/reset-controller.h>
+
+#define SIRFSOC_RSTBIT_NUM	64
 
 void __iomem *sirfsoc_rstc_base;
 static DEFINE_MUTEX(rstc_lock);
 
-static struct of_device_id rstc_ids[]  = {
-	{ .compatible = "sirf,prima2-rstc" },
-	{ .compatible = "sirf,marco-rstc" },
-	{},
-};
-
-static int __init sirfsoc_of_rstc_init(void)
-{
-	struct device_node *np;
-
-	np = of_find_matching_node(NULL, rstc_ids);
-	if (!np) {
-		pr_err("unable to find compatible sirf rstc node in dtb\n");
-		return -ENOENT;
-	}
-
-	sirfsoc_rstc_base = of_iomap(np, 0);
-	if (!sirfsoc_rstc_base)
-		panic("unable to map rstc cpu registers\n");
-
-	of_node_put(np);
-
-	return 0;
-}
-early_initcall(sirfsoc_of_rstc_init);
-
-int sirfsoc_reset_device(struct device *dev)
+static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
+					unsigned long sw_reset_idx)
 {
-	u32 reset_bit;
+	u32 reset_bit = sw_reset_idx;
 
-	if (of_property_read_u32(dev->of_node, "reset-bit", &reset_bit))
+	if (reset_bit >= SIRFSOC_RSTBIT_NUM)
 		return -EINVAL;
 
 	mutex_lock(&rstc_lock);
 
-	if (of_device_is_compatible(dev->of_node, "sirf,prima2-rstc")) {
+	if (of_device_is_compatible(rcdev->of_node, "sirf,prima2-rstc")) {
 		/*
 		 * Writing 1 to this bit resets corresponding block. Writing 0 to this
 		 * bit de-asserts reset signal of the corresponding block.
@@ -83,6 +61,40 @@ int sirfsoc_reset_device(struct device *dev)
 	return 0;
 }
 
+static struct reset_control_ops sirfsoc_rstc_ops = {
+	.reset = sirfsoc_reset_module,
+};
+
+static struct reset_controller_dev sirfsoc_reset_controller = {
+	.ops = &sirfsoc_rstc_ops,
+	.nr_resets = SIRFSOC_RSTBIT_NUM,
+};
+
+static struct of_device_id rstc_ids[]  = {
+	{ .compatible = "sirf,prima2-rstc" },
+	{ .compatible = "sirf,marco-rstc" },
+	{},
+};
+
+void __init sirfsoc_of_rstc_init(void)
+{
+	struct device_node *np = of_find_matching_node(NULL, rstc_ids);
+	if (!np) {
+		pr_err("unable to find compatible sirf rstc node in dtb\n");
+		return;
+	}
+
+	sirfsoc_rstc_base = of_iomap(np, 0);
+	if (!sirfsoc_rstc_base) {
+		pr_err("unable to map rstc cpu registers\n");
+		return;
+	}
+
+	sirfsoc_reset_controller.of_node = np;
+
+	reset_controller_register(&sirfsoc_reset_controller);
+}
+
 #define SIRFSOC_SYS_RST_BIT  BIT(31)
 
 void sirfsoc_restart(enum reboot_mode mode, const char *cmd)
-- 
1.8.2.3
