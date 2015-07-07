From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  7 Jul 2015 18:17:57 +0100
Subject: [PATCH v3 07/15] PCI/MSI: Let pci_msi_get_domain use struct device's
 msi_domain
In-Reply-To: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436289485-28230-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can easily find which MSI domain a PCI device is
using, use dev_get_msi_domain as a way to retrieve the information.

The original code is still used as a fallback.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 1e55935..5ffc340 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -41,7 +41,8 @@ static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
 {
 	struct irq_domain *domain = NULL;
 
-	if (dev->bus->msi)
+	domain = dev_get_msi_domain(&dev->dev);
+	if (!domain && dev->bus->msi)
 		domain = dev->bus->msi->domain;
 	if (!domain)
 		domain = arch_get_pci_msi_domain(dev);
-- 
2.1.4
