From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 25 Nov 2012 01:47:41 +0100
Subject: [RFC 1/2] ARM: S3C24XX: add devicetree support for interrupts
In-Reply-To: <201211250145.21226.heiko@sntech.de>
References: <201211250145.21226.heiko@sntech.de>
Message-ID: <201211250147.42164.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds devicetree parsing of the controller-data for the
interrupt controllers on S3C24XX architectures.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../interrupt-controller/samsung,s3c24xx-irq.txt   |   57 ++++++
 arch/arm/mach-s3c24xx/common.h                     |    1 +
 arch/arm/plat-s3c24xx/irq.c                        |  197 ++++++++++++++++++++
 3 files changed, 255 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
new file mode 100644
index 0000000..c637637
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
@@ -0,0 +1,57 @@
+Samsung S3C24XX Interrupt Controllers
+
+The S3C24XX SoCs contain custom set of interrupt controllers providing a
+varying number of interrupt sources.
+
+The set consists of a main- and a sub-controller as well as a controller
+for the external interrupts and on newer SoCs even a second main controller.
+
+The bit-to-interrupt and parent mapping of the controllers is not fixed
+over all SoCs and therefore must be defined in the controller description.
+
+Required properties:
+- compatible: Compatible property value should be "samsung,s3c24xx-irq".
+
+- reg: Physical base address of the controller and length of memory mapped
+  region.
+
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
+
+- s3c24xx,irqlist : List of irqtypes found on this controller as
+  two-value pairs consisting of irqtype and parent-irq
+
+  parent-irq is always the list position of the irq in the irqlist
+  of the parent controller (0..31)
+
+  irqtypes are:
+  - 0 .. none
+  - 1 .. external interrupts in the main register (GPF0 .. GPF3)
+  - 2 .. edge irq in the main register
+  - 3 .. for parent-irqs, that have sub-irqs in child controllers
+  - 4 .. level irqs in the sub-register
+  - 5 .. edge irqs in the sub-register
+  - 6 .. external irqs in the external irq register (starting with GPF4)
+  - 7 .. irq in the second base irq controller of S3C2416/S3C2450 SoCs
+
+Optional properties:
+- interrupt_parent : The parent interrupt controller
+
+Example:
+
+	intc2:interrupt-controller at 4a000040 {
+		compatible = "samsung,s3c24xx-irq";
+		reg = <0x4a000040 0x18>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		s3c24xx,irqlist = <7 0 /* 2D */
+				   7 0 /* IIC1 */
+				   0 0 /* reserved */
+				   0 0 /* reserved */
+				   7 0 /* PCM0 */
+				   7 0 /* PCM1 */
+				   7 0 /* I2S0 */
+				   7 0>; /* I2S1 */
+	};
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index ed6276f..7a7b770 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -16,5 +16,6 @@ void s3c2410_restart(char mode, const char *cmd);
 void s3c244x_restart(char mode, const char *cmd);
 
 extern struct syscore_ops s3c24xx_irq_syscore_ops;
+extern void s3c24xx_init_irq_of(void);
 
 #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index 0510627..4f8fe4a 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -25,6 +25,9 @@
 #include <linux/slab.h>
 
 #include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
@@ -956,3 +959,197 @@ void __init s3c2443_init_irq(void)
 	s3c24xx_init_irq();
 }
 #endif
+
+#ifdef CONFIG_OF
+static int __init s3c24xx_init_intc_of(struct device_node *np,
+				       struct device_node *interrupt_parent)
+{
+	struct s3c_irq_intc *intc;
+	struct s3c_irq_intc *parent;
+	struct s3c_irq_data *irq_data;
+	struct property *intc_prop;
+	int irq_num = 0, irq_start = 0, irq_offset = 0;
+	int ret, i, cnt;
+	const __be32 *p;
+	u32 val;
+
+	intc = kzalloc(sizeof(struct s3c_irq_intc), GFP_KERNEL);
+	if (!intc)
+		return -ENOMEM;
+
+	p = of_get_address(np, 0, NULL, NULL);
+	if (!p) {
+		pr_err("irq: register address missing\n");
+		ret = -EINVAL;
+		goto err_addr;
+	}
+
+	/* select the correct data for the controller.
+	 * Need to hard code the irq num start and offset
+	 * to preserve the static mapping for now
+	 */
+	switch (of_translate_address(np, p)) {
+	case 0x4a000000:
+		pr_debug("irq: found main intc\n");
+		intc->reg_pending = S3C2410_SRCPND;
+		intc->reg_intpnd = S3C2410_INTPND;
+		intc->reg_mask = S3C2410_INTMSK;
+		irq_num = 32;
+		irq_start = S3C2410_IRQ(0);
+		irq_offset = 0;
+		break;
+	case 0x560000a4:
+		pr_debug("irq: found extintc\n");
+		intc->reg_pending = S3C2410_EINTPEND;
+		intc->reg_mask = S3C2410_EINTMASK;
+		irq_num = 20;
+		irq_start = S3C2410_IRQ(32);
+		irq_offset = 4;
+		break;
+	case 0x4a000018:
+		pr_debug("irq: found subintc\n");
+		intc->reg_pending = S3C2410_SUBSRCPND;
+		intc->reg_mask = S3C2410_INTSUBMSK;
+		irq_num = 29;
+		irq_start = S3C2410_IRQSUB(0);
+		irq_offset = 0;
+		break;
+	case 0x4a000040:
+		pr_debug("irq: found intc2\n");
+		intc->reg_pending = S3C2416_SRCPND2;
+		intc->reg_intpnd = S3C2416_INTPND2;
+		intc->reg_mask = S3C2416_INTMSK2;
+		irq_num = 8;
+		irq_start = S3C2416_IRQ(0);
+		irq_offset = 0;
+		break;
+	case 0:
+		pr_err("irq: couldn't translate address\n");
+		ret = -EINVAL;
+		goto err_addr;
+	default:
+		pr_err("irq: unsupported controller address\n");
+		ret = -EINVAL;
+		goto err_addr;
+	}
+
+	irq_data = kzalloc(sizeof(struct s3c_irq_data) * 32, GFP_KERNEL);
+	if (!irq_data) {
+		ret = -ENOMEM;
+		goto err_addr;
+	}
+
+	cnt = 0;
+	intc_prop = of_find_property(np, "s3c24xx,irqlist", NULL);
+	if (!intc_prop) {
+		pr_err("irq: irqlist not found\n");
+		ret = -EINVAL;
+		goto err_data;
+	}
+
+	/* build the irq_data list */
+	p = NULL;
+	for (i = 0; i < 32; i++) {
+		p = of_prop_next_u32(intc_prop, p, &val);
+
+		/* when we hit the first non-valid element, assume it's
+		 * the end of the list. The rest of the fields are
+		 * already of type S3C_IRQTYPE_NONE (value 0)
+		 */
+		if (!p)
+			break;
+
+		irq_data[i].type = val;
+
+		p = of_prop_next_u32(intc_prop, p, &val);
+		if (!p) {
+			pr_warn("irq: uneven number of elements in irqlist, last value will be dropped\n");
+			irq_data[i].type = 0;
+			break;
+		}
+
+		irq_data[i].parent_irq = val;
+
+		pr_debug("irq: found hwirq %d with type %d and parent %lu\n",
+			 i, irq_data[i].type, irq_data[i].parent_irq);
+		cnt++;
+	}
+
+	/* if we haven't found any irq definition@all,
+	 * something is very wrong.
+	 */
+	if (!cnt) {
+		pr_err("irq: empty irq definition\n");
+		ret = -EINVAL;
+		goto err_data;
+	}
+
+	intc->irqs = irq_data;
+
+	/* put the intc into the dt as property, so we can access it from
+	 * as the interrupt_parent later
+	 */
+
+	intc_prop = kzalloc(sizeof(struct property), GFP_KERNEL);
+	if (!intc_prop) {
+		ret = -ENOMEM;
+		goto err_data;
+	}
+
+	intc_prop->name = kstrdup("s3c-irq-intc", GFP_KERNEL);
+	intc_prop->value = intc;
+	intc_prop->length = sizeof(struct s3c_irq_intc);
+
+	ret = prom_add_property(np, intc_prop);
+	if (ret) {
+		pr_err("irq: failed to add dt property\n");
+		goto err_prop;
+	}
+
+	/* set the parent relationship */
+	if (interrupt_parent) {
+		parent = (struct s3c_irq_intc *)of_get_property(
+				      interrupt_parent, "s3c-irq-intc", NULL);
+		if (!parent) {
+			pr_err("irq: no parent for non-root controller found\n");
+			goto err_domain;
+		}
+
+		intc->parent = parent;
+	}
+
+	/* now that all the data is complete, init the irq-domain */
+	s3c24xx_clear_intc(intc);
+	intc->domain = irq_domain_add_legacy(np, irq_num, irq_start,
+					     irq_offset, &s3c24xx_irq_ops,
+					     intc);
+	if (!intc->domain) {
+		pr_err("irq: could not create irq-domain\n");
+		ret = -EINVAL;
+		goto err_domain;
+	}
+
+	return 0;
+
+err_domain:
+	prom_remove_property(np, intc_prop);
+err_prop:
+	kfree(intc_prop);
+err_data:
+	kfree(irq_data);
+err_addr:
+	kfree(intc);
+
+	return ret;
+}
+
+static const struct of_device_id s3c24xx_irq_match[] __initconst = {
+	{ .compatible = "samsung,s3c24xx-irq", .data = s3c24xx_init_intc_of, },
+	{ /* sentinel */ }
+};
+
+void __init s3c24xx_init_irq_of(void)
+{
+	of_irq_init(s3c24xx_irq_match);
+}
+#endif
-- 
1.7.2.3
