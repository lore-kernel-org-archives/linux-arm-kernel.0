From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 10 Jan 2014 11:15:42 +0800
Subject: [PATCH v5] ARM: prima2: move to generic reset controller driver
 framework
Message-ID: <1389323742-30263-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this moves to generic IP module reset framework, and make other drivers
use common device_reset() API.

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 -v5: move to subsys_init according to Arnd's feedback

 .../devicetree/bindings/reset/sirf,rstc.txt        |   42 +++++++++
 arch/arm/boot/dts/atlas6.dtsi                      |    3 +-
 arch/arm/boot/dts/marco.dtsi                       |    3 +-
 arch/arm/boot/dts/prima2.dtsi                      |    3 +-
 arch/arm/mach-prima2/Kconfig                       |    1 +
 arch/arm/mach-prima2/common.c                      |    2 +-
 arch/arm/mach-prima2/rstc.c                        |   93 ++++++++++++-------
 7 files changed, 109 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/sirf,rstc.txt

diff --git a/Documentation/devicetree/bindings/reset/sirf,rstc.txt b/Documentation/devicetree/bindings/reset/sirf,rstc.txt
new file mode 100644
index 0000000..0505de7
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/sirf,rstc.txt
@@ -0,0 +1,42 @@
+CSR SiRFSoC Reset Controller
+======================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: Should be "sirf,prima2-rstc" or "sirf,marco-rstc"
+- reg: should be register base and length as documented in the
+  datasheet
+- #reset-cells: 1, see below
+
+example:
+
+rstc: reset-controller at 88010000 {
+	compatible = "sirf,prima2-rstc";
+	reg = <0x88010000 0x1000>;
+	#reset-cells = <1>;
+};
+
+Specifying reset lines connected to IP modules
+==============================================
+
+The reset controller(rstc) manages various reset sources. This module provides
+reset signals for most blocks in system. Those device nodes should specify the
+reset line on the rstc in their resets property, containing a phandle to the
+rstc device node and a RESET_INDEX specifying which module to reset, as described
+in reset.txt.
+
+For SiRFSoC, RESET_INDEX is just reset_bit defined in SW_RST0 and SW_RST1 registers.
+For modules whose rest_bit is in SW_RST0, its RESET_INDEX is 0~31. For modules whose
+rest_bit is in SW_RST1, its RESET_INDEX is 32~63.
+
+example:
+
+vpp at 90020000 {
+	compatible = "sirf,prima2-vpp";
+	reg = <0x90020000 0x10000>;
+	interrupts = <31>;
+	clocks = <&clks 35>;
+	resets = <&rstc 6>;
+};
diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 978bab4..b63cfef 100644
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
index daee5894..b292a5c 100644
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
index d49aff7..26c6123 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -15,7 +15,7 @@
 #include <linux/of_platform.h>
 #include "common.h"
 
-void __init sirfsoc_init_late(void)
+static void __init sirfsoc_init_late(void)
 {
 	sirfsoc_pm_init();
 }
diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index ccb5339..a599767 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -13,57 +13,36 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
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
 		 * datasheet doesn't require explicit delay between the set and clear
 		 * of reset bit. it could be shorter if tests pass.
 		 */
-		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | reset_bit,
+		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | (1 << reset_bit),
 			sirfsoc_rstc_base + (reset_bit / 32) * 4);
 		msleep(10);
-		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~reset_bit,
+		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~(1 << reset_bit),
 			sirfsoc_rstc_base + (reset_bit / 32) * 4);
 	} else {
 		/*
@@ -73,9 +52,9 @@ int sirfsoc_reset_device(struct device *dev)
 		 * datasheet doesn't require explicit delay between the set and clear
 		 * of reset bit. it could be shorter if tests pass.
 		 */
-		writel(reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8);
+		writel(1 << reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8);
 		msleep(10);
-		writel(reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8 + 4);
+		writel(1 << reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8 + 4);
 	}
 
 	mutex_unlock(&rstc_lock);
@@ -83,6 +62,52 @@ int sirfsoc_reset_device(struct device *dev)
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
+static int sirfsoc_rstc_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	sirfsoc_rstc_base = of_iomap(np, 0);
+	if (!sirfsoc_rstc_base) {
+		dev_err(&pdev->dev, "unable to map rstc cpu registers\n");
+		return -ENOMEM;
+	}
+
+	sirfsoc_reset_controller.of_node = np;
+
+	reset_controller_register(&sirfsoc_reset_controller);
+
+	return 0;
+}
+
+static const struct of_device_id rstc_ids[]  = {
+	{ .compatible = "sirf,prima2-rstc" },
+	{ .compatible = "sirf,marco-rstc" },
+	{},
+};
+
+static struct platform_driver sirfsoc_rstc_driver = {
+	.probe		= sirfsoc_rstc_probe,
+	.driver		= {
+		.name	= "sirfsoc_rstc",
+		.owner	= THIS_MODULE,
+		.of_match_table = rstc_ids,
+	},
+};
+
+static int __init sirfsoc_rstc_init(void)
+{
+	return platform_driver_register(&sirfsoc_rstc_driver);
+}
+subsys_initcall(sirfsoc_rstc_init);
+
 #define SIRFSOC_SYS_RST_BIT  BIT(31)
 
 void sirfsoc_restart(enum reboot_mode mode, const char *cmd)
-- 
1.7.5.4
