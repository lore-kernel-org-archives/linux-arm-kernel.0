From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 27 Oct 2014 15:48:46 +0800
Subject: [PATCH 09/10] arm/PCI: Clean unused pcibios_add_bus() and
 pcibios_remove_bus()
In-Reply-To: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
References: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1414396127-30023-10-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MSI controller has been saved in pci_sys_data, now we can
clean up pcibios_add_bus() and pcibios_remove_bus()
in arm, and use pcibios_msi_controller() to get MSI controller
pointer.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/arm/include/asm/mach/pci.h |    4 ----
 arch/arm/kernel/bios32.c        |   16 ----------------
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 8144d61..8292b5f 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -39,8 +39,6 @@ struct hw_pci {
 					  resource_size_t start,
 					  resource_size_t size,
 					  resource_size_t align);
-	void		(*add_bus)(struct pci_bus *bus);
-	void		(*remove_bus)(struct pci_bus *bus);
 };
 
 /*
@@ -71,8 +69,6 @@ struct pci_sys_data {
 					  resource_size_t start,
 					  resource_size_t size,
 					  resource_size_t align);
-	void		(*add_bus)(struct pci_bus *bus);
-	void		(*remove_bus)(struct pci_bus *bus);
 	void		*private_data;	/* platform controller private data	*/
 };
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 073229f..32301fc 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -369,20 +369,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	struct pci_sys_data *sys = bus->sysdata;
-	if (sys->add_bus)
-		sys->add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	struct pci_sys_data *sys = bus->sysdata;
-	if (sys->remove_bus)
-		sys->remove_bus(bus);
-}
-
 /*
  * Swizzle the device pin each time we cross a bridge.  If a platform does
  * not provide a swizzle function, we perform the standard PCI swizzling.
@@ -487,8 +473,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
 		sys->align_resource = hw->align_resource;
-		sys->add_bus = hw->add_bus;
-		sys->remove_bus = hw->remove_bus;
 		INIT_LIST_HEAD(&sys->resources);
 
 		if (hw->private_data)
-- 
1.7.1
