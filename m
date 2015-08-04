From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 04 Aug 2015 16:54:11 -0500
Subject: [PATCH v5 3/9] ARM/PCI, designware,
 xilinx: Use pci_scan_root_bus_msi()
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20150804215411.9189.53901.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

ARM previously stored the msi_controller pointer in its sysdata, struct
pci_sys_data, and implemented pcibios_msi_controller() to retrieve it.
That made PCI host controller drivers specific to ARM because they had to
put the msi_controller pointer in the ARM-specific pci_sys_data.

There is now a generic mechanism, pci_scan_root_bus_msi(), for giving the
msi_controller pointer to the PCI core.  Use this for all ARM systems and
for the DesignWare and Xilinx PCI host controller drivers.

This removes an ARM dependency from the DesignWare, DRA7xx, EXYNOS, i.MX6,
Keystone, Layerscape, SPEAr13xx, and Xilinx drivers.

[bhelgaas: changelog, split into separate patch]
Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Pratyush Anand <pratyush.anand@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Jingoo Han <jingoohan1@gmail.com>
CC: Simon Horman <horms@verge.net.au>
CC: Russell King <linux@arm.linux.org.uk>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Michal Simek <michal.simek@xilinx.com>
CC: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/mach/pci.h    |    2 --
 arch/arm/kernel/bios32.c           |    5 +++--
 drivers/pci/host/pcie-designware.c |    6 +++---
 drivers/pci/host/pcie-xilinx.c     |    5 ++---
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 28b9bb3..c074e7a 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -19,9 +19,7 @@ struct pci_bus;
 struct device;
 
 struct hw_pci {
-#ifdef CONFIG_PCI_MSI
 	struct msi_controller *msi_ctrl;
-#endif
 	struct pci_ops	*ops;
 	int		nr_controllers;
 	void		**private_data;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 4e95260..283bc1c 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -486,8 +486,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			if (hw->scan)
 				sys->bus = hw->scan(nr, sys);
 			else
-				sys->bus = pci_scan_root_bus(parent, sys->busnr,
-						hw->ops, sys, &sys->resources);
+				sys->bus = pci_scan_root_bus_msi(parent,
+					sys->busnr, hw->ops, sys,
+					&sys->resources, hw->msi_ctrl);
 
 			if (WARN(!sys->bus, "PCI: unable to scan bus!")) {
 				kfree(sys);
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..bd0aeec 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -526,7 +526,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 #ifdef CONFIG_PCI_MSI
 	dw_pcie_msi_chip.dev = pp->dev;
-	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
 #endif
 
 	dw_pci.nr_controllers = 1;
@@ -708,8 +707,9 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	struct pcie_port *pp = sys_to_pcie(sys);
 
 	pp->root_bus_nr = sys->busnr;
-	bus = pci_scan_root_bus(pp->dev, sys->busnr,
-				  &dw_pcie_ops, sys, &sys->resources);
+	bus = pci_scan_root_bus_msi(pp->dev, sys->busnr, &dw_pcie_ops, sys,
+				    &sys->resources, &dw_pcie_msi_chip);
+
 	if (!bus)
 		return NULL;
 
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index f1a06a0..526807d 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -647,8 +647,8 @@ static struct pci_bus *xilinx_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	struct pci_bus *bus;
 
 	port->root_busno = sys->busnr;
-	bus = pci_scan_root_bus(port->dev, sys->busnr, &xilinx_pcie_ops,
-				sys, &sys->resources);
+	bus = pci_scan_root_bus_msi(port->dev, sys->busnr, &xilinx_pcie_ops,
+				sys, &sys->resources, &xilinx_pcie_msi_chip);
 
 	return bus;
 }
@@ -847,7 +847,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PCI_MSI
 	xilinx_pcie_msi_chip.dev = port->dev;
-	hw.msi_ctrl = &xilinx_pcie_msi_chip;
 #endif
 	pci_common_init_dev(dev, &hw);
 
