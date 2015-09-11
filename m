From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 11 Sep 2015 16:21:59 -0700
Subject: [PATCH 6/6] PCI: generic: Allow bus default MSI controller to be
 specified.
In-Reply-To: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1442013719-5001-7-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

If the device tree node for the bus has a "msi-parent" property, use
that as the default MSI controller for devices on the bus.  Add device
tree binding documentation describing the new property.

This allows the pci-host-generic driver to be used in systems with
multiple MSI controllers.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../devicetree/bindings/pci/host-generic-pci.txt          |  5 +++++
 drivers/pci/host/pci-host-generic.c                       | 15 +++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
index cf3e205..daa6942 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
@@ -29,6 +29,11 @@ Properties of the host controller node:
                    to indicate the range of bus numbers for this controller.
                    If absent, defaults to <0 255> (i.e. all buses).
 
+- msi-parent     : Optional property to indicate the MSI controller associated
+                   with devices on the bus.  If not present, the default MSI
+                   controller is used.  This property is further discussed in
+                   interrupt-controller/msi.txt
+
 - #address-cells : Must be 3.
 
 - #size-cells    : Must be 2.
diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 8219c0b..e0248b4 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -225,6 +225,7 @@ static int gen_pci_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
 	struct pci_bus *bus, *child;
+	struct msi_controller *msi;
 
 	if (!pci)
 		return -ENOMEM;
@@ -265,8 +266,18 @@ static int gen_pci_probe(struct platform_device *pdev)
 	if (!pci_has_flag(PCI_PROBE_ONLY))
 		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 
-	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
-				&pci->cfg.ops.ops, pci, &pci->resources);
+	msi = NULL;
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		struct device_node *msi_node;
+
+		msi_node = of_parse_phandle(np, "msi-parent", 0);
+		if (msi_node)
+			msi = of_pci_find_msi_chip_by_node(msi_node);
+	}
+
+	bus = pci_scan_root_bus_msi(dev, pci->cfg.bus_range->start,
+				    &pci->cfg.ops.ops, pci, &pci->resources,
+				    msi);
 	if (!bus) {
 		dev_err(dev, "Scanning rootbus failed");
 		return -ENODEV;
-- 
1.7.11.7
