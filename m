From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Wed, 15 Apr 2015 17:49:23 +0800
Subject: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
In-Reply-To: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMMU of some platforms can only isolate limited device ID.
This may require that all PCI devices share the same ITS
device with the fixed device ID. The patch adds function
arch_msi_share_devid_update used for these platforms to update
the fixed device ID and maximum MSI interrupts number.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d0374a6..be78d0a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1169,6 +1169,15 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
+void __weak
+arch_msi_share_devid_update(struct pci_dev *pdev, u32 *dev_id, u32 *nvesc)
+{
+	/*
+	 * use PCI_DEVID NOT share device ID as default
+	 * so nothing need to do
+	 */
+}
+
 static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 			   int nvec, msi_alloc_info_t *info)
 {
@@ -1185,6 +1194,8 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 	dev_alias.count = nvec;
 
 	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
+	arch_msi_share_devid_update(pdev, &dev_alias.dev_id, &dev_alias.count);
+
 	its = domain->parent->host_data;
 
 	its_dev = its_find_device(its, dev_alias.dev_id);
-- 
1.9.1
