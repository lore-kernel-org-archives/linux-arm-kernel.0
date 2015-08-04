From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 04 Aug 2015 16:54:20 -0500
Subject: [PATCH v5 4/9] ARM/PCI: Remove msi_controller from struct pci_sys_data
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20150804215420.9189.22914.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

ARM now uses pci_bus->msi to store the msi_controller pointer, so we don't
need to save it in struct pci_sys_data, and we don't need to implement
pcibios_msi_controller() to get it out of pci_sys_data.

Remove msi_controller from struct pci_sys_data and
pcibios_msi_controller().

[bhelgaas: changelog, split into separate patch]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/include/asm/mach/pci.h |    3 ---
 arch/arm/kernel/bios32.c        |   12 ------------
 2 files changed, 15 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index c074e7a..8857d28 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -40,9 +40,6 @@ struct hw_pci {
  * Per-controller structure
  */
 struct pci_sys_data {
-#ifdef CONFIG_PCI_MSI
-	struct msi_controller *msi_ctrl;
-#endif
 	struct list_head node;
 	int		busnr;		/* primary bus number			*/
 	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 283bc1c..874e182 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -18,15 +18,6 @@
 
 static int debug_pci;
 
-#ifdef CONFIG_PCI_MSI
-struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
-{
-	struct pci_sys_data *sysdata = dev->bus->sysdata;
-
-	return sysdata->msi_ctrl;
-}
-#endif
-
 /*
  * We can't use pci_get_device() here since we are
  * called from interrupt context.
@@ -462,9 +453,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		if (WARN(!sys, "PCI: unable to allocate sys data!"))
 			break;
 
-#ifdef CONFIG_PCI_MSI
-		sys->msi_ctrl = hw->msi_ctrl;
-#endif
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
