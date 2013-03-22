From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 22 Mar 2013 18:46:46 +0100
Subject: [PATCH v4 5/5] irqchip: s3c24xx: add devicetree support
In-Reply-To: <201303221843.37668.heiko@sntech.de>
References: <201303221843.37668.heiko@sntech.de>
Message-ID: <201303221846.46473.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary code to initialize the interrupt controller
thru devicetree data using the irqchip infrastructure.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../interrupt-controller/samsung,s3c24xx-irq.txt   |   64 +++++++
 drivers/irqchip/irq-s3c24xx.c                      |  181 ++++++++++++++++++++
 2 files changed, 245 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
new file mode 100644
index 0000000..bfd689b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
@@ -0,0 +1,64 @@
+Samsung S3C24XX Interrupt Controllers
+
+The S3C24XX SoCs contain a custom set of interrupt controllers providing a
+varying number of interrupt sources. The set consists of a main- and sub-
+controller and on newer SoCs even a second main controller.
+
+Required properties:
+- compatible: Compatible property value should be "samsung,s3c24xx-irq",
+
+- reg: Physical base address of the controller and length of memory mapped
+  region.
+
+- interrupt-controller : Identifies the node as an interrupt controller
+
+Sub-controllers as child nodes:
+  The interrupt controllers that should be referenced by device nodes are
+  represented by child nodes. Valid names are intc, subintc and intc2.
+  The interrupt values in device nodes are than mapped directly to the
+  bit-numbers of the pending register of the named interrupt controller.
+
+  Interrupts properties using sub-controller also should contain the hwirq
+  of their parent interrupt in the main controller as third interrupt-cell.
+
+Required properties:
+- interrupt-controller : Identifies the node as an interrupt controller
+
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2 for the main controllers and 3
+  for the sub-controller.
+
+Example:
+
+	interrupt-controller at 4a000000 {
+		compatible = "samsung,s3c24xx-irq";
+		reg = <0x4a000000 0x100>;
+		interrupt-controller;
+
+		intc:intc {
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		subintc:subintc {
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+
+	[...]
+
+	serial at 50000000 {
+		compatible = "samsung,s3c2410-uart";
+		reg = <0x50000000 0x4000>;
+		interrupt-parent = <&subintc>;
+		interrupts = <0 4 28>, <1 4 28>;
+	};
+
+	rtc at 57000000 {
+		compatible = "samsung,s3c2410-rtc";
+		reg = <0x57000000 0x100>;
+		interrupt-parent = <&intc>;
+		interrupts = <30 3>, <8 3>;
+		status = "disabled";
+	};
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 7cba4f0..c26eb3f 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -25,6 +25,9 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
@@ -36,6 +39,8 @@
 #include <plat/regs-irqtype.h>
 #include <plat/pm.h>
 
+#include "irqchip.h"
+
 #define S3C_IRQTYPE_NONE	0
 #define S3C_IRQTYPE_EINT	1
 #define S3C_IRQTYPE_EDGE	2
@@ -1128,3 +1133,179 @@ void __init s3c2443_init_irq(void)
 	s3c24xx_init_intc(NULL, &init_s3c2443subint[0], main_intc, 0x4a000018);
 }
 #endif
+
+#ifdef CONFIG_OF
+static int s3c24xx_irq_map_of(struct irq_domain *h, unsigned int virq,
+							irq_hw_number_t hw)
+{
+	struct s3c_irq_intc *intc = h->host_data;
+	struct s3c_irq_intc *parent_intc = intc->parent;
+	struct s3c_irq_data *irq_data = &intc->irqs[hw];
+
+	/* attach controller pointer to irq_data */
+	irq_data->intc = intc;
+
+	if (!parent_intc)
+		irq_set_chip_and_handler(virq, &s3c_irq_chip, handle_edge_irq);
+	else
+		irq_set_chip_and_handler(virq, &s3c_irq_level_chip,
+					 handle_edge_irq);
+
+	set_irq_flags(virq, IRQF_VALID);
+
+	return 0;
+}
+
+static struct irq_domain_ops s3c24xx_irq_ops_of_main = {
+	.map = s3c24xx_irq_map_of,
+	.xlate = irq_domain_xlate_twocell,
+};
+
+static int s3c_irq_xlate_subintc(struct irq_domain *d, struct device_node *n,
+			const u32 *intspec, unsigned int intsize,
+			irq_hw_number_t *out_hwirq, unsigned int *out_type)
+{
+	struct s3c_irq_intc *intc = d->host_data;
+	struct s3c_irq_intc *parent_intc = intc->parent;
+	struct s3c_irq_data *irq_data = &intc->irqs[intspec[0]];
+	struct s3c_irq_data *parent_irq_data;
+
+	int irqno;
+
+	if (WARN_ON(intsize < 3))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+
+	irqno = irq_create_mapping(parent_intc->domain, intspec[2]);
+	if (irqno < 0) {
+		pr_err("irq: could not map parent interrupt\n");
+		return irqno;
+	}
+
+	irq_data->parent_irq = intspec[2];
+	parent_irq_data = &parent_intc->irqs[irq_data->parent_irq];
+	parent_irq_data->sub_intc = intc;
+	parent_irq_data->sub_bits |= (1UL << intspec[0]);
+
+	irq_set_chained_handler(irqno, s3c_irq_demux);
+
+	return 0;
+}
+
+static struct irq_domain_ops s3c24xx_irq_ops_of_sub = {
+	.map = s3c24xx_irq_map_of,
+	.xlate = s3c_irq_xlate_subintc,
+};
+
+struct s3c24xx_irq_of_ctrl {
+	char			*name;
+	unsigned long		offset;
+	struct s3c_irq_intc	**handle;
+	struct s3c_irq_intc	**parent;
+	struct irq_domain_ops	*ops;
+};
+
+static struct s3c24xx_irq_of_ctrl s3c24xx_ctrl[] = {
+	{
+		.name = "intc",
+		.offset = 0,
+		.handle = &main_intc,
+		.ops = &s3c24xx_irq_ops_of_main,
+	}, {
+		.name = "subintc",
+		.offset = 0x18,
+		.parent = &main_intc,
+		.ops = &s3c24xx_irq_ops_of_sub,
+	}, {
+		.name = "intc2",
+		.offset = 0x40,
+		.handle = &main_intc2,
+		.ops = &s3c24xx_irq_ops_of_main,
+	}
+};
+
+int __init s3c24xx_init_intc_of(struct device_node *np,
+				 struct device_node *interrupt_parent)
+{
+	struct device_node *intc_node;
+	struct s3c_irq_intc *intc;
+	struct s3c24xx_irq_of_ctrl *ctrl;
+	void __iomem *reg_base;
+	int i;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base) {
+		pr_err("irq-s3c24xx: could not map irq registers\n");
+		return -EINVAL;
+	}
+
+	set_handle_irq(s3c24xx_handle_irq);
+
+	for (i = 0; i < ARRAY_SIZE(s3c24xx_ctrl); i++) {
+		ctrl = &s3c24xx_ctrl[i];
+
+		intc_node = of_find_node_by_name(np, ctrl->name);
+		if (!intc_node) {
+			pr_debug("irq: no device node for %s\n",
+				ctrl->name);
+			continue;
+		}
+
+		intc = kzalloc(sizeof(struct s3c_irq_intc), GFP_KERNEL);
+		if (!intc) {
+			of_node_put(intc_node);
+			return -ENOMEM;
+		}
+
+		pr_debug("irq: found controller %s\n", ctrl->name);
+
+		intc->irqs = kzalloc(sizeof(struct s3c_irq_data) * 32,
+				     GFP_KERNEL);
+		if (!intc->irqs) {
+			kfree(intc);
+			of_node_put(intc_node);
+			return -ENOMEM;
+		}
+
+		if (ctrl->parent) {
+			intc->reg_pending = reg_base + ctrl->offset;
+			intc->reg_mask = reg_base + ctrl->offset + 0x4;
+
+			if (*(ctrl->parent)) {
+				intc->parent = *(ctrl->parent);
+			} else {
+				pr_warn("irq: parent of %s missing\n",
+					ctrl->name);
+				kfree(intc->irqs);
+				kfree(intc);
+				of_node_put(intc_node);
+				continue;
+			}
+		} else {
+			intc->reg_pending = reg_base + ctrl->offset;
+			intc->reg_mask = reg_base + ctrl->offset + 0x08;
+			intc->reg_intpnd = reg_base + ctrl->offset + 0x10;
+		}
+
+		/* now that all the data is complete, init the irq-domain */
+		s3c24xx_clear_intc(intc);
+		intc->domain = irq_domain_add_linear(intc_node, 32,
+						     ctrl->ops, intc);
+		if (!intc->domain) {
+			pr_err("irq: could not create irq-domain\n");
+			kfree(intc->irqs);
+			kfree(intc);
+			of_node_put(intc_node);
+			continue;
+		}
+
+		if (ctrl->handle)
+			*(ctrl->handle) = intc;
+	}
+
+	return 0;
+}
+IRQCHIP_DECLARE(s3c24xx_irq, "samsung,s3c24xx-irq", s3c24xx_init_intc_of);
+#endif
-- 
1.7.2.3
