From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Mar 2015 16:37:42 +0000
Subject: [PATCH 03/11] irqchip: gicv3-its: Iterate over PCI aliases to
 generate ITS configuration
In-Reply-To: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
References: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1425659870-11832-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current PCI/MSI support in the GICv3 ITS doesn't really deal
with systems where different PCI devices end-up using the same
RequesterID (as it would be the case with non-transparent bridges,
for example). It is likely that none of these devices would
actually generate any interrupt, as the ITS is programmed with
the device's own ID, and not that of the bridge.

A solution to this is to iterate over the PCI hierarchy to
discover what the device aliases too. We also use this
to discover the upper bound of the number of MSIs that this
sub-hierarchy can generate.

With this in place, PCI aliases can be supported.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 54 ++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 733b32f..46b9441 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1129,31 +1129,69 @@ static int its_alloc_device_irq(struct its_device *dev, irq_hw_number_t *hwirq)
 	return 0;
 }
 
+struct its_pci_alias {
+	struct pci_dev	*pdev;
+	u32		dev_id;
+	u32		count;
+};
+
+static int its_pci_msi_vec_count(struct pci_dev *pdev)
+{
+	int msi, msix;
+
+	msi = max(pci_msi_vec_count(pdev), 0);
+	msix = max(pci_msix_vec_count(pdev), 0);
+
+	return max(msi, msix);
+}
+
+static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct its_pci_alias *dev_alias = data;
+
+	dev_alias->dev_id = alias;
+	if (pdev != dev_alias->pdev)
+		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
+
+	return 0;
+}
+
 static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 			   int nvec, msi_alloc_info_t *info)
 {
 	struct pci_dev *pdev;
 	struct its_node *its;
-	u32 dev_id;
 	struct its_device *its_dev;
+	struct its_pci_alias dev_alias;
 
 	if (!dev_is_pci(dev))
 		return -EINVAL;
 
 	pdev = to_pci_dev(dev);
-	dev_id = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	dev_alias.pdev = pdev;
+	dev_alias.count = nvec;
+
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
 	its = domain->parent->host_data;
 
-	its_dev = its_find_device(its, dev_id);
-	if (WARN_ON(its_dev))
-		return -EINVAL;
+	its_dev = its_find_device(its, dev_alias.dev_id);
+	if (its_dev) {
+		/*
+		 * We already have seen this ID, probably through
+		 * another alias (PCI bridge of some sort). No need to
+		 * create the device.
+		 */
+		dev_dbg(dev, "Reusing ITT for devID %x\n", dev_alias.dev_id);
+		goto out;
+	}
 
-	its_dev = its_create_device(its, dev_id, nvec);
+	its_dev = its_create_device(its, dev_alias.dev_id, dev_alias.count);
 	if (!its_dev)
 		return -ENOMEM;
 
-	dev_dbg(&pdev->dev, "ITT %d entries, %d bits\n", nvec, ilog2(nvec));
-
+	dev_dbg(&pdev->dev, "ITT %d entries, %d bits\n",
+		dev_alias.count, ilog2(dev_alias.count));
+out:
 	info->scratchpad[0].ptr = its_dev;
 	info->scratchpad[1].ptr = dev;
 	return 0;
-- 
2.1.4
