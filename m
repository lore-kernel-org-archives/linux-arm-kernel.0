From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 04 Aug 2015 16:54:28 -0500
Subject: [PATCH v5 5/9] PCI/MSI: Remove unused pcibios_msi_controller() hook
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20150804215428.9189.60846.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

The pcibios_msi_controller() hook was only implemented by ARM, and it sets
pci_bus->msi now, so it doesn't need this hook anymore.

Remove the unused pcibios_msi_controller() hook.

[bhelgaas: changelog, split into separate patch]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f66be868..0d20142 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -77,24 +77,9 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 
 /* Arch hooks */
 
-struct msi_controller * __weak pcibios_msi_controller(struct pci_dev *dev)
-{
-	return NULL;
-}
-
-static struct msi_controller *pci_msi_controller(struct pci_dev *dev)
-{
-	struct msi_controller *msi_ctrl = dev->bus->msi;
-
-	if (msi_ctrl)
-		return msi_ctrl;
-
-	return pcibios_msi_controller(dev);
-}
-
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
-	struct msi_controller *chip = pci_msi_controller(dev);
+	struct msi_controller *chip = dev->bus->msi;
 	int err;
 
 	if (!chip || !chip->setup_irq)
