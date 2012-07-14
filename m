From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:04:05 -0500
Subject: [PATCH v2 09/15] ARM: dove: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The i/o regions are changed from 1MB to 64KB. It's likely that the 2nd
bus is not setup correctly.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                       |    1 -
 arch/arm/mach-dove/common.c            |   10 ----------
 arch/arm/mach-dove/include/mach/dove.h |    8 +++-----
 arch/arm/mach-dove/include/mach/io.h   |   19 -------------------
 arch/arm/mach-dove/pcie.c              |   23 ++++-------------------
 5 files changed, 7 insertions(+), 54 deletions(-)
 delete mode 100644 arch/arm/mach-dove/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7215ebf..ed930ad 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -537,7 +537,6 @@ config ARCH_DOVE
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
-	select NEED_MACH_IO_H
 	select PLAT_ORION
 	help
 	  Support for the Marvell Dove SoC 88AP510
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 9493076..95e78a8 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -49,16 +49,6 @@ static struct map_desc dove_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(DOVE_NB_REGS_PHYS_BASE),
 		.length		= DOVE_NB_REGS_SIZE,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= DOVE_PCIE0_IO_VIRT_BASE,
-		.pfn		= __phys_to_pfn(DOVE_PCIE0_IO_PHYS_BASE),
-		.length		= DOVE_PCIE0_IO_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= DOVE_PCIE1_IO_VIRT_BASE,
-		.pfn		= __phys_to_pfn(DOVE_PCIE1_IO_PHYS_BASE),
-		.length		= DOVE_PCIE1_IO_SIZE,
-		.type		= MT_DEVICE,
 	},
 };
 
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index d52b0ef..c91e300 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -50,14 +50,12 @@
 #define DOVE_NB_REGS_SIZE		SZ_8M
 
 #define DOVE_PCIE0_IO_PHYS_BASE		0xf2000000
-#define DOVE_PCIE0_IO_VIRT_BASE		0xfee00000
 #define DOVE_PCIE0_IO_BUS_BASE		0x00000000
-#define DOVE_PCIE0_IO_SIZE		SZ_1M
+#define DOVE_PCIE0_IO_SIZE		SZ_64K
 
 #define DOVE_PCIE1_IO_PHYS_BASE		0xf2100000
-#define DOVE_PCIE1_IO_VIRT_BASE		0xfef00000
-#define DOVE_PCIE1_IO_BUS_BASE		0x00100000
-#define DOVE_PCIE1_IO_SIZE		SZ_1M
+#define DOVE_PCIE1_IO_BUS_BASE		0x00010000
+#define DOVE_PCIE1_IO_SIZE		SZ_64K
 
 /*
  * Dove Core Registers Map
diff --git a/arch/arm/mach-dove/include/mach/io.h b/arch/arm/mach-dove/include/mach/io.h
deleted file mode 100644
index 29c8b85..0000000
--- a/arch/arm/mach-dove/include/mach/io.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-dove/include/mach/io.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#include "dove.h"
-
-#define IO_SPACE_LIMIT		0xffffffff
-
-#define __io(a)  	((void __iomem *)(((a) - DOVE_PCIE0_IO_BUS_BASE) + \
-						 DOVE_PCIE0_IO_VIRT_BASE))
-
-#endif
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 47921b0..11ed6ef 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -26,7 +26,6 @@ struct pcie_port {
 	u8			root_bus_nr;
 	void __iomem		*base;
 	spinlock_t		conf_lock;
-	char			io_space_name[16];
 	char			mem_space_name[16];
 	struct resource		res[2];
 };
@@ -53,24 +52,10 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
 
 	orion_pcie_setup(pp->base);
 
-	/*
-	 * IORESOURCE_IO
-	 */
-	snprintf(pp->io_space_name, sizeof(pp->io_space_name),
-		 "PCIe %d I/O", pp->index);
-	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
-	pp->res[0].name = pp->io_space_name;
-	if (pp->index == 0) {
-		pp->res[0].start = DOVE_PCIE0_IO_PHYS_BASE;
-		pp->res[0].end = pp->res[0].start + DOVE_PCIE0_IO_SIZE - 1;
-	} else {
-		pp->res[0].start = DOVE_PCIE1_IO_PHYS_BASE;
-		pp->res[0].end = pp->res[0].start + DOVE_PCIE1_IO_SIZE - 1;
-	}
-	pp->res[0].flags = IORESOURCE_IO;
-	if (request_resource(&ioport_resource, &pp->res[0]))
-		panic("Request PCIe IO resource failed\n");
-	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
+	if (pp->index == 0)
+		pci_ioremap_io(sys->busnr * SZ_64K, DOVE_PCIE0_IO_PHYS_BASE);
+	else
+		pci_ioremap_io(sys->busnr * SZ_64K, DOVE_PCIE1_IO_PHYS_BASE);
 
 	/*
 	 * IORESOURCE_MEM
-- 
1.7.9.5
