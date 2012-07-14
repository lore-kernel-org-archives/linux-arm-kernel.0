From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:03:58 -0500
Subject: [PATCH v2 02/15] ARM: move PCI i/o resource setup into common code
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With consolidation of the PCI i/o mappings, the i/o space is being
set to start at a PCI bus addr of 0x0 and fixed to 64K per bus. In
this case the core ARM PCI setup code can setup the i/o resource.

Currently, the resource is only setup if the platform did not setup
an i/o resource.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/mach/pci.h |    3 +++
 arch/arm/kernel/bios32.c        |   41 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 51630c0..423edff 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -11,6 +11,7 @@
 #ifndef __ASM_MACH_PCI_H
 #define __ASM_MACH_PCI_H
 
+#include <linux/ioport.h>
 #include <asm/mach/map.h>
 
 struct pci_sys_data;
@@ -44,6 +45,8 @@ struct pci_sys_data {
 	unsigned long	io_offset;	/* bus->cpu IO mapping offset		*/
 	struct pci_bus	*bus;		/* PCI bus				*/
 	struct list_head resources;	/* root bus resources (apertures)       */
+	struct resource io_res;
+	char		io_res_name[12];
 					/* Bridge swizzling			*/
 	u8		(*swizzle)(struct pci_dev *, u8 *);
 					/* IRQ mapping				*/
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 311e1cc..316dd02 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -424,6 +424,38 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
+static int __init pcibios_init_resources(int busnr, struct pci_sys_data *sys)
+{
+	int ret;
+	struct pci_host_bridge_window *window;
+
+	if (list_empty(&sys->resources)) {
+		pci_add_resource_offset(&sys->resources,
+			 &iomem_resource, sys->mem_offset);
+	}
+
+	list_for_each_entry(window, &sys->resources, list) {
+		if (resource_type(window->res) == IORESOURCE_IO)
+			return 0;
+	}
+
+	sys->io_res.start = (busnr * SZ_64K) ?  : pcibios_min_io;
+	sys->io_res.end = (busnr + 1) * SZ_64K - 1;
+	sys->io_res.flags = IORESOURCE_IO;
+	sys->io_res.name = sys->io_res_name;
+	sprintf(sys->io_res_name, "PCI%d I/O", busnr);
+
+	ret = request_resource(&ioport_resource, &sys->io_res);
+	if (ret) {
+		pr_err("PCI: unable to allocate I/O port region (%d)\n", ret);
+		return ret;
+	}
+	pci_add_resource_offset(&sys->resources, &sys->io_res,
+				sys->io_offset);
+
+	return 0;
+}
+
 static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 {
 	struct pci_sys_data *sys = NULL;
@@ -446,11 +478,10 @@ static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 		ret = hw->setup(nr, sys);
 
 		if (ret > 0) {
-			if (list_empty(&sys->resources)) {
-				pci_add_resource_offset(&sys->resources,
-					 &ioport_resource, sys->io_offset);
-				pci_add_resource_offset(&sys->resources,
-					 &iomem_resource, sys->mem_offset);
+			ret = pcibios_init_resources(nr, sys);
+			if (ret)  {
+				kfree(sys);
+				break;
 			}
 
 			if (hw->scan)
-- 
1.7.9.5
