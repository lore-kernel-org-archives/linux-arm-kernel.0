From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:17:55 +0100
Subject: [RFC/RFT PATCH 04/18] ARM: PCI: bios32: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-5-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge).

Convert ARM bios32 code to pci_scan_root_bus_bridge() to improve
the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/kernel/bios32.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 2f0e077..e2095f5 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -473,7 +473,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		ret = hw->setup(nr, sys);
 
 		if (ret > 0) {
-			struct pci_host_bridge *host_bridge;
+			struct pci_host_bridge *bridge;
 
 			ret = pcibios_init_resource(nr, sys, hw->io_optional);
 			if (ret)  {
@@ -483,10 +483,31 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 
 			if (hw->scan)
 				sys->bus = hw->scan(nr, sys);
-			else
-				sys->bus = pci_scan_root_bus_msi(parent,
-					sys->busnr, hw->ops, sys,
-					&sys->resources, hw->msi_ctrl);
+			else {
+				bridge = pci_alloc_host_bridge(0);
+				if (!bridge) {
+					kfree(sys);
+					break;
+				}
+
+				list_splice_init(&sys->resources,
+						 &bridge->windows);
+				bridge->dev.parent = parent;
+				bridge->sysdata = sys;
+				bridge->busnr = sys->busnr;
+				bridge->ops = hw->ops;
+				bridge->msi = hw->msi_ctrl;
+				bridge->align_resource =
+						hw->align_resource;
+
+				ret = pci_scan_root_bus_bridge(bridge);
+				if (ret < 0) {
+					pci_free_host_bridge(bridge);
+					break;
+				}
+
+				sys->bus = bridge->bus;
+			}
 
 			if (WARN(!sys->bus, "PCI: unable to scan bus!")) {
 				kfree(sys);
@@ -496,9 +517,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			busnr = sys->bus->busn_res.end + 1;
 
 			list_add(&sys->node, head);
-
-			host_bridge = pci_find_host_bridge(sys->bus);
-			host_bridge->align_resource = hw->align_resource;
 		} else {
 			kfree(sys);
 			if (ret < 0)
-- 
2.10.0
