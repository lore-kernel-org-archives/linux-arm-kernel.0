From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:04:09 -0500
Subject: [PATCH v2 13/15] ARM: iop13xx: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-14-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move iop13xx PCI to fixed i/o mapping and remove io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                             |    1 -
 arch/arm/mach-iop13xx/include/mach/io.h      |   28 -------------------
 arch/arm/mach-iop13xx/include/mach/iop13xx.h |   21 +++------------
 arch/arm/mach-iop13xx/pci.c                  |   37 +++++++++-----------------
 arch/arm/mach-iop13xx/setup.c                |   10 -------
 5 files changed, 16 insertions(+), 81 deletions(-)
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e542f99..c61e0a4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -486,7 +486,6 @@ config ARCH_IOP13XX
 	select PCI
 	select ARCH_SUPPORTS_MSI
 	select VMSPLIT_1G
-	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	select NEED_RET_TO_USER
 	help
diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
deleted file mode 100644
index e197cb8..0000000
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * iop13xx custom ioremap implementation
- * Copyright (c) 2005-2006, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
- * Place - Suite 330, Boston, MA 02111-1307 USA.
- *
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#include <mach/iop13xx.h>
-
-#define IO_SPACE_LIMIT (IOP13XX_PCIE_IO_WINDOW_SIZE + IOP13XX_PCIX_IO_WINDOW_SIZE - 1)
-
-#define __io(a) (IOP13XX_PCIX_LOWER_IO_VA + ((a) & IO_SPACE_LIMIT))
-
-#endif
diff --git a/arch/arm/mach-iop13xx/include/mach/iop13xx.h b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
index d3777db..9278b8c 100644
--- a/arch/arm/mach-iop13xx/include/mach/iop13xx.h
+++ b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
@@ -69,19 +69,11 @@ extern unsigned long get_iop_tick_rate(void);
  * 0x8000.0000 + 928M	0x2.8000.0000   (ioremap)	PCIE outbound memory window
  *
  * IO MAP
- * 0x1000 + 64K	0x0.fffb.1000	0xfed6.1000	PCIX outbound i/o window
- * 0x1000 + 64K	0x0.fffd.1000	0xfed7.1000	PCIE outbound i/o window
+ * 0x00000 + 64K	0x0.fffb.0000	0xfee0.0000	PCIX outbound i/o window
+ * 0x10000 + 64K	0x0.fffd.0000	0xfee1.0000	PCIE outbound i/o window
  */
-#define IOP13XX_PCIX_IO_WINDOW_SIZE   0x10000UL
 #define IOP13XX_PCIX_LOWER_IO_PA      0xfffb0000UL
-#define IOP13XX_PCIX_LOWER_IO_VA      0xfed60000UL
 #define IOP13XX_PCIX_LOWER_IO_BA      0x0UL /* OIOTVR */
-#define IOP13XX_PCIX_IO_BUS_OFFSET    0x1000UL
-#define IOP13XX_PCIX_UPPER_IO_BA      (IOP13XX_PCIX_LOWER_IO_BA +\
-				       IOP13XX_PCIX_IO_WINDOW_SIZE - 1)
-#define IOP13XX_PCIX_IO_PHYS_TO_VIRT(addr) (u32) ((u32) addr -\
-					   (IOP13XX_PCIX_LOWER_IO_PA\
-					   - IOP13XX_PCIX_LOWER_IO_VA))
 
 #define IOP13XX_PCIX_MEM_PHYS_OFFSET  0x100000000ULL
 #define IOP13XX_PCIX_MEM_WINDOW_SIZE  0x3a000000UL
@@ -101,16 +93,9 @@ extern unsigned long get_iop_tick_rate(void);
 					IOP13XX_PCIX_LOWER_MEM_BA)
 
 /* PCI-E ranges */
-#define IOP13XX_PCIE_IO_WINDOW_SIZE   	 0x10000UL
 #define IOP13XX_PCIE_LOWER_IO_PA      	 0xfffd0000UL
-#define IOP13XX_PCIE_LOWER_IO_VA      	 0xfed70000UL
 #define IOP13XX_PCIE_LOWER_IO_BA      	 0x0UL  /* OIOTVR */
-#define IOP13XX_PCIE_IO_BUS_OFFSET	 0x1000UL
-#define IOP13XX_PCIE_UPPER_IO_BA      	 (IOP13XX_PCIE_LOWER_IO_BA +\
-					 IOP13XX_PCIE_IO_WINDOW_SIZE - 1)
-#define IOP13XX_PCIE_IO_PHYS_TO_VIRT(addr) (u32) ((u32) addr -\
-					   (IOP13XX_PCIE_LOWER_IO_PA\
-					   - IOP13XX_PCIE_LOWER_IO_VA))
+#define IOP13XX_PCIE_LOWER_IO_BA      	 0x10000UL
 
 #define IOP13XX_PCIE_MEM_PHYS_OFFSET  	 0x200000000ULL
 #define IOP13XX_PCIE_MEM_WINDOW_SIZE  	 0x3a000000UL
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 1bb905a..f3826bb 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -970,7 +970,6 @@ void __init iop13xx_pci_init(void)
 	__raw_writel(__raw_readl(IOP13XX_XBG_BECSR) & 3, IOP13XX_XBG_BECSR);
 
 	/* Setup the Min Address for PCI memory... */
-	pcibios_min_io = 0;
 	pcibios_min_mem = IOP13XX_PCIX_LOWER_MEM_BA;
 
 	/* if Linux is given control of an ATU
@@ -1003,7 +1002,7 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 	if (nr > 1)
 		return 0;
 
-	res = kcalloc(2, sizeof(struct resource), GFP_KERNEL);
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
 	if (!res)
 		panic("PCI: unable to alloc resources");
 
@@ -1042,17 +1041,13 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 				  << IOP13XX_ATUX_PCIXSR_FUNC_NUM;
 		__raw_writel(pcixsr, IOP13XX_ATUX_PCIXSR);
 
-		res[0].start = IOP13XX_PCIX_LOWER_IO_BA + IOP13XX_PCIX_IO_BUS_OFFSET;
-		res[0].end   = IOP13XX_PCIX_UPPER_IO_BA;
-		res[0].name  = "IQ81340 ATUX PCI I/O Space";
-		res[0].flags = IORESOURCE_IO;
+		pci_ioremap_io(0, IOP13XX_PCIX_LOWER_IO_PA);
 
-		res[1].start = IOP13XX_PCIX_LOWER_MEM_RA;
-		res[1].end   = IOP13XX_PCIX_UPPER_MEM_RA;
-		res[1].name  = "IQ81340 ATUX PCI Memory Space";
-		res[1].flags = IORESOURCE_MEM;
+		res->start = IOP13XX_PCIX_LOWER_MEM_RA;
+		res->end   = IOP13XX_PCIX_UPPER_MEM_RA;
+		res->name  = "IQ81340 ATUX PCI Memory Space";
+		res->flags = IORESOURCE_MEM;
 		sys->mem_offset = IOP13XX_PCIX_MEM_OFFSET;
-		sys->io_offset = IOP13XX_PCIX_LOWER_IO_BA;
 		break;
 	case IOP13XX_INIT_ATU_ATUE:
 		/* Note: the function number field in the PCSR is ro */
@@ -1063,17 +1058,13 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 
 		__raw_writel(pcsr, IOP13XX_ATUE_PCSR);
 
-		res[0].start = IOP13XX_PCIE_LOWER_IO_BA + IOP13XX_PCIE_IO_BUS_OFFSET;
-		res[0].end   = IOP13XX_PCIE_UPPER_IO_BA;
-		res[0].name  = "IQ81340 ATUE PCI I/O Space";
-		res[0].flags = IORESOURCE_IO;
+		pci_ioremap_io(IOP13XX_PCIE_LOWER_IO_BA, IOP13XX_PCIE_LOWER_IO_PA);
 
-		res[1].start = IOP13XX_PCIE_LOWER_MEM_RA;
-		res[1].end   = IOP13XX_PCIE_UPPER_MEM_RA;
-		res[1].name  = "IQ81340 ATUE PCI Memory Space";
-		res[1].flags = IORESOURCE_MEM;
+		res->start = IOP13XX_PCIE_LOWER_MEM_RA;
+		res->end   = IOP13XX_PCIE_UPPER_MEM_RA;
+		res->name  = "IQ81340 ATUE PCI Memory Space";
+		res->flags = IORESOURCE_MEM;
 		sys->mem_offset = IOP13XX_PCIE_MEM_OFFSET;
-		sys->io_offset = IOP13XX_PCIE_LOWER_IO_BA;
 		sys->map_irq = iop13xx_pcie_map_irq;
 		break;
 	default:
@@ -1081,11 +1072,9 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 		return 0;
 	}
 
-	request_resource(&ioport_resource, &res[0]);
-	request_resource(&iomem_resource, &res[1]);
+	request_resource(&iomem_resource, res);
 
-	pci_add_resource_offset(&sys->resources, &res[0], sys->io_offset);
-	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, res, sys->mem_offset);
 
 	return 1;
 }
diff --git a/arch/arm/mach-iop13xx/setup.c b/arch/arm/mach-iop13xx/setup.c
index daabb1f..4a7f20d 100644
--- a/arch/arm/mach-iop13xx/setup.c
+++ b/arch/arm/mach-iop13xx/setup.c
@@ -40,16 +40,6 @@ static struct map_desc iop13xx_std_desc[] __initdata = {
 		.pfn 	 = __phys_to_pfn(IOP13XX_PMMR_PHYS_MEM_BASE),
 		.length  = IOP13XX_PMMR_SIZE,
 		.type	 = MT_DEVICE,
-	}, { /* PCIE IO space */
-		.virtual = IOP13XX_PCIE_LOWER_IO_VA,
-		.pfn 	 = __phys_to_pfn(IOP13XX_PCIE_LOWER_IO_PA),
-		.length  = IOP13XX_PCIX_IO_WINDOW_SIZE,
-		.type	 = MT_DEVICE,
-	}, { /* PCIX IO space */
-		.virtual = IOP13XX_PCIX_LOWER_IO_VA,
-		.pfn 	 = __phys_to_pfn(IOP13XX_PCIX_LOWER_IO_PA),
-		.length  = IOP13XX_PCIX_IO_WINDOW_SIZE,
-		.type	 = MT_DEVICE,
 	},
 };
 
-- 
1.7.9.5
