From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:17:58 +0100
Subject: [RFC/RFT PATCH 07/18] ARM: PCI: orion5x: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-8-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge().

Convert ARM orion5x platform code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-orion5x/pci.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index ecb998e..6dc4c89 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -557,13 +557,30 @@ int __init orion5x_pci_sys_setup(int nr, struct pci_sys_data *sys)
 
 struct pci_bus __init *orion5x_pci_sys_scan_bus(int nr, struct pci_sys_data *sys)
 {
-	if (nr == 0)
-		return pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
-					 &sys->resources);
+	struct pci_host_bridge *bridge;
+	int ret = -ENODEV;
 
-	if (nr == 1 && !orion5x_pci_disabled)
-		return pci_scan_root_bus(NULL, sys->busnr, &pci_ops, sys,
-					 &sys->resources);
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(&sys->resources, &bridge->windows);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = sys;
+	bridge->busnr = sys->busnr;
+
+	if (nr == 0) {
+		bridge->ops = &pcie_ops;
+		ret = pci_scan_root_bus_bridge(bridge);
+	}
+
+	if (nr == 1 && !orion5x_pci_disabled) {
+		bridge->ops = &pci_ops;
+		ret = pci_scan_root_bus_bridge(bridge);
+	}
+
+	if (!ret)
+		return bridge->bus;
 
 	BUG();
 	return NULL;
-- 
2.10.0
