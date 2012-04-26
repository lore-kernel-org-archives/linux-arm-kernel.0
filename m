From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Apr 2012 11:19:17 +0100
Subject: [PATCH 8/8] ARM: PCI: remove per-pci_hw list of buses
In-Reply-To: <20120426101626.GE24211@n2100.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
Message-ID: <E1SNLnB-00081I-Sl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No one uses the per-hw list of buses, so get rid of this.  Instead,
build the list locally.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/pci.h |    1 -
 arch/arm/kernel/bios32.c        |   11 +++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index b4b94b4..26c511f 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -19,7 +19,6 @@ struct hw_pci {
 #ifdef CONFIG_PCI_DOMAINS
 	int		domain;
 #endif
-	struct list_head buses;
 	struct pci_ops	*ops;
 	int		nr_controllers;
 	int		(*setup)(int nr, struct pci_sys_data *);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 00a506f..2555250 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -423,7 +423,7 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static void __init pcibios_init_hw(struct hw_pci *hw)
+static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 {
 	struct pci_sys_data *sys = NULL;
 	int ret;
@@ -463,7 +463,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 
 			busnr = sys->bus->subordinate + 1;
 
-			list_add(&sys->node, &hw->buses);
+			list_add(&sys->node, head);
 		} else {
 			kfree(sys);
 			if (ret < 0)
@@ -475,19 +475,18 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 void __init pci_common_init(struct hw_pci *hw)
 {
 	struct pci_sys_data *sys;
-
-	INIT_LIST_HEAD(&hw->buses);
+	LIST_HEAD(head);
 
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 	if (hw->preinit)
 		hw->preinit();
-	pcibios_init_hw(hw);
+	pcibios_init_hw(hw, &head);
 	if (hw->postinit)
 		hw->postinit();
 
 	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);
 
-	list_for_each_entry(sys, &hw->buses, node) {
+	list_for_each_entry(sys, &head, node) {
 		struct pci_bus *bus = sys->bus;
 
 		if (!pci_has_flag(PCI_PROBE_ONLY)) {
-- 
1.7.4.4
