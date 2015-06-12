From: majun258@huawei.com (Ma Jun)
Date: Fri, 12 Jun 2015 10:49:58 +0800
Subject: [PATCH v2 2/3] IRQ/Gic-V3: Change arm-gic-its to support the Mbigen
 interrupt
In-Reply-To: <1434077399-32200-1-git-send-email-majun258@huawei.com>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
Message-ID: <1434077399-32200-3-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is applied to support the mbigen interrupt.

As a kind of MSI interrupt controller, the mbigen is used as a child 
domain of ITS domain just like PCI devices.
So the arm-gic-v3-its and related files are changed.

The chip.c is also changed to check irq_ach before it called.

Change log:
---arm-gic-v3-its.c: [1]Create the mbigen irq domain in its_init;
	[2] add the irq_compose_mbigen_msg and irq_write_mbigen_msg 
	for mbigen using.[3]add its_mbigen_prepare function.
---irq.h: Add 'irq_compose_mbigen_msg' and 'irq_write_mbigen_msg' in
	struct irq_chip for mbigen using.
---chip.c: Before the irq_ack callback, check the irq_ack first(chip.c)


Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c |   66 +++++++++++++++++++++++++++++++++++++-
 include/linux/irq.h              |    5 +++
 kernel/irq/chip.c                |   40 ++++++++++++++++++++--
 3 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9687f8a..2651f7c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -22,6 +22,7 @@
 #include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
+#include <linux/mbi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -61,6 +62,7 @@ struct its_node {
 	raw_spinlock_t		lock;
 	struct list_head	entry;
 	struct msi_controller	msi_chip;
+	struct mbigen_chip	mbi_chip;
 	struct irq_domain	*domain;
 	void __iomem		*base;
 	unsigned long		phys_base;
@@ -599,7 +601,21 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 
 	msg->address_lo		= addr & ((1UL << 32) - 1);
 	msg->address_hi		= addr >> 32;
-	msg->data		= its_get_event_id(d);
+	msg->data			= its_get_event_id(d);
+}
+
+static void its_irq_compose_mbigen_msg(struct irq_data *d,struct mbigen_msg *msg)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct its_node *its;
+	u64 addr;
+
+	its = its_dev->its;
+	addr = its->phys_base + GITS_TRANSLATER;
+
+	msg->address_lo		= addr & ((1UL << 32) - 1);
+	msg->address_hi		= addr >> 32;
+	msg->data			= its_get_event_id(d);
 }
 
 static struct irq_chip its_irq_chip = {
@@ -609,6 +625,7 @@ static struct irq_chip its_irq_chip = {
 	.irq_eoi		= its_eoi_irq,
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
+	.irq_compose_mbigen_msg	= its_irq_compose_mbigen_msg,
 };
 
 static void its_mask_msi_irq(struct irq_data *d)
@@ -1245,6 +1262,38 @@ static struct msi_domain_info its_pci_msi_domain_info = {
 	.chip	= &its_msi_irq_chip,
 };
 
+static int its_mbigen_prepare(struct irq_domain *domain, struct mbi_desc *desc,
+								int hwirq, struct mbi_alloc_info *arg)
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
+	arg->desc = desc;
+	arg->hwirq = hwirq;
+	return 0;
+}
+
+static struct mbigen_domain_ops its_mbigen_ops = {
+	.mbigen_prepare		= its_mbigen_prepare,
+};
+
+static struct mbigen_domain_info its_mbigen_domain_info = {
+	.ops	= &its_mbigen_ops,
+};
+
 static int its_irq_gic_domain_alloc(struct irq_domain *domain,
 				    unsigned int virq,
 				    irq_hw_number_t hwirq)
@@ -1489,6 +1538,18 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 		err = of_pci_msi_chip_add(&its->msi_chip);
 		if (err)
 			goto out_free_domains;
+
+		if (IS_ENABLED(CONFIG_MBIGEN_IRQ_DOMAIN)) {
+			its->mbi_chip.domain = its_mbigen_create_irq_domain(node,
+										&its_mbigen_domain_info,
+										its->domain);
+
+			if (!its->mbi_chip.domain) {
+				err = -ENOMEM;
+				pr_warn_once("ITS:no mbigen chip found\n");
+				goto out_free_mbigen;
+			}
+		}
 	}
 
 	spin_lock(&its_lock);
@@ -1497,6 +1558,9 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 
 	return 0;
 
+out_free_mbigen:
+	if (its->mbi_chip.domain)
+		irq_domain_remove(its->mbi_chip.domain);
 out_free_domains:
 	if (its->msi_chip.domain)
 		irq_domain_remove(its->msi_chip.domain);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 62c6901..874497a 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -30,6 +30,7 @@
 struct seq_file;
 struct module;
 struct msi_msg;
+struct mbigen_msg;
 enum irqchip_irq_state;
 
 /*
@@ -363,6 +364,9 @@ struct irq_chip {
 	int		(*irq_request_resources)(struct irq_data *data);
 	void		(*irq_release_resources)(struct irq_data *data);
 
+	void		(*irq_compose_mbigen_msg)(struct irq_data *data, struct mbigen_msg *msg);
+	void		(*irq_write_mbigen_msg)(struct irq_data *data, struct mbigen_msg *msg);
+
 	void		(*irq_compose_msi_msg)(struct irq_data *data, struct msi_msg *msg);
 	void		(*irq_write_msi_msg)(struct irq_data *data, struct msi_msg *msg);
 
@@ -457,6 +461,7 @@ extern void handle_bad_irq(unsigned int irq, struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
+extern int irq_chip_compose_mbigen_msg(struct irq_data *data, struct mbigen_msg *msg);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern void irq_chip_ack_parent(struct irq_data *data);
 extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index eb9a4ea..83104fd 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -12,6 +12,7 @@
 
 #include <linux/irq.h>
 #include <linux/msi.h>
+#include <linux/mbi.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
@@ -882,7 +883,8 @@ void irq_cpu_offline(void)
 void irq_chip_ack_parent(struct irq_data *data)
 {
 	data = data->parent_data;
-	data->chip->irq_ack(data);
+	if (data->chip->irq_ack)
+		data->chip->irq_ack(data);
 }
 
 /**
@@ -892,7 +894,8 @@ void irq_chip_ack_parent(struct irq_data *data)
 void irq_chip_mask_parent(struct irq_data *data)
 {
 	data = data->parent_data;
-	data->chip->irq_mask(data);
+	if (data->chip->irq_mask)
+		data->chip->irq_mask(data);
 }
 
 /**
@@ -902,7 +905,8 @@ void irq_chip_mask_parent(struct irq_data *data)
 void irq_chip_unmask_parent(struct irq_data *data)
 {
 	data = data->parent_data;
-	data->chip->irq_unmask(data);
+	if (data->chip->irq_unmask)
+		data->chip->irq_unmask(data);
 }
 
 /**
@@ -912,7 +916,8 @@ void irq_chip_unmask_parent(struct irq_data *data)
 void irq_chip_eoi_parent(struct irq_data *data)
 {
 	data = data->parent_data;
-	data->chip->irq_eoi(data);
+	if (data->chip->irq_eoi)
+		data->chip->irq_eoi(data);
 }
 
 /**
@@ -991,3 +996,30 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	return 0;
 }
+
+/**
+ * irq_chip_compose_mbigen_msg - Componse mbigen message for a mbigen irq chip
+ * @data:	Pointer to interrupt specific data
+ * @msg:	Pointer to the mbigen message
+ *
+ * For hierarchical domains we find the first chip in the hierarchy
+ * which implements the irq_compose_mbigen_msg callback. For non
+ * hierarchical we use the top level chip.
+ */
+
+int irq_chip_compose_mbigen_msg(struct irq_data *data, struct mbigen_msg *msg)
+{
+	struct irq_data *pos = NULL;
+
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+	for (; data; data = data->parent_data)
+#endif
+		if (data->chip && data->chip->irq_compose_mbigen_msg)
+			pos = data;
+	if (!pos)
+		return -ENOSYS;
+
+	pos->chip->irq_compose_mbigen_msg(pos, msg);
+
+	return 0;
+}
-- 
1.7.1
