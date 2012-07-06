From: robherring2@gmail.com (Rob Herring)
Date: Fri,  6 Jul 2012 13:40:34 -0500
Subject: [PATCH 09/15] ARM: orion5x: use fixed PCI i/o mapping
In-Reply-To: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
Message-ID: <1341600040-30993-10-git-send-email-robherring2@gmail.com>
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
 arch/arm/mach-orion5x/common.c               |   16 ++++++----------
 arch/arm/mach-orion5x/include/mach/io.h      |   22 ----------------------
 arch/arm/mach-orion5x/include/mach/orion5x.h |   14 ++++++--------
 4 files changed, 12 insertions(+), 41 deletions(-)
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
index 9148b22..82a2502 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -26,6 +26,7 @@
 #include <asm/timex.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include <asm/mach/time.h>
 #include <mach/bridge-regs.h>
 #include <mach/hardware.h>
@@ -47,16 +48,6 @@ static struct map_desc orion5x_io_desc[] __initdata = {
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
@@ -66,6 +57,11 @@ static struct map_desc orion5x_io_desc[] __initdata = {
 
 void __init orion5x_map_io(void)
 {
+	unsigned long pci_io_pfn[] = {
+		__phys_to_pfn(ORION5X_PCIE_IO_PHYS_BASE),
+		__phys_to_pfn(ORION5X_PCI_IO_PHYS_BASE),
+	};
+	pci_map_io_pfn(pci_io_pfn, ARRAY_SIZE(pci_io_pfn), SZ_1M);
 	iotable_init(orion5x_io_desc, ARRAY_SIZE(orion5x_io_desc));
 }
 
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
index 683e085..e997a42 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -31,22 +31,20 @@
  * fc000000	device bus mappings (cs0/cs1)
  *
  * virt		phys		size
- * fdd00000	f1000000	1M	on-chip peripheral registers
- * fde00000	f2000000	1M	PCIe I/O space
- * fdf00000	f2100000	1M	PCI I/O space
- * fe000000	f0000000	16M	PCIe WA space (Orion-1/Orion-NAS only)
+ * fe000000	f1000000	1M	on-chip peripheral registers
+ * fee00000	f2000000	1M	PCIe I/O space
+ * fef00000	f2100000	1M	PCI I/O space
+ * fd000000	f0000000	16M	PCIe WA space (Orion-1/Orion-NAS only)
  ****************************************************************************/
 #define ORION5X_REGS_PHYS_BASE		0xf1000000
-#define ORION5X_REGS_VIRT_BASE		0xfdd00000
+#define ORION5X_REGS_VIRT_BASE		0xfe000000
 #define ORION5X_REGS_SIZE		SZ_1M
 
 #define ORION5X_PCIE_IO_PHYS_BASE	0xf2000000
-#define ORION5X_PCIE_IO_VIRT_BASE	0xfde00000
 #define ORION5X_PCIE_IO_BUS_BASE	0x00000000
 #define ORION5X_PCIE_IO_SIZE		SZ_1M
 
 #define ORION5X_PCI_IO_PHYS_BASE	0xf2100000
-#define ORION5X_PCI_IO_VIRT_BASE	0xfdf00000
 #define ORION5X_PCI_IO_BUS_BASE		0x00100000
 #define ORION5X_PCI_IO_SIZE		SZ_1M
 
@@ -55,7 +53,7 @@
 
 /* Relevant only for Orion-1/Orion-NAS */
 #define ORION5X_PCIE_WA_PHYS_BASE	0xf0000000
-#define ORION5X_PCIE_WA_VIRT_BASE	0xfe000000
+#define ORION5X_PCIE_WA_VIRT_BASE	0xfd000000
 #define ORION5X_PCIE_WA_SIZE		SZ_16M
 
 #define ORION5X_PCIE_MEM_PHYS_BASE	0xe0000000
-- 
1.7.9.5
