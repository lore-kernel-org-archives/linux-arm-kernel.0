From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Thu, 18 Oct 2018 17:37:17 +0200
Subject: [PATCH v3 2/4] PCI: mvebu: Drop unused PCI express capability code
In-Reply-To: <20181018153719.23115-1-thomas.petazzoni@bootlin.com>
References: <20181018153719.23115-1-thomas.petazzoni@bootlin.com>
Message-ID: <20181018153719.23115-3-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit dc0352ab0b2a0 ("PCI: mvebu: Add PCI Express root complex
capability block") added support for emulating the PCI Express
capability block. As part of this, the pcie_sltcap, pcie_devctl and
pcie_rtctl fields were added to the mvebu_sw_pci_bridge structure, and
used when reading the corresponding PCI Express capability block
registers.

However, those structure members are never set to any value other than
zero. This makes them unneeded because:

 - pcie_devctl is used to OR *value, so with pcie_devctl always zero,
   it has no effect.

 - for pcie_sltcap and pcie_rtstl, the mvebu_sw_pci_bridge_read()
   function always returns 0 for registers that are not explicitly
   handled.

In preparation for reworking the PCI bridge emulation logic in
pci-mvebu, let's simplify the code by dropping those structure
members.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 50eb0729385b..beaff9325a09 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -111,11 +111,6 @@ struct mvebu_sw_pci_bridge {
 	u8 intline;
 	u8 intpin;
 	u16 bridgectrl;
-
-	/* PCI express capability */
-	u32 pcie_sltcap;
-	u16 pcie_devctl;
-	u16 pcie_rtctl;
 };
 
 struct mvebu_pcie_port;
@@ -588,7 +583,6 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL) &
 				 ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
 				   PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
-		*value |= bridge->pcie_devctl;
 		break;
 
 	case PCISWCAP_EXP_LNKCAP:
@@ -604,18 +598,10 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
 		break;
 
-	case PCISWCAP_EXP_SLTCAP:
-		*value = bridge->pcie_sltcap;
-		break;
-
 	case PCISWCAP_EXP_SLTCTL:
 		*value = PCI_EXP_SLTSTA_PDS << 16;
 		break;
 
-	case PCISWCAP_EXP_RTCTL:
-		*value = bridge->pcie_rtctl;
-		break;
-
 	case PCISWCAP_EXP_RTSTA:
 		*value = mvebu_readl(port, PCIE_RC_RTSTA);
 		break;
-- 
2.14.4
