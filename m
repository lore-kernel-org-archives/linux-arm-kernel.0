From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:03:59 -0500
Subject: [PATCH v2 03/15] ARM: versatile: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move versatile PCI to fixed i/o mapping and remove io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                |    1 -
 arch/arm/mach-versatile/core.c                  |    5 -----
 arch/arm/mach-versatile/include/mach/hardware.h |    1 -
 arch/arm/mach-versatile/include/mach/io.h       |   27 -----------------------
 arch/arm/mach-versatile/pci.c                   |   22 ++++--------------
 5 files changed, 4 insertions(+), 52 deletions(-)
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
index cd8ea35..ca7902c 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -169,11 +169,6 @@ static struct map_desc versatile_io_desc[] __initdata = {
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
index e95bf84..2f84f40 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -169,13 +169,6 @@ static struct pci_ops pci_versatile_ops = {
 	.write	= versatile_write_config,
 };
 
-static struct resource io_port = {
-	.name	= "PCI",
-	.start	= 0,
-	.end	= IO_SPACE_LIMIT,
-	.flags	= IORESOURCE_IO,
-};
-
 static struct resource io_mem = {
 	.name	= "PCI I/O space",
 	.start	= VERSATILE_PCI_MEM_BASE0,
@@ -207,12 +200,6 @@ static int __init pci_versatile_setup_resources(struct pci_sys_data *sys)
 		       "memory region (%d)\n", ret);
 		goto out;
 	}
-	ret = request_resource(&ioport_resource, &io_port);
-	if (ret) {
-		printk(KERN_ERR "PCI: unable to allocate I/O "
-		       "port region (%d)\n", ret);
-		goto out;
-	}
 	ret = request_resource(&iomem_resource, &non_mem);
 	if (ret) {
 		printk(KERN_ERR "PCI: unable to allocate non-prefetchable "
@@ -227,11 +214,9 @@ static int __init pci_versatile_setup_resources(struct pci_sys_data *sys)
 	}
 
 	/*
-	 * the IO resource for this bus
 	 * the mem resource for this bus
 	 * the prefetch mem resource for this bus
 	 */
-	pci_add_resource_offset(&sys->resources, &io_port, sys->io_offset);
 	pci_add_resource_offset(&sys->resources, &non_mem, sys->mem_offset);
 	pci_add_resource_offset(&sys->resources, &pre_mem, sys->mem_offset);
 
@@ -260,9 +245,11 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 		goto out;
 	}
 
+	ret = pci_ioremap_io(0, VERSATILE_PCI_MEM_BASE0);
+	if (ret)
+		goto out;
+
 	if (nr == 0) {
-		sys->mem_offset = 0;
-		sys->io_offset = 0;
 		ret = pci_versatile_setup_resources(sys);
 		if (ret < 0) {
 			printk("pci_versatile_setup: resources... oops?\n");
@@ -319,7 +306,6 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 
 void __init pci_versatile_preinit(void)
 {
-	pcibios_min_io = 0x44000000;
 	pcibios_min_mem = 0x50000000;
 
 	__raw_writel(VERSATILE_PCI_MEM_BASE0 >> 28, PCI_IMAP0);
-- 
1.7.9.5
