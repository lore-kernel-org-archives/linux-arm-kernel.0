From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 23:14:30 +0100
Subject: [PATCH 4/5] ARM: cns3xxx: enable multiplatform support
In-Reply-To: <1363299271-8283-1-git-send-email-arnd@arndb.de>
References: <1363299271-8283-1-git-send-email-arnd@arndb.de>
Message-ID: <1363299271-8283-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the cns3xxx configuration option inside of ARCH_MULTIPLATFORM,
since there is no reason for not doing it now. We can then also remove
the three header files that become obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                                | 12 ------
 arch/arm/configs/cns3420vb_defconfig            |  2 +
 arch/arm/mach-cns3xxx/Kconfig                   | 11 +++++
 arch/arm/mach-cns3xxx/include/mach/timex.h      | 12 ------
 arch/arm/mach-cns3xxx/include/mach/uncompress.h | 53 -------------------------
 5 files changed, 13 insertions(+), 77 deletions(-)
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8bad33e..78ffcc6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -382,18 +382,6 @@ config ARCH_BCM2835
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
 	  use in the Raspberry Pi, and Roku 2 devices.
 
-config ARCH_CNS3XXX
-	bool "Cavium Networks CNS3XXX family"
-	select ARM_GIC
-	select CPU_V6K
-	select GENERIC_CLOCKEVENTS
-	select MIGHT_HAVE_CACHE_L2X0
-	select MIGHT_HAVE_PCI
-	select PCI_DOMAINS if PCI
-	select SPARSE_IRQ
-	help
-	  Support for Cavium Networks CNS3XXX platform.
-
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/configs/cns3420vb_defconfig b/arch/arm/configs/cns3420vb_defconfig
index b79e984..b1ff5cd 100644
--- a/arch/arm/configs/cns3420vb_defconfig
+++ b/arch/arm/configs/cns3420vb_defconfig
@@ -19,6 +19,8 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_IOSCHED_CFQ=m
+CONFIG_ARCH_MULTI_V6=y
+#CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_CNS3XXX=y
 CONFIG_MACH_CNS3420VB=y
 CONFIG_DEBUG_CNS3XXX=y
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index 9ebfcc4..5720f3d 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -1,3 +1,14 @@
+config ARCH_CNS3XXX
+	bool "Cavium Networks CNS3XXX family" if ARCH_MULTI_V6
+	select ARM_GIC
+	select CPU_V6K
+	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_CACHE_L2X0
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
+	help
+	  Support for Cavium Networks CNS3XXX platform.
+
 menu "CNS3XXX platform type"
 	depends on ARCH_CNS3XXX
 
diff --git a/arch/arm/mach-cns3xxx/include/mach/timex.h b/arch/arm/mach-cns3xxx/include/mach/timex.h
deleted file mode 100644
index 1fd0421..0000000
--- a/arch/arm/mach-cns3xxx/include/mach/timex.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Cavium Networks architecture timex specifications
- *
- * Copyright 2003 ARM Limited
- * Copyright 2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- */
-
-#define CLOCK_TICK_RATE		(50000000 / 16)
diff --git a/arch/arm/mach-cns3xxx/include/mach/uncompress.h b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
deleted file mode 100644
index e2c642c..0000000
--- a/arch/arm/mach-cns3xxx/include/mach/uncompress.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright 2003 ARM Limited
- * Copyright 2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- */
-
-#include <asm/mach-types.h>
-#include "cns3xxx.h"
-
-#define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))
-#define AMBA_UART_LCRH(base)	(*(volatile unsigned char *)((base) + 0x2c))
-#define AMBA_UART_CR(base)	(*(volatile unsigned char *)((base) + 0x30))
-#define AMBA_UART_FR(base)	(*(volatile unsigned char *)((base) + 0x18))
-
-/*
- * Return the UART base address
- */
-static inline unsigned long get_uart_base(void)
-{
-	if (machine_is_cns3420vb())
-		return CNS3XXX_UART0_BASE;
-	else
-		return 0;
-}
-
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	unsigned long base = get_uart_base();
-
-	while (AMBA_UART_FR(base) & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR(base) = c;
-}
-
-static inline void flush(void)
-{
-	unsigned long base = get_uart_base();
-
-	while (AMBA_UART_FR(base) & (1 << 3))
-		barrier();
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-- 
1.8.1.2
