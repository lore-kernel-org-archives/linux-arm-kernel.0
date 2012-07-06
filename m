From: robherring2@gmail.com (Rob Herring)
Date: Fri,  6 Jul 2012 13:40:33 -0500
Subject: [PATCH 08/15] ARM: kirkwood: use fixed PCI i/o mapping
In-Reply-To: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
Message-ID: <1341600040-30993-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move kirkwood PCI to fixed i/o mapping and remove io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                               |    1 -
 arch/arm/mach-kirkwood/common.c                |   17 +++++++----------
 arch/arm/mach-kirkwood/include/mach/io.h       |   24 ------------------------
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    2 --
 4 files changed, 7 insertions(+), 37 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ed930ad..8a74244 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -547,7 +547,6 @@ config ARCH_KIRKWOOD
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
-	select NEED_MACH_IO_H
 	select PLAT_ORION
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f261cd2..45d9793 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -22,6 +22,7 @@
 #include <asm/timex.h>
 #include <asm/kexec.h>
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include <asm/mach/time.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
@@ -41,16 +42,6 @@
  ****************************************************************************/
 static struct map_desc kirkwood_io_desc[] __initdata = {
 	{
-		.virtual	= KIRKWOOD_PCIE_IO_VIRT_BASE,
-		.pfn		= __phys_to_pfn(KIRKWOOD_PCIE_IO_PHYS_BASE),
-		.length		= KIRKWOOD_PCIE_IO_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= KIRKWOOD_PCIE1_IO_VIRT_BASE,
-		.pfn		= __phys_to_pfn(KIRKWOOD_PCIE1_IO_PHYS_BASE),
-		.length		= KIRKWOOD_PCIE1_IO_SIZE,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= KIRKWOOD_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(KIRKWOOD_REGS_PHYS_BASE),
 		.length		= KIRKWOOD_REGS_SIZE,
@@ -60,6 +51,12 @@ static struct map_desc kirkwood_io_desc[] __initdata = {
 
 void __init kirkwood_map_io(void)
 {
+	unsigned long pci_io_pfn[] = {
+		__phys_to_pfn(KIRKWOOD_PCIE_IO_PHYS_BASE),
+		__phys_to_pfn(KIRKWOOD_PCIE1_IO_PHYS_BASE),
+	};
+	pci_map_io_pfn(pci_io_pfn, ARRAY_SIZE(pci_io_pfn), SZ_1M);
+
 	iotable_init(kirkwood_io_desc, ARRAY_SIZE(kirkwood_io_desc));
 }
 
diff --git a/arch/arm/mach-kirkwood/include/mach/io.h b/arch/arm/mach-kirkwood/include/mach/io.h
deleted file mode 100644
index 5d0ab61..0000000
--- a/arch/arm/mach-kirkwood/include/mach/io.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/include/mach/io.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#include "kirkwood.h"
-
-#define IO_SPACE_LIMIT		0xffffffff
-
-static inline void __iomem *__io(unsigned long addr)
-{
-	return (void __iomem *)((addr - KIRKWOOD_PCIE_IO_BUS_BASE)
-					+ KIRKWOOD_PCIE_IO_VIRT_BASE);
-}
-
-#define __io(a)			__io(a)
-
-#endif
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index c5b6851..43e4f9b 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -37,12 +37,10 @@
 #define KIRKWOOD_NAND_MEM_SIZE		SZ_1K
 
 #define KIRKWOOD_PCIE1_IO_PHYS_BASE	0xf3000000
-#define KIRKWOOD_PCIE1_IO_VIRT_BASE	0xfef00000
 #define KIRKWOOD_PCIE1_IO_BUS_BASE	0x00100000
 #define KIRKWOOD_PCIE1_IO_SIZE		SZ_1M
 
 #define KIRKWOOD_PCIE_IO_PHYS_BASE	0xf2000000
-#define KIRKWOOD_PCIE_IO_VIRT_BASE	0xfee00000
 #define KIRKWOOD_PCIE_IO_BUS_BASE	0x00000000
 #define KIRKWOOD_PCIE_IO_SIZE		SZ_1M
 
-- 
1.7.9.5
