From: Minghuan.Lian@nxp.com (Minghuan Lian)
Date: Tue, 25 Oct 2016 20:39:22 +0800
Subject: [PATCH] irqchip/ls-scfg-msi: update Layerscape SCFG MSI driver
Message-ID: <1477399162-22881-1-git-send-email-Minghuan.Lian@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. The patch uses soc_device_match() to match the SoC family
and revision instead of DTS compatible, because compatible cannot
describe the SoC revision information.
2. The patch provides a new method to support Layerscape
SCFG MSI. It tries to assign a dedicated MSIR to every core.
When changing a MSI interrupt affinity, the MSI message
data will be changed to refer to a new MSIR that has
been associated with the core.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
The patch depends on https://patchwork.kernel.org/patch/9342915/

 drivers/irqchip/irq-ls-scfg-msi.c | 444 +++++++++++++++++++++++++++++++-------
 1 file changed, 367 insertions(+), 77 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 02cca74c..0245d8a 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -17,23 +18,91 @@
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
+#include <linux/sys_soc.h>
 
-#define MSI_MAX_IRQS	32
-#define MSI_IBS_SHIFT	3
-#define MSIR		4
+#define LS_MSIR_NUM_MAX		4 /* MSIIR can index 4 MSI registers */
+#define IRQS_32_PER_MSIR	32
+#define IRQS_8_PER_MSIR		8
+
+#define MSIR_OFFSET(idx)	((idx) * 0x4)
+
+enum msi_affinity_flag {
+	MSI_GROUP_AFFINITY_FLAG,
+	MSI_AFFINITY_FLAG
+};
+
+struct ls_scfg_msi;
+struct ls_scfg_msi_ctrl;
+
+struct ls_scfg_msi_cfg {
+	u32 ibs_shift; /* Shift of interrupt bit select */
+	u32 msir_irqs; /* The irq number per MSIR */
+	u32 msir_base; /* The base address of MSIR */
+};
+
+struct ls_scfg_msir {
+	struct ls_scfg_msi_ctrl	*ctrl;
+	void __iomem		*addr;
+	int			index;
+	int			virq;
+};
+
+struct ls_scfg_msi_ctrl {
+	struct list_head		list;
+	struct ls_scfg_msi		*msi_data;
+	void __iomem			*regs;
+	phys_addr_t			msiir_addr;
+	enum msi_affinity_flag		flag;
+	int				irq_base;
+	spinlock_t			lock;
+	struct ls_scfg_msir		*msir;
+	unsigned long			*bm;
+};
 
 struct ls_scfg_msi {
-	spinlock_t		lock;
-	struct platform_device	*pdev;
-	struct irq_domain	*parent;
-	struct irq_domain	*msi_domain;
-	void __iomem		*regs;
-	phys_addr_t		msiir_addr;
-	int			irq;
-	DECLARE_BITMAP(used, MSI_MAX_IRQS);
+	struct platform_device		*pdev;
+	struct irq_domain		*parent;
+	struct irq_domain		*msi_domain;
+	struct list_head		ctrl_list;
+	const struct ls_scfg_msi_cfg	*cfg;
+	u32				cpu_num;
+};
+
+static struct ls_scfg_msi_cfg ls1021_msi_cfg = {
+	.ibs_shift = 3,
+	.msir_irqs = IRQS_32_PER_MSIR,
+	.msir_base = 0x4,
+};
+
+static struct ls_scfg_msi_cfg ls1043_rev11_msi_cfg = {
+	.ibs_shift = 2,
+	.msir_irqs = IRQS_8_PER_MSIR,
+	.msir_base = 0x10,
+};
+
+static struct ls_scfg_msi_cfg ls1046_msi_cfg = {
+	.ibs_shift = 2,
+	.msir_irqs = IRQS_32_PER_MSIR,
+	.msir_base = 0x4,
+};
+
+static struct soc_device_attribute soc_msi_matches[] = {
+	{ .family = "QorIQ LS1021A",
+	  .data = &ls1021_msi_cfg },
+	{ .family = "QorIQ LS1012A",
+	  .data = &ls1021_msi_cfg },
+	{ .family = "QorIQ LS1043A", .revision = "1.0",
+	  .data = &ls1021_msi_cfg },
+	{ .family = "QorIQ LS1043A", .revision = "1.1",
+	  .data = &ls1043_rev11_msi_cfg },
+	{ .family = "QorIQ LS1046A",
+	  .data = &ls1046_msi_cfg },
+	{ },
 };
 
 static struct irq_chip ls_scfg_msi_irq_chip = {
@@ -49,19 +118,53 @@ struct ls_scfg_msi {
 	.chip	= &ls_scfg_msi_irq_chip,
 };
 
+static int ctrl_num;
+
+static irqreturn_t (*ls_scfg_msi_irq_handler)(int irq, void *arg);
+
 static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct ls_scfg_msi *msi_data = irq_data_get_irq_chip_data(data);
+	struct ls_scfg_msi_ctrl *ctrl = irq_data_get_irq_chip_data(data);
+	u32 ibs, srs;
 
-	msg->address_hi = upper_32_bits(msi_data->msiir_addr);
-	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
-	msg->data = data->hwirq << MSI_IBS_SHIFT;
+	msg->address_hi = upper_32_bits(ctrl->msiir_addr);
+	msg->address_lo = lower_32_bits(ctrl->msiir_addr);
+
+	ibs = data->hwirq - ctrl->irq_base;
+
+	srs = cpumask_first(irq_data_get_affinity_mask(data));
+	if (srs >= ctrl->msi_data->cpu_num)
+		srs = 0;
+
+	msg->data = ibs << ctrl->msi_data->cfg->ibs_shift | srs;
+
+	pr_debug("%s: ibs %d srs %d address0x%x-0x%x data 0x%x\n",
+		 __func__, ibs, srs, msg->address_hi,
+		 msg->address_lo, msg->data);
 }
 
-static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
-				    const struct cpumask *mask, bool force)
+static int ls_scfg_msi_set_affinity(struct irq_data *data,
+				const struct cpumask *mask, bool force)
 {
-	return -EINVAL;
+	struct ls_scfg_msi_ctrl *ctrl = irq_data_get_irq_chip_data(data);
+	u32 cpu;
+
+	if (!force)
+		cpu = cpumask_any_and(mask, cpu_online_mask);
+	else
+		cpu = cpumask_first(mask);
+
+	if (cpu >= ctrl->msi_data->cpu_num)
+		return -EINVAL;
+
+	if (ctrl->msir[cpu].virq <= 0) {
+		pr_warn("cannot bind the irq to cpu%d\n", cpu);
+		return -EINVAL;
+	}
+
+	cpumask_copy(irq_data_get_affinity_mask(data), mask);
+
+	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
 static struct irq_chip ls_scfg_msi_parent_chip = {
@@ -76,44 +179,57 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain *domain,
 					void *args)
 {
 	struct ls_scfg_msi *msi_data = domain->host_data;
-	int pos, err = 0;
+	static struct list_head *current_entry;
+	struct ls_scfg_msi_ctrl *ctrl;
+	int i, hwirq = -ENOMEM;
+
+	if (!current_entry || current_entry->next == &msi_data->ctrl_list)
+		current_entry = &msi_data->ctrl_list;
+
+	list_for_each_entry(ctrl, current_entry, list) {
+		spin_lock(&ctrl->lock);
+		hwirq = bitmap_find_free_region(ctrl->bm,
+						msi_data->cfg->msir_irqs,
+						order_base_2(nr_irqs));
+		spin_unlock(&ctrl->lock);
+
+		if (hwirq >= 0)
+			break;
+	}
 
-	WARN_ON(nr_irqs != 1);
+	if (hwirq < 0)
+		return hwirq;
 
-	spin_lock(&msi_data->lock);
-	pos = find_first_zero_bit(msi_data->used, MSI_MAX_IRQS);
-	if (pos < MSI_MAX_IRQS)
-		__set_bit(pos, msi_data->used);
-	else
-		err = -ENOSPC;
-	spin_unlock(&msi_data->lock);
+	hwirq = hwirq + ctrl->irq_base;
 
-	if (err)
-		return err;
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &ls_scfg_msi_parent_chip, ctrl,
+				    handle_simple_irq, NULL, NULL);
 
-	irq_domain_set_info(domain, virq, pos,
-			    &ls_scfg_msi_parent_chip, msi_data,
-			    handle_simple_irq, NULL, NULL);
+	current_entry = &ctrl->list;
 
 	return 0;
 }
 
 static void ls_scfg_msi_domain_irq_free(struct irq_domain *domain,
-				   unsigned int virq, unsigned int nr_irqs)
+					unsigned int virq,
+					unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct ls_scfg_msi *msi_data = irq_data_get_irq_chip_data(d);
+	struct ls_scfg_msi_ctrl *ctrl = irq_data_get_irq_chip_data(d);
 	int pos;
 
-	pos = d->hwirq;
-	if (pos < 0 || pos >= MSI_MAX_IRQS) {
-		pr_err("failed to teardown msi. Invalid hwirq %d\n", pos);
+	pos = d->hwirq - ctrl->irq_base;
+
+	if (pos < 0 || pos >= ctrl->msi_data->cfg->msir_irqs) {
+		pr_err("Failed to teardown msi. Invalid hwirq %d\n", pos);
 		return;
 	}
 
-	spin_lock(&msi_data->lock);
-	__clear_bit(pos, msi_data->used);
-	spin_unlock(&msi_data->lock);
+	spin_lock(&ctrl->lock);
+	bitmap_release_region(ctrl->bm, pos, order_base_2(nr_irqs));
+	spin_unlock(&ctrl->lock);
 }
 
 static const struct irq_domain_ops ls_scfg_msi_domain_ops = {
@@ -121,29 +237,198 @@ static void ls_scfg_msi_domain_irq_free(struct irq_domain *domain,
 	.free	= ls_scfg_msi_domain_irq_free,
 };
 
-static void ls_scfg_msi_irq_handler(struct irq_desc *desc)
+static irqreturn_t ls_scfg_msi_irqs32_handler(int irq, void *arg)
 {
-	struct ls_scfg_msi *msi_data = irq_desc_get_handler_data(desc);
+	struct ls_scfg_msir *msir = arg;
+	struct ls_scfg_msi_ctrl *ctrl = msir->ctrl;
+	struct ls_scfg_msi *msi_data = ctrl->msi_data;
 	unsigned long val;
-	int pos, virq;
+	int pos = 0, hwirq, virq;
+	irqreturn_t ret = IRQ_NONE;
 
-	chained_irq_enter(irq_desc_get_chip(desc), desc);
+	val = ioread32be(msir->addr);
 
-	val = ioread32be(msi_data->regs + MSIR);
-	for_each_set_bit(pos, &val, MSI_MAX_IRQS) {
-		virq = irq_find_mapping(msi_data->parent, (31 - pos));
-		if (virq)
+	for_each_set_bit(pos, &val, IRQS_32_PER_MSIR) {
+		hwirq = (IRQS_32_PER_MSIR - 1 - pos) + ctrl->irq_base;
+		virq = irq_find_mapping(msi_data->parent, hwirq);
+		if (virq) {
 			generic_handle_irq(virq);
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	return ret;
+}
+
+static irqreturn_t ls_scfg_msi_irqs8_handler(int irq, void *arg)
+{
+	struct ls_scfg_msir *msir = arg;
+	struct ls_scfg_msi_ctrl *ctrl = msir->ctrl;
+	struct ls_scfg_msi *msi_data = ctrl->msi_data;
+	unsigned long val;
+	int pos = 0, hwirq, virq;
+	irqreturn_t ret = IRQ_NONE;
+
+	val = ioread32be(msir->addr);
+	val = (val << (msir->index * 8)) & 0xff000000;
+
+	for_each_set_bit(pos, &val, IRQS_32_PER_MSIR) {
+		hwirq = (IRQS_32_PER_MSIR - 1 - pos) + ctrl->irq_base;
+		virq = irq_find_mapping(msi_data->parent, hwirq);
+		if (virq) {
+			generic_handle_irq(virq);
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	return ret;
+}
+
+static void ls_scfg_msi_cascade(struct irq_desc *desc)
+{
+	struct ls_scfg_msir *msir = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+	ls_scfg_msi_irq_handler(desc->irq_data.irq, msir);
+	chained_irq_exit(chip, desc);
+}
+
+static int ls_scfg_msi_setup_hwirq(struct ls_scfg_msi_ctrl *ctrl,
+				   struct device_node *node,
+				   int index)
+{
+	struct ls_scfg_msir *msir = &ctrl->msir[index];
+	int ret;
+
+	msir->virq = of_irq_get(node, index);
+	if (msir->virq <= 0)
+		return -ENODEV;
+
+	msir->index = index;
+	msir->ctrl = ctrl;
+	msir->addr = ctrl->regs + ctrl->msi_data->cfg->msir_base +
+		     MSIR_OFFSET(msir->index);
+
+	if (ctrl->flag == MSI_GROUP_AFFINITY_FLAG) {
+		ret = request_irq(msir->virq, ls_scfg_msi_irq_handler,
+				  IRQF_NO_THREAD, "MSI-GROUP", msir);
+		if (ret) {
+			pr_err("failed to request irq %d\n", msir->virq);
+			msir->virq = 0;
+			return -ENODEV;
+		}
+	} else {
+		irq_set_chained_handler(msir->virq, ls_scfg_msi_cascade);
+		irq_set_handler_data(msir->virq, msir);
+		irq_set_affinity(msir->virq, get_cpu_mask(index));
+	}
+
+	return 0;
+}
+
+static void ls_scfg_msi_ctrl_remove(struct ls_scfg_msi_ctrl *ctrl)
+{
+	struct ls_scfg_msir *msir;
+	int i;
+
+	if (!ctrl)
+		return;
+
+	if (ctrl->msir) {
+		for (i = 0; i < ctrl->msi_data->cpu_num; i++) {
+			msir = &ctrl->msir[i];
+
+			if (msir->virq <= 0)
+				continue;
+
+			if (ctrl->flag == MSI_GROUP_AFFINITY_FLAG)
+				free_irq(msir->virq, msir);
+			else
+				irq_set_chained_handler_and_data(msir->virq,
+								 NULL, NULL);
+		}
+
+		kfree(ctrl->msir);
 	}
 
-	chained_irq_exit(irq_desc_get_chip(desc), desc);
+	if (ctrl->regs)
+		iounmap(ctrl->regs);
+
+	kfree(ctrl->bm);
+	kfree(ctrl);
+}
+
+static int ls_scfg_msi_ctrl_probe(struct device_node *node,
+				  struct ls_scfg_msi *msi_data)
+{
+	struct ls_scfg_msi_ctrl *ctrl;
+	struct resource res;
+	int err, irqs, i;
+
+	err = of_address_to_resource(node, 0, &res);
+	if (err) {
+		pr_warn("%s: no regs\n", node->full_name);
+		return -ENXIO;
+	}
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return  -ENOMEM;
+
+	ctrl->msi_data = msi_data;
+	ctrl->msiir_addr = res.start;
+	spin_lock_init(&ctrl->lock);
+
+	ctrl->regs = ioremap(res.start, resource_size(&res));
+	if (!ctrl->regs) {
+		pr_err("%s: unable to map registers\n", node->full_name);
+		err = -ENOMEM;
+		goto _err;
+	}
+
+	ctrl->msir = kcalloc(msi_data->cpu_num, sizeof(struct ls_scfg_msir),
+			     GFP_KERNEL);
+	if (!ctrl->msir) {
+		err = -ENOMEM;
+		goto _err;
+	}
+
+	ctrl->bm = kcalloc(BITS_TO_LONGS(msi_data->cfg->msir_irqs),
+			   sizeof(long), GFP_KERNEL);
+	if (!ctrl->bm) {
+		err = -ENOMEM;
+		goto _err;
+	}
+
+	ctrl->irq_base = msi_data->cfg->msir_irqs * ctrl_num;
+	ctrl_num++;
+
+	irqs = of_irq_count(node);
+	if (irqs >= msi_data->cpu_num)
+		ctrl->flag = MSI_AFFINITY_FLAG;
+	else
+		ctrl->flag = MSI_GROUP_AFFINITY_FLAG;
+
+	for (i = 0; i < msi_data->cpu_num; i++)
+		ls_scfg_msi_setup_hwirq(ctrl, node, i);
+
+	list_add_tail(&ctrl->list, &msi_data->ctrl_list);
+
+	return 0;
+
+_err:
+	ls_scfg_msi_ctrl_remove(ctrl);
+	pr_err("MSI: failed probing %s (%d)\n", node->full_name, err);
+	return err;
 }
 
 static int ls_scfg_msi_domains_init(struct ls_scfg_msi *msi_data)
 {
 	/* Initialize MSI domain parent */
 	msi_data->parent = irq_domain_add_linear(NULL,
-						 MSI_MAX_IRQS,
+						 msi_data->cfg->msir_irqs *
+						 ctrl_num,
 						 &ls_scfg_msi_domain_ops,
 						 msi_data);
 	if (!msi_data->parent) {
@@ -167,51 +452,57 @@ static int ls_scfg_msi_domains_init(struct ls_scfg_msi *msi_data)
 static int ls_scfg_msi_probe(struct platform_device *pdev)
 {
 	struct ls_scfg_msi *msi_data;
-	struct resource *res;
-	int ret;
+	const struct soc_device_attribute *match;
+	struct device_node *child;
 
 	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
 	if (!msi_data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	msi_data->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(msi_data->regs)) {
-		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
-		return PTR_ERR(msi_data->regs);
-	}
-	msi_data->msiir_addr = res->start;
-
-	msi_data->irq = platform_get_irq(pdev, 0);
-	if (msi_data->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get MSI irq\n");
-		return -ENODEV;
-	}
+	INIT_LIST_HEAD(&msi_data->ctrl_list);
 
 	msi_data->pdev = pdev;
-	spin_lock_init(&msi_data->lock);
+	msi_data->cpu_num = num_possible_cpus();
+
+	match = soc_device_match(soc_msi_matches);
+	if (match)
+		msi_data->cfg = match->data;
+	else
+		msi_data->cfg = &ls1046_msi_cfg;
+
+	if (msi_data->cfg->msir_irqs == IRQS_8_PER_MSIR)
+		ls_scfg_msi_irq_handler = ls_scfg_msi_irqs8_handler;
+	else
+		ls_scfg_msi_irq_handler = ls_scfg_msi_irqs32_handler;
 
-	ret = ls_scfg_msi_domains_init(msi_data);
-	if (ret)
-		return ret;
+	for_each_child_of_node(msi_data->pdev->dev.of_node, child)
+		ls_scfg_msi_ctrl_probe(child, msi_data);
 
-	irq_set_chained_handler_and_data(msi_data->irq,
-					 ls_scfg_msi_irq_handler,
-					 msi_data);
+	ls_scfg_msi_domains_init(msi_data);
 
 	platform_set_drvdata(pdev, msi_data);
 
+	dev_info(&pdev->dev, "irqs:%dx%d ibs_shift:%d msir_base:0x%x\n",
+		 msi_data->cfg->msir_irqs, ctrl_num,
+		 msi_data->cfg->ibs_shift, msi_data->cfg->msir_base);
+
 	return 0;
 }
 
 static int ls_scfg_msi_remove(struct platform_device *pdev)
 {
 	struct ls_scfg_msi *msi_data = platform_get_drvdata(pdev);
+	struct ls_scfg_msi_ctrl *ctrl, *temp;
 
-	irq_set_chained_handler_and_data(msi_data->irq, NULL, NULL);
+	list_for_each_entry_safe(ctrl, temp, &msi_data->ctrl_list, list) {
+		list_move_tail(&ctrl->list, &msi_data->ctrl_list);
+		ls_scfg_msi_ctrl_remove(ctrl);
+	}
 
-	irq_domain_remove(msi_data->msi_domain);
-	irq_domain_remove(msi_data->parent);
+	if (msi_data->msi_domain)
+		irq_domain_remove(msi_data->msi_domain);
+	if (msi_data->parent)
+		irq_domain_remove(msi_data->parent);
 
 	platform_set_drvdata(pdev, NULL);
 
@@ -219,8 +510,7 @@ static int ls_scfg_msi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ls_scfg_msi_id[] = {
-	{ .compatible = "fsl,1s1021a-msi", },
-	{ .compatible = "fsl,1s1043a-msi", },
+	{ .compatible = "fsl,ls-scfg-msi" },
 	{},
 };
 
-- 
1.9.1
