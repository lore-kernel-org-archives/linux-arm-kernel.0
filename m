From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Tue, 24 Mar 2015 13:39:47 +0200
Subject: [RFC 2/3] ARM alpine: introduce msi-x unit support
Message-ID: <55114d03.iX0oPRytazw2gT2x%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the alpine-msix unit.
The unit captures memory writes and triggers interrupts in the GIC.

The address written encodes the level-sensitive SGI that will be raised.
The data written is ignored by the unit. There is no need to ack an interrupt
raised bu msi-x unit (other then acking the gic interrupt).

Signed-off-by: Barak Wasserstrom <barak@annapurnaLabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 .../devicetree/bindings/arm/al/al-msix.txt         |  35 +++
 arch/arm/mach-alpine/Kconfig                       |   2 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-alpine-msi.c                   | 291 +++++++++++++++++++++
 4 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/al/al-msix.txt
 create mode 100644 drivers/irqchip/irq-alpine-msi.c

diff --git a/Documentation/devicetree/bindings/arm/al/al-msix.txt b/Documentation/devicetree/bindings/arm/al/al-msix.txt
new file mode 100644
index 0000000..502c4a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/al/al-msix.txt
@@ -0,0 +1,35 @@
+Annapurna Labs MSIX handler
+
+The alpine msi-x handler is an internal unit in the Alpine P.O.C able to capture
+memory writes and generate interrupts to the GIC accordingly.
+
+Required properties:
+
+- compatible : The value here should contain "al,alpine-msix".
+
+- interrupt-controller : Identifies the node as an interrupt controller
+
+- msi-controller : Identifies the node as an MSI controller.
+
+- reg : Offset and length of the MSIX address space
+
+- interrupts : first and last interrupts to be mannaged by msi-x unit.
+	These two interrupts are defined as GIC interrupts [1].
+	Interrupt type of both must be GIC_SPI.
+	Interrupt flags of both must be IRQ_TYPE_EDGE_RISING.
+
+The interrupt-parent of this unit must be an arm GIC.
+
+Example:
+
+msix: msix at 0xfbe10000 {
+	compatible = "al,alpine-msix";
+	reg = <0x0 0xfbe10000 0x0 0x10000>;
+	interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>,
+		     <GIC_SPI 159 IRQ_TYPE_EDGE_RISING>;
+	interrupt-controller;
+	msi-controller;
+	interrupt-parent = <&gic>;
+};
+
+[1] arm/gic.txt
diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
index 2c44b93..f8eb27a 100644
--- a/arch/arm/mach-alpine/Kconfig
+++ b/arch/arm/mach-alpine/Kconfig
@@ -8,5 +8,7 @@ config ARCH_ALPINE
 	select MFD_SYSCON
 	select PCI
 	select PCI_HOST_GENERIC
+	select PCI_MSI
+	select PCI_MSI_IRQ_DOMAIN
 	help
 	  This enables support for the Annapurna Labs Alpine V1 boards.
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 42965d2..ab213d7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
+obj-$(CONFIG_ARCH_ALPINE)		+= irq-alpine-msi.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
new file mode 100644
index 0000000..bbdeb25
--- /dev/null
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -0,0 +1,291 @@
+/*
+ * Annapurna Labs MSIX support services
+ *
+ * Copyright (C) 2015 Annapurna Labs Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * based on: irq-gic-v2m.c
+ */
+#define pr_fmt(fmt) "Alpine MSI-X: " fmt
+
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
+#include <asm/irq.h>
+#include <linux/irqchip/arm-gic.h>
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+
+#include <asm-generic/msi.h>
+
+#include "irqchip.h"
+
+/*
+ * Generic PCI/MSI-X level: generic, minimal required changes
+ * hwirq is allocated by generic env, ignored
+ */
+static void mask_pci_msi_andparent(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void unmask_pci_msi_andparent(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip parent_msi_irq_chip = {
+	.name			= "PCI/MSI-X",
+	.irq_mask		= mask_pci_msi_andparent,
+	.irq_unmask		= unmask_pci_msi_andparent,
+	.irq_eoi		= irq_chip_eoi_parent,
+};
+
+static struct msi_domain_info parent_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS
+		   | MSI_FLAG_PCI_MSIX),
+	.chip	= &parent_msi_irq_chip,
+};
+
+/*
+ * Alpine MSI-X level:
+ * child of gic domain/irqchip, parent of generic msi domain/irqchip
+ * hwirq is # of sgi raised in gic
+ */
+struct alpine_msix_data {
+	struct msi_controller controller;
+	struct irq_domain *domain;
+
+	u32 addr_high;
+	u32 addr_low;
+
+	unsigned int irq_offset;
+	unsigned int num_irqs;
+	unsigned long *irq_bitmap;
+};
+
+static void alpine_msix_compose_msi_msg(struct irq_data *data,
+					struct msi_msg *msg)
+{
+	struct alpine_msix_data *mdata = irq_data_get_irq_chip_data(data);
+
+	msg->address_hi = mdata->addr_high;
+	msg->address_lo = mdata->addr_low + (data->hwirq << 3);
+	msg->data = 0;
+}
+
+static int alpine_msix_set_affinity(struct irq_data *irq_data,
+				    const struct cpumask *mask, bool force)
+{
+	int ret;
+
+	ret = irq_chip_set_affinity_parent(irq_data, mask, force);
+	if (ret == IRQ_SET_MASK_OK)
+		ret = IRQ_SET_MASK_OK_DONE;
+
+	return ret;
+}
+
+static struct irq_chip alpine_msix_irq_chip = {
+	.name			= "Alpine/MSI-X",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= alpine_msix_set_affinity,
+	.irq_compose_msi_msg	= alpine_msix_compose_msi_msg,
+};
+
+static int alpine_irq_allocate(struct alpine_msix_data *mdata)
+{
+	int pos;
+
+again:
+	pos = find_first_zero_bit(mdata->irq_bitmap, mdata->num_irqs);
+	if (pos >= mdata->num_irqs)
+		return -ENOSPC;
+
+	if (test_and_set_bit(pos, mdata->irq_bitmap))
+		goto again;
+
+	return mdata->irq_offset + pos;
+}
+
+static void alpine_irq_free(struct alpine_msix_data *mdata, unsigned int sgi)
+{
+	clear_bit(sgi - mdata->irq_offset, mdata->irq_bitmap);
+}
+
+static int alpine_msix_gic_alloc(struct irq_domain *gic_domain,
+				 unsigned int virq, int sgi)
+{
+	struct of_phandle_args args;
+	struct irq_data *d;
+	int err;
+
+	args.np = gic_domain->of_node;
+	args.args_count = 3;
+	args.args[0] = 0;
+	args.args[1] = sgi;
+	args.args[2] = IRQ_TYPE_EDGE_RISING;
+	err = gic_domain->ops->alloc(gic_domain, virq, 1, &args);
+	if (err)
+		return err;
+	d = irq_domain_get_irq_data(gic_domain, virq);
+	d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
+	return 0;
+}
+
+static void alpine_msix_domain_free(struct irq_domain *domain,
+				    unsigned int first_virq,
+				    unsigned int nr_irqs)
+{
+	struct irq_data *d;
+	struct alpine_msix_data *mdata;
+	int virq;
+
+	for (virq = first_virq; virq < first_virq + nr_irqs; virq++) {
+		d = irq_domain_get_irq_data(domain, virq);
+		mdata = irq_data_get_irq_chip_data(d);
+		alpine_irq_free(mdata, d->hwirq);
+		irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	}
+}
+
+static int alpine_msix_domain_alloc(struct irq_domain *domain,
+				    unsigned int first_virq,
+				    unsigned int nr_irqs, void *args)
+{
+	struct alpine_msix_data *mdata = domain->host_data;
+	int hwirq, err, virq;
+
+	err = 0;
+	for (virq = first_virq; virq < first_virq + nr_irqs; virq++) {
+		hwirq = alpine_irq_allocate(mdata);
+		if (hwirq < 0) {
+			err = hwirq;
+			break;
+		}
+		err = alpine_msix_gic_alloc(domain->parent, virq, hwirq);
+		if (err) {
+			alpine_irq_free(mdata, hwirq);
+			break;
+		}
+		irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					      &alpine_msix_irq_chip, mdata);
+	}
+	if (err)
+		alpine_msix_domain_free(domain, first_virq, virq - first_virq);
+	return err;
+}
+
+static const struct irq_domain_ops alpine_msix_domain_ops = {
+	.alloc			= alpine_msix_domain_alloc,
+	.free			= alpine_msix_domain_free,
+};
+
+static int alpine_msix_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	struct alpine_msix_data *mdata;
+	struct irq_domain *gic_domain;
+	struct device_node *gic_node;
+	int status = 0;
+	struct resource res;
+	struct of_phandle_args first, last;
+
+	status = of_address_to_resource(node, 0, &res);
+	if (status)
+		return status;
+
+	mdata = kzalloc(sizeof(struct alpine_msix_data), GFP_KERNEL);
+
+	if (!mdata)
+		return -ENOMEM;
+
+	mdata->addr_high = ((u64)res.start) >> 32;
+	mdata->addr_low = (res.start & 0xffffffff);
+
+	if (of_irq_parse_one(node, 0, &first) ||
+	    of_irq_parse_one(node, 1, &last)) {
+		pr_err("Failed to parse irq\n");
+		status = -EINVAL;
+		goto error;
+	}
+	if (first.args_count != 3 || first.args[0] != 0 ||
+	    first.args[2] != IRQ_TYPE_EDGE_RISING ||
+	    last.args_count != 3 || last.args[0] != 0 ||
+	    last.args[2] != IRQ_TYPE_EDGE_RISING ||
+	    first.args[1] >= last.args[1]) {
+		pr_err("Invalid interrupts\n");
+		status = -EINVAL;
+		goto error;
+	}
+	mdata->num_irqs = last.args[1] - first.args[1];
+	mdata->irq_offset = first.args[1];
+	pr_info("Allocating %u interrupts, starting with %u\n", mdata->num_irqs,
+		 mdata->irq_offset);
+
+	mdata->irq_bitmap = kcalloc(BITS_TO_LONGS(mdata->num_irqs),
+				    sizeof(long), GFP_KERNEL);
+	if (!mdata->irq_bitmap) {
+		status = -ENOMEM;
+		goto error;
+	}
+
+	gic_node = of_irq_find_parent(node);
+
+	if (!gic_node) {
+		pr_err("IRQ parent not found\n");
+		status = -EINVAL;
+		goto error;
+	}
+	gic_domain = irq_find_host(gic_node);
+
+	mdata->domain = irq_domain_add_tree(NULL, &alpine_msix_domain_ops,
+					    mdata);
+	if (!mdata->domain) {
+		status = -ENOMEM;
+		goto error;
+	}
+
+	mdata->domain->parent = gic_domain;
+
+	mdata->controller.of_node = node;
+	mdata->controller.domain = pci_msi_create_irq_domain(node,
+							     &parent_msi_domain_info,
+							     mdata->domain);
+	if (!mdata->controller.domain) {
+		status = -ENOMEM;
+		goto error;
+	}
+
+	status = of_pci_msi_chip_add(&mdata->controller);
+	if (status < 0)
+		goto error;
+
+	return 0;
+
+error:
+	if (mdata->controller.domain)
+		irq_domain_remove(mdata->controller.domain);
+	if (mdata->domain)
+		irq_domain_remove(mdata->domain);
+	kfree(mdata->irq_bitmap);
+	kfree(mdata);
+	return status;
+}
+IRQCHIP_DECLARE(alpine_msix, "al,alpine-msix", alpine_msix_init);
-- 
1.9.1
