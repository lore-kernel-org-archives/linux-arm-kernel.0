From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:06:53 +0100
Subject: [PATCH 08/10] ARM: s3c64xx: use common debug-ll implementation
In-Reply-To: <1448467615-447097-1-git-send-email-arnd@arndb.de>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
Message-ID: <1448467615-447097-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uart on s3c64xx is essentially the same as on s3c24xx,
so we can share a single assembler file. However, the addresses
are different, and we need to add the respective Kconfig magic
to get the right addresses.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug                           | 19 +++++++++++-
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S | 38 ------------------------
 2 files changed, 18 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/debug-macro.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 259c0ca9c99a..17ca2b5f8be7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -857,6 +857,7 @@ choice
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
+		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
 		bool "Use Samsung S3C UART 0 for low-level debug"
 		help
@@ -868,6 +869,7 @@ choice
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
+		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
 		bool "Use Samsung S3C UART 1 for low-level debug"
 		help
@@ -879,6 +881,7 @@ choice
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
+		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
 		bool "Use Samsung S3C UART 2 for low-level debug"
 		help
@@ -889,6 +892,7 @@ choice
 	config DEBUG_S3C_UART3
 		depends on PLAT_SAMSUNG && (ARCH_EXYNOS || ARCH_S5PV210)
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
+		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
 		bool "Use Samsung S3C UART 3 for low-level debug"
 		help
@@ -1253,6 +1257,9 @@ config DEBUG_S3C2410_UART
 config DEBUG_S3C24XX_UART
 	bool
 
+config DEBUG_S3C64XX_UART
+	bool
+
 config DEBUG_S5PV210_UART
 	bool
 
@@ -1338,7 +1345,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA0
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA1
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA4
-	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART
+	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART || DEBUG_S3C64XX_UART
 	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
 	default "debug/sirf.S" if DEBUG_SIRFSOC_UART
 	default "debug/sti.S" if DEBUG_STI_UART
@@ -1416,6 +1423,10 @@ config DEBUG_UART_PHYS
 				DEBUG_S3C2410_UART2)
 	default 0x78000000 if DEBUG_CNS3XXX
 	default 0x7c0003f8 if FOOTBRIDGE
+	default 0x7f005000 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART0
+	default 0x7f005400 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART1
+	default 0x7f005800 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART2
+	default 0x7f005c00 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART3
 	default 0x80010000 if DEBUG_ASM9260_UART
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
@@ -1474,6 +1485,7 @@ config DEBUG_UART_PHYS
 		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF2 || \
 		DEBUG_RMOBILE_SCIFA0 || DEBUG_RMOBILE_SCIFA1 || \
 		DEBUG_RMOBILE_SCIFA4 || DEBUG_S3C24XX_UART || \
+		DEBUG_S3C64XX_UART || \
 		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
 		DEBUG_AT91_UART
@@ -1499,8 +1511,12 @@ config DEBUG_UART_VIRT
 	default 0xf4090000 if ARCH_LPC32XX
 	default 0xf4200000 if ARCH_GEMINI
 	default 0xf7000000 if DEBUG_SUN9I_UART0
+	default 0xf7000000 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART0
 	default 0xf7000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
 				DEBUG_S3C2410_UART0)
+	default 0xf7000400 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART1
+	default 0xf7000800 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART2
+	default 0xf7000c00 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART3
 	default 0xf7004000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART1 || \
 				DEBUG_S3C2410_UART1)
 	default 0xf7008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
@@ -1566,6 +1582,7 @@ config DEBUG_UART_VIRT
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_NETX_UART || \
 		DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
+		DEBUG_S3C64XX_UART || \
 		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
deleted file mode 100644
index c9b95325b672..000000000000
--- a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
+++ /dev/null
@@ -1,38 +0,0 @@
-/* arch/arm/mach-s3c6400/include/mach/debug-macro.S
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* pull in the relevant register and map files. */
-
-#include <linux/serial_s3c.h>
-#include <mach/map.h>
-
-	/* note, for the boot process to work we have to keep the UART
-	 * virtual address aligned to an 1MiB boundary for the L1
-	 * mapping the head code makes. We keep the UART virtual address
-	 * aligned and add in the offset when we load the value here.
-	 */
-
-	.macro addruart, rp, rv, tmp
-		ldr	\rp, = S3C_PA_UART
-		ldr	\rv, = (S3C_VA_UART + S3C_PA_UART & 0xfffff)
-#if CONFIG_DEBUG_S3C_UART != 0
-		add	\rp, \rp, #(0x400 * CONFIG_DEBUG_S3C_UART)
-		add	\rv, \rv, #(0x400 * CONFIG_DEBUG_S3C_UART)
-#endif
-	.endm
-
-/* include the reset of the code which will do the work, we're only
- * compiling for a single cpu processor type so the default of s3c2440
- * will be fine with us.
- */
-
-#include <debug/samsung.S>
-- 
2.1.0.rc2
