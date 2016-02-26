From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 26 Feb 2016 17:35:47 +0000
Subject: [RFC v4 07/14] msi: Add a new MSI_FLAG_IRQ_REMAPPING flag
In-Reply-To: <1456508154-2253-1-git-send-email-eric.auger@linaro.org>
References: <1456508154-2253-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1456508154-2253-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's introduce a new msi_domain_info flag value, MSI_FLAG_IRQ_REMAPPING
meant to tell the domain supports IRQ REMAPPING, also known as Interrupt
Translation Service. On Intel HW this capability is abstracted on IOMMU
side while on ARM it is abstracted on MSI controller side.

GICv3 ITS HW is the first HW advertising that feature.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 3 ++-
 include/linux/msi.h                      | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index aee60ed..8223765 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -96,7 +96,8 @@ static struct msi_domain_ops its_pci_msi_ops = {
 
 static struct msi_domain_info its_pci_msi_domain_info = {
 	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX |
+		   MSI_FLAG_IRQ_REMAPPING),
 	.ops	= &its_pci_msi_ops,
 	.chip	= &its_msi_irq_chip,
 };
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a2a0068..03eda72 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -261,6 +261,8 @@ enum {
 	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
 	/* Support PCI MSIX interrupts */
 	MSI_FLAG_PCI_MSIX		= (1 << 4),
+	/* Support MSI IRQ remapping service */
+	MSI_FLAG_IRQ_REMAPPING		= (1 << 5),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
-- 
1.9.1
