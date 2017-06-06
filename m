From: slash.tmp@free.fr (Mason)
Date: Tue, 6 Jun 2017 15:42:36 +0200
Subject: [RFC PATCH v1] irqchip: Add support for tango interrupt router
Message-ID: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt router supports 128 inputs -> 24 outputs

---
 .../bindings/interrupt-controller/sigma,smp8759-intc.txt  |  48 ++++++
 drivers/irqchip/Makefile                                  |   2 +-
 drivers/irqchip/irq-smp8759.c                             | 204 ++++++++++++++++++++++++
 3 files changed, 253 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt
new file mode 100644
index 000000000000..c84ca9315768
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt
@@ -0,0 +1,48 @@
+Sigma Designs SMP8759 interrupt router
+
+Required properties:
+- compatible: "sigma,smp8759-intc"
+- reg: address/size of register area
+- interrupt-controller
+- #interrupt-cells: <2>  (hwirq and trigger_type)
+- interrupt-parent: parent phandle
+- interrupts: list of interrupt lines to parent
+
+Example:
+
+	interrupt-controller at 6f800 {
+		compatible = "sigma,smp8759-intc";
+		reg = <0x6f800 0x430>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		/*
+		 * There probably is a better way than explicitly listing
+		 * the 24 interrupts?
+		 */
+		interrupts =
+			<GIC_SPI  0 IRQ_TYPE_NONE>,
+			<GIC_SPI  1 IRQ_TYPE_NONE>,
+			<GIC_SPI  2 IRQ_TYPE_NONE>,
+			<GIC_SPI  3 IRQ_TYPE_NONE>,
+			<GIC_SPI  4 IRQ_TYPE_NONE>,
+			<GIC_SPI  5 IRQ_TYPE_NONE>,
+			<GIC_SPI  6 IRQ_TYPE_NONE>,
+			<GIC_SPI  7 IRQ_TYPE_NONE>,
+			<GIC_SPI  8 IRQ_TYPE_NONE>,
+			<GIC_SPI  9 IRQ_TYPE_NONE>,
+			<GIC_SPI 10 IRQ_TYPE_NONE>,
+			<GIC_SPI 11 IRQ_TYPE_NONE>,
+			<GIC_SPI 12 IRQ_TYPE_NONE>,
+			<GIC_SPI 13 IRQ_TYPE_NONE>,
+			<GIC_SPI 14 IRQ_TYPE_NONE>,
+			<GIC_SPI 15 IRQ_TYPE_NONE>,
+			<GIC_SPI 16 IRQ_TYPE_NONE>,
+			<GIC_SPI 17 IRQ_TYPE_NONE>,
+			<GIC_SPI 18 IRQ_TYPE_NONE>,
+			<GIC_SPI 19 IRQ_TYPE_NONE>,
+			<GIC_SPI 20 IRQ_TYPE_NONE>,
+			<GIC_SPI 21 IRQ_TYPE_NONE>,
+			<GIC_SPI 22 IRQ_TYPE_NONE>,
+			<GIC_SPI 23 IRQ_TYPE_NONE>;
+	};
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e4dbfc85abdb..013104923b71 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -47,7 +47,7 @@ obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= irq-zevio.o
 obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
 obj-$(CONFIG_ST_IRQCHIP)		+= irq-st.o
-obj-$(CONFIG_TANGO_IRQ)			+= irq-tango.o
+obj-$(CONFIG_TANGO_IRQ)			+= irq-tango.o irq-smp8759.o
 obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
 obj-$(CONFIG_TS4800_IRQ)		+= irq-ts4800.o
 obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
diff --git a/drivers/irqchip/irq-smp8759.c b/drivers/irqchip/irq-smp8759.c
new file mode 100644
index 000000000000..b8338e14d399
--- /dev/null
+++ b/drivers/irqchip/irq-smp8759.c
@@ -0,0 +1,204 @@
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+
+#define IRQ_MAX			128
+#define OUTPUT_MAX		24
+#define IRQ_ENABLE		BIT(31)
+#define LEVEL_OUTPUT_LINE	0
+
+/*
+ * 128 inputs -> 24 outputs
+ * Group LEVEL_HIGH IRQs on output line 0
+ * Edge interrupts get a dedicated output line
+ * gic_spi_to_tango_hwirq array maps GIC SPI hwirq to tango hwirq
+ */
+struct tango_intc {
+	DECLARE_BITMAP(enabled, IRQ_MAX);
+	spinlock_t lock;
+	void __iomem *config;
+	void __iomem *status;
+	struct irq_domain *dom;
+	u8 gic_spi_to_tango_hwirq[OUTPUT_MAX];
+};
+
+static void tango_level_isr(struct irq_desc *desc)
+{
+	unsigned int pos, virq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct tango_intc *intc = irq_desc_get_handler_data(desc);
+	DECLARE_BITMAP(status, IRQ_MAX);
+
+	chained_irq_enter(chip, desc);
+
+	memcpy_fromio(status, intc->status, IRQ_MAX / BITS_PER_BYTE);
+	bitmap_and(status, status, intc->enabled, IRQ_MAX);
+	for_each_set_bit(pos, status, IRQ_MAX) {
+		virq = irq_find_mapping(intc->dom, pos);
+		generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void tango_edge_isr(struct irq_desc *desc)
+{
+	unsigned int virq;
+	struct irq_data *d = &desc->irq_data;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct tango_intc *intc = irq_desc_get_handler_data(desc);
+
+	/* I don't know how to get the SPI number, d->hwirq - 32 is a hack */
+	int hwirq = intc->gic_spi_to_tango_hwirq[d->hwirq - 32];
+	//printk("%s: SPI=%lu hwirq=%d\n", __func__, d->hwirq, hwirq);
+
+	chained_irq_enter(chip, desc);
+	virq = irq_find_mapping(intc->dom, hwirq);
+	generic_handle_irq(virq);
+	chained_irq_exit(chip, desc);
+}
+
+static void tango_mask(struct irq_data *data)
+{
+	unsigned long flags;
+	struct tango_intc *intc = data->chip_data;
+
+	spin_lock_irqsave(&intc->lock, flags);
+	__clear_bit(data->hwirq, intc->enabled);
+	writel_relaxed(0, intc->config + data->hwirq * 4);
+	spin_unlock_irqrestore(&intc->lock, flags);
+}
+
+static void tango_unmask(struct irq_data *data)
+{
+	unsigned long flags;
+	struct tango_intc *intc = data->chip_data;
+
+#if 0
+	if (!in_irq() && !in_interrupt()) {
+		printk("HWIRQ=%lu mask=%u\n", data->hwirq, data->mask);
+		dump_stack();
+	}
+#endif
+
+	spin_lock_irqsave(&intc->lock, flags);
+	__set_bit(data->hwirq, intc->enabled);
+	writel_relaxed(IRQ_ENABLE | data->mask, intc->config + data->hwirq * 4);
+	spin_unlock_irqrestore(&intc->lock, flags);
+}
+
+static int find_free_output_line(struct tango_intc *intc)
+{
+	int i;
+
+	/* Start at 1, because 0 is reserved for level interrupts */
+	for (i = 1; i < OUTPUT_MAX; ++i)
+		if (intc->gic_spi_to_tango_hwirq[i] == 0)
+			return i;
+
+	return -ENOSPC;
+}
+
+int tango_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	struct tango_intc *intc = data->chip_data;
+	printk("%s: IRQ=%lu type=%x\n", __func__, data->hwirq, flow_type);
+	dump_stack();
+	if (flow_type & IRQ_TYPE_LEVEL_HIGH) {
+		data->mask = LEVEL_OUTPUT_LINE;
+		return 0;
+	}
+
+	if (flow_type & IRQ_TYPE_EDGE_RISING) {
+		int res = find_free_output_line(intc);
+		if (res < 0)
+			return res;
+		data->mask = res;
+		intc->gic_spi_to_tango_hwirq[res] = data->hwirq;
+		printk("Map tango hwirq %lu to GIC SPI %d\n", data->hwirq, res);
+		return 0;
+	}
+
+	/* LEVEL_LOW and EDGE_FALLING are not supported */
+	return -ENOSYS;
+}
+
+static struct irq_chip tango_chip = {
+	.name		= "tango",
+	.irq_mask	= tango_mask,
+	.irq_unmask	= tango_unmask,
+	.irq_set_type	= tango_set_type,
+};
+
+static int tango_map(struct irq_domain *dom, unsigned int virq, irq_hw_number_t hw)
+{
+	struct tango_intc *intc = dom->host_data;
+	struct irq_desc *desc = irq_to_desc(virq);
+	printk("%s: dom=%p virq=%u hwirq=%lu desc=%p\n", __func__, dom, virq, hw, desc);
+	irq_domain_set_info(dom, virq, hw, &tango_chip, intc, handle_simple_irq, NULL, NULL);
+	return 0;
+}
+
+static void tango_unmap(struct irq_domain *d, unsigned int virq)
+{
+	printk("%s: dom=%p virq=%u\n", __func__, d, virq);
+	dump_stack();
+}
+
+struct irq_domain_ops dom_ops =
+{
+	.map	= tango_map,
+	.unmap	= tango_unmap,
+	.xlate	= irq_domain_xlate_twocell,
+};
+
+static int __init tango_irq_init(struct device_node *node, struct device_node *parent)
+{
+	int i, virq;
+	struct irq_domain *irq_dom;
+	struct irq_data *irq_data;
+	void __iomem *base;
+	struct tango_intc *intc = kzalloc(sizeof(*intc), GFP_KERNEL);
+
+	base = of_iomap(node, 0);
+	if (!base)
+		panic("%s: of_iomap failed", node->name);
+
+	/*
+	 * Use output line 0 for level high IRQs
+	 * Should we check that index 0 points to SPI 0?
+	 */
+	virq = irq_of_parse_and_map(node, 0);
+	if (!virq)
+		panic("%s: Failed to map IRQ 0\n", node->name);
+
+	irq_data = irq_get_irq_data(virq);
+	irqd_set_trigger_type(irq_data, IRQ_TYPE_LEVEL_HIGH);
+	irq_set_chained_handler_and_data(virq, tango_level_isr, intc);
+
+	for (i = 1; i < OUTPUT_MAX; ++i)
+	{
+		virq = irq_of_parse_and_map(node, i);
+		if (!virq)
+			panic("%s: Failed to map IRQ %d\n", node->name, i);
+
+		/*
+		 * I don't think trigger type should appear in DT because
+		 * it is a purely SW/driver decision
+		 */
+		irq_data = irq_get_irq_data(virq);
+		irqd_set_trigger_type(irq_data, IRQ_TYPE_EDGE_RISING);
+		irq_set_chained_handler_and_data(virq, tango_edge_isr, intc);
+	}
+
+	irq_dom = irq_domain_add_linear(node, IRQ_MAX, &dom_ops, intc);
+
+	spin_lock_init(&intc->lock);
+	intc->config = base;
+	intc->status = base + 0x420;
+	intc->dom = irq_dom;
+
+	return 0;
+}
+IRQCHIP_DECLARE(tango_intc, "sigma,smp8759-intc", tango_irq_init);
-- 
1.8.3.1
