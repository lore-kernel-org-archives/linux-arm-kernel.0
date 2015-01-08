From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  8 Jan 2015 17:06:12 +0000
Subject: [PATCH v2 8/8] PCI/MSI: Drop domain field from msi_controller
In-Reply-To: <1420736772-11088-1-git-send-email-marc.zyngier@arm.com>
References: <1420736772-11088-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1420736772-11088-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only two users of that field are not using the msi_controller
structure anymore, so drop it altogether.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/msi.c   | 2 --
 include/linux/msi.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 003040b..a36894f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -42,8 +42,6 @@ static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
 	struct irq_domain *domain = NULL;
 
 	domain = dev_get_msi_domain(&dev->dev);
-	if (!domain && dev->bus->msi)
-		domain = dev->bus->msi->domain;
 	if (!domain)
 		domain = arch_get_pci_msi_domain(dev);
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8ac4a68..692f217 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -108,9 +108,6 @@ struct msi_controller {
 	struct device *dev;
 	struct device_node *of_node;
 	struct list_head list;
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	struct irq_domain *domain;
-#endif
 
 	int (*setup_irq)(struct msi_controller *chip, struct pci_dev *dev,
 			 struct msi_desc *desc);
-- 
2.1.4
