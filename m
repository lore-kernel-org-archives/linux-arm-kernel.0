From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:04:04 -0500
Subject: [PATCH v2 08/15] ARM: footbridge: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move footbridge PCI to fixed i/o mapping. io.h is still needed for the
!MMU case.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/mach-footbridge/common.c                  |    8 ++------
 arch/arm/mach-footbridge/dc21285.c                 |   16 ++++------------
 .../arm/mach-footbridge/include/mach/debug-macro.S |    3 ++-
 arch/arm/mach-footbridge/include/mach/io.h         |   12 ++----------
 5 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3dfc555..7215ebf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -431,7 +431,7 @@ config ARCH_FOOTBRIDGE
 	select FOOTBRIDGE
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
-	select NEED_MACH_IO_H
+	select NEED_MACH_IO_H if !MMU
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for systems based on the DC21285 companion chip
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 3e6aaa6..e8f1fe6 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
- 
+
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/irq.h>
@@ -26,6 +26,7 @@
 
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 
 #include "common.h"
 
@@ -175,11 +176,6 @@ static struct map_desc ebsa285_host_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(DC21285_PCI_IACK),
 		.length		= PCIIACK_SIZE,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= PCIO_BASE,
-		.pfn		= __phys_to_pfn(DC21285_PCI_IO),
-		.length		= PCIO_SIZE,
-		.type		= MT_DEVICE,
 	},
 #endif
 };
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 9d62e33..a7cd2cf 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -276,8 +276,8 @@ int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 
 	sys->mem_offset  = DC21285_PCI_MEM;
 
-	pci_add_resource_offset(&sys->resources,
-				&ioport_resource, sys->io_offset);
+	pci_ioremap_io(0, DC21285_PCI_IO);
+
 	pci_add_resource_offset(&sys->resources, &res[0], sys->mem_offset);
 	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
 
@@ -298,7 +298,7 @@ void __init dc21285_preinit(void)
 	mem_size = (unsigned int)high_memory - PAGE_OFFSET;
 	for (mem_mask = 0x00100000; mem_mask < 0x10000000; mem_mask <<= 1)
 		if (mem_mask >= mem_size)
-			break;		
+			break;
 
 	/*
 	 * These registers need to be set up whether we're the
@@ -350,14 +350,6 @@ void __init dc21285_preinit(void)
 			    "PCI data parity", NULL);
 
 	if (cfn_mode) {
-		static struct resource csrio;
-
-		csrio.flags  = IORESOURCE_IO;
-		csrio.name   = "Footbridge";
-
-		allocate_resource(&ioport_resource, &csrio, 128,
-				  0xff00, 0xffff, 128, NULL, NULL);
-
 		/*
 		 * Map our SDRAM at a known address in PCI space, just in case
 		 * the firmware had other ideas.  Using a nonzero base is
@@ -365,7 +357,7 @@ void __init dc21285_preinit(void)
 		 * in the range 0x000a0000 to 0x000c0000. (eg, S3 cards).
 		 */
 		*CSR_PCICSRBASE       = 0xf4000000;
-		*CSR_PCICSRIOBASE     = csrio.start;
+		*CSR_PCICSRIOBASE     = 0;
 		*CSR_PCISDRAMBASE     = __virt_to_bus(PAGE_OFFSET);
 		*CSR_PCIROMBASE       = 0;
 		*CSR_PCICMD = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index e5acde2..c169f0c 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -17,7 +17,8 @@
 	/* For NetWinder debugging */
 		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x000003f8
-		orr	\rv, \rp, #0xff000000	@ virtual
+		orr	\rv, \rp, #0xfe000000	@ virtual
+		orr	\rv, \rv, #0x00e00000	@ virtual
 		orr	\rp, \rp, #0x7c000000	@ physical
 		.endm
 
diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
index aba531ee..aba4638 100644
--- a/arch/arm/mach-footbridge/include/mach/io.h
+++ b/arch/arm/mach-footbridge/include/mach/io.h
@@ -14,18 +14,10 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#ifdef CONFIG_MMU
-#define MMU_IO(a, b)	(a)
-#else
-#define MMU_IO(a, b)	(b)
-#endif
-
-#define PCIO_SIZE       0x00100000
-#define PCIO_BASE       MMU_IO(0xff000000, 0x7c000000)
-
 /*
- * Translation of various region addresses to virtual addresses
+ * Translation of various i/o addresses to host addresses for !CONFIG_MMU
  */
+#define PCIO_BASE       0x7c000000
 #define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
 
 #endif
-- 
1.7.9.5
