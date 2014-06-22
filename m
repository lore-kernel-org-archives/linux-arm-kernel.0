From: vidyas@nvidia.com (Vidya Sagar)
Date: Sun, 22 Jun 2014 18:14:44 +0530
Subject: [PATCH v4] ARM: fix debug prints relevant to PCI devices
Message-ID: <1403441084-5643-1-git-send-email-vidyas@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per PCIe spec, fast back-to-back transactions feature
is not applicable to PCIe devices. Hence, do not print
that fast back-to-back trasactions are disabled when
there is a PCIe device found on the bus

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
v4:
* initialized 'has_pcie_dev' to 'false'

v3:
* removed KERN_INFO from pr_info() which was not removed by mistake in previous patch

v2:
* Modified has_pcie_dev type to bool and used pci_is_pcie() instead of pci_pcie_cap()
* replaced printk with pr_info

 arch/arm/kernel/bios32.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a26c1..749d1a0 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -290,6 +290,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 	u16 features = PCI_COMMAND_SERR | PCI_COMMAND_PARITY | PCI_COMMAND_FAST_BACK;
+	bool has_pcie_dev = false;
 
 	/*
 	 * Walk the devices on this bus, working out what we can
@@ -298,6 +299,8 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 status;
 
+		if (!has_pcie_dev)
+			has_pcie_dev = pci_is_pcie(dev);
 		pci_read_config_word(dev, PCI_STATUS, &status);
 
 		/*
@@ -354,9 +357,12 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 
 	/*
 	 * Report what we did for this bus
+	 * (only if the bus doesn't have any PCIe devices)
 	 */
-	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
-		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
+	if (!has_pcie_dev)
+		pr_info("PCI: bus%d: Fast back to back transfers %sabled\n",
+			bus->number,
+			(features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-- 
1.8.1.5
