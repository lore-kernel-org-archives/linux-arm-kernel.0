From: slash.tmp@free.fr (Mason)
Date: Tue, 1 Aug 2017 18:56:22 +0200
Subject: [PATCH v6] irqchip: Add support for tango interrupt router
In-Reply-To: <473118cd-20dc-3534-d0d8-88799e3d2c3b@free.fr>
References: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
 <20170606175219.34ef62b9@free-electrons.com>
 <d8a4d8ad-a9f3-07eb-9e2a-a4bbec01961e@free.fr>
 <dfb86360-2247-65bb-602b-5c21029709fd@free.fr>
 <c0bd235a-9035-2002-31eb-e68710b076fd@free.fr>
 <24f34220-a017-f4e0-b72e-d1fdb014c0e1@free.fr>
 <9f384711-eef0-5117-b89c-9d2dc16e5ae5@free.fr>
 <afcc2b79-61ff-b54d-eac1-ea7f3ee6b6b2@free.fr>
 <e4a201b1-64e7-32a1-9cad-e632eeb156f6@free.fr>
 <473118cd-20dc-3534-d0d8-88799e3d2c3b@free.fr>
Message-ID: <eea0ba7d-15d2-fb20-7c23-b2d3c4a7cfa7@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This controller maps 128 input lines to 24 output lines.
The output lines are routed to GIC SPI 0 to 23.
This driver muxes LEVEL_HIGH IRQs onto output line 0,
and gives every EDGE_RISING IRQ a dedicated output line.
---
Changes from v5 to v6:
Add suspend/resume support

This driver is now feature complete AFAICT.
Marc, Thomas, Jason, it would be great if you could tell me
if I did something stupid wrt the irqchip API.
---
 .../interrupt-controller/sigma,smp8759-intc.txt    |  18 ++
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-smp8759.c                      | 204 +++++++++++++++++++++
 3 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt
 create mode 100644 drivers/irqchip/irq-smp8759.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt
new file mode 100644
index 000000000000..9ec922f3c0a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt
@@ -0,0 +1,18 @@
+Sigma Designs SMP8759 interrupt router
+
+Required properties:
+- compatible: "sigma,smp8759-intc"
+- reg: address/size of register area
+- interrupt-controller
+- #interrupt-cells: <2>  (hwirq and trigger_type)
+- interrupt-parent: parent phandle
+
+Example:
+
+	interrupt-controller at 6f800 {
+		compatible = "sigma,smp8759-intc";
+		reg = <0x6f800 0x430>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
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
index 000000000000..a1680a250598
--- /dev/null
+++ b/drivers/irqchip/irq-smp8759.c
@@ -0,0 +1,204 @@
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/syscore_ops.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+/*
+ * This controller maps IRQ_MAX input lines to SPI_MAX output lines.
+ * The output lines are routed to GIC SPI 0 to 23.
+ * This driver muxes LEVEL_HIGH IRQs onto output line 0,
+ * and gives every EDGE_RISING IRQ a dedicated output line.
+ */
+#define IRQ_MAX		128
+#define SPI_MAX		24
+#define LEVEL_SPI	0
+#define IRQ_ENABLE	BIT(31)
+#define STATUS		0x420
+
+struct tango_intc {
+	void __iomem *base;
+	struct irq_domain *dom;
+	u8 spi_to_tango_irq[SPI_MAX];
+	u8 tango_irq_to_spi[IRQ_MAX];
+	DECLARE_BITMAP(enabled_level, IRQ_MAX);
+	DECLARE_BITMAP(enabled_edge, IRQ_MAX);
+	spinlock_t lock;
+};
+
+static struct tango_intc *tango_intc;
+
+static void tango_level_isr(struct irq_desc *desc)
+{
+	uint pos, virq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct tango_intc *intc = irq_desc_get_handler_data(desc);
+	DECLARE_BITMAP(status, IRQ_MAX);
+
+	chained_irq_enter(chip, desc);
+
+	spin_lock(&intc->lock);
+	memcpy_fromio(status, intc->base + STATUS, IRQ_MAX / BITS_PER_BYTE);
+	bitmap_and(status, status, intc->enabled_level, IRQ_MAX);
+	spin_unlock(&intc->lock);
+
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
+	uint virq;
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct tango_intc *intc = irq_desc_get_handler_data(desc);
+	int tango_irq = intc->spi_to_tango_irq[data->hwirq - 32];
+
+	chained_irq_enter(chip, desc);
+	virq = irq_find_mapping(intc->dom, tango_irq);
+	generic_handle_irq(virq);
+	chained_irq_exit(chip, desc);
+}
+
+static void tango_mask(struct irq_data *data)
+{
+	unsigned long flags;
+	struct tango_intc *intc = data->chip_data;
+	u32 spi = intc->tango_irq_to_spi[data->hwirq];
+
+	spin_lock_irqsave(&intc->lock, flags);
+	writel_relaxed(0, intc->base + data->hwirq * 4);
+	if (spi == LEVEL_SPI)
+		__clear_bit(data->hwirq, intc->enabled_level);
+	else
+		__clear_bit(data->hwirq, intc->enabled_edge);
+	spin_unlock_irqrestore(&intc->lock, flags);
+}
+
+static void tango_unmask(struct irq_data *data)
+{
+	unsigned long flags;
+	struct tango_intc *intc = data->chip_data;
+	u32 spi = intc->tango_irq_to_spi[data->hwirq];
+
+	spin_lock_irqsave(&intc->lock, flags);
+	writel_relaxed(IRQ_ENABLE | spi, intc->base + data->hwirq * 4);
+	if (spi == LEVEL_SPI)
+		__set_bit(data->hwirq, intc->enabled_level);
+	else
+		__set_bit(data->hwirq, intc->enabled_edge);
+	spin_unlock_irqrestore(&intc->lock, flags);
+}
+
+static int tango_set_type(struct irq_data *data, uint flow_type)
+{
+	return 0;
+}
+
+static struct irq_chip tango_chip = {
+	.name		= "tango",
+	.irq_mask	= tango_mask,
+	.irq_unmask	= tango_unmask,
+	.irq_set_type	= tango_set_type,
+};
+
+static int tango_alloc(struct irq_domain *dom, uint virq, uint n, void *arg)
+{
+	int spi;
+	struct irq_fwspec *fwspec = arg;
+	struct tango_intc *intc = dom->host_data;
+	u32 hwirq = fwspec->param[0], trigger = fwspec->param[1];
+
+	if (trigger & IRQ_TYPE_EDGE_FALLING || trigger & IRQ_TYPE_LEVEL_LOW)
+		return -EINVAL;
+
+	if (trigger & IRQ_TYPE_LEVEL_HIGH)
+		intc->tango_irq_to_spi[hwirq] = LEVEL_SPI;
+
+	if (trigger & IRQ_TYPE_EDGE_RISING) {
+		for (spi = 1; spi < SPI_MAX; ++spi) {
+			if (intc->spi_to_tango_irq[spi] == 0) {
+				intc->tango_irq_to_spi[hwirq] = spi;
+				intc->spi_to_tango_irq[spi] = hwirq;
+				break;
+			}
+		}
+		if (spi == SPI_MAX)
+			return -ENOSPC;
+	}
+
+	irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &tango_chip, intc);
+	irq_set_handler(virq, handle_simple_irq);
+
+	return 0;
+}
+
+static struct irq_domain_ops dom_ops = {
+	.xlate	= irq_domain_xlate_twocell,
+	.alloc	= tango_alloc,
+};
+
+static void tango_resume(void)
+{
+	int hwirq;
+	DECLARE_BITMAP(enabled, IRQ_MAX);
+	struct tango_intc *intc = tango_intc;
+
+	bitmap_or(enabled, intc->enabled_level, intc->enabled_edge, IRQ_MAX);
+	for (hwirq = 0; hwirq < IRQ_MAX; ++hwirq) {
+		u32 val = intc->tango_irq_to_spi[hwirq];
+		if (test_bit(hwirq, enabled))
+			val |= IRQ_ENABLE;
+		writel_relaxed(val, intc->base + hwirq * 4);
+	}
+}
+
+static struct syscore_ops tango_syscore_ops = {
+	.resume		= tango_resume,
+};
+
+static int __init map_irq(struct device_node *gic, int spi, int trigger)
+{
+	struct of_phandle_args irq_data = { gic, 3, { 0, spi, trigger }};
+	return irq_create_of_mapping(&irq_data);
+}
+
+static int __init tango_irq_init(struct device_node *node, struct device_node *parent)
+{
+	int spi, virq;
+	struct tango_intc *intc;
+
+	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
+	if (!intc)
+		panic("%s: Failed to kalloc\n", node->name);
+
+	virq = map_irq(parent, LEVEL_SPI, IRQ_TYPE_LEVEL_HIGH);
+	if (!virq)
+		panic("%s: Failed to map IRQ %d\n", node->name, LEVEL_SPI);
+
+	irq_set_chained_handler_and_data(virq, tango_level_isr, intc);
+
+	for (spi = 1; spi < SPI_MAX; ++spi) {
+		virq = map_irq(parent, spi, IRQ_TYPE_EDGE_RISING);
+		if (!virq)
+			panic("%s: Failed to map IRQ %d\n", node->name, spi);
+
+		irq_set_chained_handler_and_data(virq, tango_edge_isr, intc);
+	}
+
+	tango_intc = intc;
+	register_syscore_ops(&tango_syscore_ops);
+
+	spin_lock_init(&intc->lock);
+	intc->base = of_iomap(node, 0);
+	intc->dom = irq_domain_add_linear(node, IRQ_MAX, &dom_ops, intc);
+	if (!intc->base || !intc->dom)
+		panic("%s: Failed to setup IRQ controller\n", node->name);
+
+	return 0;
+}
+IRQCHIP_DECLARE(tango_intc, "sigma,smp8759-intc", tango_irq_init);
-- 
2.11.0
