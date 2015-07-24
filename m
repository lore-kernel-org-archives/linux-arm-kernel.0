From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 24 Jul 2015 17:13:02 +0100
Subject: [PATCH v2 1/2] ARM: PCI: bios32: replace panic with WARN messages on
 failures
Message-ID: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the ARM PCI bios32 layer, failures to dynamically allocate pci_sys_data
for a PCI bus, or a PCI bus scan failure have to be considered serious
warnings but they should not trigger a system panic so that at least the
system is given a chance to be debugged.

This patch replaces the panic statements with WARN() messages to
improve error reporting in the ARM PCI bios32 layer.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/bios32.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1..a5c782c 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -459,8 +459,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 
 	for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
 		sys = kzalloc(sizeof(struct pci_sys_data), GFP_KERNEL);
-		if (!sys)
-			panic("PCI: unable to allocate sys data!");
+		if (WARN(!sys, "PCI: unable to allocate sys data!"))
+			break;
 
 #ifdef CONFIG_PCI_MSI
 		sys->msi_ctrl = hw->msi_ctrl;
@@ -489,8 +489,10 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				sys->bus = pci_scan_root_bus(parent, sys->busnr,
 						hw->ops, sys, &sys->resources);
 
-			if (!sys->bus)
-				panic("PCI: unable to scan bus!");
+			if (WARN(!sys->bus, "PCI: unable to scan bus!")) {
+				kfree(sys);
+				break;
+			}
 
 			busnr = sys->bus->busn_res.end + 1;
 
-- 
2.2.1
