From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 17:08:33 +0200
Subject: [PATCH 5/6 v3] ARM: integrator: move CM base into device tree
Message-ID: <1381417713-6826-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the core module (CM) control base into the device
tree. It is a simple memory range of 0x200 bytes. Move the
cm header down into the machine directory and unexport the
cm_control() symbol as no modules are using it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Actually git add the changes too. Mea culpa. Maybe I need
  coffee?
ChangeLog v1->v2:
- Clarify and extend the documentation for the CM node and
  its required regs propery.
---
 Documentation/devicetree/bindings/arm/arm-boards |  19 ++++
 arch/arm/boot/dts/integrator.dtsi                |   5 +
 arch/arm/mach-integrator/cm.h                    |  40 ++++++++
 arch/arm/mach-integrator/core.c                  | 120 +++++++++++++++--------
 arch/arm/mach-integrator/include/mach/cm.h       |  38 -------
 arch/arm/mach-integrator/integrator_ap.c         |   6 +-
 arch/arm/mach-integrator/integrator_cp.c         |   3 +-
 arch/arm/mach-integrator/leds.c                  |   3 +-
 8 files changed, 148 insertions(+), 86 deletions(-)
 create mode 100644 arch/arm/mach-integrator/cm.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/cm.h

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 5fdd7b9..0ebf3d9 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -11,6 +11,20 @@ FPGA type interrupt controllers, see the versatile-fpga-irq binding doc.
 
 Required nodes:
 
+- core-module: the root node to the Integrator platforms must have
+  a core-module with regs and the compatible string
+  "arm,core-module-integrator"
+
+  Required properties for the core module:
+  - regs: the location and size of the core module registers, one
+    range of 0x200 bytes.
+
+- cpcon/syscon: the root node the Integrator/CP must have a /cpcon
+  node pointing to the CP control registers, and the Integrator/AP
+  must have a /syscon node pointing to the Integrator/AP system
+  controller. The AP syscon node must include the logical module
+  interrupts.
+
 In the root node the Integrator/CP must have a /cpcon node pointing
 to the CP control registers, and the Integrator/AP must have a
 /syscon node pointing to the Integrator/AP system controller.
@@ -25,6 +39,11 @@ example:
 	model = "ARM Integrator/AP";
 	compatible = "arm,integrator-ap";
 
+	core-module at 10000000 {
+		compatible = "arm,core-module-integrator";
+		reg = <0x10000000 0x200>;
+	};
+
 	syscon {
 		/* AP system controller registers */
 		reg = <0x11000000 0x100>;
diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 813b91d..0f06f86 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -5,6 +5,11 @@
 /include/ "skeleton.dtsi"
 
 / {
+	core-module at 10000000 {
+		compatible = "arm,core-module-integrator";
+		reg = <0x10000000 0x200>;
+	};
+
 	timer at 13000000 {
 		reg = <0x13000000 0x100>;
 		interrupt-parent = <&pic>;
diff --git a/arch/arm/mach-integrator/cm.h b/arch/arm/mach-integrator/cm.h
new file mode 100644
index 0000000..2ba8be0
--- /dev/null
+++ b/arch/arm/mach-integrator/cm.h
@@ -0,0 +1,40 @@
+/*
+ * update the core module control register.
+ */
+void cm_control(u32, u32);
+
+struct device_node;
+void cm_init(void);
+void cm_clear_irqs(void);
+
+#define CM_CTRL_LED			(1 << 0)
+#define CM_CTRL_nMBDET			(1 << 1)
+#define CM_CTRL_REMAP			(1 << 2)
+#define CM_CTRL_RESET			(1 << 3)
+
+/*
+ * Integrator/AP,PP2 specific
+ */
+#define CM_CTRL_HIGHVECTORS		(1 << 4)
+#define CM_CTRL_BIGENDIAN		(1 << 5)
+#define CM_CTRL_FASTBUS			(1 << 6)
+#define CM_CTRL_SYNC			(1 << 7)
+
+/*
+ * ARM926/946/966 Integrator/CP specific
+ */
+#define CM_CTRL_LCDBIASEN		(1 << 8)
+#define CM_CTRL_LCDBIASUP		(1 << 9)
+#define CM_CTRL_LCDBIASDN		(1 << 10)
+#define CM_CTRL_LCDMUXSEL_MASK		(7 << 11)
+#define CM_CTRL_LCDMUXSEL_GENLCD	(1 << 11)
+#define CM_CTRL_LCDMUXSEL_VGA565_TFT555	(2 << 11)
+#define CM_CTRL_LCDMUXSEL_SHARPLCD	(3 << 11)
+#define CM_CTRL_LCDMUXSEL_VGA555_TFT555	(4 << 11)
+#define CM_CTRL_LCDEN0			(1 << 14)
+#define CM_CTRL_LCDEN1			(1 << 15)
+#define CM_CTRL_STATIC1			(1 << 16)
+#define CM_CTRL_STATIC2			(1 << 17)
+#define CM_CTRL_STATIC			(1 << 18)
+#define CM_CTRL_n24BITEN		(1 << 19)
+#define CM_CTRL_EBIWP			(1 << 20)
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index e31483a..28bb033 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -22,18 +22,21 @@
 #include <linux/amba/serial.h>
 #include <linux/io.h>
 #include <linux/stat.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <mach/cm.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/time.h>
 #include <asm/pgtable.h>
 
+#include "cm.h"
 #include "common.h"
 
 static DEFINE_RAW_SPINLOCK(cm_lock);
+static void __iomem *cm_base;
 
 /**
  * cm_control - update the CM_CTRL register.
@@ -46,12 +49,80 @@ void cm_control(u32 mask, u32 set)
 	u32 val;
 
 	raw_spin_lock_irqsave(&cm_lock, flags);
-	val = readl(CM_CTRL) & ~mask;
-	writel(val | set, CM_CTRL);
+	val = readl(cm_base + INTEGRATOR_HDR_CTRL_OFFSET) & ~mask;
+	writel(val | set, cm_base + INTEGRATOR_HDR_CTRL_OFFSET);
 	raw_spin_unlock_irqrestore(&cm_lock, flags);
 }
 
-EXPORT_SYMBOL(cm_control);
+static const char *integrator_arch_str(u32 id)
+{
+	switch ((id >> 16) & 0xff) {
+	case 0x00:
+		return "ASB little-endian";
+	case 0x01:
+		return "AHB little-endian";
+	case 0x03:
+		return "AHB-Lite system bus, bi-endian";
+	case 0x04:
+		return "AHB";
+	case 0x08:
+		return "AHB system bus, ASB processor bus";
+	default:
+		return "Unknown";
+	}
+}
+
+static const char *integrator_fpga_str(u32 id)
+{
+	switch ((id >> 12) & 0xf) {
+	case 0x01:
+		return "XC4062";
+	case 0x02:
+		return "XC4085";
+	case 0x03:
+		return "XVC600";
+	case 0x04:
+		return "EPM7256AE (Altera PLD)";
+	default:
+		return "Unknown";
+	}
+}
+
+void cm_clear_irqs(void)
+{
+	/* disable core module IRQs */
+	writel(0xffffffffU, cm_base + INTEGRATOR_HDR_IC_OFFSET +
+		IRQ_ENABLE_CLEAR);
+}
+
+static const struct of_device_id cm_match[] = {
+	{ .compatible = "arm,core-module-integrator"},
+	{ },
+};
+
+void cm_init(void)
+{
+	struct device_node *cm = of_find_matching_node(NULL, cm_match);
+	u32 val;
+
+	if (!cm) {
+		pr_crit("no core module node found in device tree\n");
+		return;
+	}
+	cm_base = of_iomap(cm, 0);
+	if (!cm_base) {
+		pr_crit("could not remap core module\n");
+		return;
+	}
+	cm_clear_irqs();
+	val = readl(cm_base + INTEGRATOR_HDR_ID_OFFSET);
+	pr_info("Detected ARM core module:\n");
+	pr_info("    Manufacturer: %02x\n", (val >> 24));
+	pr_info("    Architecture: %s\n", integrator_arch_str(val));
+	pr_info("    FPGA: %s\n", integrator_fpga_str(val));
+	pr_info("    Build: %02x\n", (val >> 4) & 0xFF);
+	pr_info("    Rev: %c\n", ('A' + (val & 0x03)));
+}
 
 /*
  * We need to stop things allocating the low memory; ideally we need a
@@ -87,27 +158,7 @@ static ssize_t intcp_get_arch(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	const char *arch;
-
-	switch ((integrator_id >> 16) & 0xff) {
-	case 0x00:
-		arch = "ASB little-endian";
-		break;
-	case 0x01:
-		arch = "AHB little-endian";
-		break;
-	case 0x03:
-		arch = "AHB-Lite system bus, bi-endian";
-		break;
-	case 0x04:
-		arch = "AHB";
-		break;
-	default:
-		arch = "Unknown";
-		break;
-	}
-
-	return sprintf(buf, "%s\n", arch);
+	return sprintf(buf, "%s\n", integrator_arch_str(integrator_id));
 }
 
 static struct device_attribute intcp_arch_attr =
@@ -117,24 +168,7 @@ static ssize_t intcp_get_fpga(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	const char *fpga;
-
-	switch ((integrator_id >> 12) & 0xf) {
-	case 0x01:
-		fpga = "XC4062";
-		break;
-	case 0x02:
-		fpga = "XC4085";
-		break;
-	case 0x04:
-		fpga = "EPM7256AE (Altera PLD)";
-		break;
-	default:
-		fpga = "Unknown";
-		break;
-	}
-
-	return sprintf(buf, "%s\n", fpga);
+	return sprintf(buf, "%s\n", integrator_fpga_str(integrator_id));
 }
 
 static struct device_attribute intcp_fpga_attr =
diff --git a/arch/arm/mach-integrator/include/mach/cm.h b/arch/arm/mach-integrator/include/mach/cm.h
deleted file mode 100644
index 202e6a5..0000000
--- a/arch/arm/mach-integrator/include/mach/cm.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * update the core module control register.
- */
-void cm_control(u32, u32);
-
-#define CM_CTRL	__io_address(INTEGRATOR_HDR_CTRL)
-
-#define CM_CTRL_LED			(1 << 0)
-#define CM_CTRL_nMBDET			(1 << 1)
-#define CM_CTRL_REMAP			(1 << 2)
-#define CM_CTRL_RESET			(1 << 3)
-
-/*
- * Integrator/AP,PP2 specific
- */
-#define CM_CTRL_HIGHVECTORS		(1 << 4)
-#define CM_CTRL_BIGENDIAN		(1 << 5)
-#define CM_CTRL_FASTBUS			(1 << 6)
-#define CM_CTRL_SYNC			(1 << 7)
-
-/*
- * ARM926/946/966 Integrator/CP specific
- */
-#define CM_CTRL_LCDBIASEN		(1 << 8)
-#define CM_CTRL_LCDBIASUP		(1 << 9)
-#define CM_CTRL_LCDBIASDN		(1 << 10)
-#define CM_CTRL_LCDMUXSEL_MASK		(7 << 11)
-#define CM_CTRL_LCDMUXSEL_GENLCD	(1 << 11)
-#define CM_CTRL_LCDMUXSEL_VGA565_TFT555	(2 << 11)
-#define CM_CTRL_LCDMUXSEL_SHARPLCD	(3 << 11)
-#define CM_CTRL_LCDMUXSEL_VGA555_TFT555	(4 << 11)
-#define CM_CTRL_LCDEN0			(1 << 14)
-#define CM_CTRL_LCDEN1			(1 << 15)
-#define CM_CTRL_STATIC1			(1 << 16)
-#define CM_CTRL_STATIC2			(1 << 17)
-#define CM_CTRL_STATIC			(1 << 18)
-#define CM_CTRL_n24BITEN		(1 << 19)
-#define CM_CTRL_EBIWP			(1 << 20)
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 88a62a5..ece4755 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -57,6 +57,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
+#include "cm.h"
 #include "common.h"
 #include "pci_v3.h"
 
@@ -145,7 +146,7 @@ static int irq_suspend(void)
 static void irq_resume(void)
 {
 	/* disable all irq sources */
-	writel(-1, VA_CMIC_BASE + IRQ_ENABLE_CLEAR);
+	cm_clear_irqs();
 	writel(-1, VA_IC_BASE + IRQ_ENABLE_CLEAR);
 	writel(-1, VA_IC_BASE + FIQ_ENABLE_CLEAR);
 
@@ -447,8 +448,7 @@ static const struct of_device_id fpga_irq_of_match[] __initconst = {
 
 static void __init ap_init_irq_of(void)
 {
-	/* disable core module IRQs */
-	writel(0xffffffffU, VA_CMIC_BASE + IRQ_ENABLE_CLEAR);
+	cm_init();
 	of_irq_init(fpga_irq_of_match);
 	integrator_clk_init(false);
 }
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 26b3441..422c3f9 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -36,7 +36,6 @@
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
-#include <mach/cm.h>
 #include <mach/lm.h>
 
 #include <asm/mach/arch.h>
@@ -49,6 +48,7 @@
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
 
+#include "cm.h"
 #include "common.h"
 
 /* Base address to the CP controller */
@@ -255,6 +255,7 @@ static const struct of_device_id fpga_irq_of_match[] __initconst = {
 
 static void __init intcp_init_irq_of(void)
 {
+	cm_init();
 	of_irq_init(fpga_irq_of_match);
 	integrator_clk_init(true);
 }
diff --git a/arch/arm/mach-integrator/leds.c b/arch/arm/mach-integrator/leds.c
index 7a7f6d3..98fb74e 100644
--- a/arch/arm/mach-integrator/leds.c
+++ b/arch/arm/mach-integrator/leds.c
@@ -11,10 +11,11 @@
 #include <linux/slab.h>
 #include <linux/leds.h>
 
-#include <mach/cm.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
 
+#include "cm.h"
+
 #if defined(CONFIG_NEW_LEDS) && defined(CONFIG_LEDS_CLASS)
 
 #define ALPHA_REG __io_address(INTEGRATOR_DBG_BASE)
-- 
1.8.3.1
