From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 21 Nov 2012 00:15:11 -0700
Subject: [PATCH] ARM: Kirkwood: Use hw_pci.ops instead of hw_pci.scan
Message-ID: <20121121071511.GE19837@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kirkwood_pcie_scan_bus function duplicates the common code in
bios32.c, passing ops in will use the common code..

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/mach-kirkwood/pcie.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

Just a little clean up I found while reviewing the PCI-E code.

diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index ec54491..d5aedf6 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -224,22 +224,6 @@ static void __devinit rc_pci_fixup(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
 
-static struct pci_bus __init *
-kirkwood_pcie_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	struct pci_bus *bus;
-
-	if (nr < num_pcie_ports) {
-		bus = pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
-					&sys->resources);
-	} else {
-		bus = NULL;
-		BUG();
-	}
-
-	return bus;
-}
-
 static int __init kirkwood_pcie_map_irq(const struct pci_dev *dev, u8 slot,
 	u8 pin)
 {
@@ -251,8 +235,8 @@ static int __init kirkwood_pcie_map_irq(const struct pci_dev *dev, u8 slot,
 
 static struct hw_pci kirkwood_pci __initdata = {
 	.setup		= kirkwood_pcie_setup,
-	.scan		= kirkwood_pcie_scan_bus,
 	.map_irq	= kirkwood_pcie_map_irq,
+	.ops            = &pcie_ops,
 };
 
 static void __init add_pcie_port(int index, void __iomem *base)
-- 
1.7.4.1
