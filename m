From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:04:01 -0500
Subject: [PATCH v2 05/15] ARM: integrator: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move integrator PCI to fixed i/o mapping and remove io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                 |    1 -
 arch/arm/mach-integrator/include/mach/io.h       |   33 ----------------------
 arch/arm/mach-integrator/include/mach/platform.h |    4 +++
 arch/arm/mach-integrator/integrator_ap.c         |    7 +----
 arch/arm/mach-integrator/pci_v3.c                |    3 --
 5 files changed, 5 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ac446e3..5d37628 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -261,7 +261,6 @@ config ARCH_INTEGRATOR
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_FPGA_IRQ
-	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	select MULTI_IRQ_HANDLER
diff --git a/arch/arm/mach-integrator/include/mach/io.h b/arch/arm/mach-integrator/include/mach/io.h
deleted file mode 100644
index 8de70de..0000000
--- a/arch/arm/mach-integrator/include/mach/io.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  arch/arm/mach-integrator/include/mach/io.h
- *
- *  Copyright (C) 1999 ARM Limited
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
-/*
- * WARNING: this has to mirror definitions in platform.h
- */
-#define PCI_MEMORY_VADDR        0xe8000000
-#define PCI_CONFIG_VADDR        0xec000000
-#define PCI_V3_VADDR            0xed000000
-#define PCI_IO_VADDR            0xee000000
-
-#define __io(a)			((void __iomem *)(PCI_IO_VADDR + (a)))
-
-#endif
diff --git a/arch/arm/mach-integrator/include/mach/platform.h b/arch/arm/mach-integrator/include/mach/platform.h
index ec467ba..4c03475 100644
--- a/arch/arm/mach-integrator/include/mach/platform.h
+++ b/arch/arm/mach-integrator/include/mach/platform.h
@@ -324,6 +324,10 @@
  */
 #define PHYS_PCI_V3_BASE                0x62000000
 
+#define PCI_MEMORY_VADDR		0xe8000000
+#define PCI_CONFIG_VADDR		0xec000000
+#define PCI_V3_VADDR			0xed000000
+
 /* ------------------------------------------------------------------------
  *  Integrator Interrupt Controllers
  * ------------------------------------------------------------------------
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index c857501..83bee54 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -72,7 +72,7 @@
  * e8000000	40000000	PCI memory		PHYS_PCI_MEM_BASE	(max 512M)
  * ec000000	61000000	PCI config space	PHYS_PCI_CONFIG_BASE	(max 16M)
  * ed000000	62000000	PCI V3 regs		PHYS_PCI_V3_BASE	(max 64k)
- * ee000000	60000000	PCI IO			PHYS_PCI_IO_BASE	(max 16M)
+ * fee00000	60000000	PCI IO			PHYS_PCI_IO_BASE	(max 16M)
  * ef000000			Cache flush
  * f1000000	10000000	Core module registers
  * f1100000	11000000	System controller registers
@@ -146,11 +146,6 @@ static struct map_desc ap_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(PHYS_PCI_V3_BASE),
 		.length		= SZ_64K,
 		.type		= MT_DEVICE
-	}, {
-		.virtual	= PCI_IO_VADDR,
-		.pfn		= __phys_to_pfn(PHYS_PCI_IO_BASE),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE
 	}
 };
 
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index b866880..810f4ec 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -374,12 +374,9 @@ static int __init pci_v3_setup_resources(struct pci_sys_data *sys)
 	}
 
 	/*
-	 * the IO resource for this bus
 	 * the mem resource for this bus
 	 * the prefetch mem resource for this bus
 	 */
-	pci_add_resource_offset(&sys->resources,
-				&ioport_resource, sys->io_offset);
 	pci_add_resource_offset(&sys->resources, &non_mem, sys->mem_offset);
 	pci_add_resource_offset(&sys->resources, &pre_mem, sys->mem_offset);
 
-- 
1.7.9.5
