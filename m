From: carlo.caione@gmail.com (Carlo Caione)
Date: Mon,  6 Jan 2014 18:41:35 +0100
Subject: [PATCH v2 1/3] ARM: sun7i: irqchip: Add irqchip driver for NMI
 controller
In-Reply-To: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
References: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
Message-ID: <1389030097-10822-2-git-send-email-carlo.caione@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A20 SoCs have special registers to control / (un)mask /
acknowledge NMI. This NMI controller is separated and independent from GIC.
This patch adds a new irqchip to manage NMI.

Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
---
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-sun7i-nmi.c | 191 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100644 drivers/irqchip/irq-sun7i-nmi.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c60b901..d6ad783 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
 obj-$(CONFIG_ARCH_MOXART)		+= irq-moxart.o
 obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
+obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun7i-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
diff --git a/drivers/irqchip/irq-sun7i-nmi.c b/drivers/irqchip/irq-sun7i-nmi.c
new file mode 100644
index 0000000..c36a236
--- /dev/null
+++ b/drivers/irqchip/irq-sun7i-nmi.c
@@ -0,0 +1,191 @@
+/*
+ * Allwinner A20 SoCs NMI IRQ chip driver.
+ *
+ * Carlo Caione <carlo.caione@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/irqchip/chained_irq.h>
+#include "irqchip.h"
+
+#define SUN7I_NMI_IRQ_CTRL_REG	0x00
+#define SUN7I_NMI_IRQ_PEND_REG	0x04
+#define SUN7I_NMI_IRQ_EN_REG	0x08
+
+#define SUN7I_NMI_SRC_TYPE_MASK	0x00000003
+
+enum {
+	SUN7I_SRC_TYPE_LEVEL_LOW = 0,
+	SUN7I_SRC_TYPE_EDGE_FALLING,
+	SUN7I_SRC_TYPE_LEVEL_HIGH,
+	SUN7I_SRC_TYPE_EDGE_RISING,
+};
+
+/*
+ * Ack level interrupts right before unmask
+ *
+ * In case of level-triggered interrupt, IRQ line must be acked before it
+ * is unmasked or else a double-interrupt is triggered
+ */
+
+static void sun7i_sc_nmi_ack_and_unmask(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	u32 mask = d->mask;
+
+	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK)
+		ct->chip.irq_ack(d);
+
+	irq_gc_lock(gc);
+	irq_reg_writel(mask, gc->reg_base + ct->regs.mask);
+	irq_gc_unlock(gc);
+}
+
+static inline void sun7i_sc_nmi_write(struct irq_chip_generic *gc, u32 off,
+				      u32 val)
+{
+	irq_reg_writel(val, gc->reg_base + off);
+}
+
+static inline u32 sun7i_sc_nmi_read(struct irq_chip_generic *gc, u32 off)
+{
+	return irq_reg_readl(gc->reg_base + off);
+}
+
+static void sun7i_sc_nmi_handle_irq(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_domain *domain = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_get_chip(irq);
+	unsigned int virq = irq_find_mapping(domain, 0);
+
+	chained_irq_enter(chip, desc);
+	generic_handle_irq(virq);
+	chained_irq_exit(chip, desc);
+}
+
+static int sun7i_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	u32 src_type_reg;
+	unsigned int src_type;
+
+	irq_gc_lock(gc);
+
+	switch (flow_type & IRQF_TRIGGER_MASK) {
+	case IRQ_TYPE_EDGE_FALLING:
+		src_type = SUN7I_SRC_TYPE_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		src_type = SUN7I_SRC_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		src_type = SUN7I_SRC_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_NONE:
+	case IRQ_TYPE_LEVEL_LOW:
+		src_type = SUN7I_SRC_TYPE_LEVEL_LOW;
+		break;
+	default:
+		irq_gc_unlock(gc);
+		pr_err("%s: Cannot assign multiple trigger modes to IRQ %d.\n",
+			__func__, data->irq);
+		return -EBADR;
+	}
+
+	irqd_set_trigger_type(data, flow_type);
+	irq_setup_alt_chip(data, flow_type);
+
+	src_type_reg = sun7i_sc_nmi_read(gc, SUN7I_NMI_IRQ_CTRL_REG);
+	src_type_reg &= ~SUN7I_NMI_SRC_TYPE_MASK;
+	src_type_reg |= src_type;
+	sun7i_sc_nmi_write(gc, SUN7I_NMI_IRQ_CTRL_REG, src_type_reg);
+
+	irq_gc_unlock(gc);
+
+	return IRQ_SET_MASK_OK;
+}
+
+static int __init sun7i_sc_nmi_irq_init(struct device_node *node,
+					struct device_node *parent)
+{
+	struct irq_domain *domain;
+	struct irq_chip_generic *gc;
+	unsigned int irq;
+	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	int ret;
+
+	domain = irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL);
+	if (!domain) {
+		pr_err("%s: Could not register interrupt domain.\n", node->name);
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(domain, 1, 2, node->name,
+					     handle_level_irq, clr, 0,
+					     IRQ_GC_INIT_MASK_CACHE);
+	if (ret) {
+		 pr_err("%s: Could not allocate generic interrupt chip.\n",
+			 node->name);
+		 goto fail_irqd_remove;
+	}
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq <= 0) {
+		pr_err("%s: unable to parse irq\n", node->name);
+		ret = -EINVAL;
+		goto fail_irqd_remove;
+	}
+
+	gc = irq_get_domain_generic_chip(domain, 0);
+	gc->reg_base = of_iomap(node, 0);
+	if (!gc->reg_base) {
+		pr_err("%s: unable to map resource\n", node->name);
+		ret = -ENOMEM;
+		goto fail_irqd_remove;
+	}
+
+	gc->chip_types[0].type			= IRQ_TYPE_LEVEL_MASK;
+	gc->chip_types[0].chip.irq_ack		= irq_gc_ack_set_bit;
+	gc->chip_types[0].chip.irq_mask		= irq_gc_mask_clr_bit;
+	gc->chip_types[0].chip.irq_unmask	= sun7i_sc_nmi_ack_and_unmask;
+	gc->chip_types[0].chip.irq_set_type	= sun7i_sc_nmi_set_type;
+	gc->chip_types[0].regs.ack		= SUN7I_NMI_IRQ_PEND_REG;
+	gc->chip_types[0].regs.mask		= SUN7I_NMI_IRQ_EN_REG;
+
+	gc->chip_types[1].type			= IRQ_TYPE_EDGE_BOTH;
+	gc->chip_types[1].chip.name		= gc->chip_types[0].chip.name;
+	gc->chip_types[1].chip.irq_ack		= irq_gc_ack_set_bit;
+	gc->chip_types[1].chip.irq_mask		= irq_gc_mask_clr_bit;
+	gc->chip_types[1].chip.irq_unmask	= sun7i_sc_nmi_ack_and_unmask;
+	gc->chip_types[1].chip.irq_set_type	= sun7i_sc_nmi_set_type;
+	gc->chip_types[1].regs.ack		= SUN7I_NMI_IRQ_PEND_REG;
+	gc->chip_types[1].regs.mask		= SUN7I_NMI_IRQ_EN_REG;
+	gc->chip_types[1].handler		= handle_edge_irq;
+
+	irq_set_handler_data(irq, domain);
+	irq_set_chained_handler(irq, sun7i_sc_nmi_handle_irq);
+
+	sun7i_sc_nmi_write(gc, SUN7I_NMI_IRQ_EN_REG, 0);
+	sun7i_sc_nmi_write(gc, SUN7I_NMI_IRQ_PEND_REG, 0x1);
+
+	return 0;
+
+fail_irqd_remove:
+	irq_domain_remove(domain);
+	return ret;
+}
+
+IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-sc-nmi", sun7i_sc_nmi_irq_init);
-- 
1.8.5.2
