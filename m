From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 22 Sep 2015 17:00:06 -0700
Subject: [PATCH v2 3/3] irqchip/gicv3-its: Handle OF device tree "msi-map"
 properties.
In-Reply-To: <1442966406-13198-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442966406-13198-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1442966406-13198-4-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Call of_msi_map_rid() to handle mapping of the requester id.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index cf351c6..8b1c938 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -86,7 +86,8 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
 
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = dev_alias.dev_id;
+	info->scratchpad[0].ul = of_msi_map_rid(dev, domain->of_node,
+						dev_alias.dev_id);
 
 	return msi_info->ops->msi_prepare(domain->parent,
 					  dev, dev_alias.count, info);
-- 
1.9.1
