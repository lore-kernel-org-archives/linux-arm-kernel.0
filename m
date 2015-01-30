From: stefan@agner.ch (Stefan Agner)
Date: Fri, 30 Jan 2015 11:33:03 +0100
Subject: [PATCH v4 1/3] irqchip: vf610-mscm-ir: add support for MSCM interrupt
 router
In-Reply-To: <1422613985-11726-1-git-send-email-stefan@agner.ch>
References: <1422613985-11726-1-git-send-email-stefan@agner.ch>
Message-ID: <1422613985-11726-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for Vybrid's interrupt router. On VF6xx models,
almost all peripherals can be used by either of the two CPU's,
the Cortex-A5 or the Cortex-M4. The interrupt router routes the
peripheral interrupts to the configured CPU.

This IRQ chip driver configures the interrupt router to route
the requested interrupt to the CPU the kernel is running on.
The driver makes use of the irqdomain hierarchy support. The
parent is given by the device tree. This should be one of the
two possible parents either ARM GIC or the ARM NVIC interrupt
controller. The latter is currently not yet supported.

Note that there is no resource control mechnism implemented to
avoid concurrent access of the same peripheral. The user needs
to make sure to use device trees which assign the peripherals
orthogonally. However, this driver warns the user in case the
interrupt is already configured for the other CPU. This provides
a poor man's resource controller.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/Kconfig           |   1 +
 drivers/irqchip/Kconfig             |  11 ++
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-vf610-mscm-ir.c | 206 ++++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+)
 create mode 100644 drivers/irqchip/irq-vf610-mscm-ir.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e8627e0..3c5859e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -631,6 +631,7 @@ config SOC_IMX6SX
 
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
+	select VF610_MSCM
 	select ARM_GIC
 	select PINCTRL_VF610
 	select PL310_ERRATA_769419 if CACHE_L2X0
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index cc79d2a..9c13d81 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -136,6 +136,17 @@ config IRQ_CROSSBAR
 	  a free irq and configures the IP. Thus the peripheral interrupts are
 	  routed to one of the free irqchip interrupt lines.
 
+config VF610_MSCM_IR
+	bool
+	help
+	  Support for MSCM interrupt router available on Vybrid SoC's. The
+	  interrupt router is between the CPU's interrupt controller and the
+	  peripheral. The router allows to route the peripheral interrupts to
+	  one of the two available CPU's on Vybrid VF6xx SoC's (Cortex-A5 or
+	  Cortex-M4). The router will be configured transparently on a IRQ
+	  request.
+	select IRQ_DOMAIN_HIERARCHY
+
 config KEYSTONE_IRQ
 	tristate "Keystone 2 IRQ controller IP"
 	depends on ARCH_KEYSTONE
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 9516a32..04595f5 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
 obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
 obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
 obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
+obj-$(CONFIG_VF610_MSCM_IR)		+= irq-vf610-mscm-ir.o
 obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
diff --git a/drivers/irqchip/irq-vf610-mscm-ir.c b/drivers/irqchip/irq-vf610-mscm-ir.c
new file mode 100644
index 0000000..e5f0347
--- /dev/null
+++ b/drivers/irqchip/irq-vf610-mscm-ir.c
@@ -0,0 +1,206 @@
+/*
+ * Copyright (C) 2014-2015 Toradex AG
+ * Author: Stefan Agner <stefan@agner.ch>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Interrupt controller driver for the MSCM Interrupt Router.
+ *
+ * o All peripheral interrupts of the Vybrid SoC can be routed to
+ *   CPU 0, CPU 1 or both. The routing is useful for dual-core
+ *   variants of Vybrid SoC such as VF6xx. This driver routes the
+ *   requested interrupt to the CPU currently running on.
+ *
+ * o It is necessary to setup the interrupt route even on single-core
+ *   variants of Vybrid.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mfd/syscon.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "irqchip.h"
+
+#define MSCM_CPxNUM		0x4
+
+#define MSCM_IRSPRC(n)		(0x80 + 2 * (n))
+#define MSCM_IRSPRC_CPEN_MASK	0x3
+
+#define MSCM_IRSPRC_NUM		112
+
+struct vf610_mscm_ir_chip_data {
+	void __iomem *mscm_ir_base;
+	u16 cpu_mask;
+	u16 saved_irsprc[MSCM_IRSPRC_NUM];
+};
+
+static struct vf610_mscm_ir_chip_data *mscm_ir_data;
+
+static inline void vf610_mscm_ir_save(struct vf610_mscm_ir_chip_data *data)
+{
+	int i;
+
+	for (i = 0; i < MSCM_IRSPRC_NUM; i++)
+		data->saved_irsprc[i] = readw_relaxed(data->mscm_ir_base + MSCM_IRSPRC(i));
+}
+
+static inline void vf610_mscm_ir_restore(struct vf610_mscm_ir_chip_data *data)
+{
+	int i;
+
+	for (i = 0; i < MSCM_IRSPRC_NUM; i++)
+		writew_relaxed(data->saved_irsprc[i], data->mscm_ir_base + MSCM_IRSPRC(i));
+}
+
+static int vf610_mscm_ir_notifier(struct notifier_block *self,
+				  unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		vf610_mscm_ir_save(mscm_ir_data);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		vf610_mscm_ir_restore(mscm_ir_data);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mscm_ir_notifier_block = {
+	.notifier_call = vf610_mscm_ir_notifier,
+};
+
+static void vf610_mscm_ir_enable(struct irq_data *data)
+{
+	irq_hw_number_t hwirq = data->hwirq;
+	struct vf610_mscm_ir_chip_data *chip_data = data->chip_data;
+	u16 irsprc;
+
+	irsprc = readw_relaxed(chip_data->mscm_ir_base + MSCM_IRSPRC(hwirq));
+	irsprc &= MSCM_IRSPRC_CPEN_MASK;
+
+	WARN_ON(irsprc);
+
+	writew_relaxed(chip_data->cpu_mask,
+		       chip_data->mscm_ir_base + MSCM_IRSPRC(hwirq));
+
+	irq_chip_unmask_parent(data);
+}
+
+static void vf610_mscm_ir_disable(struct irq_data *data)
+{
+	irq_hw_number_t hwirq = data->hwirq;
+	struct vf610_mscm_ir_chip_data *chip_data = data->chip_data;
+
+	writew_relaxed(0x0, chip_data->mscm_ir_base + MSCM_IRSPRC(hwirq));
+
+	irq_chip_mask_parent(data);
+}
+
+static struct irq_chip vf610_mscm_ir_irq_chip = {
+	.name			= "mscm-ir",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_enable		= vf610_mscm_ir_enable,
+	.irq_disable		= vf610_mscm_ir_disable,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static int vf610_mscm_ir_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				      unsigned int nr_irqs, void *arg)
+{
+	int i;
+	irq_hw_number_t hwirq;
+	struct of_phandle_args *irq_data = arg;
+	struct of_phandle_args gic_data;
+
+	if (irq_data->args_count != 2)
+		return -EINVAL;
+
+	hwirq = irq_data->args[0];
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &vf610_mscm_ir_irq_chip,
+					      domain->host_data);
+
+	gic_data.np = domain->parent->of_node;
+	gic_data.args_count = 3;
+	gic_data.args[0] = GIC_SPI;
+	gic_data.args[1] = irq_data->args[0];
+	gic_data.args[2] = irq_data->args[1];
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_data);
+}
+
+static const struct irq_domain_ops mscm_irq_domain_ops = {
+	.xlate = irq_domain_xlate_twocell,
+	.alloc = vf610_mscm_ir_domain_alloc,
+	.free = irq_domain_free_irqs_common,
+};
+
+static int __init vf610_mscm_ir_of_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	struct irq_domain *domain, *domain_parent;
+	struct regmap *mscm_cp_regmap;
+	int ret, cpuid;
+
+	domain_parent = irq_find_host(parent);
+	if (!domain_parent) {
+		pr_err("vf610_mscm_ir: interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	mscm_ir_data = kzalloc(sizeof(*mscm_ir_data), GFP_KERNEL);
+	if (!mscm_ir_data)
+		return -ENOMEM;
+
+	mscm_ir_data->mscm_ir_base = of_io_request_and_map(node, 0, "mscm-ir");
+
+	if (!mscm_ir_data->mscm_ir_base) {
+		pr_err("vf610_mscm_ir: unable to map mscm register\n");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	mscm_cp_regmap = syscon_regmap_lookup_by_phandle(node, "fsl,cpucfg");
+	if (IS_ERR(mscm_cp_regmap)) {
+		ret = PTR_ERR(mscm_cp_regmap);
+		pr_err("vf610_mscm_ir: regmap lookup for cpucfg failed\n");
+		goto out_unmap;
+	}
+
+	regmap_read(mscm_cp_regmap, MSCM_CPxNUM, &cpuid);
+	mscm_ir_data->cpu_mask = 0x1 << cpuid;
+
+	domain = irq_domain_add_hierarchy(domain_parent, 0,
+					  MSCM_IRSPRC_NUM, node,
+					  &mscm_irq_domain_ops, mscm_ir_data);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	cpu_pm_register_notifier(&mscm_ir_notifier_block);
+
+	return 0;
+
+out_unmap:
+	iounmap(mscm_ir_data->mscm_ir_base);
+out_free:
+	kfree(mscm_ir_data);
+	return ret;
+}
+IRQCHIP_DECLARE(vf610_mscm_ir, "fsl,vf610-mscm-ir", vf610_mscm_ir_of_init);
-- 
2.2.2
