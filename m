From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:18:08 +0100
Subject: [RFC/RFT PATCH 17/18] ARM: PCI: Remove pci_fixup_irqs() call for
 bios32 host controllers
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-18-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Legacy PCI host controllers (ie host controllers that set-up the PCI bus
through the ARM pci_common_init() API) are currently relying on
pci_fixup_irqs() to assign legacy PCI irqs to devices. This is not ideal
in that pci_fixup_irqs() assign IRQs for all PCI devices present in a
given system some of which may well be enabled by the time
pci_fixup_irqs() is called (ie a system with multiple host controllers).
With the introduction of struct pci_host_bridge.(*map_irq) pointer it is
possible to assign IRQs for all devices originating from a PCI host
bridge at probe time; this is implemented through pci_assign_irq() that
relies on the struct pci_host_bridge.map_irq pointer to map IRQ for a
given device.

The benefits this brings are twofold:

- the IRQ for a device is assigned once at probe time
- the IRQ assignment works also for hotplugged devices

Remove pci_fixup_irqs() call from bios32 code and rely on
pci_assign_irq() to carry out the IRQ mapping at device probe
time.

The map_irq() and swizzle_irq() struct pci_host_bridge callbacks are
set-up in the struct pci_host_bridge created in the bios32
pcibios_init_hw() function and mach-* code paths (for PCI mach
implementations that require a specific struct hw_pci.(*scan) function
callback).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/kernel/bios32.c    |  4 ++--
 arch/arm/mach-dove/pcie.c   | 18 ++++++++++--------
 arch/arm/mach-iop13xx/pci.c |  2 ++
 arch/arm/mach-orion5x/pci.c | 28 +++++++++++++++-------------
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index e2095f5..a5b6d4f 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -497,6 +497,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				bridge->busnr = sys->busnr;
 				bridge->ops = hw->ops;
 				bridge->msi = hw->msi_ctrl;
+				bridge->map_irq = pcibios_map_irq;
+				bridge->swizzle_irq = pcibios_swizzle;
 				bridge->align_resource =
 						hw->align_resource;
 
@@ -537,8 +539,6 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 	if (hw->postinit)
 		hw->postinit();
 
-	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);
-
 	list_for_each_entry(sys, &head, node) {
 		struct pci_bus *bus = sys->bus;
 
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 999e465..6df2be9 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -152,6 +152,14 @@ static void rc_pci_fixup(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
 
+static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pci_sys_data *sys = dev->sysdata;
+	struct pcie_port *pp = sys->private_data;
+
+	return pp->index ? IRQ_DOVE_PCIE1 : IRQ_DOVE_PCIE0;
+}
+
 static struct pci_bus __init *
 dove_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 {
@@ -172,6 +180,8 @@ dove_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
 	bridge->ops = &pcie_ops;
+	bridge->map_irq = dove_pcie_map_irq;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0) {
@@ -182,14 +192,6 @@ dove_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	return bridge->bus;
 }
 
-static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	struct pci_sys_data *sys = dev->sysdata;
-	struct pcie_port *pp = sys->private_data;
-
-	return pp->index ? IRQ_DOVE_PCIE1 : IRQ_DOVE_PCIE0;
-}
-
 static struct hw_pci dove_pci __initdata = {
 	.nr_controllers	= 2,
 	.setup		= dove_pcie_setup,
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index b0a8ded..3a7f960 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -537,6 +537,7 @@ struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
 	bridge->dev.parent = NULL;
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	switch (which_atu) {
 	case IOP13XX_INIT_ATU_ATUX:
@@ -556,6 +557,7 @@ struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
 		break;
 	case IOP13XX_INIT_ATU_ATUE:
 		bridge->ops = &iop13xx_atue_ops;
+		bridge->map_irq = iop13xx_pcie_map_irq;
 		ret = pci_scan_root_bus_bridge(bridge);
 		if (ret < 0) {
 			pci_free_host_bridge(bridge);
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 6dc4c89..86335e7 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -555,6 +555,19 @@ int __init orion5x_pci_sys_setup(int nr, struct pci_sys_data *sys)
 	return 0;
 }
 
+int __init orion5x_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int bus = dev->bus->number;
+
+	/*
+	 * PCIe endpoint?
+	 */
+	if (orion5x_pci_disabled || bus < orion5x_pci_local_bus_nr())
+		return IRQ_ORION5X_PCIE0_INT;
+
+	return -1;
+}
+
 struct pci_bus __init *orion5x_pci_sys_scan_bus(int nr, struct pci_sys_data *sys)
 {
 	struct pci_host_bridge *bridge;
@@ -568,6 +581,8 @@ struct pci_bus __init *orion5x_pci_sys_scan_bus(int nr, struct pci_sys_data *sys
 	bridge->dev.parent = NULL;
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
+	bridge->map_irq = orion5x_pci_map_irq;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	if (nr == 0) {
 		bridge->ops = &pcie_ops;
@@ -585,16 +600,3 @@ struct pci_bus __init *orion5x_pci_sys_scan_bus(int nr, struct pci_sys_data *sys
 	BUG();
 	return NULL;
 }
-
-int __init orion5x_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int bus = dev->bus->number;
-
-	/*
-	 * PCIe endpoint?
-	 */
-	if (orion5x_pci_disabled || bus < orion5x_pci_local_bus_nr())
-		return IRQ_ORION5X_PCIE0_INT;
-
-	return -1;
-}
-- 
2.10.0
