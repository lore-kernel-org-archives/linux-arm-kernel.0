From: majun258@huawei.com (Ma Jun)
Date: Mon, 6 Jul 2015 15:09:06 +0800
Subject: [PATCH v3 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <1436166548-34920-1-git-send-email-majun258@huawei.com>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
Message-ID: <1436166548-34920-2-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch contains the mbigen interrupt controller driver.

To support Mbigen device, irq-mbigen.c and mbi.h are added.

As a kind of MSI interrupt controller, the mbigen is used as a child 
domain of ITS domain just like PCI devices.

In this patch:
[1]: Create the Mbigen domain as a child domain of ITS according to the
     Mbigen device node definition in dts file
[2]: Parse the interrupts of devices(connected to mbigen chip) node which defined in dts file 
[3]: other operations of interrupts: mask,unmask,activate..

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/Kconfig      |    8 +
 drivers/irqchip/Makefile     |    1 +
 drivers/irqchip/irq-mbigen.c |  486 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mbi.h          |   15 ++
 4 files changed, 510 insertions(+), 0 deletions(-)
 create mode 100644 drivers/irqchip/irq-mbigen.c
 create mode 100644 include/linux/mbi.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6de62a9..bb70af7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -27,6 +27,14 @@ config ARM_GIC_V3_ITS
 	bool
 	select PCI_MSI_IRQ_DOMAIN
 
+config MBIGEN_IRQ_DOMAIN
+	bool "Support mbigen interrupt controller"
+	default y
+	depends on ARM_GIC_V3 && ARM_GIC_V3_ITS
+	help
+	 Enable the mbigen interrupt controller used on
+	 Hisillicon platform.
+
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index dda4927..23571c1 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o
+obj-$(CONFIG_MBIGEN_IRQ_DOMAIN)		+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_ATMEL_AIC_IRQ)		+= irq-atmel-aic-common.o irq-atmel-aic.o
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
new file mode 100644
index 0000000..25f1442
--- /dev/null
+++ b/drivers/irqchip/irq-mbigen.c
@@ -0,0 +1,486 @@
+/*
+ * Copyright (C) 2014 Hisilicon Limited, All Rights Reserved.
+ * Author: Yun Wu <wuyun.wu@huawei.com>
+ * Author: Jun Ma <majun258@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/mbi.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include "irqchip.h"
+
+/* Irq numbers per mbigen node supported */
+#define IRQS_PER_MBIGEN_NODE	128
+/* Max mbigen node number in one chip */
+#define MG_NR			(10)
+/* Max interrupts  Mbigen chip supported */
+#define MG_NR_IRQS		IRQS_PER_MBIGEN_NODE * (MG_NR + 1)
+
+#define	DEV_SHIFT		(10)
+#define	COMPOSE_HWIRQ(x, y)	(((x) << DEV_SHIFT) | (y))
+#define	HWIRQ_OFFSET(x)		((x) & 0x3ff)
+#define GET_NODE_NUM(x)		(((x) >> DEV_SHIFT) & 0xff)
+
+#define IRQ_EVENT_ID_SHIFT	(12)
+
+#define IRQ_EVENT_ID_MASK	(0x3ff << IRQ_EVENT_ID_SHIFT)
+
+/* mbigen node register range */
+#define MBIGEN_NODE_OFFSET	0x1000
+/* vector register offset in mbigen node */
+#define REG_MBIGEN_VEC_OFFSET	0x200
+/* interrupt type register offset */
+#define REG_MBIGEN_TYPE_OFFSET	0x0
+
+/* get the vector register addr in mbigne node
+ * x: mbigen node number
+ * y: the irq pin offset
+ */
+#define MBIGEN_NODE_ADDR_BASE(x)	((x) * MBIGEN_NODE_OFFSET)
+
+#define MBIGEN_VEC_REG_ADDR(x, y)	\
+	(MBIGEN_NODE_ADDR_BASE(x) + REG_MBIGEN_VEC_OFFSET + ((y) * 4))
+
+#define MBIGEN_TYPE_REG_ADDR(x, y)	\
+	(MBIGEN_NODE_ADDR_BASE(x) + REG_MBIGEN_TYPE_OFFSET + y)
+
+/**
+ * strutct mbigen_chip - mbigen chip structure descriptor
+ * usually one subsys(ex.DSA,ALG,PCIE)has one mbigen chip
+ */
+struct mbigen_chip {
+	raw_spinlock_t		lock;
+	struct list_head	entry;
+	struct device		*dev;
+	struct device_node	*node;
+	void __iomem		*base;
+	struct irq_domain	*domain;
+	struct list_head	nodes;
+};
+
+/*
+ * mbigen_node: structure of mbigen node in a mbigen chip
+ * usually, a mbigen chip includes 8 ~ 11 mbigen nodes.
+ * The node number depends on the device number connected
+ * to this mbigen chip.
+ * @nid: the mbigen nod number
+ */
+struct mbigen_node {
+	raw_spinlock_t		lock;
+	struct list_head	entry;
+	struct mbigen_chip	*chip;
+	unsigned int		nid;
+	struct list_head	nodes;
+};
+
+/* refer to the devices connected to mbigen node */
+struct mbigen_device {
+	struct list_head	entry;
+	struct mbigen_node	*mgn_node;
+	struct device_node	*source;
+	unsigned int		irq;
+	unsigned int		nr_irqs;
+	unsigned int		offset;
+};
+
+/**
+ * struct mbi_desc - Message Based Interrupt (MBI) descriptor
+ *
+ * @dev:	the device owned the MBI
+ * @msg_id:	identifier of the message group
+ * @lines:	max number of interrupts supported by the message register
+ * @irq:	base linux interrupt number of the MBI
+ * @nvec:	number of interrupts controlled by the MBI
+ * @data:	message specific data
+ */
+struct mbi_desc {
+	struct device	*dev;
+	int		msg_id;
+	unsigned int	lines;
+	unsigned int		irq;
+	unsigned int		nvec;
+	void			*data;
+};
+
+static LIST_HEAD(mbigen_chip_list);
+static DEFINE_SPINLOCK(mbigen_lock);
+
+static void mbigen_free_dev(struct mbigen_device *mgn_dev)
+{
+	raw_spin_lock(&mgn_dev->mgn_node->lock);
+	list_del(&mgn_dev->entry);
+	raw_spin_unlock(&mgn_dev->mgn_node->lock);
+	kfree(mgn_dev);
+}
+
+static struct mbigen_device *mbigen_create_device(struct mbigen_node *mgn_node,
+					      struct device_node *node,
+						  unsigned int virq,
+					      unsigned int nr_irqs)
+{
+	struct mbigen_device *mgn_dev;
+
+	mgn_dev = kzalloc(sizeof(*mgn_dev), GFP_KERNEL);
+	if (!mgn_dev)
+		return NULL;
+
+	INIT_LIST_HEAD(&mgn_dev->entry);
+	mgn_dev->mgn_node = mgn_node;
+	mgn_dev->source = node;
+	mgn_dev->irq = virq;
+	mgn_dev->nr_irqs = nr_irqs;
+
+	raw_spin_lock(&mgn_node->lock);
+	list_add(&mgn_dev->entry, &mgn_node->nodes);
+	raw_spin_unlock(&mgn_node->lock);
+	return mgn_dev;
+}
+
+static struct mbigen_node *get_mbigen_node(struct mbigen_chip *chip,
+					unsigned int nid)
+{
+	struct mbigen_node *tmp, *mbigen;
+	bool found = false;
+
+	if (nid > MG_NR) {
+		pr_warn("MBIGEN: Device ID exceeds max number!!\n");
+		return NULL;
+	}
+
+	list_for_each_entry(mbigen, &chip->nodes, entry) {
+		if (mbigen->nid == nid) {
+			found = true;
+			return mbigen;
+		}
+	}
+
+	/*
+	 * Stop working if no memory available, even if we could
+	 * get what we want.
+	 */
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return NULL;
+
+	raw_spin_lock(&chip->lock);
+
+	tmp->chip = chip;
+	tmp->nid = nid;
+	raw_spin_lock_init(&tmp->lock);
+	INIT_LIST_HEAD(&tmp->entry);
+	INIT_LIST_HEAD(&tmp->nodes);
+
+	list_add(&tmp->entry, &chip->nodes);
+	mbigen = tmp;
+	raw_spin_unlock(&chip->lock);
+
+	return mbigen;
+}
+
+/**
+ * get_mbigen_node_type: get the mbigen node type
+ * @nid: the mbigen node value
+ * return 0: evnent id of interrupt connected to this node can be changed.
+ * return 1: evnent id of interrupt connected to this node cant be changed.
+ */
+static int get_mbigen_node_type(int nid)
+{
+	if (nid > MG_NR) {
+		pr_warn("MBIGEN: Device ID exceeds max number!\n");
+		return 1;
+	}
+	if ((nid == 0) || (nid == 5) || (nid > 7))
+		return 0;
+	else
+		return 1;
+}
+
+static int mbigen_write_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct mbigen_chip *chip = d->domain->host_data;
+	void __iomem *addr;
+	u32 nid, val, offset;
+	int ret = 0;
+
+	nid = GET_NODE_NUM(d->hwirq);
+	ret = get_mbigen_node_type(nid);
+	if (ret)
+		return 0;
+
+	offset = HWIRQ_OFFSET(d->hwirq);
+
+	addr = chip->base + MBIGEN_VEC_REG_ADDR(nid, offset);
+
+	val = readl_relaxed(addr);
+
+	val &= ~IRQ_EVENT_ID_MASK;
+	val |= (msg->data << IRQ_EVENT_ID_SHIFT);
+
+	writel_relaxed(val, addr);
+	return ret;
+}
+
+/*
+ * Interrupt controller operations
+ */
+static int mbigen_set_type(struct irq_data *d, unsigned int type)
+{
+	struct mbigen_chip *chip = d->domain->host_data;
+	u32 ofst, mask;
+	u32 val, nid, hwirq;
+	void __iomem *addr;
+
+	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
+
+	nid = GET_NODE_NUM(d->hwirq);
+	hwirq = HWIRQ_OFFSET(d->hwirq);
+
+	ofst = hwirq / 32 * 4;
+	mask = 1 << (hwirq % 32);
+
+	addr = chip->base + MBIGEN_TYPE_REG_ADDR(nid, ofst);
+	raw_spin_lock(&chip->lock);
+	val = readl_relaxed(addr);
+
+	if (type == IRQ_TYPE_LEVEL_HIGH)
+		val |= mask;
+	else if (type == IRQ_TYPE_EDGE_RISING)
+		val &= ~mask;
+
+	writel_relaxed(val, addr);
+	raw_spin_unlock(&chip->lock);
+
+	return 0;
+}
+
+static void mbigen_mask_irq(struct irq_data *data)
+{
+	irq_chip_mask_parent(data);
+}
+
+static void mbigen_unmask_irq(struct irq_data *data)
+{
+	irq_chip_unmask_parent(data);
+}
+
+static int mbigen_set_affinity(struct irq_data *data,
+			       const struct cpumask *mask,
+			       bool force)
+{
+	int ret;
+
+	ret = irq_chip_set_affinity_parent(data, mask, force);
+	return ret;
+}
+
+static void mbigen_irq_eoi(struct irq_data *d)
+{
+	irq_chip_eoi_parent(d);
+}
+
+static struct irq_chip mbigen_irq_chip = {
+	.name			= "MBIGEN-v2",
+	.irq_mask		= mbigen_mask_irq,
+	.irq_unmask		= mbigen_unmask_irq,
+	.irq_eoi		= mbigen_irq_eoi,
+	.irq_set_affinity	= mbigen_set_affinity,
+	.irq_set_type		= mbigen_set_type,
+};
+
+/*
+ * Interrupt domain operations
+ */
+
+static int mbigen_domain_xlate(struct irq_domain *d,
+			       struct device_node *controller,
+			       const u32 *intspec, unsigned int intsize,
+			       unsigned long *out_hwirq,
+			       unsigned int *out_type)
+{
+
+	if (d->of_node != controller)
+		return -EINVAL;
+
+	if (intsize < 4)
+		return -EINVAL;
+
+	*out_hwirq = COMPOSE_HWIRQ(intspec[3], intspec[2]);
+
+	*out_type = intspec[4] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int mbigen_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs, void *arg)
+{
+	struct mbigen_chip *chip = domain->host_data;
+	struct of_phandle_args *irq_data = arg;
+	irq_hw_number_t hwirq;
+	u32 nid, dev_id, mbi_lines;
+	struct mbigen_node *mgn_node;
+	struct mbigen_device *mgn_dev;
+	msi_alloc_info_t out_arg;
+	int ret = 0, i;
+
+	/* OF style allocation, one interrupt at a time */
+	WARN_ON(nr_irqs != 1);
+
+	dev_id = irq_data->args[0];
+	nid = irq_data->args[3];
+	hwirq = COMPOSE_HWIRQ(nid, irq_data->args[2]);
+
+	mgn_node = get_mbigen_node(chip, nid);
+	if (!mgn_node)
+		return -ENODEV;
+
+	mgn_dev = mbigen_create_device(mgn_node, irq_data->np, virq, nr_irqs);
+	if (!mgn_dev)
+		return -ENOMEM;
+
+	mbi_lines = irq_data->args[1];
+
+	ret = its_msi_prepare(domain, dev_id, mbi_lines, &out_arg);
+	if (ret)
+		return ret;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &out_arg);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+						&mbigen_irq_chip, mgn_dev);
+	}
+
+	return ret;
+}
+
+static void mbigen_domain_free(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct mbigen_device *mgn_dev = irq_data_get_irq_chip_data(d);
+
+	WARN_ON(virq != mgn_dev->irq);
+	WARN_ON(nr_irqs != mgn_dev->nr_irqs);
+	mbigen_free_dev(mgn_dev);
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static void mbigen_domain_activate(struct irq_domain *domain,
+				struct irq_data *irq_data)
+{
+	struct msi_msg msg;
+
+	BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
+	mbigen_write_msg(irq_data, &msg);
+}
+
+static void mbigen_domain_deactivate(struct irq_domain *domain,
+				  struct irq_data *irq_data)
+{
+	struct msi_msg msg;
+
+	memset(&msg, 0, sizeof(msg));
+	mbigen_write_msg(irq_data, &msg);
+}
+
+static struct irq_domain_ops mbigen_domain_ops = {
+	.xlate		= mbigen_domain_xlate,
+	.alloc		= mbigen_domain_alloc,
+	.free		= mbigen_domain_free,
+	.activate	= mbigen_domain_activate,
+	.deactivate	= mbigen_domain_deactivate,
+};
+
+/*
+ * Early initialization as an interrupt controller
+ */
+static int __init mbigen_of_init(struct device_node *node,
+				 struct device_node *parent_node)
+{
+	struct mbigen_chip *chip;
+	struct irq_domain *parent_domain;
+	int err;
+
+	parent_node = of_parse_phandle(node, "msi-parent", 0);
+
+	if (!parent_node) {
+		pr_warn("MBIGEN: no ITS node for %s\n", node->full_name);
+		return -ENXIO;
+	}
+
+	parent_domain = get_its_domain(parent_node);
+
+	if (!parent_domain) {
+		pr_warn("MBIGEN: no ITS domain for %s\n", node->full_name);
+		return -ENXIO;
+	}
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->base = of_iomap(node, 0);
+	if (!chip->base) {
+		pr_err("%s: Registers not found.\n", node->full_name);
+		err = -ENXIO;
+		goto free_chip;
+	}
+
+	chip->domain = irq_domain_add_hierarchy(parent_domain,
+						0, MG_NR_IRQS, node,
+						&mbigen_domain_ops, chip);
+
+	if (!chip->domain) {
+		err = -ENOMEM;
+		goto unmap_reg;
+	}
+
+	chip->node = node;
+	raw_spin_lock_init(&chip->lock);
+	INIT_LIST_HEAD(&chip->entry);
+	INIT_LIST_HEAD(&chip->nodes);
+	pr_debug("MBIGEN: %s\n", node->full_name);
+	spin_lock(&mbigen_lock);
+	list_add(&chip->entry, &mbigen_chip_list);
+	spin_unlock(&mbigen_lock);
+
+	return 0;
+
+unmap_reg:
+	iounmap(chip->base);
+free_chip:
+	kfree(chip);
+	pr_warn("MBIGEN: failed probing %s\n", node->full_name);
+	return err;
+}
+IRQCHIP_DECLARE(hisi_mbigen, "hisilicon,mbigen-v2", mbigen_of_init);
+
+MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
+MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hisilicon MBI Generator driver");
diff --git a/include/linux/mbi.h b/include/linux/mbi.h
new file mode 100644
index 0000000..d3b8155
--- /dev/null
+++ b/include/linux/mbi.h
@@ -0,0 +1,15 @@
+#ifndef _LINUX_MBI_H
+#define _LINUX_MBI_H
+
+#include <linux/device.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+
+/* Function to parse and map message interrupts */
+extern int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
+		    int nvec, msi_alloc_info_t *info);
+extern struct irq_domain *get_its_domain(struct device_node *node);
+
+#endif /* _LINUX_MBI_H */
-- 
1.7.1
