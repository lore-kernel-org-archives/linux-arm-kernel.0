From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Sat, 10 Oct 2015 10:59:13 +0800
Subject: [PATCH v10 2/6] ARM/PCI: remove align_resource in pci_sys_data
In-Reply-To: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <1444445957-239522-3-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch is needed in order to unify the PCIe designware framework for ARM and
ARM64 architectures. In the PCIe designware unification process we are calling
pci_create_root_bus() passing a "sysdata" parameter that is the same for both
ARM and ARM64 and is of type "struct pcie_port*". In the ARM case this will
cause a problem with the function pcibios_align_resource(); in fact this will
cast "dev->sysdata" to "struct pci_sys_data*", whereas designware had passed a
"struct pcie_port*" pointer.

This patch solves the issue by removing "align_resource" from "pci_sys_data"
struct and defining a static global function pointer in "bios32.c"

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 arch/arm/include/asm/mach/pci.h |  6 ------
 arch/arm/kernel/bios32.c        | 12 ++++++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 8857d28..0070e85 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -52,12 +52,6 @@ struct pci_sys_data {
 	u8		(*swizzle)(struct pci_dev *, u8 *);
 					/* IRQ mapping				*/
 	int		(*map_irq)(const struct pci_dev *, u8, u8);
-					/* Resource alignement requirements	*/
-	resource_size_t (*align_resource)(struct pci_dev *dev,
-					  const struct resource *res,
-					  resource_size_t start,
-					  resource_size_t size,
-					  resource_size_t align);
 	void		*private_data;	/* platform controller private data	*/
 };
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 874e182..6551d28 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -17,6 +17,11 @@
 #include <asm/mach/pci.h>
 
 static int debug_pci;
+static resource_size_t (*align_resource)(struct pci_dev *dev,
+		  const struct resource *res,
+		  resource_size_t start,
+		  resource_size_t size,
+		  resource_size_t align) = NULL;
 
 /*
  * We can't use pci_get_device() here since we are
@@ -456,7 +461,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
-		sys->align_resource = hw->align_resource;
+		align_resource = hw->align_resource;
 		INIT_LIST_HEAD(&sys->resources);
 
 		if (hw->private_data)
@@ -572,7 +577,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
-	struct pci_sys_data *sys = dev->sysdata;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
@@ -580,8 +584,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	start = (start + align - 1) & ~(align - 1);
 
-	if (sys->align_resource)
-		return sys->align_resource(dev, res, start, size, align);
+	if (align_resource)
+		return align_resource(dev, res, start, size, align);
 
 	return start;
 }
-- 
1.9.1
