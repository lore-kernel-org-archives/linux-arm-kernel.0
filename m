From: paul.burton@imgtec.com (Paul Burton)
Date: Tue, 15 Aug 2017 12:02:20 -0700
Subject: [PATCH v7 5/8] PCI: xilinx-nwl: Translate INTx range to hwirqs 0-3
In-Reply-To: <20170815190223.18807-1-paul.burton@imgtec.com>
References: <20170815190223.18807-1-paul.burton@imgtec.com>
Message-ID: <20170815190223.18807-6-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The devicetree binding documentation for the Xilinx NWL PCIe root port
bridge shows an example which uses an interrupt-map property to map PCI
INTx interrupts to hardware IRQ numbers 1-4. The driver creates an IRQ
domain with size 4, which therefore covers the hwirq range 0-3.

This means that if we attempt to make use of the INTD interrupt then
we're likely to hit a WARN() in irq_domain_associate() because INTD, or
hwirw=4, is outside of the range covered by the IRQ domain.
irq_domain_associate() will then return -EINVAL and we'll be unable to
make use of INTD.

Fix this by making use of the pci_irqd_intx_xlate() helper function to
translate the 1-4 range used in the DT to a 0-3 range used within the
driver, and stop adding 1 to decoded hwirq numbers.

Whilst cleaning up INTx handling we make use of the new PCI_NUM_INTX
macro & drop the custom INTX definitions.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-pci at vger.kernel.org

---
I have only build tested this. The problem is identical to that in the
pcie-xilinx driver, which is fixed similarly in an earlier patch.

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-xilinx-nwl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index eec641a34fc5..573847f4b9bc 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -133,7 +133,6 @@
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 
 #define INT_PCI_MSI_NR			(2 * 32)
-#define INTX_NUM			4
 
 /* Readin the PS_LINKUP */
 #define PS_LINKUP_OFFSET		0x00000238
@@ -334,9 +333,8 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
 
 	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
 				MSGF_LEG_SR_MASKALL) != 0) {
-		for_each_set_bit(bit, &status, INTX_NUM) {
-			virq = irq_find_mapping(pcie->legacy_irq_domain,
-						bit + 1);
+		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
+			virq = irq_find_mapping(pcie->legacy_irq_domain, bit);
 			if (virq)
 				generic_handle_irq(virq);
 		}
@@ -436,6 +434,7 @@ static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
 
 static const struct irq_domain_ops legacy_domain_ops = {
 	.map = nwl_legacy_map,
+	.xlate = pci_irqd_intx_xlate,
 };
 
 #ifdef CONFIG_PCI_MSI
@@ -559,7 +558,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 	}
 
 	pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node,
-							INTX_NUM,
+							PCI_NUM_INTX,
 							&legacy_domain_ops,
 							pcie);
 
-- 
2.14.1
