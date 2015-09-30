From: majun258@huawei.com (MaJun)
Date: Wed, 30 Sep 2015 17:39:08 +0800
Subject: [PATCH v5 2/3] Probe mbigen chip and initial mbigen device as
 platform device.
In-Reply-To: <1443605949-15396-1-git-send-email-majun258@huawei.com>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
Message-ID: <1443605949-15396-3-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

After initializing mbigen device as interrupt controller,
this patch is used to probe mbigen chip and initial mbigen
device as a platform device so as to allocate msi-irqs 
within ITS-pMSI domain.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/irq-mbigen.c |  203 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 203 insertions(+), 0 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index e05a0ed..5951180 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -82,22 +82,45 @@
 #define MBIGEN_NODE_ADDR_BASE(nid)	((nid) * MBIGEN_NODE_OFFSET)
 
 /*
+ * struct mbigen_chip - holds the information of mbigen
+ * chip.
+ * @lock: spin lock protecting mbigen device list
+ * @pdev: pointer to the platform device structure of mbigen chip.
+ * @local_mgn_dev_list: list of devices connected to this mbigen chip.
+ * @base: mapped address of this mbigen chip.
+ */
+struct mbigen_chip {
+	raw_spinlock_t		lock;
+	struct platform_device *pdev;
+	struct list_head	local_mgn_dev_list;
+	void __iomem		*base;
+};
+
+/*
  * struct mbigen_device--Holds the  information of devices connected
  * to mbigen chip
+ * @lock: spin lock protecting mbigen node list
  * @domain: irq domain of this mbigen device.
+ * @local_entry: node in mbigen chip's mbigen_device_list
  * @global_entry: node in a global mbigen device list.
  * @node: represents the mbigen device node defined in device tree.
  * @mgn_data: pointer to mbigen_irq_data
  * @nr_irqs: the total interrupt lines of this device
  * @base: mapped address of mbigen chip which this mbigen device connected.
+ * @chip: pointer to mbigen chip
+ * @pdev: pointer to platform device structure of this mbigen device.
 */
 struct mbigen_device {
+	raw_spinlock_t		lock;
 	struct irq_domain	*domain;
+	struct list_head	local_entry;
 	struct list_head	global_entry;
 	struct device_node	*node;
 	struct mbigen_irq_data	*mgn_data;
 	unsigned int		nr_irqs;
 	void __iomem		*base;
+	struct mbigen_chip	*chip;
+	struct platform_device *pdev;
 };
 
 /*
@@ -340,6 +363,186 @@ out_free_dev:
 }
 IRQCHIP_DECLARE(hisi_mbigen, "hisilicon,mbigen-intc-v2", mbigen_intc_of_init);
 
+static struct mbigen_device *find_mbigen_device(struct device_node *node)
+{
+	struct mbigen_device *dev = NULL, *tmp;
+
+	spin_lock(&mbigen_device_lock);
+
+	list_for_each_entry(tmp, &mbigen_device_list, global_entry) {
+		if (tmp->node == node) {
+			dev = tmp;
+			break;
+		}
+	}
+	spin_unlock(&mbigen_device_lock);
+
+	return dev;
+}
+
+static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct mbigen_irq_data *mgn_irq_data = irq_get_handler_data(desc->irq);
+	struct mbigen_device *mgn_dev = mgn_irq_data->dev;
+	struct irq_priv_info *info = &mgn_irq_data->info;
+	u32 val;
+
+	val = readl_relaxed(info->reg_offset + mgn_dev->base);
+
+	val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
+	val |= (msg->data << IRQ_EVENT_ID_SHIFT);
+
+	writel_relaxed(val, info->reg_offset + mgn_dev->base);
+}
+
+static void mbigen_device_free(struct mbigen_device *mgn_dev)
+{
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, &mgn_dev->pdev->dev) {
+		free_irq(desc->irq, mgn_dev);
+	}
+
+	platform_msi_domain_free_irqs(&mgn_dev->pdev->dev);
+
+	/* delete mgn_dev from global mbigen device list*/
+	spin_lock(&mbigen_device_lock);
+	list_del(&mgn_dev->global_entry);
+	spin_unlock(&mbigen_device_lock);
+
+	irq_domain_remove(mgn_dev->domain);
+	kfree(mgn_dev->mgn_data);
+	kfree(mgn_dev);
+}
+
+static void mbigen_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
+{
+	struct mbigen_irq_data *mgn_irq_data = irq_get_handler_data(irq);
+
+	if (unlikely(!mgn_irq_data->dev_irq))
+		handle_bad_irq(mgn_irq_data->dev_irq, desc);
+	else
+		generic_handle_irq(mgn_irq_data->dev_irq);
+}
+
+
+static void mbigen_set_irq_handler_data(struct msi_desc *desc,
+				struct mbigen_device *mgn_dev)
+{
+	struct mbigen_irq_data *mgn_irq_data;
+
+	mgn_irq_data = &mgn_dev->mgn_data[desc->platform.msi_index];
+
+	mgn_irq_data->dev = mgn_dev;
+	mgn_irq_data->msi_irq = desc->irq;
+
+	irq_set_handler_data(desc->irq, mgn_irq_data);
+}
+
+/*
+ * Initial mbigen chip and mbigen device.
+ */
+static int mbigen_chip_probe(struct platform_device *pdev)
+{
+	struct mbigen_chip *mgn_chip;
+	struct device *dev = &pdev->dev;
+	struct device_node *root = dev->of_node, *child;
+	struct platform_device *mgn_pdev;
+	struct mbigen_device *mgn_dev;
+	struct msi_desc *desc;
+	void __iomem *base;
+	int ret;
+
+	mgn_chip = kzalloc(sizeof(*mgn_chip), GFP_KERNEL);
+	if (!mgn_chip)
+		return -ENOMEM;
+
+	mgn_chip->pdev = pdev;
+
+	base = of_iomap(root, 0);
+	mgn_chip->base = base;
+
+	of_platform_populate(root, NULL, NULL, &pdev->dev);
+
+	for_each_child_of_node(root, child) {
+		mgn_dev = find_mbigen_device(child);
+		mgn_pdev = of_find_device_by_node(child);
+
+		mgn_dev->base = base;
+		mgn_dev->pdev = mgn_pdev;
+		mgn_dev->chip = mgn_chip;
+
+		/* go to allocate msi-irqs from ITS-pMSI domain */
+		ret = platform_msi_domain_alloc_irqs(&mgn_pdev->dev,
+				mgn_dev->nr_irqs, mbigen_write_msg);
+		if (ret) {
+			pr_warn("mbigen-v2:failed to allocate msi irqs\n");
+			continue;
+		}
+
+		for_each_msi_entry(desc, &mgn_pdev->dev) {
+			mbigen_set_irq_handler_data(desc, mgn_dev);
+			irq_set_chained_handler(desc->irq, mbigen_handle_cascade_irq);
+		}
+
+		/* add this mbigen device into local mbigen device list
+		*which belong to mbigen chip
+		*/
+		INIT_LIST_HEAD(&mgn_dev->local_entry);
+		INIT_LIST_HEAD(&mgn_chip->local_mgn_dev_list);
+		raw_spin_lock_init(&mgn_chip->lock);
+
+		raw_spin_lock(&mgn_chip->lock);
+		list_add(&mgn_dev->local_entry, &mgn_chip->local_mgn_dev_list);
+		raw_spin_unlock(&mgn_chip->lock);
+	}
+
+	platform_set_drvdata(pdev, mgn_chip);
+
+	return 0;
+}
+
+static int mbigen_chip_remove(struct platform_device *pdev)
+{
+	struct mbigen_chip *mgn_chip = platform_get_drvdata(pdev);
+	struct mbigen_device *mgn_dev, *tmp;
+
+	raw_spin_lock(&mgn_chip->lock);
+	list_for_each_entry_safe(mgn_dev, tmp, &mgn_chip->local_mgn_dev_list,
+							local_entry) {
+		list_del(&mgn_dev->local_entry);
+		mbigen_device_free(mgn_dev);
+	}
+	raw_spin_lock(&mgn_chip->lock);
+
+	iounmap(mgn_chip->base);
+	kfree(mgn_chip);
+
+	return 0;
+}
+
+static const struct of_device_id mbigen_of_match[] = {
+	{ .compatible = "hisilicon,mbigen-v2" },
+	{ /* END */ }
+};
+MODULE_DEVICE_TABLE(of, mbigen_of_match);
+
+static struct platform_driver mbigen_platform_driver = {
+	.driver = {
+		.name		= "Hisilicon MBIGEN-V2",
+		.owner		= THIS_MODULE,
+		.of_match_table	= mbigen_of_match,
+	},
+	.probe			= mbigen_chip_probe,
+	.remove			= mbigen_chip_remove,
+};
+
+static int __init mbigen_chip_init(void)
+{
+	return platform_driver_register(&mbigen_platform_driver);
+}
+core_initcall(mbigen_chip_init);
+
 MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
 MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
 MODULE_LICENSE("GPL");
-- 
1.7.1
