From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:17:56 +0100
Subject: [RFC/RFT PATCH 05/18] ARM: PCI: dove: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-6-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge().

Convert ARM dove platform code to pci_scan_root_bus_bridge() to improve
the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/pcie.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 91fe971..999e465 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -155,13 +155,31 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
 static struct pci_bus __init *
 dove_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 {
+	struct pci_host_bridge *bridge;
+	int ret;
+
 	if (nr >= num_pcie_ports) {
 		BUG();
 		return NULL;
 	}
 
-	return pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
-				 &sys->resources);
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(&sys->resources, &bridge->windows);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = sys;
+	bridge->busnr = sys->busnr;
+	bridge->ops = &pcie_ops;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0) {
+		pci_free_host_bridge(bridge);
+		return NULL;
+	}
+
+	return bridge->bus;
 }
 
 static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-- 
2.10.0
