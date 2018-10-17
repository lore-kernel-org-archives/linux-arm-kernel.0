From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Oct 2018 13:11:06 +0530
Subject: [PATCH v2 13/21] PCI: keystone: Cleanup configuration space access
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
Message-ID: <20181017074114.28239-14-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup configuration space access by removing ks_pcie_cfg_setup
which has an unncessary check of "if (bus == 0)" which will never be the
case of *_other_conf() and adding macros for configuring the CFG_SETUP
register required for accessing the configuration space of the device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 70 +++++++----------------
 1 file changed, 20 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 4f764ec49a4c..1f14de0ef27f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -45,7 +45,13 @@
 
 /* Application registers */
 #define CMD_STATUS			0x004
+
 #define CFG_SETUP			0x008
+#define CFG_BUS(x)			(((x) & 0xff) << 16)
+#define CFG_DEVICE(x)			(((x) & 0x1f) << 8)
+#define CFG_FUNC(x)			((x) & 0x7)
+#define CFG_TYPE1			BIT(24)
+
 #define OB_SIZE				0x030
 #define CFG_PCIM_WIN_SZ_IDX		3
 #define CFG_PCIM_WIN_CNT		32
@@ -364,60 +370,21 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	ks_pcie_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
 }
 
-/**
- * ks_pcie_cfg_setup() - Set up configuration space address for a device
- *
- * @ks_pcie: ptr to keystone_pcie structure
- * @bus: Bus number the device is residing on
- * @devfn: device, function number info
- *
- * Forms and returns the address of configuration space mapped in PCIESS
- * address space 0.  Also configures CFG_SETUP for remote configuration space
- * access.
- *
- * The address space has two regions to access configuration - local and remote.
- * We access local region for bus 0 (as RC is attached on bus 0) and remote
- * region for others with TYPE 1 access when bus > 1.  As for device on bus = 1,
- * we will do TYPE 0 access as it will be on our secondary bus (logical).
- * CFG_SETUP is needed only for remote configuration access.
- */
-static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
-				       unsigned int devfn)
-{
-	u8 device = PCI_SLOT(devfn), function = PCI_FUNC(devfn);
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	u32 regval;
-
-	if (bus == 0)
-		return pci->dbi_base;
-
-	regval = (bus << 16) | (device << 8) | function;
-
-	/*
-	 * Since Bus#1 will be a virtual bus, we need to have TYPE0
-	 * access only.
-	 * TYPE 1
-	 */
-	if (bus != 1)
-		regval |= BIT(24);
-
-	ks_pcie_app_writel(ks_pcie, CFG_SETUP, regval);
-	return pp->va_cfg0_base;
-}
-
 static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 unsigned int devfn, int where, int size,
 				 u32 *val)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u8 bus_num = bus->number;
-	void __iomem *addr;
+	u32 reg;
 
-	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
+	reg = CFG_BUS(bus->number) | CFG_DEVICE(PCI_SLOT(devfn)) |
+		CFG_FUNC(PCI_FUNC(devfn));
+	if (bus->parent->number != pp->root_bus_nr)
+		reg |= CFG_TYPE1;
+	ks_pcie_app_writel(ks_pcie, CFG_SETUP, reg);
 
-	return dw_pcie_read(addr + where, size, val);
+	return dw_pcie_read(pp->va_cfg0_base + where, size, val);
 }
 
 static int ks_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
@@ -426,12 +393,15 @@ static int ks_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u8 bus_num = bus->number;
-	void __iomem *addr;
+	u32 reg;
 
-	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
+	reg = CFG_BUS(bus->number) | CFG_DEVICE(PCI_SLOT(devfn)) |
+		CFG_FUNC(PCI_FUNC(devfn));
+	if (bus->parent->number != pp->root_bus_nr)
+		reg |= CFG_TYPE1;
+	ks_pcie_app_writel(ks_pcie, CFG_SETUP, reg);
 
-	return dw_pcie_write(addr + where, size, val);
+	return dw_pcie_write(pp->va_cfg0_base + where, size, val);
 }
 
 /**
-- 
2.17.1
