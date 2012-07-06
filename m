From: robherring2@gmail.com (Rob Herring)
Date: Fri,  6 Jul 2012 13:40:40 -0500
Subject: [PATCH 15/15] ARM: iop3xx: use fixed PCI i/o mapping
In-Reply-To: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
Message-ID: <1341600040-30993-16-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move iop33x and iop32x PCI to fixed i/o mapping and remove io.h. This
changes the PCI bus addresses from the cpu address to 0 based. It appears
that there is translation h/w for this, but its untested.

Not sure what to do with io_offset. I think it should always be 0.
AFAICT, PCI setup is skipped if the ATU is already setup.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                       |    2 --
 arch/arm/include/asm/hardware/iop3xx.h |   12 +-----------
 arch/arm/mach-iop32x/include/mach/io.h |   19 -------------------
 arch/arm/mach-iop33x/include/mach/io.h |   19 -------------------
 arch/arm/plat-iop/pci.c                |    4 ++--
 arch/arm/plat-iop/setup.c              |    7 ++-----
 6 files changed, 5 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/mach-iop32x/include/mach/io.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1b7faa5..58bb75e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -495,7 +495,6 @@ config ARCH_IOP32X
 	bool "IOP32x-based"
 	depends on MMU
 	select CPU_XSCALE
-	select NEED_MACH_IO_H
 	select NEED_RET_TO_USER
 	select PLAT_IOP
 	select PCI
@@ -508,7 +507,6 @@ config ARCH_IOP33X
 	bool "IOP33x-based"
 	depends on MMU
 	select CPU_XSCALE
-	select NEED_MACH_IO_H
 	select NEED_RET_TO_USER
 	select PLAT_IOP
 	select PCI
diff --git a/arch/arm/include/asm/hardware/iop3xx.h b/arch/arm/include/asm/hardware/iop3xx.h
index 2ff2c75..02fe2fb 100644
--- a/arch/arm/include/asm/hardware/iop3xx.h
+++ b/arch/arm/include/asm/hardware/iop3xx.h
@@ -217,18 +217,8 @@ extern int iop3xx_get_init_atu(void);
 #define IOP3XX_PCI_LOWER_MEM_PA	0x80000000
 #define IOP3XX_PCI_MEM_WINDOW_SIZE	0x08000000
 
-#define IOP3XX_PCI_IO_WINDOW_SIZE	0x00010000
 #define IOP3XX_PCI_LOWER_IO_PA		0x90000000
-#define IOP3XX_PCI_LOWER_IO_VA		0xfe000000
-#define IOP3XX_PCI_LOWER_IO_BA		0x90000000
-#define IOP3XX_PCI_UPPER_IO_PA		(IOP3XX_PCI_LOWER_IO_PA +\
-					IOP3XX_PCI_IO_WINDOW_SIZE - 1)
-#define IOP3XX_PCI_UPPER_IO_VA		(IOP3XX_PCI_LOWER_IO_VA +\
-					IOP3XX_PCI_IO_WINDOW_SIZE - 1)
-#define IOP3XX_PCI_IO_PHYS_TO_VIRT(addr) (((u32) (addr) -\
-					IOP3XX_PCI_LOWER_IO_PA) +\
-					IOP3XX_PCI_LOWER_IO_VA)
-
+#define IOP3XX_PCI_LOWER_IO_BA		0x00000000
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mach-iop32x/include/mach/io.h b/arch/arm/mach-iop32x/include/mach/io.h
deleted file mode 100644
index e2ada26..0000000
--- a/arch/arm/mach-iop32x/include/mach/io.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-iop32x/include/mach/io.h
- *
- * Copyright (C) 2001 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __IO_H
-#define __IO_H
-
-#include <asm/hardware/iop3xx.h>
-
-#define IO_SPACE_LIMIT		0xffffffff
-#define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
-
-#endif
diff --git a/arch/arm/mach-iop33x/include/mach/io.h b/arch/arm/mach-iop33x/include/mach/io.h
deleted file mode 100644
index f7c1b65..0000000
--- a/arch/arm/mach-iop33x/include/mach/io.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-iop33x/include/mach/io.h
- *
- * Copyright (C) 2001  MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __IO_H
-#define __IO_H
-
-#include <asm/hardware/iop3xx.h>
-
-#define IO_SPACE_LIMIT		0xffffffff
-#define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
-
-#endif
diff --git a/arch/arm/plat-iop/pci.c b/arch/arm/plat-iop/pci.c
index 8daae9b..a9472bc 100644
--- a/arch/arm/plat-iop/pci.c
+++ b/arch/arm/plat-iop/pci.c
@@ -196,8 +196,8 @@ int iop3xx_pci_setup(int nr, struct pci_sys_data *sys)
 	if (!res)
 		panic("PCI: unable to alloc resources");
 
-	res[0].start = IOP3XX_PCI_LOWER_IO_PA;
-	res[0].end   = IOP3XX_PCI_LOWER_IO_PA + IOP3XX_PCI_IO_WINDOW_SIZE - 1;
+	res[0].start = IOP3XX_PCI_LOWER_IO_BA;
+	res[0].end   = IOP3XX_PCI_LOWER_IO_BA + SZ_64K - 1;
 	res[0].name  = "IOP3XX PCI I/O Space";
 	res[0].flags = IORESOURCE_IO;
 	request_resource(&ioport_resource, &res[0]);
diff --git a/arch/arm/plat-iop/setup.c b/arch/arm/plat-iop/setup.c
index bade586..1ab725b 100644
--- a/arch/arm/plat-iop/setup.c
+++ b/arch/arm/plat-iop/setup.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include <asm/hardware/iop3xx.h>
 
 /*
@@ -25,15 +26,11 @@ static struct map_desc iop3xx_std_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(IOP3XX_PERIPHERAL_PHYS_BASE),
 		.length		= IOP3XX_PERIPHERAL_SIZE,
 		.type		= MT_UNCACHED,
-	 }, {	/* PCI IO space */
-		.virtual	= IOP3XX_PCI_LOWER_IO_VA,
-		.pfn		= __phys_to_pfn(IOP3XX_PCI_LOWER_IO_PA),
-		.length		= IOP3XX_PCI_IO_WINDOW_SIZE,
-		.type		= MT_DEVICE,
 	 },
 };
 
 void __init iop3xx_map_io(void)
 {
+	pci_map_io_single(IOP3XX_PCI_LOWER_IO_PA);
 	iotable_init(iop3xx_std_desc, ARRAY_SIZE(iop3xx_std_desc));
 }
-- 
1.7.9.5
