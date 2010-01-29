From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:21 +0000
Subject: [PATCH] ARM: S3C: Remove old plat-s3c directory and unused contents
In-Reply-To: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
References: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264755741-16184-11-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the plat-s3c directory, as it isn't being used anymore and then
remove it from the ARM build.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/Kconfig                         |    1 -
 arch/arm/Makefile                        |    8 ++++----
 arch/arm/plat-s3c/Kconfig                |   11 -----------
 arch/arm/plat-s3c/Makefile               |   13 -------------
 arch/arm/plat-s3c/include/mach/io.h      |   18 ------------------
 arch/arm/plat-s3c/include/mach/timex.h   |   26 --------------------------
 arch/arm/plat-s3c/include/mach/vmalloc.h |   20 --------------------
 7 files changed, 4 insertions(+), 93 deletions(-)
 delete mode 100644 arch/arm/plat-s3c/Kconfig
 delete mode 100644 arch/arm/plat-s3c/Makefile
 delete mode 100644 arch/arm/plat-s3c/include/mach/io.h
 delete mode 100644 arch/arm/plat-s3c/include/mach/timex.h
 delete mode 100644 arch/arm/plat-s3c/include/mach/vmalloc.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3bc5169..20844fc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -785,7 +785,6 @@ source "arch/arm/mach-dove/Kconfig"
 source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 source "arch/arm/plat-s3c64xx/Kconfig"
-source "arch/arm/plat-s3c/Kconfig"
 source "arch/arm/plat-s5p/Kconfig"
 source "arch/arm/plat-s5pc1xx/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index bbcd512..774f66a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -182,10 +182,10 @@ plat-$(CONFIG_PLAT_IOP)		:= iop
 plat-$(CONFIG_PLAT_NOMADIK)	:= nomadik
 plat-$(CONFIG_PLAT_ORION)	:= orion
 plat-$(CONFIG_PLAT_PXA)		:= pxa
-plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx s3c samsung
-plat-$(CONFIG_PLAT_S3C64XX)	:= s3c64xx s3c samsung
-plat-$(CONFIG_PLAT_S5PC1XX)	:= s5pc1xx s3c samsung
-plat-$(CONFIG_PLAT_S5P)		:= s5p samsung s3c
+plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx samsung
+plat-$(CONFIG_PLAT_S3C64XX)	:= s3c64xx samsung
+plat-$(CONFIG_PLAT_S5PC1XX)	:= s5pc1xx samsung
+plat-$(CONFIG_PLAT_S5P)		:= s5p samsung
 plat-$(CONFIG_ARCH_STMP3XXX)	:= stmp3xxx
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
deleted file mode 100644
index 6108ba9..0000000
--- a/arch/arm/plat-s3c/Kconfig
+++ /dev/null
@@ -1,11 +0,0 @@
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-config PLAT_S3C
-	bool
-	depends on ARCH_S3C2410 || ARCH_S3C24A0 || ARCH_S3C64XX
-	default y
-	select NO_IOPORT
-	help
-	  Base platform code for any Samsung S3C device
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
deleted file mode 100644
index 867c9cf..0000000
--- a/arch/arm/plat-s3c/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-# arch/arm/plat-s3c/Makefile
-#
-# Copyright 2008 Simtec Electronics
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:= dummy.o
-obj-				:=
-
-# Core support for all Samsung SoCs
-
diff --git a/arch/arm/plat-s3c/include/mach/io.h b/arch/arm/plat-s3c/include/mach/io.h
deleted file mode 100644
index f6a5363..0000000
--- a/arch/arm/plat-s3c/include/mach/io.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/plat-s3c/include/mach/io.h
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben-linux@fluff.org>
- *
- * Default IO routines for plat-s3c based systems, such as S3C24A0
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
-#endif
diff --git a/arch/arm/plat-s3c/include/mach/timex.h b/arch/arm/plat-s3c/include/mach/timex.h
deleted file mode 100644
index 2a425ed..0000000
--- a/arch/arm/plat-s3c/include/mach/timex.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/timex.h
- *
- * Copyright (c) 2003-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - time parameters
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_TIMEX_H
-#define __ASM_ARCH_TIMEX_H
-
-/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
- * a variable is useless. It seems as long as we make our timers an
- * exact multiple of HZ, any value that makes a 1->1 correspondence
- * for the time conversion functions to/from jiffies is acceptable.
-*/
-
-
-#define CLOCK_TICK_RATE 12000000
-
-
-#endif /* __ASM_ARCH_TIMEX_H */
diff --git a/arch/arm/plat-s3c/include/mach/vmalloc.h b/arch/arm/plat-s3c/include/mach/vmalloc.h
deleted file mode 100644
index bfd2ca6..0000000
--- a/arch/arm/plat-s3c/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* arch/arm/plat-s3c/include/mach/vmalloc.h
- *
- * from arch/arm/mach-iop3xx/include/mach/vmalloc.h
- *
- * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 vmalloc definition
-*/
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	  (0xE0000000)
-
-#endif /* __ASM_ARCH_VMALLOC_H */
-- 
1.6.0.4
