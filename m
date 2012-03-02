From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:36 -0600
Subject: [PATCH v3 24/30] ARM: shark: use fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-25-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig                               |    1 -
 arch/arm/mach-shark/core.c                     |   14 ++------------
 arch/arm/mach-shark/include/mach/debug-macro.S |    7 ++++---
 arch/arm/mach-shark/include/mach/entry-macro.S |    3 ++-
 arch/arm/mach-shark/include/mach/io.h          |   18 ------------------
 5 files changed, 8 insertions(+), 35 deletions(-)
 delete mode 100644 arch/arm/mach-shark/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 682c5d8..b14bf3c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -893,7 +893,6 @@ config ARCH_SHARK
 	select PCI
 	select ARCH_USES_GETTIMEOFFSET
 	select NEED_MACH_MEMORY_H
-	select NEED_MACH_IO_H
 	help
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index 6a2a7f2..da12ad0 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -17,11 +17,10 @@
 #include <asm/param.h>
 
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#define IO_BASE                 0xe0000000
-#define IO_SIZE                 0x08000000
 #define IO_START                0x40000000
 #define ROMCARD_SIZE            0x08000000
 #define ROMCARD_START           0x10000000
@@ -103,18 +102,9 @@ arch_initcall(shark_init);
 
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
 static void __init shark_map_io(void)
 {
-	iotable_init(shark_io_desc, ARRAY_SIZE(shark_io_desc));
+	pci_map_io_single(IO_START);
 }
 
 #define IRQ_TIMER 0
diff --git a/arch/arm/mach-shark/include/mach/debug-macro.S b/arch/arm/mach-shark/include/mach/debug-macro.S
index 20eb2bf..b08ef9d 100644
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
+		orr	\rv, \rv, #0x00f00000
+		orr	\rp, \rp, #0x40000000
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-shark/include/mach/entry-macro.S b/arch/arm/mach-shark/include/mach/entry-macro.S
index 0bb6cc6..3ff46fc 100644
--- a/arch/arm/mach-shark/include/mach/entry-macro.S
+++ b/arch/arm/mach-shark/include/mach/entry-macro.S
@@ -11,7 +11,8 @@
 		.endm
 
 		.macro  get_irqnr_preamble, base, tmp
-		mov	\base, #0xe0000000
+		mov	\base, #0xfe000000
+		orr	\base, \base, #0x00f00000
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
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
-- 
1.7.5.4
