From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Wed, 15 Apr 2015 17:48:33 +0800
Subject: [PATCH v2 1/3] arm/pci: Add support architecture-independent PCIe
 driver
In-Reply-To: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <1429091315-31891-2-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe common driver of arm architecture uses private structure
pci_sys_data and hw_pci to associate with specific PCIe controller
ops which results in the PCIe controller driver not compatible
with other architectures. This patch provides another approach
to support architecture-independent PCIe driver which does not
need to use pci_sys_data and hw_pci and call pci_common_init_dev().

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v1-v2: no change

 arch/arm/kernel/bios32.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index ab19b7c0..8820ed5 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -7,6 +7,7 @@
  */
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -17,12 +18,16 @@
 #include <asm/mach/pci.h>
 
 static int debug_pci;
+static int pci_commont_init_enable;
 
 #ifdef CONFIG_PCI_MSI
 struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
 {
 	struct pci_sys_data *sysdata = dev->bus->sysdata;
 
+	if (!pci_commont_init_enable)
+		return NULL;
+
 	return sysdata->msi_ctrl;
 }
 #endif
@@ -508,6 +513,8 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 	struct pci_sys_data *sys;
 	LIST_HEAD(head);
 
+	pci_commont_init_enable = 1;
+
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 	if (hw->preinit)
 		hw->preinit();
@@ -597,7 +604,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	start = (start + align - 1) & ~(align - 1);
 
-	if (sys->align_resource)
+	if (pci_commont_init_enable && sys->align_resource)
 		return sys->align_resource(dev, res, start, size, align);
 
 	return start;
@@ -651,3 +658,13 @@ void __init pci_map_io_early(unsigned long pfn)
 	pci_io_desc.pfn = pfn;
 	iotable_init(&pci_io_desc, 1);
 }
+
+/*
+ * Try to assign the IRQ number from DT when adding a new device
+ */
+int pcibios_add_device(struct pci_dev *dev)
+{
+	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+
+	return 0;
+}
-- 
1.9.1
