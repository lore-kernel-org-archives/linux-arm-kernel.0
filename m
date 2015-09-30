From: ddaney.cavm@gmail.com (David Daney)
Date: Wed, 30 Sep 2015 15:47:02 -0700
Subject: [PATCH v3 4/4] irqchip/gic-v3-its: Add handling of PCI requester id.
In-Reply-To: <1443653222-24924-1-git-send-email-ddaney.cavm@gmail.com>
References: <1443653222-24924-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1443653222-24924-5-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Replace open coded generation PCI/MSI requester id with call to the
new function pci_msi_domain_get_msi_rid() which applies the "msi-map"
to the id value.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index cf351c6..7bbf64a 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -42,7 +42,6 @@ static struct irq_chip its_msi_irq_chip = {
 
 struct its_pci_alias {
 	struct pci_dev	*pdev;
-	u32		dev_id;
 	u32		count;
 };
 
@@ -60,7 +59,6 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct its_pci_alias *dev_alias = data;
 
-	dev_alias->dev_id = alias;
 	if (pdev != dev_alias->pdev)
 		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
 
@@ -86,7 +84,7 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
 
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = dev_alias.dev_id;
+	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
 
 	return msi_info->ops->msi_prepare(domain->parent,
 					  dev, dev_alias.count, info);
-- 
1.9.1
