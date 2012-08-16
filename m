From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Aug 2012 14:15:57 +0200
Subject: [PATCH 3/6] ARM: plat-versatile: add DT support to FPGA IRQ controller
Message-ID: <1345119357-22702-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds Device Tree probing support to the Versatile FPGA
IRQ controller.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/arm/versatile-fpga-irq.txt | 35 ++++++++++++++++++
 arch/arm/plat-versatile/fpga-irq.c                 | 41 ++++++++++++++++++++++
 arch/arm/plat-versatile/include/plat/fpga-irq.h    |  2 ++
 3 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt

diff --git a/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt b/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt
new file mode 100644
index 0000000..d20242a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt
@@ -0,0 +1,35 @@
+* ARM Versatile FPGA interrupt controller
+
+One or more FPGA IRQ controllers can be synthesized in an ARM reference board
+such as the Integrator or Versatile family. The output of these different
+controllers are OR:ed together and fed to the CPU tile's IRQ input. Each
+instance can handle up to 32 interrupts.
+
+Required properties:
+- compatible: "arm,versatile-fpga-irq"
+- interrupt-controller: Identifies the node as an interrupt controller
+- #interrupt-cells: The number of cells to define the interrupts.  Must be 1
+  as the FPGA IRQ controller has no configuration options for interrupt
+  sources.  The cell is a u32 and defines the interrupt number.
+- reg: The register bank for the FPGA interrupt controller.
+- irq-start: the u32 hardware IRQ number of the first interrupt handled by
+  this FPGA IRQ instance - since there may be many FPGA IRQ controller
+  instances, each will have its unique hardware offset number.
+- clear-mask: a u32 number representing the mask written to clear all IRQs
+  on the controller at boot for example.
+- valid-mask: a u32 number representing a bit mask determining which of
+  the interrupts are valid. Unconnected/unused lines are set to 0, and
+  the system till not make it possible for devices to request these
+  interrupts.
+
+Example:
+
+pic: pic at 14000000 {
+        compatible = "arm,versatile-fpga-irq";
+        #interrupt-cells = <1>;
+        interrupt-controller;
+        reg = <0x14000000 0x100>;
+        irq-start = <1>;
+        clear-mask = <0xffffffff>;
+        valid-mask = <0x003fffff>;
+};
diff --git a/arch/arm/plat-versatile/fpga-irq.c b/arch/arm/plat-versatile/fpga-irq.c
index 6e70d03..379ff53 100644
--- a/arch/arm/plat-versatile/fpga-irq.c
+++ b/arch/arm/plat-versatile/fpga-irq.c
@@ -5,6 +5,8 @@
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
@@ -14,6 +16,13 @@
 #define IRQ_RAW_STATUS		0x04
 #define IRQ_ENABLE_SET		0x08
 #define IRQ_ENABLE_CLEAR	0x0c
+#define INT_SOFT_SET		0x10
+#define INT_SOFT_CLEAR		0x14
+#define FIQ_STATUS		0x20
+#define FIQ_RAW_STATUS		0x24
+#define FIQ_ENABLE		0x28
+#define FIQ_ENABLE_SET		0x28
+#define FIQ_ENABLE_CLEAR	0x2C
 
 /**
  * struct fpga_irq_data - irq data container for the FPGA IRQ controller
@@ -156,3 +165,35 @@ void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
 
 	fpga_irq_id++;
 }
+
+#ifdef CONFIG_OF
+int __init fpga_irq_of_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	void __iomem *base;
+	u32 irq_start;
+	u32 clear_mask;
+	u32 valid_mask;
+
+	if (WARN_ON(!node))
+		return -ENODEV;
+
+	base = of_iomap(node, 0);
+	WARN(!base, "unable to map fpga irq registers\n");
+
+	if (of_property_read_u32(node, "irq-start", &irq_start))
+		irq_start = 0;
+
+	if (of_property_read_u32(node, "clear-mask", &clear_mask))
+		clear_mask = 0;
+
+	if (of_property_read_u32(node, "valid-mask", &valid_mask))
+		valid_mask = 0;
+
+	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
+	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
+	fpga_irq_init(base, node->name, irq_start, -1, valid_mask, node);
+
+	return 0;
+}
+#endif
diff --git a/arch/arm/plat-versatile/include/plat/fpga-irq.h b/arch/arm/plat-versatile/include/plat/fpga-irq.h
index 91bcfb6..1fac965 100644
--- a/arch/arm/plat-versatile/include/plat/fpga-irq.h
+++ b/arch/arm/plat-versatile/include/plat/fpga-irq.h
@@ -7,5 +7,7 @@ struct pt_regs;
 void fpga_handle_irq(struct pt_regs *regs);
 void fpga_irq_init(void __iomem *, const char *, int, int, u32,
 		struct device_node *node);
+int fpga_irq_of_init(struct device_node *node,
+		     struct device_node *parent);
 
 #endif
-- 
1.7.11.2
