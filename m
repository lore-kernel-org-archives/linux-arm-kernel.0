From: robherring2@gmail.com (Rob Herring)
Date: Fri,  6 Jul 2012 13:40:27 -0500
Subject: [PATCH 02/15] ARM: versatile: use fixed PCI i/o mapping
In-Reply-To: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
Message-ID: <1341600040-30993-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move versatile PCI to fixed i/o mapping and remove io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                |    1 -
 arch/arm/mach-versatile/core.c                  |    7 ++----
 arch/arm/mach-versatile/include/mach/hardware.h |    1 -
 arch/arm/mach-versatile/include/mach/io.h       |   27 -----------------------
 arch/arm/mach-versatile/pci.c                   |    1 -
 5 files changed, 2 insertions(+), 35 deletions(-)
 delete mode 100644 arch/arm/mach-versatile/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..8fb7e4a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -293,7 +293,6 @@ config ARCH_VERSATILE
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select NEED_MACH_IO_H if PCI
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
 	select PLAT_VERSATILE_FPGA_IRQ
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index cd8ea35..49c0801 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -47,6 +47,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <asm/hardware/timer-sp.h>
@@ -169,17 +170,13 @@ static struct map_desc versatile_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(VERSATILE_PCI_CFG_BASE),
 		.length		= VERSATILE_PCI_CFG_BASE_SIZE,
 		.type		= MT_DEVICE
-	}, {
-		.virtual	=  (unsigned long)VERSATILE_PCI_VIRT_MEM_BASE0,
-		.pfn		= __phys_to_pfn(VERSATILE_PCI_MEM_BASE0),
-		.length		= IO_SPACE_LIMIT,
-		.type		= MT_DEVICE
 	},
 #endif
 };
 
 void __init versatile_map_io(void)
 {
+	pci_map_io_single(VERSATILE_PCI_MEM_BASE0);
 	iotable_init(versatile_io_desc, ARRAY_SIZE(versatile_io_desc));
 }
 
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
index 408e58d..3e5d425 100644
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ b/arch/arm/mach-versatile/include/mach/hardware.h
@@ -29,7 +29,6 @@
  */
 #define VERSATILE_PCI_VIRT_BASE		(void __iomem *)0xe8000000ul
 #define VERSATILE_PCI_CFG_VIRT_BASE	(void __iomem *)0xe9000000ul
-#define VERSATILE_PCI_VIRT_MEM_BASE0	(void __iomem *)PCIO_BASE
 
 /* macro to get at MMIO space when running virtually */
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
diff --git a/arch/arm/mach-versatile/include/mach/io.h b/arch/arm/mach-versatile/include/mach/io.h
deleted file mode 100644
index 0406513..0000000
--- a/arch/arm/mach-versatile/include/mach/io.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- *  arch/arm/mach-versatile/include/mach/io.h
- *
- *  Copyright (C) 2003 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define PCIO_BASE	0xeb000000ul
-
-#define __io(a)		((a) + PCIO_BASE)
-
-#endif
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index bec933b..9710d2c 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -319,7 +319,6 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 
 void __init pci_versatile_preinit(void)
 {
-	pcibios_min_io = 0x44000000;
 	pcibios_min_mem = 0x50000000;
 
 	__raw_writel(VERSATILE_PCI_MEM_BASE0 >> 28, PCI_IMAP0);
-- 
1.7.9.5
