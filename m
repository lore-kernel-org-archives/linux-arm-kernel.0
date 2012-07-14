From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:04:07 -0500
Subject: [PATCH v2 11/15] ARM: orion5x: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-12-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move orion5x PCI to fixed i/o mapping and remove io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                             |    1 -
 arch/arm/mach-orion5x/common.c               |   10 -----
 arch/arm/mach-orion5x/include/mach/io.h      |   22 ----------
 arch/arm/mach-orion5x/include/mach/orion5x.h |   20 +++++----
 arch/arm/mach-orion5x/pci.c                  |   56 +++++++++-----------------
 5 files changed, 27 insertions(+), 82 deletions(-)
 delete mode 100644 arch/arm/mach-orion5x/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8a74244..e542f99 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -585,7 +585,6 @@ config ARCH_ORION5X
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
-	select NEED_MACH_IO_H
 	select PLAT_ORION
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 9148b22..70f7d71 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -47,16 +47,6 @@ static struct map_desc orion5x_io_desc[] __initdata = {
 		.length		= ORION5X_REGS_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= ORION5X_PCIE_IO_VIRT_BASE,
-		.pfn		= __phys_to_pfn(ORION5X_PCIE_IO_PHYS_BASE),
-		.length		= ORION5X_PCIE_IO_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= ORION5X_PCI_IO_VIRT_BASE,
-		.pfn		= __phys_to_pfn(ORION5X_PCI_IO_PHYS_BASE),
-		.length		= ORION5X_PCI_IO_SIZE,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= ORION5X_PCIE_WA_VIRT_BASE,
 		.pfn		= __phys_to_pfn(ORION5X_PCIE_WA_PHYS_BASE),
 		.length		= ORION5X_PCIE_WA_SIZE,
diff --git a/arch/arm/mach-orion5x/include/mach/io.h b/arch/arm/mach-orion5x/include/mach/io.h
deleted file mode 100644
index 1aa5d0a..0000000
--- a/arch/arm/mach-orion5x/include/mach/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/io.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#include <mach/orion5x.h>
-#include <asm/sizes.h>
-
-#define IO_SPACE_LIMIT		SZ_2M
-static inline void __iomem *__io(unsigned long addr)
-{
-	return (void __iomem *)(addr + ORION5X_PCIE_IO_VIRT_BASE);
-}
-
-#define __io(a)			 __io(a)
-#endif
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index 683e085..1b60131 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -31,31 +31,29 @@
  * fc000000	device bus mappings (cs0/cs1)
  *
  * virt		phys		size
- * fdd00000	f1000000	1M	on-chip peripheral registers
- * fde00000	f2000000	1M	PCIe I/O space
- * fdf00000	f2100000	1M	PCI I/O space
- * fe000000	f0000000	16M	PCIe WA space (Orion-1/Orion-NAS only)
+ * fe000000	f1000000	1M	on-chip peripheral registers
+ * fee00000	f2000000	64K	PCIe I/O space
+ * fee10000	f2100000	64K	PCI I/O space
+ * fd000000	f0000000	16M	PCIe WA space (Orion-1/Orion-NAS only)
  ****************************************************************************/
 #define ORION5X_REGS_PHYS_BASE		0xf1000000
-#define ORION5X_REGS_VIRT_BASE		0xfdd00000
+#define ORION5X_REGS_VIRT_BASE		0xfe000000
 #define ORION5X_REGS_SIZE		SZ_1M
 
 #define ORION5X_PCIE_IO_PHYS_BASE	0xf2000000
-#define ORION5X_PCIE_IO_VIRT_BASE	0xfde00000
 #define ORION5X_PCIE_IO_BUS_BASE	0x00000000
-#define ORION5X_PCIE_IO_SIZE		SZ_1M
+#define ORION5X_PCIE_IO_SIZE		SZ_64K
 
 #define ORION5X_PCI_IO_PHYS_BASE	0xf2100000
-#define ORION5X_PCI_IO_VIRT_BASE	0xfdf00000
-#define ORION5X_PCI_IO_BUS_BASE		0x00100000
-#define ORION5X_PCI_IO_SIZE		SZ_1M
+#define ORION5X_PCI_IO_BUS_BASE		0x00010000
+#define ORION5X_PCI_IO_SIZE		SZ_64K
 
 #define ORION5X_SRAM_PHYS_BASE		(0xf2200000)
 #define ORION5X_SRAM_SIZE		SZ_8K
 
 /* Relevant only for Orion-1/Orion-NAS */
 #define ORION5X_PCIE_WA_PHYS_BASE	0xf0000000
-#define ORION5X_PCIE_WA_VIRT_BASE	0xfe000000
+#define ORION5X_PCIE_WA_VIRT_BASE	0xfd000000
 #define ORION5X_PCIE_WA_SIZE		SZ_16M
 
 #define ORION5X_PCIE_MEM_PHYS_BASE	0xe0000000
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index cb19e16..6921d49 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -162,35 +162,25 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 		pcie_ops.read = pcie_rd_conf_wa;
 	}
 
+	pci_ioremap_io(sys->busnr * SZ_64K, ORION5X_PCIE_IO_PHYS_BASE);
+
 	/*
 	 * Request resources.
 	 */
-	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
 	if (!res)
 		panic("pcie_setup unable to alloc resources");
 
 	/*
-	 * IORESOURCE_IO
-	 */
-	sys->io_offset = 0;
-	res[0].name = "PCIe I/O Space";
-	res[0].flags = IORESOURCE_IO;
-	res[0].start = ORION5X_PCIE_IO_BUS_BASE;
-	res[0].end = res[0].start + ORION5X_PCIE_IO_SIZE - 1;
-	if (request_resource(&ioport_resource, &res[0]))
-		panic("Request PCIe IO resource failed\n");
-	pci_add_resource_offset(&sys->resources, &res[0], sys->io_offset);
-
-	/*
 	 * IORESOURCE_MEM
 	 */
-	res[1].name = "PCIe Memory Space";
-	res[1].flags = IORESOURCE_MEM;
-	res[1].start = ORION5X_PCIE_MEM_PHYS_BASE;
-	res[1].end = res[1].start + ORION5X_PCIE_MEM_SIZE - 1;
-	if (request_resource(&iomem_resource, &res[1]))
+	res->name = "PCIe Memory Space";
+	res->flags = IORESOURCE_MEM;
+	res->start = ORION5X_PCIE_MEM_PHYS_BASE;
+	res->end = res->start + ORION5X_PCIE_MEM_SIZE - 1;
+	if (request_resource(&iomem_resource, res))
 		panic("Request PCIe Memory resource failed\n");
-	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, res, sys->mem_offset);
 
 	return 1;
 }
@@ -489,35 +479,25 @@ static int __init pci_setup(struct pci_sys_data *sys)
 	 */
 	orion5x_setbits(PCI_CMD, PCI_CMD_HOST_REORDER);
 
+	pci_ioremap_io(sys->busnr * SZ_64K, ORION5X_PCI_IO_PHYS_BASE);
+
 	/*
 	 * Request resources
 	 */
-	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
 	if (!res)
 		panic("pci_setup unable to alloc resources");
 
 	/*
-	 * IORESOURCE_IO
-	 */
-	sys->io_offset = 0;
-	res[0].name = "PCI I/O Space";
-	res[0].flags = IORESOURCE_IO;
-	res[0].start = ORION5X_PCI_IO_BUS_BASE;
-	res[0].end = res[0].start + ORION5X_PCI_IO_SIZE - 1;
-	if (request_resource(&ioport_resource, &res[0]))
-		panic("Request PCI IO resource failed\n");
-	pci_add_resource_offset(&sys->resources, &res[0], sys->io_offset);
-
-	/*
 	 * IORESOURCE_MEM
 	 */
-	res[1].name = "PCI Memory Space";
-	res[1].flags = IORESOURCE_MEM;
-	res[1].start = ORION5X_PCI_MEM_PHYS_BASE;
-	res[1].end = res[1].start + ORION5X_PCI_MEM_SIZE - 1;
-	if (request_resource(&iomem_resource, &res[1]))
+	res->name = "PCI Memory Space";
+	res->flags = IORESOURCE_MEM;
+	res->start = ORION5X_PCI_MEM_PHYS_BASE;
+	res->end = res->start + ORION5X_PCI_MEM_SIZE - 1;
+	if (request_resource(&iomem_resource, res))
 		panic("Request PCI Memory resource failed\n");
-	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, res, sys->mem_offset);
 
 	return 1;
 }
-- 
1.7.9.5
