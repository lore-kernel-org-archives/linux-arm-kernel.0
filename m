From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 31 May 2016 13:19:39 +0200
Subject: [PATCH V5 2/7] acpi, pci: Setup MSI domain on a per-devices basis.
In-Reply-To: <1464693584-22343-1-git-send-email-tn@semihalf.com>
References: <1464693584-22343-1-git-send-email-tn@semihalf.com>
Message-ID: <1464693584-22343-3-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible to provide information about which MSI controller to
use on a per-device basis for DT. This patch supply this with ACPI support.

Currently, IORT is the only one ACPI table which can provide such mapping.
In order to plug IORT into MSI infrastructure we are adding ACPI
equivalents for finding PCI device domain and its RID translation
(pci_msi_domain_get_msi_rid and pci_msi_domain_get_msi_rid calls).

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/msi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..ba49df7 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/iort.h>
 #include <linux/slab.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
@@ -1364,8 +1365,8 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
 	of_node = irq_domain_get_of_node(domain);
-	if (of_node)
-		rid = of_msi_map_rid(&pdev->dev, of_node, rid);
+	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
+			iort_pci_get_msi_rid(pdev, rid);
 
 	return rid;
 }
@@ -1381,9 +1382,13 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
  */
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
+	struct irq_domain *dom;
 	u32 rid = 0;
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-	return of_msi_map_get_device_domain(&pdev->dev, rid);
+	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
+	if (!dom)
+		dom = iort_pci_get_domain(pdev, rid);
+	return dom;
 }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
-- 
1.9.1
