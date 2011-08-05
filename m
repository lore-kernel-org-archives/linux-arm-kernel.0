From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri,  5 Aug 2011 09:19:13 +0100
Subject: [PATCH] ARM: GIC: Add device tree interrupt specifier translation
	support
Message-ID: <1312532353-8772-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for translation of hardware interrupt numbers specified in device
tree nodes to linux irq number.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
Notes:
1. The translation of SGI/PPI interrupts is supported only for CPU0.
2. The documentation is derived from the following patch submitted
   earlier by Rob Herring.
   [PATCH 2/3] ARM: gic: add OF based initialization

 Documentation/devicetree/bindings/arm/gic.txt |   21 +++++++
 arch/arm/common/gic.c                         |   70 +++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
new file mode 100644
index 0000000..3204ac5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -0,0 +1,21 @@
+* ARM Generic Interrupt Controller
+
+Some ARM cores have an interrupt controller called GIC. The ARM GIC
+representation in the device tree should be done as under:
+
+Required properties:
+- compatible: should be "arm,cortex-a9-gic".
+- reg: Specifies base physical address(s) and size of the GIC registers. The
+  first two values are the GIC distributor register base and size. The second
+  two values are the GIC cpu interface register base and size.
+- interrupt-controller: Identifies the node as an interrupt controller
+- #interrupt-cells: Specifies the number of cells needed to encode a
+  interrupt source and the value shall be 1.
+
+Example:
+	GIC:interrupt-controller at 10490000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
+	};
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 3227ca9..c11d3a5 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -28,6 +28,11 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
+#ifdef CONFIG_OF_IRQ
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#endif
 
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
@@ -394,3 +399,68 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
 }
 #endif
+
+#ifdef CONFIG_OF_IRQ
+
+/* GIC interrupt types corresponding to the device tree interrupt specifier */
+enum gic_int_type {
+	GIC_INT_TYPE_SPI = 0,
+	GIC_INT_TYPE_SGI = 1,
+	GIC_INT_TYPE_PPI = 2,
+};
+
+/* Translate dt irq specifier to linux irq number */
+static int gic_irq_domain_translate_dt(struct irq_domain *d,
+			    struct device_node *controller,
+			    const u32 *intspec, unsigned int intsize,
+			    unsigned long *out_hwirq, unsigned int *out_type)
+{
+	if (d->of_node != controller)
+		return -EINVAL;
+	if (intsize < 2)
+		return -EINVAL;
+
+	switch (intspec[0]) {
+	case GIC_INT_TYPE_SPI:
+		*out_hwirq = intspec[1] + 32; /* +32, for start of SPI */
+		break;
+	case GIC_INT_TYPE_SGI:
+		*out_hwirq = intspec[1];
+		break;
+	case GIC_INT_TYPE_PPI:
+		*out_hwirq = intspec[1] + 16; /* +16, for start of PPI */
+		break;
+	default:
+		pr_info("gic_irq_domain_translate_dt: invalid gic intr type\n");
+		return -EINVAL;
+	}
+
+	*out_hwirq += d->irq_base;
+	*out_type = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static struct irq_domain_ops gic_irq_domain_dt_ops = {
+	.dt_translate = gic_irq_domain_translate_dt,
+};
+
+int gic_add_irq_domain_dt(unsigned int irq_base)
+{
+	struct device_node *np;
+	struct irq_domain *domain;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
+	if (!np)
+		return -ENODEV;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return -ENOMEM;
+
+	domain->irq_base = irq_base;
+	domain->of_node = np;
+	domain->ops = &gic_irq_domain_dt_ops;
+	irq_domain_add(domain);
+	return 0;
+}
+#endif
-- 
1.7.4.1
