From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:04:10 -0500
Subject: [PATCH v2 14/15] ARM: mv78xx0: use fixed pci i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-15-git-send-email-robherring2@gmail.com>
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
 arch/arm/mach-mv78xx0/addr-map.c             |    3 +-
 arch/arm/mach-mv78xx0/common.c               |    5 --
 arch/arm/mach-mv78xx0/include/mach/io.h      |   24 ------
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h |   21 +++--
 arch/arm/mach-mv78xx0/pcie.c                 |  110 ++++++++------------------
 6 files changed, 45 insertions(+), 119 deletions(-)
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
index 62b53d7..7764d93 100644
--- a/arch/arm/mach-mv78xx0/addr-map.c
+++ b/arch/arm/mach-mv78xx0/addr-map.c
@@ -13,6 +13,7 @@
 #include <linux/mbus.h>
 #include <linux/io.h>
 #include <plat/addr-map.h>
+#include <mach/mv78xx0.h>
 #include "common.h"
 
 /*
@@ -81,7 +82,7 @@ void __init mv78xx0_setup_pcie_io_win(int window, u32 base, u32 size,
 				      int maj, int min)
 {
 	orion_setup_cpu_win(&addr_map_cfg, window, base, size,
-			    TARGET_PCIE(maj), ATTR_PCIE_IO(min), -1);
+			    TARGET_PCIE(maj), ATTR_PCIE_IO(min), 0);
 }
 
 void __init mv78xx0_setup_pcie_mem_win(int window, u32 base, u32 size,
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index b4c53b8..2082644 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -135,11 +135,6 @@ static struct map_desc mv78xx0_io_desc[] __initdata = {
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
index e807c4c..bd03fed 100644
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
@@ -46,11 +46,10 @@
 #define MV78XX0_CORE_REGS_SIZE		SZ_16K
 
 #define MV78XX0_PCIE_IO_PHYS_BASE(i)	(0xf0800000 + ((i) << 20))
-#define MV78XX0_PCIE_IO_VIRT_BASE(i)	(0xfe700000 + ((i) << 20))
 #define MV78XX0_PCIE_IO_SIZE		SZ_1M
 
 #define MV78XX0_REGS_PHYS_BASE		0xf1000000
-#define MV78XX0_REGS_VIRT_BASE		0xfef00000
+#define MV78XX0_REGS_VIRT_BASE		0xfd000000
 #define MV78XX0_REGS_SIZE		SZ_1M
 
 #define MV78XX0_PCIE_MEM_PHYS_BASE	0xc0000000
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 2e56e86..26a059b 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -15,6 +15,7 @@
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <plat/addr-map.h>
+#include <mach/mv78xx0.h>
 #include "common.h"
 
 struct pcie_port {
@@ -23,16 +24,13 @@ struct pcie_port {
 	u8			root_bus_nr;
 	void __iomem		*base;
 	spinlock_t		conf_lock;
-	char			io_space_name[16];
 	char			mem_space_name[16];
-	struct resource		res[2];
+	struct resource		res;
 };
 
 static struct pcie_port pcie_port[8];
 static int num_pcie_ports;
 static struct resource pcie_io_space;
-static struct resource pcie_mem_space;
-
 
 void __init mv78xx0_pcie_id(u32 *dev, u32 *rev)
 {
@@ -40,102 +38,59 @@ void __init mv78xx0_pcie_id(u32 *dev, u32 *rev)
 	*rev = orion_pcie_rev((void __iomem *)PCIE00_VIRT_BASE);
 }
 
+u32 pcie_port_size[8] = {
+	0,
+	0x30000000,
+	0x10000000,
+	0x10000000,
+	0x08000000,
+	0x08000000,
+	0x08000000,
+	0x04000000,
+};
+
 static void __init mv78xx0_pcie_preinit(void)
 {
 	int i;
 	u32 size_each;
 	u32 start;
-	int win;
+	int win = 0;
 
 	pcie_io_space.name = "PCIe I/O Space";
 	pcie_io_space.start = MV78XX0_PCIE_IO_PHYS_BASE(0);
 	pcie_io_space.end =
 		MV78XX0_PCIE_IO_PHYS_BASE(0) + MV78XX0_PCIE_IO_SIZE * 8 - 1;
-	pcie_io_space.flags = IORESOURCE_IO;
+	pcie_io_space.flags = IORESOURCE_MEM;
 	if (request_resource(&iomem_resource, &pcie_io_space))
 		panic("can't allocate PCIe I/O space");
 
-	pcie_mem_space.name = "PCIe MEM Space";
-	pcie_mem_space.start = MV78XX0_PCIE_MEM_PHYS_BASE;
-	pcie_mem_space.end =
-		MV78XX0_PCIE_MEM_PHYS_BASE + MV78XX0_PCIE_MEM_SIZE - 1;
-	pcie_mem_space.flags = IORESOURCE_MEM;
-	if (request_resource(&iomem_resource, &pcie_mem_space))
-		panic("can't allocate PCIe MEM space");
+	if (num_pcie_ports > 7)
+		panic("invalid number of PCIe ports");
+
+	size_each = pcie_port_size[num_pcie_ports];
 
+	start = MV78XX0_PCIE_MEM_PHYS_BASE;
 	for (i = 0; i < num_pcie_ports; i++) {
 		struct pcie_port *pp = pcie_port + i;
 
-		snprintf(pp->io_space_name, sizeof(pp->io_space_name),
-			"PCIe %d.%d I/O", pp->maj, pp->min);
-		pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
-		pp->res[0].name = pp->io_space_name;
-		pp->res[0].start = MV78XX0_PCIE_IO_PHYS_BASE(i);
-		pp->res[0].end = pp->res[0].start + MV78XX0_PCIE_IO_SIZE - 1;
-		pp->res[0].flags = IORESOURCE_IO;
-
 		snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
 			"PCIe %d.%d MEM", pp->maj, pp->min);
 		pp->mem_space_name[sizeof(pp->mem_space_name) - 1] = 0;
-		pp->res[1].name = pp->mem_space_name;
-		pp->res[1].flags = IORESOURCE_MEM;
-	}
-
-	switch (num_pcie_ports) {
-	case 0:
-		size_each = 0;
-		break;
-
-	case 1:
-		size_each = 0x30000000;
-		break;
-
-	case 2 ... 3:
-		size_each = 0x10000000;
-		break;
-
-	case 4 ... 6:
-		size_each = 0x08000000;
-		break;
-
-	case 7:
-		size_each = 0x04000000;
-		break;
-
-	default:
-		panic("invalid number of PCIe ports");
-	}
-
-	start = MV78XX0_PCIE_MEM_PHYS_BASE;
-	for (i = 0; i < num_pcie_ports; i++) {
-		struct pcie_port *pp = pcie_port + i;
-
-		pp->res[1].start = start;
-		pp->res[1].end = start + size_each - 1;
+		pp->res.name = pp->mem_space_name;
+		pp->res.flags = IORESOURCE_MEM;
+		pp->res.start = start;
+		pp->res.end = start + size_each - 1;
 		start += size_each;
-	}
-
-	for (i = 0; i < num_pcie_ports; i++) {
-		struct pcie_port *pp = pcie_port + i;
 
-		if (request_resource(&pcie_io_space, &pp->res[0]))
-			panic("can't allocate PCIe I/O sub-space");
-
-		if (request_resource(&pcie_mem_space, &pp->res[1]))
+		if (request_resource(&iomem_resource, &pp->res))
 			panic("can't allocate PCIe MEM sub-space");
-	}
 
-	win = 0;
-	for (i = 0; i < num_pcie_ports; i++) {
-		struct pcie_port *pp = pcie_port + i;
+		mv78xx0_setup_pcie_mem_win(win + i + 8, pp->res.start,
+					   resource_size(&pp->res),
+					   pp->maj, pp->min);
 
-		mv78xx0_setup_pcie_io_win(win++, pp->res[0].start,
-					  resource_size(&pp->res[0]),
+		mv78xx0_setup_pcie_io_win(win + i, i * SZ_64K, SZ_64K,
 					  pp->maj, pp->min);
-
-		mv78xx0_setup_pcie_mem_win(win++, pp->res[1].start,
-					   resource_size(&pp->res[1]),
-					   pp->maj, pp->min);
 	}
 }
 
@@ -156,8 +111,9 @@ static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
 	orion_pcie_setup(pp->base);
 
-	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
-	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
+	pci_ioremap_io(nr * SZ_64K, MV78XX0_PCIE_IO_PHYS_BASE(nr));
+
+	pci_add_resource_offset(&sys->resources, &pp->res, sys->mem_offset);
 
 	return 1;
 }
@@ -281,7 +237,7 @@ static void __init add_pcie_port(int maj, int min, unsigned long base)
 		pp->root_bus_nr = -1;
 		pp->base = (void __iomem *)base;
 		spin_lock_init(&pp->conf_lock);
-		memset(pp->res, 0, sizeof(pp->res));
+		memset(&pp->res, 0, sizeof(pp->res));
 	} else {
 		printk("link down, ignoring\n");
 	}
-- 
1.7.9.5
