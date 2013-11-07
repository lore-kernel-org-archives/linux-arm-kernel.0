From: andrew@lunn.ch (Andrew Lunn)
Date: Thu,  7 Nov 2013 11:35:29 +0100
Subject: [RESEND PATCH v2 1/3] irqchip: irq-dove: Add PMU interrupt controller.
Message-ID: <1383820531-4387-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dove has a Power Management Unit with its own interrupt
controller. This is chained on the main interrupt controller.  Add a
driver, making use of generic chip where possible.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

cc: devicetree at vger.kernel.org
cc: pawel.moll at arm.com
cc: mark.rutland at arm.com
cc: swarren at wwwdotorg.org
cc: ian.campbell at citrix.com
---
 .../interrupt-controller/marvell,dove-pmu-intc.txt |  17 +++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-dove.c                         | 126 +++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,dove-pmu-intc.txt
 create mode 100644 drivers/irqchip/irq-dove.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,dove-pmu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,dove-pmu-intc.txt
new file mode 100644
index 000000000000..1feb5825d372
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,dove-pmu-intc.txt
@@ -0,0 +1,17 @@
+Marvell Dove Power Management Unit interrupt controller
+
+Required properties:
+- compatible: shall be "marvell,dove-pmu-intc"
+- reg: base address of PMU interrupt registers starting with CAUSE register
+- interrupts: PMU interrupt of the main interrupt controller
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: number of cells to encode an interrupt source, shall be 1
+
+Example:
+	pmu_intc: pmu-interrupt-ctrl at d0050 {
+		compatible = "marvell,dove-pmu-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xd0050 0x8>;
+		interrupts = <33>;
+	};
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c60b9010b152..f743006ce7ad 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
+obj-$(CONFIG_ARCH_DOVE)			+= irq-dove.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
 obj-$(CONFIG_ARCH_MVEBU)		+= irq-armada-370-xp.o
diff --git a/drivers/irqchip/irq-dove.c b/drivers/irqchip/irq-dove.c
new file mode 100644
index 000000000000..788acd89848a
--- /dev/null
+++ b/drivers/irqchip/irq-dove.c
@@ -0,0 +1,126 @@
+/*
+ * Marvell Dove SoCs PMU IRQ chip driver.
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <asm/exception.h>
+#include <asm/mach/irq.h>
+
+#include "irqchip.h"
+
+#define DOVE_PMU_IRQ_CAUSE	0x00
+#define DOVE_PMU_IRQ_MASK	0x04
+
+static void dove_pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_domain *d = irq_get_handler_data(irq);
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, 0);
+	u32 stat = readl_relaxed(gc->reg_base + DOVE_PMU_IRQ_CAUSE) &
+		   gc->mask_cache;
+
+	while (stat) {
+		u32 hwirq = ffs(stat) - 1;
+
+		generic_handle_irq(irq_find_mapping(d, gc->irq_base + hwirq));
+		stat &= ~(1 << hwirq);
+	}
+}
+
+static void pmu_irq_ack(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	u32 mask = ~d->mask;
+
+	/*
+	 * The PMU mask register is not RW0C: it is RW.	 This means that
+	 * the bits take whatever value is written to them; if you write
+	 * a '1', you will set the interrupt.
+	 *
+	 * Unfortunately this means there is NO race free way to clear
+	 * these interrupts.
+	 *
+	 * So, let's structure the code so that the window is as small as
+	 * possible.
+	 */
+	irq_gc_lock(gc);
+	mask &= irq_reg_readl(gc->reg_base +  ct->regs.ack);
+	irq_reg_writel(mask, gc->reg_base +  ct->regs.ack);
+	irq_gc_unlock(gc);
+}
+
+static int __init dove_pmu_irq_init(struct device_node *np,
+				    struct device_node *parent)
+{
+	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	struct resource r;
+	struct irq_domain *domain;
+	struct irq_chip_generic *gc;
+	int ret, irq, nrirqs = 7;
+
+	domain = irq_domain_add_linear(np, nrirqs,
+				       &irq_generic_chip_ops, NULL);
+	if (!domain) {
+		pr_err("%s: unable to add irq domain\n", np->name);
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(domain, nrirqs, 1, np->name,
+			     handle_level_irq, clr, 0, IRQ_GC_INIT_MASK_CACHE);
+	if (ret) {
+		pr_err("%s: unable to alloc irq domain gc\n", np->name);
+		return ret;
+	}
+
+	ret = of_address_to_resource(np, 0, &r);
+	if (ret) {
+		pr_err("%s: unable to get resource\n", np->name);
+		return ret;
+	}
+
+	if (!request_mem_region(r.start, resource_size(&r), np->name)) {
+		pr_err("%s: unable to request mem region\n", np->name);
+		return -ENOMEM;
+	}
+
+	/* Map the parent interrupt for the chained handler */
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0) {
+		pr_err("%s: unable to parse irq\n", np->name);
+		return -EINVAL;
+	}
+
+	gc = irq_get_domain_generic_chip(domain, 0);
+	gc->reg_base = ioremap(r.start, resource_size(&r));
+	if (!gc->reg_base) {
+		pr_err("%s: unable to map resource\n", np->name);
+		return -ENOMEM;
+	}
+
+	gc->chip_types[0].regs.ack = DOVE_PMU_IRQ_CAUSE;
+	gc->chip_types[0].regs.mask = DOVE_PMU_IRQ_MASK;
+	gc->chip_types[0].chip.irq_ack = pmu_irq_ack;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
+	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
+
+	/* mask and clear all interrupts */
+	writel(0, gc->reg_base + DOVE_PMU_IRQ_MASK);
+	writel(0, gc->reg_base + DOVE_PMU_IRQ_CAUSE);
+
+	irq_set_handler_data(irq, domain);
+	irq_set_chained_handler(irq, dove_pmu_irq_handler);
+
+	return 0;
+}
+IRQCHIP_DECLARE(dove_pmu_intc,
+		"marvell,dove-pmu-intc", dove_pmu_irq_init);
-- 
1.8.4.rc3
