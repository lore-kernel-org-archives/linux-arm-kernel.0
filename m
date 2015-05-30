From: majun258@huawei.com (majun (F))
Date: Sat, 30 May 2015 11:19:05 +0800
Subject: [PATCH 1/4]:Add mbigen driver to support mbigen interrupt controller
Message-ID: <55692C29.60003@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch contains the mbigen device driver.

To support Mbigen device, irq-mbigen.c and mbi.h are added.

As a MSI interrupt controller, the mbigen is used as a child domain of
MSI domain just like PCI devices.

Change log:
--irq-mbigen.c: the driver of mbigen device.The mbigen irq domain is created here
   as child domain of MSI.
--Add CONFIG_MBIGEN_IRQ_DOMAIN enable this driver

Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/Kconfig      |    4 +
 drivers/irqchip/Makefile     |    1 +
 drivers/irqchip/irq-mbigen.c |  562 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mbi.h          |   77 ++++++
 4 files changed, 644 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 drivers/irqchip/Kconfig
 mode change 100644 => 100755 drivers/irqchip/Makefile
 create mode 100755 drivers/irqchip/irq-mbigen.c
 create mode 100644 include/linux/mbi.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
old mode 100644
new mode 100755
index 6de62a9..595a6eb
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -26,6 +26,10 @@ config ARM_GIC_V3
 config ARM_GIC_V3_ITS
 	bool
 	select PCI_MSI_IRQ_DOMAIN
+	select MBIGEN_IRQ_DOMAIN
+
+config MBIGEN_IRQ_DOMAIN
+	bool

 config ARM_NVIC
 	bool
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
old mode 100644
new mode 100755
index dda4927..23571c1
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
new file mode 100755
index 0000000..462f9a0
--- /dev/null
+++ b/drivers/irqchip/irq-mbigen.c
@@ -0,0 +1,562 @@
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
+#include <linux/irqchip/arm-gic-its.h>
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
+/* Number of mbigens supported in one chip */
+#define MG_NR			6
+
+struct mbigen_node {
+	struct list_head	entry;
+	struct mbigen		*mbigen;
+	struct device_node	*source;
+	unsigned int		irq;
+	unsigned int		nr_irqs;
+};
+
+struct mbigen {
+	raw_spinlock_t		lock;
+	struct list_head	entry;
+	struct mbigen_chip	*chip;
+	unsigned int		nid;
+	unsigned int		irqs_used;
+	struct list_head	nodes;
+};
+
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
+static LIST_HEAD(mbigen_chips);
+static DEFINE_SPINLOCK(mbigen_lock);
+
+int get_mbi_offset(int virq)
+{
+	struct irq_data *data;
+	struct mbi_desc *mbidesc;
+	int offset = 0;
+
+	data = irq_get_irq_data(virq);
+
+	mbidesc = (struct mbi_desc *)data->msi_desc;
+	offset = mbidesc->offset;
+	return offset;
+}
+
+int mbi_parse_irqs(struct device *dev, struct mbi_ops *ops)
+{
+	pr_warn("%s:this function not use now\n", __func__);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(mbi_parse_irqs);
+
+void mbi_free_irqs(struct device *dev, unsigned int virq, unsigned int nvec)
+{
+	pr_warn("%s:this function not use now\n", __func__);
+}
+EXPORT_SYMBOL(mbi_free_irqs);
+
+static inline unsigned int mbigen_get_nr_irqs(unsigned int nid)
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
+static void mbigen_free_node(struct mbigen_node *mgn)
+{
+	raw_spin_lock(&mgn->mbigen->lock);
+	list_del(&mgn->entry);
+	raw_spin_unlock(&mgn->mbigen->lock);
+	kfree(mgn);
+}
+
+static struct mbigen_node *mbigen_create_node(struct mbigen *mbigen,
+					      struct device_node *node,
+					      unsigned int virq,
+					      unsigned int nr_irqs)
+{
+	struct mbigen_node *mgn;
+
+	mgn = kzalloc(sizeof(*mgn), GFP_KERNEL);
+	if (!mgn)
+		return NULL;
+
+	INIT_LIST_HEAD(&mgn->entry);
+	mgn->mbigen = mbigen;
+	mgn->source = node;
+	mgn->irq = virq;
+	mgn->nr_irqs = nr_irqs;
+
+	raw_spin_lock(&mbigen->lock);
+	list_add(&mgn->entry, &mbigen->nodes);
+	raw_spin_unlock(&mbigen->lock);
+	pr_info("%s,mbigen id:%d,virq:%d\n", __func__, mbigen->nid, virq);
+	return mgn;
+}
+
+static void mbigen_free(struct mbigen *mbigen)
+{
+	struct mbigen_node *mgn, *tmp;
+
+	list_for_each_entry_safe(mgn, tmp, &mbigen->nodes, entry)
+		mbigen_free_node(mgn);
+
+	kfree(mbigen);
+}
+
+static struct mbigen *mbigen_get_device(struct mbigen_chip *chip,
+										unsigned int nid)
+{
+	struct mbigen *tmp, *mbigen;
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
+/*
+ * MBI operations
+ */
+/*---------------------------
+irq_data: belong to msi domain
+
+--------------------------*/
+void mbigen_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
+{
+
+	struct irq_data *data;
+	struct mbigen_node *mgn;
+	struct mbigen *mbigen;
+	void __iomem *addr;
+
+
+	data = irq_get_irq_data(irq_data->irq);
+
+	mgn = data->chip_data;
+	mbigen = mgn->mbigen;
+
+	addr = mbigen->chip->base + MG_MSG_DATA + mbigen->nid * 4;
+	if (mbigen->nid > 3)
+		addr += MG_EXT_OFST;
+
+	writel_relaxed(msg->data & ~0xffff, addr);
+}
+/*
+static struct mbi_ops mbigen_mbi_ops = {
+	.write_msg	= mbigen_write_msg,
+};
+*/
+/*
+ * Interrupt controller operations
+ */
+
+static void mbigen_ack_irq(struct irq_data *d)
+{
+	struct mbigen_chip *chip = d->domain->host_data;
+	u32 ofst = d->hwirq / 32 * 4;
+	u32 mask = 1 << (d->hwirq % 32);
+
+	writel_relaxed(mask, chip->base + MG_IRQ_CLEAR + ofst);
+}
+
+static int mbigen_set_type(struct irq_data *d, unsigned int type)
+{
+	struct mbigen_chip *chip = d->domain->host_data;
+	u32 ofst = d->hwirq / 32 * 4;
+	u32 mask = 1 << (d->hwirq % 32);
+	u32 val;
+
+	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
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
+void mbigen_mask_irq(struct irq_data *data)
+{
+	irq_chip_mask_parent(data);
+}
+void mbigen_unmask_irq(struct irq_data *data)
+{
+	irq_chip_unmask_parent(data);
+}
+static struct irq_chip mbigen_chip = {
+	.name			= "Hisilicon MBIGEN",
+	.irq_mask		= mbigen_mask_irq,
+	.irq_unmask		= mbigen_unmask_irq,
+	.irq_ack		= mbigen_ack_irq,
+	.irq_eoi		= irq_chip_eoi_parent,
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
+	if (d->of_node != controller)
+		return -EINVAL;
+
+	if (intsize < 2)
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+	pr_info("%s :out hwirq %ld\n", __func__, *out_hwirq);
+
+	return 0;
+}
+/*-------------------------------------
+domain: parent domain of mbigen domain
+--------------------------------------*/
+
+static int mbigen_mbi_prepare(struct irq_domain *domain, struct mbi_desc *desc,
+								int hwirq, msi_alloc_info_t *arg)
+{
+	struct its_node *its = domain->parent->host_data;
+	struct its_device *its_dev;
+	u32 dev_id;
+
+	dev_id = desc->msg_id;
+
+	its_dev = its_find_device(its, dev_id);
+	if (!its_dev) {
+		its_dev = its_create_device(its, dev_id, desc->lines);
+		if (!its_dev)
+			return -ENOMEM;
+	}
+
+	arg->scratchpad[0].ptr = its_dev;
+	arg->scratchpad[1].ptr = NULL;
+
+	arg->desc = (struct msi_desc *)desc;
+	arg->hwirq = hwirq;
+	return 0;
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
+struct mbi_desc *mbi_alloc_desc(struct device *dev, struct mbi_ops *ops,
+				int msg_id, unsigned int lines,
+				unsigned int offset, void *data)
+{
+	struct mbi_desc *desc;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return NULL;
+
+	desc->dev	= dev;
+	desc->ops	= ops;
+	desc->msg_id = msg_id;
+	desc->lines	= lines;
+	desc->offset	= offset;
+	desc->data	= data;
+
+	return desc;
+}
+
+static int mbigen_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs, void *arg)
+{
+	struct of_phandle_args *irq_data = arg;
+	irq_hw_number_t hwirq = irq_data->args[0];
+	struct mbigen_chip *chip = domain->host_data;
+	unsigned int nid = mbigen_get_nid(hwirq);
+	struct mbigen *mbigen;
+	struct mbigen_node *mgn;
+	struct mbi_desc *mbi;
+	msi_alloc_info_t out_arg;
+	int ret = 0;
+	struct irq_domain *parent = domain->parent;
+	int i = 0;
+
+	/* OF style allocation, one interrupt at a time */
+	WARN_ON(nr_irqs != 1);
+
+	mbigen = mbigen_get_device(chip, nid);
+	if (!mbigen)
+		return -ENODEV;
+
+	mgn = mbigen_create_node(mbigen, irq_data->np, virq, nr_irqs);
+	if (!mgn)
+		return -ENOMEM;
+
+	mbi = mbi_alloc_desc(chip->dev, NULL, nid, mbigen_get_nr_irqs(nid),
+			     hwirq - mbigen_get_hwirq_base(nid), mgn);
+	if (!mbi) {
+		mbigen_free_node(mgn);
+		return -ENOMEM;
+	}
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &mbigen_chip, mgn);
+	pr_info("%s, hwirq:%ld,virq:%d,offset: %d\n", __func__, hwirq, virq, mbi->offset);
+
+	mbigen_mbi_prepare(parent, mbi, hwirq, &out_arg);
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &out_arg);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		ret = irq_set_msi_desc_off(virq, i, (struct msi_desc *)mbi);
+
+	return ret;
+}
+
+static void mbigen_domain_free(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct mbigen_node *mgn = irq_data_get_irq_chip_data(d);
+
+	WARN_ON(virq != mgn->irq);
+	WARN_ON(nr_irqs != mgn->nr_irqs);
+	mbigen_free_node(mgn);
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static struct irq_domain_ops mbigen_domain_ops = {
+	.xlate		= mbigen_domain_xlate,
+	.alloc		= mbigen_domain_alloc,
+	.free		= mbigen_domain_free,
+};
+
+/*
+ * Early initialization as an interrupt controller
+ */
+
+static int __init mbigen_of_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	struct mbigen_chip *chip;
+	struct device_node *msi_parent;
+	int err;
+
+	msi_parent = of_parse_phandle(node, "msi-parent", 0);
+	if (msi_parent)
+		parent = msi_parent;
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
+	chip->domain = irq_domain_add_hierarchy(irq_find_host(parent),
+						IRQ_DOMAIN_FLAG_MBIGEN, MG_NR_IRQS, node,
+						&mbigen_domain_ops, chip);
+	if (!chip->domain) {
+		err = -ENOMEM;
+		goto unmap_reg;
+	}
+
+	chip->node = node;
+	raw_spin_lock_init(&chip->lock);
+	INIT_LIST_HEAD(&chip->entry);
+	INIT_LIST_HEAD(&chip->nodes);
+
+	pr_info("MBIGEN: %s\n", node->full_name);
+
+	spin_lock(&mbigen_lock);
+	list_add(&chip->entry, &mbigen_chips);
+	spin_unlock(&mbigen_lock);
+
+	return 0;
+
+unmap_reg:
+	iounmap(chip->base);
+free_chip:
+	kfree(chip);
+	pr_info("MBIGEN: failed probing %s\n", node->full_name);
+	return err;
+}
+IRQCHIP_DECLARE(hisi_mbigen, "hisilicon,mbi-gen", mbigen_of_init);
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
+	list_for_each_entry(tmp, &mbigen_chips, entry) {
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
+	struct mbigen *mbigen, *tmp;
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
+static const struct of_device_id mbigen_of_match[] = {
+	{ .compatible = "hisilicon,mbi-gen" },
+	{ /* END */ }
+};
+MODULE_DEVICE_TABLE(of, mbigen_of_match);
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
index 0000000..94d372c
--- /dev/null
+++ b/include/linux/mbi.h
@@ -0,0 +1,77 @@
+#ifndef _LINUX_MBI_H
+#define _LINUX_MBI_H
+
+#include <linux/device.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+
+struct mbi_ops;
+struct mbi_desc;
+
+/**
+ * struct mbi_msg - MBI message descriptor
+ *
+ * @address_lo:	lower 32bit value of MBI address register
+ * @address_hi:	higher 32bit value of MBI address register
+ * @data:	data value of MBI data register
+ */
+struct mbi_msg {
+	u32	address_lo;
+	u32	address_hi;
+	u32	data;
+};
+
+/**
+ * struct mbi_desc - Message Based Interrupt (MBI) descriptor
+ *
+ * @dev:	the device owned the MBI
+ * @ops:	config operations of @dev
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
+	struct mbi_ops	*ops;
+	int		msg_id;
+	unsigned int	lines;
+	/* Message properties */
+	unsigned int		irq;
+	unsigned int		nvec;
+	int			offset;
+	void			*data;
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
+	void	(*write_msg)(struct mbi_desc *desc, struct mbi_msg *msg);
+	void	(*mask_irq)(struct mbi_desc *desc);
+	void	(*unmask_irq)(struct mbi_desc *desc);
+};
+
+/* Functions to allocate an MBI descriptor */
+struct mbi_desc *mbi_alloc_desc(struct device *dev, struct mbi_ops *ops,
+				int msg_id, unsigned int lines,
+				unsigned int offset, void *data);
+
+/* Create hierarchy MBI domain for interrupt controllers */
+struct irq_domain *mbi_create_irq_domain(struct device_node *np,
+					 struct irq_domain *parent, void *arg);
+
+/* Function to parse and map message interrupts */
+int mbi_parse_irqs(struct device *dev, struct mbi_ops *ops);
+void mbi_free_irqs(struct device *dev, unsigned int virq, unsigned int nvec);
+void mbigen_write_msg(struct irq_data *data, struct msi_msg *msg);
+int get_mbi_offset(int virq);
+
+#endif /* _LINUX_MBI_H */
-- 
1.7.1
