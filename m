From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sat, 1 Jul 2017 15:06:30 +0100
Subject: [RFT PATCH v2 29/42] ARM: PCI: Remove pci_fixup_irqs() call for
 bios32 host controllers
In-Reply-To: <20170608141342.2018-30-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <20170608141342.2018-30-lorenzo.pieralisi@arm.com>
Message-ID: <20170701140629.GC8977@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Thu, Jun 08, 2017 at 03:13:29PM +0100, Lorenzo Pieralisi wrote:
> Legacy PCI host controllers (ie host controllers that set-up the PCI bus
> through the ARM pci_common_init() API) are currently relying on
> pci_fixup_irqs() to assign legacy PCI irqs to devices. This is not ideal
> in that pci_fixup_irqs() assign IRQs for all PCI devices present in a
> given system some of which may well be enabled by the time
> pci_fixup_irqs() is called (ie a system with multiple host controllers).
> With the introduction of struct pci_host_bridge.(*map_irq) pointer it is
> possible to assign IRQs for all devices originating from a PCI host
> bridge at probe time; this is implemented through pci_assign_irq() that
> relies on the struct pci_host_bridge.map_irq pointer to map IRQ for a
> given device.
> 
> The benefits this brings are twofold:
> 
> - the IRQ for a device is assigned once at probe time
> - the IRQ assignment works also for hotplugged devices
> 
> Remove pci_fixup_irqs() call from bios32 code and rely on
> pci_assign_irq() to carry out the IRQ mapping at device probe
> time.
> 
> The map_irq() and swizzle_irq() struct pci_host_bridge callbacks are
> set-up in the struct pci_host_bridge created in the bios32
> pcibios_init_hw() function and mach-* code paths (for PCI mach
> implementations that require a specific struct hw_pci.(*scan) function
> callback).
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/kernel/bios32.c    |  4 ++--
>  arch/arm/mach-dove/pcie.c   | 18 ++++++++++--------
>  arch/arm/mach-iop13xx/pci.c |  2 ++
>  arch/arm/mach-orion5x/pci.c | 28 +++++++++++++++-------------
>  4 files changed, 29 insertions(+), 23 deletions(-)

As I mentioned to you, this patch is incomplete and needs an upgrade
(ie I misread how Orion and the gazillions board file that go with
it to map irqs - apologies but it is very hard to untangle).

I am inlining below an incremental patch to be folded in commit:

feaec00e757a ("ARM/PCI: Remove pci_fixup_irqs() call for bios32 host
controllers")

in your pci/irq-fixups branch, or if you prefer I can send you the
resulting squashed-in patch to replace this one, as you prefer.

I understand timing is tight I am doing all I can to fix this series
up and make 4.13.

Please let me know how I can help, thank you !
Lorenzo

-- >8 --
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index da201a2..56dc1a3 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -484,6 +484,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				break;
 			}
 
+			bridge->map_irq = pcibios_map_irq;
+			bridge->swizzle_irq = pcibios_swizzle;
+
 			if (hw->scan)
 				ret = hw->scan(nr, bridge);
 			else {
@@ -494,8 +497,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				bridge->busnr = sys->busnr;
 				bridge->ops = hw->ops;
 				bridge->msi = hw->msi_ctrl;
-				bridge->map_irq = pcibios_map_irq;
-				bridge->swizzle_irq = pcibios_swizzle;
 				bridge->align_resource =
 						hw->align_resource;
 
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 8d54a67..dfb62f3 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -152,14 +152,6 @@ static void rc_pci_fixup(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
 
-static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	struct pci_sys_data *sys = dev->sysdata;
-	struct pcie_port *pp = sys->private_data;
-
-	return pp->index ? IRQ_DOVE_PCIE1 : IRQ_DOVE_PCIE0;
-}
-
 static int __init
 dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 {
@@ -175,12 +167,18 @@ dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
 	bridge->ops = &pcie_ops;
-	bridge->map_irq = dove_pcie_map_irq;
-	bridge->swizzle_irq = pci_common_swizzle;
 
 	return pci_scan_root_bus_bridge(bridge);
 }
 
+static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pci_sys_data *sys = dev->sysdata;
+	struct pcie_port *pp = sys->private_data;
+
+	return pp->index ? IRQ_DOVE_PCIE1 : IRQ_DOVE_PCIE0;
+}
+
 static struct hw_pci dove_pci __initdata = {
 	.nr_controllers	= 2,
 	.setup		= dove_pcie_setup,
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 3c51a9b..070d92a 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -532,7 +532,6 @@ int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
 	bridge->dev.parent = NULL;
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
-	bridge->swizzle_irq = pci_common_swizzle;
 
 	switch (which_atu) {
 	case IOP13XX_INIT_ATU_ATUX:
@@ -548,7 +547,6 @@ int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
 		break;
 	case IOP13XX_INIT_ATU_ATUE:
 		bridge->ops = &iop13xx_atue_ops;
-		bridge->map_irq = iop13xx_pcie_map_irq;
 		ret = pci_scan_root_bus_bridge(bridge);
 		if (!ret)
 			pci_bus_atue = bridge->bus;
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 0f1c343..76951bf 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -555,19 +555,6 @@ int __init orion5x_pci_sys_setup(int nr, struct pci_sys_data *sys)
 	return 0;
 }
 
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
-
 int __init orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge)
 {
 	struct pci_sys_data *sys = pci_host_bridge_priv(bridge);
@@ -576,8 +563,6 @@ int __init orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge)
 	bridge->dev.parent = NULL;
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
-	bridge->map_irq = orion5x_pci_map_irq;
-	bridge->swizzle_irq = pci_common_swizzle;
 
 	if (nr == 0) {
 		bridge->ops = &pcie_ops;
@@ -592,3 +577,16 @@ int __init orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge)
 	BUG();
 	return -ENODEV;
 }
+
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
-- 
2.10.0
