From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:55:41 +0200
Subject: [RESEND PATCH 02/12 v4] ARM: pci: create pci_common_init_dev()
Message-ID: <1366466141-15405-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When working with device tree support for PCI on ARM you run
into a problem when mapping IRQs from the device tree irqmaps:
doing this the code in drivers/of/of_pci_irq.c will try to
find the OF node on the root bridge and this fails, because
bus->dev.of_node is NULL, and that in turn boils down to
the fact that pci_set_bus_of_node() has called
pcibios_get_phb_of_node() from drivers/pci/of.c to obtain
the OF node of the bridge or its parent and none is set
and thus NULL is returned.

Fix this by adding an additional parent argument API for
registering PCI bridges on the ARM architecture called
pci_common_init_dev(), and pass along this parent to
pci_scan_root_bus() called from pcibios_init_hw() in
bios32.c and voila: the IRQ mappings start working:
the OF node can be retrieved from the parent.

Create the old pci_common_init() as a wrapper around
the new call.

Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmitt <benh@kernel.crashing.org>
Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Put opening bracket on its own line.
- Use the proper rmk+kernel address for Russells CC.
---
 arch/arm/include/asm/mach/pci.h | 12 +++++++++++-
 arch/arm/kernel/bios32.c        |  9 +++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 5cf2e97..28ac12f 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -16,6 +16,7 @@
 struct pci_sys_data;
 struct pci_ops;
 struct pci_bus;
+struct device;
 
 struct hw_pci {
 #ifdef CONFIG_PCI_DOMAINS
@@ -57,7 +58,16 @@ struct pci_sys_data {
 /*
  * Call this with your hw_pci struct to initialise the PCI system.
  */
-void pci_common_init(struct hw_pci *);
+void pci_common_init_dev(struct device *, struct hw_pci *);
+
+/*
+ * Compatibility wrapper for older platforms that do not care about
+ * passing the parent device.
+ */
+static inline void pci_common_init(struct hw_pci *hw)
+{
+	pci_common_init_dev(NULL, hw);
+}
 
 /*
  * Setup early fixed I/O mapping.
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index a1f73b5..a99bde1 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -445,7 +445,8 @@ static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
 	return 0;
 }
 
-static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
+static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
+			    struct list_head *head)
 {
 	struct pci_sys_data *sys = NULL;
 	int ret;
@@ -479,7 +480,7 @@ static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 			if (hw->scan)
 				sys->bus = hw->scan(nr, sys);
 			else
-				sys->bus = pci_scan_root_bus(NULL, sys->busnr,
+				sys->bus = pci_scan_root_bus(parent, sys->busnr,
 						hw->ops, sys, &sys->resources);
 
 			if (!sys->bus)
@@ -496,7 +497,7 @@ static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 	}
 }
 
-void pci_common_init(struct hw_pci *hw)
+void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 {
 	struct pci_sys_data *sys;
 	LIST_HEAD(head);
@@ -504,7 +505,7 @@ void pci_common_init(struct hw_pci *hw)
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 	if (hw->preinit)
 		hw->preinit();
-	pcibios_init_hw(hw, &head);
+	pcibios_init_hw(parent, hw, &head);
 	if (hw->postinit)
 		hw->postinit();
 
-- 
1.8.1.4
