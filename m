From: majun258@huawei.com (Ma Jun)
Date: Fri, 12 Jun 2015 10:49:57 +0800
Subject: [PATCH v2 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <1434077399-32200-1-git-send-email-majun258@huawei.com>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
Message-ID: <1434077399-32200-2-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch contains the mbigen device driver.

To support Mbigen device, irq-mbigen.c and mbi.h are added.

As a kind of MSI interrupt controller, the mbigen is used as a child 
domain of ITS domain just like PCI devices does.

Change log:
---irq-mbigen.c: the driver of mbigen device.The mbigen irq domain is created here
   as child of ITS domain.


Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/Kconfig      |    7 +
 drivers/irqchip/Makefile     |    1 +
 drivers/irqchip/irq-mbigen.c |  579 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mbi.h          |  114 +++++++++
 4 files changed, 701 insertions(+), 0 deletions(-)
 create mode 100644 drivers/irqchip/irq-mbigen.c
 create mode 100644 include/linux/mbi.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6de62a9..f6cc4a7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -27,6 +27,13 @@ config ARM_GIC_V3_ITS
 	bool
 	select PCI_MSI_IRQ_DOMAIN
 
+config MBIGEN_IRQ_DOMAIN
+	bool "Support mbigen interrupt controller"
+	default y
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
index 0000000..6a0f532
--- /dev/null
+++ b/drivers/irqchip/irq-mbigen.c
@@ -0,0 +1,579 @@
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
+/* Register offsets */
+#define MG_IRQ_TYPE		0x0
+#define MG_IRQ_CLEAR		0x100
+#define MG_IRQ_STATUS		0x200
+#define MG_MSG_DATA		0x300
+
+/* The gap between normal and extended pin region */
+#define MG_EXT_OFST		0x10
+
+/* Max number of interrupts supported */
+#define MG_NR_IRQS		640
+
+/* Number of mbigen node supported in one mbigen chip */
+#define MG_NR			6
+
+/*
+ * refer to the mbigen node in a mbigen chip
+ * usually, a mbigen chip includes 4 mbigen nodes,
+ * but some some mbigen chip include 5 or 6 nodes.
+ * The node number depends on the hardware.
+ */
+struct mbigen_node {
+	raw_spinlock_t		lock;
+	struct list_head	entry;
+	struct mbigen_chip	*chip;
+	unsigned int		nid;
+	unsigned int		irqs_used;
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
+static LIST_HEAD(mbigen_chip_list);
+static DEFINE_SPINLOCK(mbigen_lock);
+
+int get_mbi_offset(int virq)
+{
+	struct irq_data *data;
+	struct mbigen_device *mgn_dev;
+	int offset = 0;
+
+	data = irq_get_irq_data(virq);
+	mgn_dev = data->chip_data;
+
+	offset = mgn_dev->offset;
+	return offset;
+}
+
+/*
+ * Get the irq number that the mbigen node can supported
+ * nid: the mbigen node id.
+ * nid = 0 ~ 3:	64 irq supported
+ * nid = 4:		128 irqs supported
+ * nid = 5:		256 irqs supported
+*/
+static unsigned int mbigen_get_nr_irqs(unsigned int nid)
+{
+	return 1 << (max_t(unsigned int, nid, 3) + 3);
+}
+
+static unsigned int mbigen_get_nid(unsigned long hwirq)
+{
+	unsigned int nid = min_t(unsigned long, hwirq >> 6, 3);
+
+	if (hwirq >> 8)
+		nid += min_t(unsigned long, hwirq >> 7, 3) - 1;
+
+	return nid;
+}
+
+static unsigned long mbigen_get_hwirq_base(unsigned int nid)
+{
+	return (nid < 5) ? (nid << 6) : ((nid + 1) << 6);
+}
+
+static void mbigen_free_dev(struct mbigen_device *mgn_dev)
+{
+	raw_spin_lock(&mgn_dev->mgn_node->lock);
+	list_del(&mgn_dev->entry);
+	raw_spin_unlock(&mgn_dev->mgn_node->lock);
+	kfree(mgn_dev);
+}
+
+static struct mbigen_device *mbigen_create_device(struct mbigen_node *mbigen,
+					      struct device_node *node,
+						  unsigned int virq,
+					      unsigned int nr_irqs,
+						  unsigned int offset)
+{
+	struct mbigen_device *mgn_dev;
+
+	mgn_dev = kzalloc(sizeof(*mgn_dev), GFP_KERNEL);
+	if (!mgn_dev)
+		return NULL;
+
+	INIT_LIST_HEAD(&mgn_dev->entry);
+	mgn_dev->mgn_node = mbigen;
+	mgn_dev->source = node;
+	mgn_dev->irq = virq;
+	mgn_dev->nr_irqs = nr_irqs;
+	mgn_dev->offset = offset;
+
+	raw_spin_lock(&mbigen->lock);
+	list_add(&mgn_dev->entry, &mbigen->nodes);
+	raw_spin_unlock(&mbigen->lock);
+	return mgn_dev;
+}
+
+static void mbigen_free(struct mbigen_node *mbigen)
+{
+	struct mbigen_device *mgn_dev, *tmp;
+
+	list_for_each_entry_safe(mgn_dev, tmp, &mbigen->nodes, entry)
+		mbigen_free_dev(mgn_dev);
+
+	kfree(mbigen);
+}
+
+static struct mbigen_node *get_mbigen_node(struct mbigen_chip *chip,
+											unsigned int nid)
+{
+	struct mbigen_node *tmp, *mbigen;
+	bool found = false;
+
+	if (nid >= MG_NR) {
+		pr_warn("MBIGEN: Device ID exceeds max number!\n");
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
+
+void mbigen_write_msg(struct irq_data *irq_data, struct mbigen_msg *msg)
+{
+
+	struct irq_data *data;
+	struct mbigen_device *mgn_dev;
+	struct mbigen_node *mbigen;
+	void __iomem *addr;
+
+
+	data = irq_get_irq_data(irq_data->irq);
+
+	mgn_dev = data->chip_data;
+	mbigen = mgn_dev->mgn_node;
+
+	addr = mbigen->chip->base + MG_MSG_DATA + mbigen->nid * 4;
+	if (mbigen->nid > 3)
+		addr += MG_EXT_OFST;
+
+	writel_relaxed(msg->data & ~0xffff, addr);
+}
+
+static struct mbigen_chip *get_mbigen_chip(struct irq_domain *domain)
+{
+	struct mbigen_chip *chip = NULL;
+
+	spin_lock(&mbigen_lock);
+	list_for_each_entry(chip, &mbigen_chip_list, entry) {
+		if (chip->node == domain->of_node)
+			break;
+	}
+	spin_unlock(&mbigen_lock);
+
+	if (!chip)
+		return NULL;
+
+	return chip;
+}
+
+/*
+ * Interrupt controller operations
+ */
+
+static void mbigen_ack_irq(struct irq_data *d)
+{
+	struct mbigen_chip *chip;
+	u32 ofst = d->hwirq / 32 * 4;
+	u32 mask = 1 << (d->hwirq % 32);
+
+	chip = get_mbigen_chip(d->domain);
+	if (!chip)
+		pr_warn("NO Mbigen chip found\n");
+
+	writel_relaxed(mask, chip->base + MG_IRQ_CLEAR + ofst);
+}
+
+static int mbigen_set_type(struct irq_data *d, unsigned int type)
+{
+	struct mbigen_chip *chip;
+	u32 ofst = d->hwirq / 32 * 4;
+	u32 mask = 1 << (d->hwirq % 32);
+	u32 val;
+
+	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
+
+	chip = get_mbigen_chip(d->domain);
+	if (!chip)
+		pr_warn("NO Mbigen chip found\n");
+
+	raw_spin_lock(&chip->lock);
+	val = readl_relaxed(chip->base + MG_IRQ_TYPE + ofst);
+
+	if (type == IRQ_TYPE_LEVEL_HIGH)
+		val |= mask;
+	else if (type == IRQ_TYPE_EDGE_RISING)
+		val &= ~mask;
+
+	writel_relaxed(val, chip->base + MG_IRQ_TYPE + ofst);
+	raw_spin_unlock(&chip->lock);
+
+	return 0;
+}
+
+void mbigen_mask_irq(struct irq_data *data)
+{
+	irq_chip_mask_parent(data);
+}
+
+void mbigen_unmask_irq(struct irq_data *data)
+{
+	irq_chip_unmask_parent(data);
+}
+
+static struct irq_chip mbigen_irq_chip = {
+	.name			= "MBIGEN",
+	.irq_mask		= mbigen_mask_irq,
+	.irq_unmask		= mbigen_unmask_irq,
+	.irq_ack		= mbigen_ack_irq,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= mbigen_set_type,
+	.irq_write_mbigen_msg	= mbigen_write_msg,
+};
+
+static inline void irq_chip_write_mbigen_msg(struct irq_data *data,
+					  struct mbigen_msg *msg)
+{
+		data->chip->irq_write_mbigen_msg(data, msg);
+}
+
+/**
+ * mbi_alloc_desc() - allocate an MBI descriptor
+ * @dev:	the device owned the MBI
+ * @ops:	config operations of @dev
+ * @msg_id:	identifier of the message group
+ * @lines:	max number of interrupts supported by the message register
+ * @offset:	hardware pin offset of @irq
+ * @data:	message specific data
+ */
+struct mbi_desc *mbi_alloc_desc(struct device *dev, int msg_id,
+								unsigned int lines,
+								unsigned int offset, void *data)
+{
+	struct mbi_desc *desc;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return NULL;
+
+	desc->dev	= dev;
+	desc->msg_id = msg_id;
+	desc->lines	= lines;
+	desc->offset	= offset;
+	desc->data	= data;
+
+	return desc;
+}
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
+	if (d->of_node != controller)
+		return -EINVAL;
+
+	if (intsize < 2)
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int mbigen_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs, void *arg)
+{
+	struct of_phandle_args *irq_data = arg;
+	struct mbigen_domain_info *info = domain->host_data;
+	struct mbigen_domain_ops *ops = info->ops;
+	struct mbigen_chip *chip;
+	irq_hw_number_t hwirq = irq_data->args[0];
+	unsigned int nid = mbigen_get_nid(hwirq);
+	struct mbigen_node *mbigen;
+	struct mbigen_device *mgn_dev;
+	struct mbi_desc *mbi;
+	struct mbi_alloc_info out_arg;
+	int ret = 0;
+	unsigned int offset = 0;
+
+	/* OF style allocation, one interrupt at a time */
+	WARN_ON(nr_irqs != 1);
+
+	chip = get_mbigen_chip(domain);
+	if (!chip)
+		pr_warn("NO Mbigen chip found\n");
+
+	mbigen = get_mbigen_node(chip, nid);
+	if (!mbigen)
+		return -ENODEV;
+
+	offset = hwirq - mbigen_get_hwirq_base(nid);
+
+	mgn_dev = mbigen_create_device(mbigen, irq_data->np, virq, nr_irqs, offset);
+	if (!mgn_dev)
+		return -ENOMEM;
+
+	mbi = mbi_alloc_desc(chip->dev, nid, mbigen_get_nr_irqs(nid),
+			     offset, mgn_dev);
+	if (!mbi) {
+		mbigen_free_dev(mgn_dev);
+		return -ENOMEM;
+	}
+
+	ret = ops->mbigen_prepare(domain, mbi, hwirq, &out_arg);
+	if (ret)
+		return ret;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &out_arg);
+	if (ret < 0) {
+		irq_domain_free_irqs_top(domain, virq, nr_irqs);
+		return ret;
+	}
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+								&mbigen_irq_chip, mgn_dev);
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
+static void mbigen_domain_activate(struct irq_domain *domain,
+				struct irq_data *irq_data)
+{
+	struct mbigen_msg msg;
+
+	BUG_ON(irq_chip_compose_mbigen_msg(irq_data, &msg));
+	irq_chip_write_mbigen_msg(irq_data, &msg);
+}
+
+static void mbigen_domain_deactivate(struct irq_domain *domain,
+				  struct irq_data *irq_data)
+{
+	struct mbigen_msg msg;
+
+	memset(&msg, 0, sizeof(msg));
+	irq_chip_write_mbigen_msg(irq_data, &msg);
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
+static const struct of_device_id mbigen_of_match[] = {
+	{ .compatible = "hisilicon,mbi-gen" },
+	{ /* END */ }
+};
+MODULE_DEVICE_TABLE(of, mbigen_of_match);
+
+struct irq_domain *its_mbigen_create_irq_domain(struct device_node *node,
+					     struct mbigen_domain_info *info,
+					     struct irq_domain *parent_domain)
+{
+	struct device_node *np;
+	struct device_node *parent_node = NULL;
+	struct mbigen_chip *chip;
+
+	for_each_matching_node(np, mbigen_of_match) {
+
+		parent_node = of_parse_phandle(np, "msi-parent", 0);
+		if (parent_node == node)
+			break;
+	}
+
+	if (!parent_node) {
+		pr_warn("MBIGEN: %s-No mbigen detected\n", node->full_name);
+		return NULL;
+	}
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return NULL;
+
+	chip->node = np;
+
+	chip->base = of_iomap(np, 0);
+	if (!chip->base) {
+		pr_err("%s: Registers not found.\n", node->full_name);
+		goto free_chip;
+	}
+
+
+	info->chip = &mbigen_irq_chip;
+
+	chip->domain = irq_domain_add_hierarchy(parent_domain,
+						0, MG_NR_IRQS, np,
+						&mbigen_domain_ops, info);
+
+	if (!chip->domain)
+		goto unmap_reg;
+
+	raw_spin_lock_init(&chip->lock);
+	INIT_LIST_HEAD(&chip->entry);
+	INIT_LIST_HEAD(&chip->nodes);
+	spin_lock(&mbigen_lock);
+	list_add(&chip->entry, &mbigen_chip_list);
+	spin_unlock(&mbigen_lock);
+	return chip->domain;
+
+unmap_reg:
+	iounmap(chip->base);
+free_chip:
+	kfree(chip);
+	return NULL;
+}
+
+/*
+ * Late initialization as a platform device
+ */
+
+static int mbigen_probe(struct platform_device *pdev)
+{
+	struct mbigen_chip *tmp, *chip = NULL;
+	struct device *dev = &pdev->dev;
+
+	spin_lock(&mbigen_lock);
+	list_for_each_entry(tmp, &mbigen_chip_list, entry) {
+		if (tmp->node == dev->of_node) {
+			chip = tmp;
+			break;
+		}
+	}
+	spin_unlock(&mbigen_lock);
+
+	if (!chip)
+		return -ENODEV;
+
+	chip->dev = dev;
+	platform_set_drvdata(pdev, chip);
+
+	return 0;
+}
+
+static int mbigen_remove(struct platform_device *pdev)
+{
+	struct mbigen_chip *chip = platform_get_drvdata(pdev);
+	struct mbigen_node *mbigen, *tmp;
+
+	spin_lock(&mbigen_lock);
+	list_del(&chip->entry);
+	spin_unlock(&mbigen_lock);
+
+	list_for_each_entry_safe(mbigen, tmp, &chip->nodes, entry) {
+		list_del(&mbigen->entry);
+		mbigen_free(mbigen);
+	}
+
+	irq_domain_remove(chip->domain);
+	iounmap(chip->base);
+	kfree(chip);
+
+	return 0;
+}
+
+static struct platform_driver mbigen_platform_driver = {
+	.driver = {
+		.name		= "Hisilicon MBIGEN",
+		.owner		= THIS_MODULE,
+		.of_match_table	= mbigen_of_match,
+	},
+	.probe			= mbigen_probe,
+	.remove			= mbigen_remove,
+};
+
+module_platform_driver(mbigen_platform_driver);
+
+MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
+MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hisilicon MBI Generator driver");
diff --git a/include/linux/mbi.h b/include/linux/mbi.h
new file mode 100644
index 0000000..e53e42b
--- /dev/null
+++ b/include/linux/mbi.h
@@ -0,0 +1,114 @@
+#ifndef _LINUX_MBI_H
+#define _LINUX_MBI_H
+
+#include <linux/device.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+struct mbi_ops;
+struct mbi_desc;
+
+/**
+ * struct mbigen_msg - MBI message descriptor
+ *
+ * @address_lo:	lower 32bit value of MBI address register
+ * @address_hi:	higher 32bit value of MBI address register
+ * @data:	data value of MBI data register
+ */
+struct mbigen_msg {
+	u32	address_lo;
+	u32	address_hi;
+	u32	data;
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
+ * @offset:	hardware pin offset of @irq
+ * @data:	message specific data
+ */
+struct mbi_desc {
+	/* MBI-related device information */
+	struct device	*dev;
+	int		msg_id;
+	unsigned int	lines;
+	/* Message properties */
+	unsigned int		irq;
+	unsigned int		nvec;
+	int			offset;
+	void			*data;
+};
+/**
+ * strutct mbigen_chip - mbigen chip structure descriptor
+ */
+struct mbigen_chip {
+	raw_spinlock_t		lock;
+	struct list_head	entry;
+	struct device		*dev;
+	struct device_node	*node;
+	struct device_node	*of_node;
+	void __iomem		*base;
+	struct irq_domain	*domain;
+	struct list_head	nodes;
+};
+
+/**
+ * struct mbi_alloc_info - Default structure for MBI interrupt allocation.
+ * @desc:	Pointer to mbi descriptor
+ * @hwirq:	Associated hw interrupt number in the domain
+ * @scratchpad:	Storage for implementation specific scratch data
+ *
+ */
+struct mbi_alloc_info {
+	struct mbi_desc			*desc;
+	irq_hw_number_t			hwirq;
+	union {
+		unsigned long		ul;
+		void			*ptr;
+	} scratchpad[2];
+};
+
+/**
+ * struct mbi_ops - MBI functions of MBI-capable device
+ *
+ * @write_msg:	write message registers for an MBI
+ * @mask_irq:	mask an MBI interrupt
+ * @unmask_irq:	unmask an MBI interrupt
+ */
+struct mbi_ops {
+	void	(*write_msg)(struct mbi_desc *desc, struct mbigen_msg *msg);
+	void	(*mask_irq)(struct mbi_desc *desc);
+	void	(*unmask_irq)(struct mbi_desc *desc);
+};
+
+struct mbigen_domain_ops {
+	int		(*mbigen_prepare)(struct irq_domain *domain,
+								struct mbi_desc *desc,
+								int hwirq,
+								struct mbi_alloc_info *arg);
+};
+
+struct mbigen_domain_info {
+	u32							flags;
+	struct mbigen_domain_ops	*ops;
+	struct irq_chip				*chip;
+};
+/* Functions to allocate an MBI descriptor */
+struct mbi_desc *mbi_alloc_desc(struct device *dev, int msg_id,
+								unsigned int lines,
+								unsigned int offset, void *data);
+
+/* Function to parse and map message interrupts */
+void mbigen_write_msg(struct irq_data *data, struct mbigen_msg *msg);
+int get_mbi_offset(int virq);
+struct irq_domain *its_mbigen_create_irq_domain(struct device_node *node,
+					     struct mbigen_domain_info *info,
+					     struct irq_domain *parent_domain);
+
+#endif /* _LINUX_MBI_H */
-- 
1.7.1
