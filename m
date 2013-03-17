From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 17 Mar 2013 14:07:58 +0100
Subject: [PATCH v3 5/6] irqchip: s3c24xx: add devicetree support
In-Reply-To: <201303171404.06146.heiko@sntech.de>
References: <201303171404.06146.heiko@sntech.de>
Message-ID: <201303171407.59128.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary code to initialize the interrupt controller
thru devicetree data using the irqchip infrastructure.

On dt machines the eint-type interrupts in the main interrupt controller
get mapped as regular edge-types, as their wakeup and interrupt type
properties will be handled by the upcoming pinctrl driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../interrupt-controller/samsung,s3c24xx-irq.txt   |   54 +++++
 drivers/irqchip/irq-s3c24xx.c                      |  222 ++++++++++++++++++++
 2 files changed, 276 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
new file mode 100644
index 0000000..be5dead
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
@@ -0,0 +1,54 @@
+Samsung S3C24XX Interrupt Controllers
+
+The S3C24XX SoCs contain a custom set of interrupt controllers providing a
+varying number of interrupt sources. The set consists of a main- and sub-
+controller and on newer SoCs even a second main controller.
+
+Required properties:
+- compatible: Compatible property value should be one of "samsung,s3c2410-irq",
+  "samsung,s3c2412-irq", "samsung,s3c2416-irq", "samsung,s3c2440-irq",
+  "samsung,s3c2442-irq", "samsung,s3c2443-irq" depending on the SoC variant.
+
+- reg: Physical base address of the controller and length of memory mapped
+  region.
+
+- interrupt-controller : Identifies the node as an interrupt controller
+
+Sub-controllers as child nodes:
+  The interrupt controllers that should be referenced by device nodes are
+  represented by child nodes. Valid names are intc, subintc and intc2.
+  The interrupt values in device nodes are then mapped directly to the
+  bit-numbers of the pending register of the named interrupt controller.
+
+Required properties:
+- interrupt-controller : Identifies the node as an interrupt controller
+
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
+
+Example:
+
+	interrupt-controller at 4a000000 {
+		compatible = "samsung,s3c2416-irq";
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
+			#interrupt-cells = <2>;
+		};
+	};
+
+	[...]
+
+	serial at 50000000 {
+		compatible = "samsung,s3c2410-uart";
+		reg = <0x50000000 0x4000>;
+		interrupt-parent = <&subintc>;
+		interrupts = <0 0>, <1 0>;
+	};
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 1eba289..55cb363 100644
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
@@ -380,6 +385,10 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 
 	parent_intc = intc->parent;
 
+	/* on dt platforms the extints get handled by the pinctrl driver */
+	if (h->of_node && irq_data->type == S3C_IRQTYPE_EINT)
+		irq_data->type = S3C_IRQTYPE_EDGE;
+
 	/* set handler and flags */
 	switch (irq_data->type) {
 	case S3C_IRQTYPE_NONE:
@@ -1104,3 +1113,216 @@ void __init s3c2443_init_irq(void)
 	s3c24xx_init_intc(NULL, &init_s3c2443subint[0], main_intc, 0x4a000018);
 }
 #endif
+
+#ifdef CONFIG_OF
+struct s3c24xx_irq_of_ctrl {
+	char			*name;
+	unsigned long		offset;
+	struct s3c_irq_data	*irq_data;
+	struct s3c_irq_intc	**handle;
+	struct s3c_irq_intc	**parent;
+};
+
+#define S3C24XX_IRQCTRL(n, o, d, h, p)		\
+{						\
+	.name		= n,			\
+	.offset		= o,			\
+	.irq_data	= d,			\
+	.handle		= h,			\
+	.parent		= p,			\
+}
+
+struct s3c24xx_irq_of_data {
+	struct s3c24xx_irq_of_ctrl	*irq_ctrl;
+	int				num_ctrl;
+};
+
+#ifdef CONFIG_CPU_S3C2410
+static struct s3c24xx_irq_of_ctrl s3c2410_ctrl[] = {
+	S3C24XX_IRQCTRL("intc", 0, init_s3c2410base, &main_intc, NULL),
+	S3C24XX_IRQCTRL("subintc", 0x18, init_s3c2410subint, NULL, &main_intc),
+};
+
+static struct s3c24xx_irq_of_data s3c2410_irq_data = {
+	.irq_ctrl = s3c2410_ctrl,
+	.num_ctrl = ARRAY_SIZE(s3c2410_ctrl),
+};
+#endif
+
+#ifdef CONFIG_CPU_S3C2412
+static struct s3c24xx_irq_of_ctrl s3c2412_ctrl[] = {
+	S3C24XX_IRQCTRL("intc", 0, init_s3c2412base, &main_intc, NULL),
+	S3C24XX_IRQCTRL("subintc", 0x18, init_s3c2412subint, NULL, &main_intc),
+};
+
+static struct s3c24xx_irq_of_data s3c2412_irq_data = {
+	.irq_ctrl = s3c2412_ctrl,
+	.num_ctrl = ARRAY_SIZE(s3c2412_ctrl),
+};
+#endif
+
+#ifdef CONFIG_CPU_S3C2416
+static struct s3c24xx_irq_of_ctrl s3c2416_ctrl[] = {
+	S3C24XX_IRQCTRL("intc", 0, init_s3c2416base, &main_intc, NULL),
+	S3C24XX_IRQCTRL("subintc", 0x18, init_s3c2416subint, NULL, &main_intc),
+	S3C24XX_IRQCTRL("intc2", 0x40, init_s3c2416_second, &main_intc2, NULL),
+};
+
+static struct s3c24xx_irq_of_data s3c2416_irq_data = {
+	.irq_ctrl = s3c2416_ctrl,
+	.num_ctrl = ARRAY_SIZE(s3c2416_ctrl),
+};
+#endif
+
+#ifdef CONFIG_CPU_S3C2440
+static struct s3c24xx_irq_of_ctrl s3c2440_ctrl[] = {
+	S3C24XX_IRQCTRL("intc", 0, init_s3c2440base, &main_intc, NULL),
+	S3C24XX_IRQCTRL("subintc", 0x18, init_s3c2440subint, NULL, &main_intc),
+};
+
+static struct s3c24xx_irq_of_data s3c2440_irq_data = {
+	.irq_ctrl = s3c2440_ctrl,
+	.num_ctrl = ARRAY_SIZE(s3c2440_ctrl),
+};
+#endif
+
+#ifdef CONFIG_CPU_S3C2442
+static struct s3c24xx_irq_of_ctrl s3c2442_ctrl[] = {
+	S3C24XX_IRQCTRL("intc", 0, init_s3c2442base, &main_intc, NULL),
+	S3C24XX_IRQCTRL("subintc", 0x18, init_s3c2442subint, NULL, &main_intc),
+};
+
+static struct s3c24xx_irq_of_data s3c2442_irq_data = {
+	.irq_ctrl = s3c2442_ctrl,
+	.num_ctrl = ARRAY_SIZE(s3c2442_ctrl),
+};
+#endif
+
+#ifdef CONFIG_CPU_S3C2443
+static struct s3c24xx_irq_of_ctrl s3c2443_ctrl[] = {
+	S3C24XX_IRQCTRL("intc", 0, init_s3c2443base, &main_intc, NULL),
+	S3C24XX_IRQCTRL("subintc", 0x18, init_s3c2443subint, NULL, &main_intc),
+};
+
+static struct s3c24xx_irq_of_data s3c2443_irq_data = {
+	.irq_ctrl = s3c2443_ctrl,
+	.num_ctrl = ARRAY_SIZE(s3c2443_ctrl),
+};
+#endif
+
+static const struct of_device_id intc_list[] = {
+#ifdef CONFIG_CPU_S3C2410
+	{ .compatible = "samsung,s3c2410-irq", .data = &s3c2410_irq_data },
+#endif
+#ifdef CONFIG_CPU_S3C2412
+	{ .compatible = "samsung,s3c2412-irq", .data = &s3c2412_irq_data },
+#endif
+#ifdef CONFIG_CPU_S3C2416
+	{ .compatible = "samsung,s3c2416-irq", .data = &s3c2416_irq_data },
+#endif
+#ifdef CONFIG_CPU_S3C2440
+	{ .compatible = "samsung,s3c2440-irq", .data = &s3c2440_irq_data },
+#endif
+#ifdef CONFIG_CPU_S3C2442
+	{ .compatible = "samsung,s3c2442-irq", .data = &s3c2442_irq_data },
+#endif
+#ifdef CONFIG_CPU_S3C2443
+	{ .compatible = "samsung,s3c2443-irq", .data = &s3c2443_irq_data },
+#endif
+	{},
+};
+
+int __init s3c24xx_init_intc_of(struct device_node *np,
+				 struct device_node *interrupt_parent)
+{
+	const struct of_device_id *match;
+	const struct s3c24xx_irq_of_data *ctrl_data;
+	struct device_node *intc_node;
+	struct s3c24xx_irq_of_ctrl *ctrl;
+	struct s3c_irq_intc *intc;
+	void __iomem *reg_base;
+	int i;
+
+	match = of_match_node(intc_list, np);
+	if (!match) {
+		pr_err("irq-s3c24xx: could not find matching irqdata\n");
+		return -EINVAL;
+	}
+
+	ctrl_data = match->data;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base) {
+		pr_err("irq-s3c24xx: could not map irq memory\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ctrl_data->num_ctrl; i++) {
+		ctrl = &ctrl_data->irq_ctrl[i];
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
+		intc->irqs = ctrl->irq_data;
+
+		if (ctrl->parent) {
+			if (*(ctrl->parent)) {
+				intc->parent = *(ctrl->parent);
+			} else {
+				pr_warn("irq: parent of %s missing\n",
+					ctrl->name);
+				kfree(intc);
+				of_node_put(intc_node);
+				continue;
+			}
+		}
+
+		if (!ctrl->parent) {
+			intc->reg_pending = reg_base + ctrl->offset;
+			intc->reg_mask = reg_base + ctrl->offset + 0x08;
+			intc->reg_intpnd = reg_base + ctrl->offset + 0x10;
+		} else {
+			intc->reg_pending = reg_base + ctrl->offset;
+			intc->reg_mask = reg_base + ctrl->offset + 0x4;
+		}
+
+		/* now that all the data is complete, init the irq-domain */
+		s3c24xx_clear_intc(intc);
+		intc->domain = irq_domain_add_linear(intc_node, 32,
+						     &s3c24xx_irq_ops, intc);
+		if (!intc->domain) {
+			pr_err("irq: could not create irq-domain\n");
+			kfree(intc);
+			of_node_put(intc_node);
+			continue;
+		}
+
+		if (ctrl->handle)
+			*(ctrl->handle) = intc;
+	}
+
+	set_handle_irq(s3c24xx_handle_irq);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(s3c2410_irq, "samsung,s3c2410-irq", s3c24xx_init_intc_of);
+IRQCHIP_DECLARE(s3c2412_irq, "samsung,s3c2412-irq", s3c24xx_init_intc_of);
+IRQCHIP_DECLARE(s3c2416_irq, "samsung,s3c2416-irq", s3c24xx_init_intc_of);
+IRQCHIP_DECLARE(s3c2440_irq, "samsung,s3c2440-irq", s3c24xx_init_intc_of);
+IRQCHIP_DECLARE(s3c2442_irq, "samsung,s3c2442-irq", s3c24xx_init_intc_of);
+IRQCHIP_DECLARE(s3c2443_irq, "samsung,s3c2443-irq", s3c24xx_init_intc_of);
+IRQCHIP_DECLARE(s3c2450_irq, "samsung,s3c2450-irq", s3c24xx_init_intc_of);
+#endif
-- 
1.7.2.3
