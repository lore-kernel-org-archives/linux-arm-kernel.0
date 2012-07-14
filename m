From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:04:03 -0500
Subject: [PATCH v2 07/15] ARM: shark: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert shark to use the fixed i/o mapping and remove io.h.

This shrinks the mapping from 256MB to 64KB, but nothing is using that much
space AFAICT.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig                               |    1 -
 arch/arm/mach-shark/core.c                     |   18 ------------------
 arch/arm/mach-shark/include/mach/debug-macro.S |    7 ++++---
 arch/arm/mach-shark/include/mach/entry-macro.S |    3 ++-
 arch/arm/mach-shark/include/mach/io.h          |   18 ------------------
 arch/arm/mach-shark/pci.c                      |    5 +++++
 6 files changed, 11 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-shark/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5d37628..3dfc555 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -869,7 +869,6 @@ config ARCH_SHARK
 	select PCI
 	select ARCH_USES_GETTIMEOFFSET
 	select NEED_MACH_MEMORY_H
-	select NEED_MACH_IO_H
 	help
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index 2704bcd..d35b94e 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -21,9 +21,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#define IO_BASE                 0xe0000000
-#define IO_SIZE                 0x08000000
-#define IO_START                0x40000000
 #define ROMCARD_SIZE            0x08000000
 #define ROMCARD_START           0x10000000
 
@@ -104,20 +101,6 @@ arch_initcall(shark_init);
 
 extern void shark_init_irq(void);
 
-static struct map_desc shark_io_desc[] __initdata = {
-	{
-		.virtual	= IO_BASE,
-		.pfn		= __phys_to_pfn(IO_START),
-		.length		= IO_SIZE,
-		.type		= MT_DEVICE
-	}
-};
-
-static void __init shark_map_io(void)
-{
-	iotable_init(shark_io_desc, ARRAY_SIZE(shark_io_desc));
-}
-
 #define IRQ_TIMER 0
 #define HZ_TIME ((1193180 + HZ/2) / HZ)
 
@@ -158,7 +141,6 @@ static void shark_init_early(void)
 MACHINE_START(SHARK, "Shark")
 	/* Maintainer: Alexander Schulz */
 	.atag_offset	= 0x3000,
-	.map_io		= shark_map_io,
 	.init_early	= shark_init_early,
 	.init_irq	= shark_init_irq,
 	.timer		= &shark_timer,
diff --git a/arch/arm/mach-shark/include/mach/debug-macro.S b/arch/arm/mach-shark/include/mach/debug-macro.S
index 20eb2bf..d129119 100644
--- a/arch/arm/mach-shark/include/mach/debug-macro.S
+++ b/arch/arm/mach-shark/include/mach/debug-macro.S
@@ -12,9 +12,10 @@
 */
 
 		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0xe0000000
-		orr	\rp, \rp, #0x000003f8
-		mov	\rv, \rp
+		mov	\rp, #0x3f8
+		orr	\rv, \rp, #0xfe000000
+		orr	\rv, \rv, #0x00e00000
+		orr	\rp, \rp, #0x40000000
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-shark/include/mach/entry-macro.S b/arch/arm/mach-shark/include/mach/entry-macro.S
index 5901b09..c9e49f0 100644
--- a/arch/arm/mach-shark/include/mach/entry-macro.S
+++ b/arch/arm/mach-shark/include/mach/entry-macro.S
@@ -8,7 +8,8 @@
  * warranty of any kind, whether express or implied.
  */
 		.macro  get_irqnr_preamble, base, tmp
-		mov	\base, #0xe0000000
+		mov	\base, #0xfe000000
+		orr	\base, \base, #0x00e00000
 		.endm
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
diff --git a/arch/arm/mach-shark/include/mach/io.h b/arch/arm/mach-shark/include/mach/io.h
deleted file mode 100644
index 1a45fc0..0000000
--- a/arch/arm/mach-shark/include/mach/io.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/io.h
- *
- * by Alexander Schulz
- *
- * derived from:
- * arch/arm/mach-ebsa110/include/mach/io.h
- * Copyright (C) 1997,1998 Russell King
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)                 ((void __iomem *)(0xe0000000 + (a)))
-
-#endif
diff --git a/arch/arm/mach-shark/pci.c b/arch/arm/mach-shark/pci.c
index 9089407..b8b4ab3 100644
--- a/arch/arm/mach-shark/pci.c
+++ b/arch/arm/mach-shark/pci.c
@@ -8,12 +8,15 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <video/vga.h>
 
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#define IO_START	0x40000000
+
 static int __init shark_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (dev->bus->number == 0)
@@ -44,6 +47,8 @@ static int __init shark_pci_init(void)
 	pcibios_min_mem = 0x50000000;
 	vga_base = 0xe8000000;
 
+	pci_ioremap_io(0, IO_START);
+
 	pci_common_init(&shark_pci);
 
 	return 0;
-- 
1.7.9.5
