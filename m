From: paul.burton@imgtec.com (Paul Burton)
Date: Tue, 15 Aug 2017 12:02:21 -0700
Subject: [PATCH v7 6/8] PCI: aardvark: Use PCI_NUM_INTX
In-Reply-To: <20170815190223.18807-1-paul.burton@imgtec.com>
References: <20170815190223.18807-1-paul.burton@imgtec.com>
Message-ID: <20170815190223.18807-7-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch from using a custom LEGACY_IRQ_NUM macro to the generic
PCI_NUM_INTX definition for the number of INTx interrupts.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-pci at vger.kernel.org

---
I have only build tested this.

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pci-aardvark.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 5fb9b620ac78..89f4e3d072d7 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -191,7 +191,6 @@
 #define LINK_WAIT_USLEEP_MIN		90000
 #define LINK_WAIT_USLEEP_MAX		100000
 
-#define LEGACY_IRQ_NUM			4
 #define MSI_IRQ_NUM			32
 
 struct advk_pcie {
@@ -729,7 +728,7 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
 	pcie->irq_domain =
-		irq_domain_add_linear(pcie_intc_node, LEGACY_IRQ_NUM,
+		irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 				      &advk_pcie_irq_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
@@ -786,7 +785,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 		advk_pcie_handle_msi(pcie);
 
 	/* Process legacy interrupts */
-	for (i = 0; i < LEGACY_IRQ_NUM; i++) {
+	for (i = 0; i < PCI_NUM_INTX; i++) {
 		if (!(status & PCIE_ISR0_INTX_ASSERT(i)))
 			continue;
 
-- 
2.14.1
