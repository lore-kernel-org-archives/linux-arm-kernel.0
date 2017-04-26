From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:17:57 +0100
Subject: [RFC/RFT PATCH 06/18] ARM: PCI: iop13xx: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-7-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge().

Convert ARM iop13xx platform code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/mach-iop13xx/pci.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 204eb44..b0a8ded 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -506,8 +506,9 @@ iop13xx_pci_abort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
  */
 struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
 {
-	int which_atu;
+	int which_atu, ret;
 	struct pci_bus *bus = NULL;
+	struct pci_host_bridge *bridge;
 
 	switch (init_atu) {
 	case IOP13XX_INIT_ATU_ATUX:
@@ -528,6 +529,15 @@ struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
 		return NULL;
 	}
 
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(&sys->resources, &bridge->windows);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = sys;
+	bridge->busnr = sys->busnr;
+
 	switch (which_atu) {
 	case IOP13XX_INIT_ATU_ATUX:
 		if (time_after_eq(jiffies + msecs_to_jiffies(1000),
@@ -535,14 +545,24 @@ struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
 			while(time_before(jiffies, atux_trhfa_timeout))
 				udelay(100);
 
-		bus = pci_bus_atux = pci_scan_root_bus(NULL, sys->busnr,
-						       &iop13xx_atux_ops,
-						       sys, &sys->resources);
+		bridge->ops = &iop13xx_atux_ops;
+		ret = pci_scan_root_bus_bridge(bridge);
+		if (ret < 0) {
+			pci_free_host_bridge(bridge);
+			return NULL;
+		}
+
+		bus = pci_bus_atux = bridge->bus;
 		break;
 	case IOP13XX_INIT_ATU_ATUE:
-		bus = pci_bus_atue = pci_scan_root_bus(NULL, sys->busnr,
-						       &iop13xx_atue_ops,
-						       sys, &sys->resources);
+		bridge->ops = &iop13xx_atue_ops;
+		ret = pci_scan_root_bus_bridge(bridge);
+		if (ret < 0) {
+			pci_free_host_bridge(bridge);
+			return NULL;
+		}
+
+		bus = pci_bus_atue = bridge->bus;
 		break;
 	}
 
-- 
2.10.0
