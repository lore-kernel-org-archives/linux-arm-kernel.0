From: slash.tmp@free.fr (Mason)
Date: Mon, 28 Aug 2017 15:58:35 +0200
Subject: [PATCH v7] irqchip: Add support for tango interrupt mapper
In-Reply-To: <29109a5f-3c0d-374a-97d5-f98b365d0e0e@arm.com>
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
 <eea0ba7d-15d2-fb20-7c23-b2d3c4a7cfa7@free.fr>
 <ee9e4a52-9b21-d57f-1ae8-c7297d4386a6@arm.com>
 <21670cea-beaf-8a41-84fb-f3c892527b0e@free.fr>
 <29109a5f-3c0d-374a-97d5-f98b365d0e0e@arm.com>
Message-ID: <0ade4a95-c7b9-1904-c639-d986255c7530@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This controller maps 128 input lines to 24 output lines.
The 24 output lines are routed to GIC SPI 0 to 23.
This driver only allocates exclusive output lines (hierarchy).
Let the legacy controller mux latency-insensitive interrupts.
---
Changes from v6 to v7
* Muxing level interrupts leaves performance on the table => Give "important"
interrupts a dedicated output line (hierarchical setup). And let the legacy
interrupt controller mux "less important" interrupts.
* Use a bitmap to manage output line allocation
* Don't panic on error; clean up and return error code
---
 .../interrupt-controller/sigma,smp8759-intc.txt    |  18 +++
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-smp8759.c                      | 158 +++++++++++++++++++++
 3 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt
 create mode 100644 drivers/irqchip/irq-smp8759.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt
new file mode 100644
index 000000000000..f4864979ab44
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8759-intc.txt
@@ -0,0 +1,18 @@
+Sigma Designs SMP8759 interrupt mapper
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
index 000000000000..359ab706f504
--- /dev/null
+++ b/drivers/irqchip/irq-smp8759.c
@@ -0,0 +1,158 @@
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/syscore_ops.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+/*
+ * This controller maps IRQ_MAX input lines to SPI_MAX output lines.
+ * The output lines are routed to GIC SPI 0 to 23.
+ * This driver only allocates exclusive output lines (hierarchy).
+ * Let the legacy controller mux latency-insensitive interrupts.
+ */
+#define IRQ_MAX		128
+#define SPI_MAX		24
+#define IRQ_ENABLE	BIT(31)
+#define STATUS		0x420
+
+struct tango_intc {
+	void __iomem *base;
+	DECLARE_BITMAP(used_spi, SPI_MAX);
+	DECLARE_BITMAP(enabled_irq, IRQ_MAX);
+	u8 tango_irq_to_spi[IRQ_MAX];
+	spinlock_t lock;
+};
+
+static struct tango_intc *tango_intc;
+
+static void tango_mask(struct irq_data *data)
+{
+	unsigned long flags;
+	struct tango_intc *intc = data->chip_data;
+
+	spin_lock_irqsave(&intc->lock, flags);
+	writel_relaxed(0, intc->base + data->hwirq * 4);
+	__clear_bit(data->hwirq, intc->enabled_irq);
+	spin_unlock_irqrestore(&intc->lock, flags);
+
+	irq_chip_mask_parent(data);
+}
+
+static void tango_unmask(struct irq_data *data)
+{
+	unsigned long flags;
+	struct tango_intc *intc = data->chip_data;
+	u32 val = IRQ_ENABLE | intc->tango_irq_to_spi[data->hwirq];
+
+	spin_lock_irqsave(&intc->lock, flags);
+	writel_relaxed(val, intc->base + data->hwirq * 4);
+	__set_bit(data->hwirq, intc->enabled_irq);
+	spin_unlock_irqrestore(&intc->lock, flags);
+
+	irq_chip_unmask_parent(data);
+}
+
+static struct irq_chip tango_chip = {
+	.name		= "mapper",
+	.irq_mask	= tango_mask,
+	.irq_unmask	= tango_unmask,
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_set_type	= irq_chip_set_type_parent,
+};
+
+static int alloc_gic_irq(struct irq_domain *dom, uint virq, u32 spi, u32 type)
+{
+	struct fwnode_handle *gic = dom->parent->fwnode;
+	struct irq_fwspec gic_fwspec = { gic, 3, { 0, spi, type }};
+	return irq_domain_alloc_irqs_parent(dom, virq, 1, &gic_fwspec);
+}
+
+static int tango_alloc(struct irq_domain *dom, uint virq, uint nirq, void *arg)
+{
+	int err, spi;
+	unsigned long flags;
+	struct irq_fwspec *fwspec = arg;
+	struct tango_intc *intc = dom->host_data;
+	u32 hwirq = fwspec->param[0], type = fwspec->param[1];
+
+	if (type & IRQ_TYPE_EDGE_FALLING || type & IRQ_TYPE_LEVEL_LOW)
+		return -EINVAL;
+
+	spin_lock_irqsave(&intc->lock, flags);
+	spi = find_first_zero_bit(intc->used_spi, SPI_MAX);
+	if (spi >= SPI_MAX) {
+		spin_unlock_irqrestore(&intc->lock, flags);
+		return -ENOSPC;
+	}
+	__set_bit(spi, intc->used_spi);
+	spin_unlock_irqrestore(&intc->lock, flags);
+
+	err = alloc_gic_irq(dom, virq, spi, type);
+	if (err) {
+		spin_lock_irqsave(&intc->lock, flags);
+		__clear_bit(spi, intc->used_spi);
+		spin_unlock_irqrestore(&intc->lock, flags);
+		return err;
+	}
+
+	intc->tango_irq_to_spi[hwirq] = spi;
+	irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &tango_chip, intc);
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
+	struct tango_intc *intc = tango_intc;
+
+	for (hwirq = 0; hwirq < IRQ_MAX; ++hwirq) {
+		u32 val = intc->tango_irq_to_spi[hwirq];
+		if (test_bit(hwirq, intc->enabled_irq))
+			val |= IRQ_ENABLE;
+		writel_relaxed(val, intc->base + hwirq * 4);
+	}
+}
+
+static struct syscore_ops tango_syscore_ops = {
+	.resume	= tango_resume,
+};
+
+static int __init tango_irq_init(struct device_node *node, struct device_node *parent)
+{
+	struct tango_intc *intc;
+	struct irq_domain *dom, *gic_dom;
+
+	gic_dom = irq_find_host(parent);
+	if (!gic_dom)
+		return -ENODEV;
+
+	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
+	if (!intc)
+		return -ENOMEM;
+
+	intc->base = of_iomap(node, 0);
+	if (!intc->base) {
+		kfree(intc);
+		return -ENXIO;
+	}
+
+	dom = irq_domain_add_hierarchy(gic_dom, 0, IRQ_MAX, node, &dom_ops, intc);
+	if (!dom) {
+		iounmap(intc->base);
+		kfree(intc);
+		return -ENOMEM;
+	}
+
+	tango_intc = intc;
+	register_syscore_ops(&tango_syscore_ops);
+	spin_lock_init(&intc->lock);
+
+	return 0;
+}
+IRQCHIP_DECLARE(tango_intc, "sigma,smp8759-intc", tango_irq_init);
-- 
2.11.0
