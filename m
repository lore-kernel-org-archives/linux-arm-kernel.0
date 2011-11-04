From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  4 Nov 2011 01:09:59 +0000
Subject: [PATCHv4 02/13] ARM: vic: device tree binding
In-Reply-To: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1320369010-23428-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a device tree binding for the VIC based on the of_irq_init()
support.  This adds an irqdomain to the vic and always registers all
vics in the static vic array rather than for pm only to keep track of
the irq domain.  struct irq_data::hwirq is used where appropriate rather
than runtime masking.

v2:	- use irq_domain_simple_ops
	- remove stub implementation of vic_of_init for !CONFIG_OF
	- Make VIC select IRQ_DOMAIN

Reviewed-by: Rob Herring <robherring2@gmail.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 Documentation/devicetree/bindings/arm/vic.txt |   29 +++++++
 arch/arm/common/Kconfig                       |    1 +
 arch/arm/common/vic.c                         |  106 ++++++++++++++++++-------
 arch/arm/include/asm/hardware/vic.h           |    7 ++-
 4 files changed, 114 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vic.txt

diff --git a/Documentation/devicetree/bindings/arm/vic.txt b/Documentation/devicetree/bindings/arm/vic.txt
new file mode 100644
index 0000000..266716b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vic.txt
@@ -0,0 +1,29 @@
+* ARM Vectored Interrupt Controller
+
+One or more Vectored Interrupt Controllers (VIC's) can be connected in an ARM
+system for interrupt routing.  For multiple controllers they can either be
+nested or have the outputs wire-OR'd together.
+
+Required properties:
+
+- compatible : should be one of
+	"arm,pl190-vic"
+	"arm,pl192-vic"
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : The number of cells to define the interrupts.  Must be 1 as
+  the VIC has no configuration options for interrupt sources.  The cell is a u32
+  and defines the interrupt number.
+- reg : The register bank for the VIC.
+
+Optional properties:
+
+- interrupts : Interrupt source for parent controllers if the VIC is nested.
+
+Example:
+
+	vic0: interrupt-controller at 60000 {
+		compatible = "arm,pl192-vic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x60000 0x1000>;
+	};
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 74df9ca..e91ee7d 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -3,6 +3,7 @@ config ARM_GIC
 	bool
 
 config ARM_VIC
+	select IRQ_DOMAIN
 	bool
 
 config ARM_VIC_NR
diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 01f18a4..e689975 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -22,6 +22,10 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/syscore_ops.h>
 #include <linux/device.h>
 #include <linux/amba/bus.h>
@@ -29,7 +33,6 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/vic.h>
 
-#ifdef CONFIG_PM
 /**
  * struct vic_device - VIC PM device
  * @irq: The IRQ number for the base of the VIC.
@@ -40,6 +43,7 @@
  * @int_enable: Save for VIC_INT_ENABLE.
  * @soft_int: Save for VIC_INT_SOFT.
  * @protect: Save for VIC_PROTECT.
+ * @domain: The IRQ domain for the VIC.
  */
 struct vic_device {
 	void __iomem	*base;
@@ -50,13 +54,13 @@ struct vic_device {
 	u32		int_enable;
 	u32		soft_int;
 	u32		protect;
+	struct irq_domain domain;
 };
 
 /* we cannot allocate memory when VICs are initially registered */
 static struct vic_device vic_devices[CONFIG_ARM_VIC_NR];
 
 static int vic_id;
-#endif /* CONFIG_PM */
 
 /**
  * vic_init2 - common initialisation code
@@ -156,39 +160,50 @@ static int __init vic_pm_init(void)
 	return 0;
 }
 late_initcall(vic_pm_init);
+#endif /* CONFIG_PM */
 
 /**
- * vic_pm_register - Register a VIC for later power management control
+ * vic_register() - Register a VIC.
  * @base: The base address of the VIC.
  * @irq: The base IRQ for the VIC.
  * @resume_sources: bitmask of interrupts allowed for resume sources.
+ * @node: The device tree node associated with the VIC.
  *
  * Register the VIC with the system device tree so that it can be notified
  * of suspend and resume requests and ensure that the correct actions are
  * taken to re-instate the settings on resume.
+ *
+ * This also configures the IRQ domain for the VIC.
  */
-static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 resume_sources)
+static void __init vic_register(void __iomem *base, unsigned int irq,
+				u32 resume_sources, struct device_node *node)
 {
 	struct vic_device *v;
 
-	if (vic_id >= ARRAY_SIZE(vic_devices))
+	if (vic_id >= ARRAY_SIZE(vic_devices)) {
 		printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
-	else {
-		v = &vic_devices[vic_id];
-		v->base = base;
-		v->resume_sources = resume_sources;
-		v->irq = irq;
-		vic_id++;
+		return;
 	}
+
+	v = &vic_devices[vic_id];
+	v->base = base;
+	v->resume_sources = resume_sources;
+	v->irq = irq;
+	vic_id++;
+
+	v->domain.irq_base = irq;
+	v->domain.nr_irq = 32;
+#ifdef CONFIG_OF_IRQ
+	v->domain.of_node = of_node_get(node);
+	v->domain.ops = &irq_domain_simple_ops;
+#endif /* CONFIG_OF */
+	irq_domain_add(&v->domain);
 }
-#else
-static inline void vic_pm_register(void __iomem *base, unsigned int irq, u32 arg1) { }
-#endif /* CONFIG_PM */
 
 static void vic_ack_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->irq & 31;
+	unsigned int irq = d->hwirq;
 	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
 	/* moreover, clear the soft-triggered, in case it was the reason */
 	writel(1 << irq, base + VIC_INT_SOFT_CLEAR);
@@ -197,14 +212,14 @@ static void vic_ack_irq(struct irq_data *d)
 static void vic_mask_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->irq & 31;
+	unsigned int irq = d->hwirq;
 	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
 }
 
 static void vic_unmask_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->irq & 31;
+	unsigned int irq = d->hwirq;
 	writel(1 << irq, base + VIC_INT_ENABLE);
 }
 
@@ -226,7 +241,7 @@ static struct vic_device *vic_from_irq(unsigned int irq)
 static int vic_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct vic_device *v = vic_from_irq(d->irq);
-	unsigned int off = d->irq & 31;
+	unsigned int off = d->hwirq;
 	u32 bit = 1 << off;
 
 	if (!v)
@@ -330,15 +345,9 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 	vic_set_irq_sources(base, irq_start, vic_sources);
 }
 
-/**
- * vic_init - initialise a vectored interrupt controller
- * @base: iomem base address
- * @irq_start: starting interrupt number, must be muliple of 32
- * @vic_sources: bitmask of interrupt sources to allow
- * @resume_sources: bitmask of interrupt sources to allow for resume
- */
-void __init vic_init(void __iomem *base, unsigned int irq_start,
-		     u32 vic_sources, u32 resume_sources)
+static void __init __vic_init(void __iomem *base, unsigned int irq_start,
+			      u32 vic_sources, u32 resume_sources,
+			      struct device_node *node)
 {
 	unsigned int i;
 	u32 cellid = 0;
@@ -375,5 +384,46 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 
 	vic_set_irq_sources(base, irq_start, vic_sources);
 
-	vic_pm_register(base, irq_start, resume_sources);
+	vic_register(base, irq_start, resume_sources, node);
+}
+
+/**
+ * vic_init() - initialise a vectored interrupt controller
+ * @base: iomem base address
+ * @irq_start: starting interrupt number, must be muliple of 32
+ * @vic_sources: bitmask of interrupt sources to allow
+ * @resume_sources: bitmask of interrupt sources to allow for resume
+ */
+void __init vic_init(void __iomem *base, unsigned int irq_start,
+		     u32 vic_sources, u32 resume_sources)
+{
+	__vic_init(base, irq_start, vic_sources, resume_sources, NULL);
+}
+
+#ifdef CONFIG_OF
+int __init vic_of_init(struct device_node *node, struct device_node *parent)
+{
+	void __iomem *regs;
+	int irq_base;
+
+	if (WARN(parent, "non-root VICs are not supported"))
+		return -EINVAL;
+
+	regs = of_iomap(node, 0);
+	if (WARN_ON(!regs))
+		return -EIO;
+
+	irq_base = irq_alloc_descs(-1, 0, 32, numa_node_id());
+	if (WARN_ON(irq_base < 0))
+		goto out_unmap;
+
+	__vic_init(regs, irq_base, ~0, ~0, node);
+
+	return 0;
+
+ out_unmap:
+	iounmap(regs);
+
+	return -EIO;
 }
+#endif /* CONFIG OF */
diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
index 5d72550..b348a54 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -41,7 +41,12 @@
 #define VIC_PL192_VECT_ADDR		0xF00
 
 #ifndef __ASSEMBLY__
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+struct device_node;
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
-#endif
+int vic_of_init(struct device_node *node, struct device_node *parent);
 
+#endif /* __ASSEMBLY__ */
 #endif
-- 
1.7.5.4
