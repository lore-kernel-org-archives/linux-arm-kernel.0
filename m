From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 15 Nov 2014 10:49:12 +0000
Subject: [PATCH 1/2] PCI/MSI: Allow an msi_chip to be associated to an irq
 domain
In-Reply-To: <1416048553-29289-1-git-send-email-marc.zyngier@arm.com>
References: <1416048553-29289-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1416048553-29289-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new stacked irq domains, it becomes pretty tempting
to allocate an MSI domain per PCI bus, which would remove
the requirement of either relying on arch-specific code, or
a default PCI MSI domain.

By allowing the msi_chip structure to carry a pointer to
an irq_domain, we can easily use this in pci_msi_setup_msi_irqs.
The existing code can still be used as a fallback if the MSI driver
does not populate the domain field.

Tested on arm64 with the GICv3 ITS driver.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/msi.c   | 16 +++++++++++++++-
 include/linux/msi.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index af66b95..aa3b720 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -84,11 +84,25 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return 0;
 }
 
+static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
+{
+	struct irq_domain *domain = NULL;
+
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	if (dev->bus->msi)
+		domain = dev->bus->msi->domain;
+#endif
+	if (!domain)
+		domain = arch_get_pci_msi_domain(dev);
+
+	return domain;
+}
+
 static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct irq_domain *domain;
 
-	domain = arch_get_pci_msi_domain(dev);
+	domain = pci_msi_get_domain(dev);
 	if (domain)
 		return pci_msi_domain_alloc_irqs(domain, type, dev);
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8b4a69b..a8d309a 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -89,6 +89,9 @@ struct msi_chip {
 	struct device *dev;
 	struct device_node *of_node;
 	struct list_head list;
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	struct irq_domain *domain;
+#endif
 
 	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
 			 struct msi_desc *desc);
-- 
2.1.0
