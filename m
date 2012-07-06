From: robherring2@gmail.com (Rob Herring)
Date: Fri,  6 Jul 2012 13:40:37 -0500
Subject: [PATCH 12/15] ARM: mv78xx0: use fixed pci i/o mapping
In-Reply-To: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
Message-ID: <1341600040-30993-13-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move mv78xx0 PCI to fixed i/o mapping and remove io.h. This changes the PCI
bus addresses from the cpu address to 0 based. It appears that there is
translation h/w for this, but its untested.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                             |    1 -
 arch/arm/mach-mv78xx0/addr-map.c             |    1 +
 arch/arm/mach-mv78xx0/common.c               |   18 ++++++++++++-----
 arch/arm/mach-mv78xx0/include/mach/io.h      |   24 ----------------------
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h |   22 +++++++++-----------
 arch/arm/mach-mv78xx0/pcie.c                 |   28 +++++---------------------
 6 files changed, 29 insertions(+), 65 deletions(-)
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c61e0a4..1b7faa5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -571,7 +571,6 @@ config ARCH_MV78XX0
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
-	select NEED_MACH_IO_H
 	select PLAT_ORION
 	help
 	  Support for the following Marvell MV78xx0 series SoCs:
diff --git a/arch/arm/mach-mv78xx0/addr-map.c b/arch/arm/mach-mv78xx0/addr-map.c
index 62b53d7..da9806a 100644
--- a/arch/arm/mach-mv78xx0/addr-map.c
+++ b/arch/arm/mach-mv78xx0/addr-map.c
@@ -13,6 +13,7 @@
 #include <linux/mbus.h>
 #include <linux/io.h>
 #include <plat/addr-map.h>
+#include <mach/mv78xx0.h>
 #include "common.h"
 
 /*
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index b4c53b8..e018d8c 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -17,6 +17,7 @@
 #include <linux/ethtool.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <asm/mach/pci.h>
 #include <mach/mv78xx0.h>
 #include <mach/bridge-regs.h>
 #include <plat/cache-feroceon-l2.h>
@@ -135,11 +136,6 @@ static struct map_desc mv78xx0_io_desc[] __initdata = {
 		.length		= MV78XX0_CORE_REGS_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= MV78XX0_PCIE_IO_VIRT_BASE(0),
-		.pfn		= __phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(0)),
-		.length		= MV78XX0_PCIE_IO_SIZE * 8,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= MV78XX0_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(MV78XX0_REGS_PHYS_BASE),
 		.length		= MV78XX0_REGS_SIZE,
@@ -150,6 +146,18 @@ static struct map_desc mv78xx0_io_desc[] __initdata = {
 void __init mv78xx0_map_io(void)
 {
 	unsigned long phys;
+	unsigned long pci_io_pfn[] = {
+		__phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(0)),
+		__phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(1)),
+		__phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(2)),
+		__phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(3)),
+		__phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(4)),
+		__phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(5)),
+		__phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(6)),
+		__phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(7)),
+	};
+
+	pci_map_io_pfn(pci_io_pfn, ARRAY_SIZE(pci_io_pfn), SZ_64K);
 
 	/*
 	 * Map the right set of per-core registers depending on
diff --git a/arch/arm/mach-mv78xx0/include/mach/io.h b/arch/arm/mach-mv78xx0/include/mach/io.h
deleted file mode 100644
index c7d9d00..0000000
--- a/arch/arm/mach-mv78xx0/include/mach/io.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/include/mach/io.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#include "mv78xx0.h"
-
-#define IO_SPACE_LIMIT		0xffffffff
-
-static inline void __iomem *__io(unsigned long addr)
-{
-	return (void __iomem *)((addr - MV78XX0_PCIE_IO_PHYS_BASE(0))
-					+ MV78XX0_PCIE_IO_VIRT_BASE(0));
-}
-
-#define __io(a)			__io(a)
-
-#endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
index e807c4c..10fc138 100644
--- a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
@@ -29,15 +29,15 @@
  *
  * virt		phys		size
  * fe400000	f102x000	16K	core-specific peripheral registers
- * fe700000	f0800000	1M	PCIe #0 I/O space
- * fe800000	f0900000	1M	PCIe #1 I/O space
- * fe900000	f0a00000	1M	PCIe #2 I/O space
- * fea00000	f0b00000	1M	PCIe #3 I/O space
- * feb00000	f0c00000	1M	PCIe #4 I/O space
- * fec00000	f0d00000	1M	PCIe #5 I/O space
- * fed00000	f0e00000	1M	PCIe #6 I/O space
- * fee00000	f0f00000	1M	PCIe #7 I/O space
- * fef00000	f1000000	1M	on-chip peripheral registers
+ * fee00000	f0800000	64K	PCIe #0 I/O space
+ * fee10000	f0900000	64K	PCIe #1 I/O space
+ * fee20000	f0a00000	64K	PCIe #2 I/O space
+ * fee30000	f0b00000	64K	PCIe #3 I/O space
+ * fee40000	f0c00000	64K	PCIe #4 I/O space
+ * fee50000	f0d00000	64K	PCIe #5 I/O space
+ * fee60000	f0e00000	64K	PCIe #6 I/O space
+ * fee70000	f0f00000	64K	PCIe #7 I/O space
+ * fd000000	f1000000	1M	on-chip peripheral registers
  */
 #define MV78XX0_CORE0_REGS_PHYS_BASE	0xf1020000
 #define MV78XX0_CORE1_REGS_PHYS_BASE	0xf1024000
@@ -46,11 +46,9 @@
 #define MV78XX0_CORE_REGS_SIZE		SZ_16K
 
 #define MV78XX0_PCIE_IO_PHYS_BASE(i)	(0xf0800000 + ((i) << 20))
-#define MV78XX0_PCIE_IO_VIRT_BASE(i)	(0xfe700000 + ((i) << 20))
-#define MV78XX0_PCIE_IO_SIZE		SZ_1M
 
 #define MV78XX0_REGS_PHYS_BASE		0xf1000000
-#define MV78XX0_REGS_VIRT_BASE		0xfef00000
+#define MV78XX0_REGS_VIRT_BASE		0xfd000000
 #define MV78XX0_REGS_SIZE		SZ_1M
 
 #define MV78XX0_PCIE_MEM_PHYS_BASE	0xc0000000
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 2e56e86..a51a1e4 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -15,6 +15,7 @@
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <plat/addr-map.h>
+#include <mach/mv78xx0.h>
 #include "common.h"
 
 struct pcie_port {
@@ -30,9 +31,6 @@ struct pcie_port {
 
 static struct pcie_port pcie_port[8];
 static int num_pcie_ports;
-static struct resource pcie_io_space;
-static struct resource pcie_mem_space;
-
 
 void __init mv78xx0_pcie_id(u32 *dev, u32 *rev)
 {
@@ -47,22 +45,6 @@ static void __init mv78xx0_pcie_preinit(void)
 	u32 start;
 	int win;
 
-	pcie_io_space.name = "PCIe I/O Space";
-	pcie_io_space.start = MV78XX0_PCIE_IO_PHYS_BASE(0);
-	pcie_io_space.end =
-		MV78XX0_PCIE_IO_PHYS_BASE(0) + MV78XX0_PCIE_IO_SIZE * 8 - 1;
-	pcie_io_space.flags = IORESOURCE_IO;
-	if (request_resource(&iomem_resource, &pcie_io_space))
-		panic("can't allocate PCIe I/O space");
-
-	pcie_mem_space.name = "PCIe MEM Space";
-	pcie_mem_space.start = MV78XX0_PCIE_MEM_PHYS_BASE;
-	pcie_mem_space.end =
-		MV78XX0_PCIE_MEM_PHYS_BASE + MV78XX0_PCIE_MEM_SIZE - 1;
-	pcie_mem_space.flags = IORESOURCE_MEM;
-	if (request_resource(&iomem_resource, &pcie_mem_space))
-		panic("can't allocate PCIe MEM space");
-
 	for (i = 0; i < num_pcie_ports; i++) {
 		struct pcie_port *pp = pcie_port + i;
 
@@ -70,8 +52,8 @@ static void __init mv78xx0_pcie_preinit(void)
 			"PCIe %d.%d I/O", pp->maj, pp->min);
 		pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
 		pp->res[0].name = pp->io_space_name;
-		pp->res[0].start = MV78XX0_PCIE_IO_PHYS_BASE(i);
-		pp->res[0].end = pp->res[0].start + MV78XX0_PCIE_IO_SIZE - 1;
+		pp->res[0].start = i * SZ_64K;
+		pp->res[0].end = pp->res[0].start + SZ_64K - 1;
 		pp->res[0].flags = IORESOURCE_IO;
 
 		snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
@@ -118,10 +100,10 @@ static void __init mv78xx0_pcie_preinit(void)
 	for (i = 0; i < num_pcie_ports; i++) {
 		struct pcie_port *pp = pcie_port + i;
 
-		if (request_resource(&pcie_io_space, &pp->res[0]))
+		if (request_resource(&ioport_resource, &pp->res[0]))
 			panic("can't allocate PCIe I/O sub-space");
 
-		if (request_resource(&pcie_mem_space, &pp->res[1]))
+		if (request_resource(&iomem_resource, &pp->res[1]))
 			panic("can't allocate PCIe MEM sub-space");
 	}
 
-- 
1.7.9.5
