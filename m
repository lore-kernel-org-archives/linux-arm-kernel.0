From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Oct 2018 13:10:55 +0530
Subject: [PATCH v2 02/21] PCI: keystone: Use quirk to set MRRS for PCI host
 bridge
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
Message-ID: <20181017074114.28239-3-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse the already existing quirk to set MRRS for PCI host bridge
instead of explicitly setting MRRS in ks_pcie_host_init.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 37 +++++++++--------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 7d43e10a03b0..5d9c5d199ada 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -43,7 +43,7 @@
 static void quirk_limit_mrrs(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge = bus->self;
+	struct pci_dev *bridge;
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
@@ -57,7 +57,7 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
 	};
 
 	if (pci_is_root_bus(bus))
-		return;
+		bridge = dev;
 
 	/* look for the host bridge */
 	while (!pci_is_root_bus(bus)) {
@@ -65,18 +65,19 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
 		bus = bus->parent;
 	}
 
-	if (bridge) {
-		/*
-		 * Keystone PCI controller has a h/w limitation of
-		 * 256 bytes maximum read request size.  It can't handle
-		 * anything higher than this.  So force this limit on
-		 * all downstream devices.
-		 */
-		if (pci_match_id(rc_pci_devids, bridge)) {
-			if (pcie_get_readrq(dev) > 256) {
-				dev_info(&dev->dev, "limiting MRRS to 256\n");
-				pcie_set_readrq(dev, 256);
-			}
+	if (!bridge)
+		return;
+
+	/*
+	 * Keystone PCI controller has a h/w limitation of
+	 * 256 bytes maximum read request size.  It can't handle
+	 * anything higher than this.  So force this limit on
+	 * all downstream devices.
+	 */
+	if (pci_match_id(rc_pci_devids, bridge)) {
+		if (pcie_get_readrq(dev) > 256) {
+			dev_info(&dev->dev, "limiting MRRS to 256\n");
+			pcie_set_readrq(dev, 256);
 		}
 	}
 }
@@ -264,7 +265,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u32 val;
 
 	ks_pcie_establish_link(ks_pcie);
 	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
@@ -275,13 +275,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	/* update the Vendor ID */
 	writew(ks_pcie->device_id, pci->dbi_base + PCI_DEVICE_ID);
 
-	/* update the DEV_STAT_CTRL to publish right mrrs */
-	val = readl(pci->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
-	val &= ~PCI_EXP_DEVCTL_READRQ;
-	/* set the mrrs to 256 bytes */
-	val |= BIT(12);
-	writel(val, pci->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
-
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
-- 
2.17.1
