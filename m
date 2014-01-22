From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 14:31:08 +0100
Subject: [PATCH 2/5] irqchip: support cascaded VICs
In-Reply-To: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
References: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1390397471-6802-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for a VIC to be cascaded off another IRQ.
On the Integrator/AP logical module IM-PD1 there is a VIC
cascaded off the central FPGA IRQ controller so this is
needed for that to work out.

In order for the plug-in board to be able to register all
the devices with their IRQs relative to the offset of the
base obtained for the cascaded VIC, the base IRQ number
is passed back to the caller.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
tglx: if you're happy with this pls ACK it so I can take this
through the ARM SoC tree.
---
 arch/arm/mach-versatile/core.c  |  2 +-
 drivers/irqchip/irq-vic.c       | 53 ++++++++++++++++++++++++++++++++++++-----
 include/linux/irqchip/arm-vic.h |  6 +++--
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 3b0572f30d56..36b97212d554 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -108,7 +108,7 @@ void __init versatile_init_irq(void)
 
 	np = of_find_matching_node_by_address(NULL, vic_of_match,
 					      VERSATILE_VIC_BASE);
-	__vic_init(VA_VIC_BASE, IRQ_VIC_START, ~0, 0, np);
+	__vic_init(VA_VIC_BASE, 0, IRQ_VIC_START, ~0, 0, np);
 
 	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
 
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 70108c1491bc..6002942a231c 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -57,6 +57,7 @@
 
 /**
  * struct vic_device - VIC PM device
+ * @parent_irq: The parent IRQ number of the VIC if cascaded, or 0.
  * @irq: The IRQ number for the base of the VIC.
  * @base: The register base for the VIC.
  * @valid_sources: A bitmask of valid interrupts
@@ -224,6 +225,17 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
 	return handled;
 }
 
+static void vic_handle_irq_cascaded(unsigned int irq, struct irq_desc *desc)
+{
+	u32 stat, hwirq;
+	struct vic_device *vic = irq_desc_get_handler_data(desc);
+
+	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
+		hwirq = ffs(stat) - 1;
+		generic_handle_irq(irq_find_mapping(vic->domain, hwirq));
+	}
+}
+
 /*
  * Keep iterating over all registered VIC's until there are no pending
  * interrupts.
@@ -246,6 +258,7 @@ static struct irq_domain_ops vic_irqdomain_ops = {
 /**
  * vic_register() - Register a VIC.
  * @base: The base address of the VIC.
+ * @parent_irq: The parent IRQ if cascaded, else 0.
  * @irq: The base IRQ for the VIC.
  * @valid_sources: bitmask of valid interrupts
  * @resume_sources: bitmask of interrupts allowed for resume sources.
@@ -257,7 +270,8 @@ static struct irq_domain_ops vic_irqdomain_ops = {
  *
  * This also configures the IRQ domain for the VIC.
  */
-static void __init vic_register(void __iomem *base, unsigned int irq,
+static void __init vic_register(void __iomem *base, unsigned int parent_irq,
+				unsigned int irq,
 				u32 valid_sources, u32 resume_sources,
 				struct device_node *node)
 {
@@ -275,6 +289,12 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 	v->resume_sources = resume_sources;
 	set_handle_irq(vic_handle_irq);
 	vic_id++;
+
+	if (parent_irq) {
+		irq_set_handler_data(parent_irq, v);
+		irq_set_chained_handler(parent_irq, vic_handle_irq_cascaded);
+	}
+
 	v->domain = irq_domain_add_simple(node, fls(valid_sources), irq,
 					  &vic_irqdomain_ops, v);
 	/* create an IRQ mapping for each valid IRQ */
@@ -413,10 +433,10 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 		writel(32, base + VIC_PL190_DEF_VECT_ADDR);
 	}
 
-	vic_register(base, irq_start, vic_sources, 0, node);
+	vic_register(base, 0, irq_start, vic_sources, 0, node);
 }
 
-void __init __vic_init(void __iomem *base, int irq_start,
+void __init __vic_init(void __iomem *base, int parent_irq, int irq_start,
 			      u32 vic_sources, u32 resume_sources,
 			      struct device_node *node)
 {
@@ -453,7 +473,7 @@ void __init __vic_init(void __iomem *base, int irq_start,
 
 	vic_init2(base);
 
-	vic_register(base, irq_start, vic_sources, resume_sources, node);
+	vic_register(base, parent_irq, irq_start, vic_sources, resume_sources, node);
 }
 
 /**
@@ -466,7 +486,28 @@ void __init __vic_init(void __iomem *base, int irq_start,
 void __init vic_init(void __iomem *base, unsigned int irq_start,
 		     u32 vic_sources, u32 resume_sources)
 {
-	__vic_init(base, irq_start, vic_sources, resume_sources, NULL);
+	__vic_init(base, 0, irq_start, vic_sources, resume_sources, NULL);
+}
+
+/**
+ * vic_init_cascaded() - initialise a cascaded vectored interrupt controller
+ * @base: iomem base address
+ * @parent_irq: the parent IRQ we're cascaded off
+ * @irq_start: starting interrupt number, must be muliple of 32
+ * @vic_sources: bitmask of interrupt sources to allow
+ * @resume_sources: bitmask of interrupt sources to allow for resume
+ *
+ * This returns the base for the new interrupts or negative on error.
+ */
+int __init vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
+			      u32 vic_sources, u32 resume_sources)
+{
+	struct vic_device *v;
+
+	v = &vic_devices[vic_id];
+	__vic_init(base, parent_irq, 0, vic_sources, resume_sources, NULL);
+	/* Return out acquired base */
+	return v->irq;
 }
 
 #ifdef CONFIG_OF
@@ -489,7 +530,7 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 	/*
 	 * Passing 0 as first IRQ makes the simple domain allocate descriptors
 	 */
-	__vic_init(regs, 0, interrupt_mask, wakeup_mask, node);
+	__vic_init(regs, 0, 0, interrupt_mask, wakeup_mask, node);
 
 	return 0;
 }
diff --git a/include/linux/irqchip/arm-vic.h b/include/linux/irqchip/arm-vic.h
index e3c82dc95756..ba46c794b4e5 100644
--- a/include/linux/irqchip/arm-vic.h
+++ b/include/linux/irqchip/arm-vic.h
@@ -29,8 +29,10 @@
 struct device_node;
 struct pt_regs;
 
-void __vic_init(void __iomem *base, int irq_start, u32 vic_sources,
-		u32 resume_sources, struct device_node *node);
+void __vic_init(void __iomem *base, int parent_irq, int irq_start,
+		u32 vic_sources, u32 resume_sources, struct device_node *node);
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
+int vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
+		      u32 vic_sources, u32 resume_sources);
 
 #endif
-- 
1.8.4.2
