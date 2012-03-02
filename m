From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:41 -0600
Subject: [PATCH v3 29/30] ARM: iop13xx: use fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-30-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                             |    1 -
 arch/arm/mach-iop13xx/include/mach/io.h      |   28 --------------------------
 arch/arm/mach-iop13xx/include/mach/iop13xx.h |    7 ++---
 arch/arm/mach-iop13xx/setup.c                |   17 ++++++---------
 4 files changed, 10 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 73a86c7..10c99f9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -483,7 +483,6 @@ config ARCH_IOP13XX
 	select PCI
 	select ARCH_SUPPORTS_MSI
 	select VMSPLIT_1G
-	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for Intel's IOP13XX (XScale) family of processors.
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
index ee1dfd2..8153ed2 100644
--- a/arch/arm/mach-iop13xx/include/mach/iop13xx.h
+++ b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
@@ -5,6 +5,7 @@
 /* The ATU offsets can change based on the strapping */
 extern u32 iop13xx_atux_pmmr_offset;
 extern u32 iop13xx_atue_pmmr_offset;
+void iop13xx_init_early(void);
 void iop13xx_init_irq(void);
 void iop13xx_map_io(void);
 void iop13xx_platform_init(void);
@@ -68,12 +69,11 @@ extern unsigned long get_iop_tick_rate(void);
  * 0x8000.0000 + 928M	0x2.8000.0000   (ioremap)	PCIE outbound memory window
  *
  * IO MAP
- * 0x1000 + 64K	0x0.fffb.1000	0xfed6.1000	PCIX outbound i/o window
- * 0x1000 + 64K	0x0.fffd.1000	0xfed7.1000	PCIE outbound i/o window
+ * 0x1000 + 64K	0x0.fffb.1000	0xfef0.1000	PCIX outbound i/o window
+ * 0x1000 + 64K	0x0.fffd.1000	0xfef1.1000	PCIE outbound i/o window
  */
 #define IOP13XX_PCIX_IO_WINDOW_SIZE   0x10000UL
 #define IOP13XX_PCIX_LOWER_IO_PA      0xfffb0000UL
-#define IOP13XX_PCIX_LOWER_IO_VA      0xfed60000UL
 #define IOP13XX_PCIX_LOWER_IO_BA      0x0UL /* OIOTVR */
 #define IOP13XX_PCIX_IO_BUS_OFFSET    0x1000UL
 #define IOP13XX_PCIX_UPPER_IO_BA      (IOP13XX_PCIX_LOWER_IO_BA +\
@@ -102,7 +102,6 @@ extern unsigned long get_iop_tick_rate(void);
 /* PCI-E ranges */
 #define IOP13XX_PCIE_IO_WINDOW_SIZE   	 0x10000UL
 #define IOP13XX_PCIE_LOWER_IO_PA      	 0xfffd0000UL
-#define IOP13XX_PCIE_LOWER_IO_VA      	 0xfed70000UL
 #define IOP13XX_PCIE_LOWER_IO_BA      	 0x0UL  /* OIOTVR */
 #define IOP13XX_PCIE_IO_BUS_OFFSET	 0x1000UL
 #define IOP13XX_PCIE_UPPER_IO_BA      	 (IOP13XX_PCIE_LOWER_IO_BA +\
diff --git a/arch/arm/mach-iop13xx/setup.c b/arch/arm/mach-iop13xx/setup.c
index daabb1f..9038626 100644
--- a/arch/arm/mach-iop13xx/setup.c
+++ b/arch/arm/mach-iop13xx/setup.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/physmap.h>
 #endif
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/hardware/iop_adma.h>
@@ -40,16 +41,6 @@ static struct map_desc iop13xx_std_desc[] __initdata = {
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
 
@@ -363,6 +354,12 @@ static struct platform_device iop13xx_adma_2_channel = {
 
 void __init iop13xx_map_io(void)
 {
+	unsigned long pfn[] = {
+		__phys_to_pfn(IOP13XX_PCIX_LOWER_IO_PA),
+		__phys_to_pfn(IOP13XX_PCIE_LOWER_IO_PA),
+	};
+	pci_map_io_pfn(pfn, ARRAY_SIZE(pfn));
+
 	/* Initialize the Static Page Table maps */
 	iotable_init(iop13xx_std_desc, ARRAY_SIZE(iop13xx_std_desc));
 }
-- 
1.7.5.4
