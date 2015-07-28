From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 28 Jul 2015 14:46:14 +0100
Subject: [PATCH v6 07/19] PCI/MSI: Let pci_msi_get_domain use struct device's
 msi_domain
In-Reply-To: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
References: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1438091186-10244-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can easily find which MSI domain a PCI device is
using, use dev_get_msi_domain as a way to retrieve the information.

The original code is still used as a fallback.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/msi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 8c30cfc..70afadc 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -39,14 +39,16 @@ struct irq_domain * __weak arch_get_pci_msi_domain(struct pci_dev *dev)
 
 static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
 {
-	struct irq_domain *domain = NULL;
+	struct irq_domain *domain;
 
-	if (dev->bus->msi)
-		domain = dev->bus->msi->domain;
-	if (!domain)
-		domain = arch_get_pci_msi_domain(dev);
+	domain = dev_get_msi_domain(&dev->dev);
+	if (domain)
+		return domain;
 
-	return domain;
+	if (dev->bus->msi && (domain = dev->bus->msi->domain))
+		return domain;
+
+	return arch_get_pci_msi_domain(dev);
 }
 
 static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-- 
2.1.4
