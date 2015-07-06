From: majun258@huawei.com (Ma Jun)
Date: Mon, 6 Jul 2015 15:09:07 +0800
Subject: [PATCH v3 2/3] IRQ/Gic-V3: Change arm-gic-its to support the Mbigen
 interrupt
In-Reply-To: <1436166548-34920-1-git-send-email-majun258@huawei.com>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
Message-ID: <1436166548-34920-3-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is applied to support the mbigen interrupt.

As a kind of MSI interrupt controller, the mbigen is used as a child 
domain of ITS domain just like PCI devices.

To support the mbigen driver, changes in its file list below:
Change in v3:
---Splitting the its_pci_msi_prepare fucntion into two functions: it_pci_msi_prepare and
	its_msi_prepare. So its_msi_prepare can be called from mbigen driver to create its
	device.
	This change based on the code from Marc. Thanks
---Add a function get_its_domain for mbigen driver using to the get pointer of its domain.

Change in v2:
---arm-gic-v3-its.c: [1]Create the mbigen irq domain in its_init;
	[2] add the irq_compose_mbigen_msg and irq_write_mbigen_msg 
	for mbigen using.[3]add its_mbigen_prepare function.
---irq.h: Add 'irq_compose_mbigen_msg' and 'irq_write_mbigen_msg' in
	struct irq_chip for mbigen using.
---chip.c: Before the irq_ack callback, check the irq_ack first(chip.c)

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c |   60 +++++++++++++++++++++++++------------
 1 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9687f8a..1cb8c20 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1193,49 +1193,55 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
+int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
 			   int nvec, msi_alloc_info_t *info)
 {
-	struct pci_dev *pdev;
 	struct its_node *its;
 	struct its_device *its_dev;
-	struct its_pci_alias dev_alias;
-
-	if (!dev_is_pci(dev))
-		return -EINVAL;
-
-	pdev = to_pci_dev(dev);
-	dev_alias.pdev = pdev;
-	dev_alias.count = nvec;
 
-	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
 	its = domain->parent->host_data;
+	its_dev = its_find_device(its, dev_id);
 
-	its_dev = its_find_device(its, dev_alias.dev_id);
 	if (its_dev) {
 		/*
 		 * We already have seen this ID, probably through
 		 * another alias (PCI bridge of some sort). No need to
 		 * create the device.
 		 */
-		dev_dbg(dev, "Reusing ITT for devID %x\n", dev_alias.dev_id);
+		pr_debug("Reusing ITT for devID %x\n", dev_id);
 		goto out;
 	}
 
-	its_dev = its_create_device(its, dev_alias.dev_id, dev_alias.count);
+	its_dev = its_create_device(its, dev_id, nvec);
 	if (!its_dev)
 		return -ENOMEM;
 
-	dev_dbg(&pdev->dev, "ITT %d entries, %d bits\n",
-		dev_alias.count, ilog2(dev_alias.count));
+	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
 	info->scratchpad[0].ptr = its_dev;
-	info->scratchpad[1].ptr = dev;
 	return 0;
 }
 
+static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *info)
+{
+	struct pci_dev *pdev;
+	struct its_pci_alias dev_alias;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	dev_alias.pdev = pdev;
+	dev_alias.count = nvec;
+
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
+
+	return its_msi_prepare(domain, dev_alias.dev_id, dev_alias.count, info);
+}
+
 static struct msi_domain_ops its_pci_msi_ops = {
-	.msi_prepare	= its_msi_prepare,
+	.msi_prepare	= its_pci_msi_prepare,
 };
 
 static struct msi_domain_info its_pci_msi_domain_info = {
@@ -1280,8 +1286,10 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i,
 					      hwirq, &its_irq_chip, its_dev);
-		dev_dbg(info->scratchpad[1].ptr, "ID:%d pID:%d vID:%d\n",
-			(int)(hwirq - its_dev->lpi_base), (int)hwirq, virq + i);
+
+		pr_debug("ID:%d pID:%d vID:%d\n",
+			 (int)(hwirq - its_dev->lpi_base),
+			 (int)hwirq, virq + i);
 	}
 
 	return 0;
@@ -1375,6 +1383,18 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
+struct irq_domain *get_its_domain(struct device_node *node)
+{
+	struct its_node *its = NULL;
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		if (its->msi_chip.of_node == node)
+			break;
+	}
+
+	return (its)?its->domain:NULL;
+}
+
 static int its_probe(struct device_node *node, struct irq_domain *parent)
 {
 	struct resource res;
-- 
1.7.1
