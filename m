From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:40 -0600
Subject: [PATCH v3 28/30] ARM: ixp23xx: use fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-29-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
---
 arch/arm/Kconfig                             |    1 -
 arch/arm/mach-ixp23xx/core.c                 |    7 ++-----
 arch/arm/mach-ixp23xx/include/mach/io.h      |   22 ----------------------
 arch/arm/mach-ixp23xx/include/mach/ixp23xx.h |   20 +++++++++-----------
 arch/arm/mach-ixp23xx/pci.c                  |    2 +-
 5 files changed, 12 insertions(+), 40 deletions(-)
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 50e68b6..73a86c7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -517,7 +517,6 @@ config ARCH_IXP23XX
 	select CPU_XSC3
  	select PCI
 	select ARCH_USES_GETTIMEOFFSET
-	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for Intel's IXP23xx (XScale) family of processors.
diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
index 7c1495e..38cbb99 100644
--- a/arch/arm/mach-ixp23xx/core.c
+++ b/arch/arm/mach-ixp23xx/core.c
@@ -39,6 +39,7 @@
 #include <asm/pgtable.h>
 
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/arch.h>
@@ -73,11 +74,6 @@ static struct map_desc ixp23xx_io_desc[] __initdata = {
 	 	.pfn		= __phys_to_pfn(IXP23XX_MSF_CSR_PHYS),
 	 	.length		= IXP23XX_MSF_CSR_SIZE,
 		.type		= MT_DEVICE,
-	}, { /* PCI I/O Space */
-	 	.virtual	= IXP23XX_PCI_IO_VIRT,
-	 	.pfn		= __phys_to_pfn(IXP23XX_PCI_IO_PHYS),
-	 	.length		= IXP23XX_PCI_IO_SIZE,
-		.type		= MT_DEVICE,
 	}, { /* PCI Config Space */
 	 	.virtual	= IXP23XX_PCI_CFG_VIRT,
 	 	.pfn		= __phys_to_pfn(IXP23XX_PCI_CFG_PHYS),
@@ -98,6 +94,7 @@ static struct map_desc ixp23xx_io_desc[] __initdata = {
 
 void __init ixp23xx_map_io(void)
 {
+	pci_map_io_single(__phys_to_pfn(IXP23XX_PCI_IO_PHYS));
 	iotable_init(ixp23xx_io_desc, ARRAY_SIZE(ixp23xx_io_desc));
 }
 
diff --git a/arch/arm/mach-ixp23xx/include/mach/io.h b/arch/arm/mach-ixp23xx/include/mach/io.h
deleted file mode 100644
index a7aceb5..0000000
--- a/arch/arm/mach-ixp23xx/include/mach/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-ixp23xx/include/mach/io.h
- *
- * Original Author: Naeem M Afzal <naeem.m.afzal@intel.com>
- * Maintainer: Deepak Saxena <dsaxena@plexity.net>
- *
- * Copyright (C) 2003-2005 Intel Corp.
- * Copyright (C) 2005 MontaVista Software, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(p)		((void __iomem*)((p) + IXP23XX_PCI_IO_VIRT))
-
-#endif
diff --git a/arch/arm/mach-ixp23xx/include/mach/ixp23xx.h b/arch/arm/mach-ixp23xx/include/mach/ixp23xx.h
index 6d02481..93309d7 100644
--- a/arch/arm/mach-ixp23xx/include/mach/ixp23xx.h
+++ b/arch/arm/mach-ixp23xx/include/mach/ixp23xx.h
@@ -20,13 +20,12 @@
  * IXP2300 linux memory map:
  *
  * virt		phys		size
- * fffd0000	a0000000	64K		XSI2CPP_CSR
- * fffc0000	c4000000	4K		EXP_CFG
- * fff00000	c8000000	64K		PERIPHERAL
- * fe000000	1c0000000	16M		CAP_CSR
+ * fef00000	1d8000000	1M		PCI_IO
  * fd000000	1c8000000	16M		MSF_CSR
- * fb000000			16M		---
- * fa000000	1d8000000	32M		PCI_IO
+ * fbfd0000	a0000000	64K		XSI2CPP_CSR
+ * fbfc0000	c4000000	4K		EXP_CFG
+ * fbf00000	c8000000	64K		PERIPHERAL
+ * fa000000	1c0000000	16M		CAP_CSR
  * f8000000	1da000000	32M		PCI_CFG
  * f6000000	1de000000	32M		PCI_CREG
  * f4000000			32M		---
@@ -39,19 +38,19 @@
  * Static mappings.
  ****************************************************************************/
 #define IXP23XX_XSI2CPP_CSR_PHYS	0xa0000000
-#define IXP23XX_XSI2CPP_CSR_VIRT	0xfffd0000
+#define IXP23XX_XSI2CPP_CSR_VIRT	0xfbfd0000
 #define IXP23XX_XSI2CPP_CSR_SIZE	0x00010000
 
 #define IXP23XX_EXP_CFG_PHYS		0xc4000000
-#define IXP23XX_EXP_CFG_VIRT		0xfffc0000
+#define IXP23XX_EXP_CFG_VIRT		0xfbfc0000
 #define IXP23XX_EXP_CFG_SIZE		0x00001000
 
 #define IXP23XX_PERIPHERAL_PHYS		0xc8000000
-#define IXP23XX_PERIPHERAL_VIRT		0xfff00000
+#define IXP23XX_PERIPHERAL_VIRT		0xfbf00000
 #define IXP23XX_PERIPHERAL_SIZE		0x00010000
 
 #define IXP23XX_CAP_CSR_PHYS		0x1c0000000ULL
-#define IXP23XX_CAP_CSR_VIRT		0xfe000000
+#define IXP23XX_CAP_CSR_VIRT		0xfa000000
 #define IXP23XX_CAP_CSR_SIZE		0x01000000
 
 #define IXP23XX_MSF_CSR_PHYS		0x1c8000000ULL
@@ -59,7 +58,6 @@
 #define IXP23XX_MSF_CSR_SIZE		0x01000000
 
 #define IXP23XX_PCI_IO_PHYS		0x1d8000000ULL
-#define IXP23XX_PCI_IO_VIRT		0xfa000000
 #define IXP23XX_PCI_IO_SIZE		0x02000000
 
 #define IXP23XX_PCI_CFG_PHYS		0x1da000000ULL
diff --git a/arch/arm/mach-ixp23xx/pci.c b/arch/arm/mach-ixp23xx/pci.c
index 25b5c46..f6f9b89 100644
--- a/arch/arm/mach-ixp23xx/pci.c
+++ b/arch/arm/mach-ixp23xx/pci.c
@@ -271,7 +271,7 @@ static struct resource ixp23xx_pci_mem_space = {
 
 static struct resource ixp23xx_pci_io_space = {
 	.start	= 0x00000100,
-	.end	= 0x01ffffff,
+	.end	= SZ_1M - 1,
 	.flags	= IORESOURCE_IO,
 	.name	= "PCI I/O Space"
 };
-- 
1.7.5.4
