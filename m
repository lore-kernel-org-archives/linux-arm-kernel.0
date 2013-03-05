From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:16 +0100
Subject: [PATCH 06/23] ARM: exynos: move debug-macro.S to include/debug/
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The move is necessary to support early debug output
on exynos with multiplatform configurations. This
implies also moving the plat/debug-macro.S file, but
we are leaving the remaining users of that file
in place, to avoid adding large numbers of extra
configuration options to Kconfig.debug

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug                           |  8 +++
 arch/arm/include/debug/exynos.S                  | 39 +++++++++++
 arch/arm/include/debug/samsung.S                 | 87 ++++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/debug-macro.S  | 39 -----------
 arch/arm/mach-s3c24xx/include/mach/debug-macro.S |  2 +-
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S |  2 +-
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S |  2 +-
 arch/arm/mach-s5pc100/include/mach/debug-macro.S |  2 +-
 arch/arm/mach-s5pv210/include/mach/debug-macro.S |  2 +-
 arch/arm/plat-samsung/include/plat/debug-macro.S | 87 ------------------------
 10 files changed, 139 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm/include/debug/exynos.S
 create mode 100644 arch/arm/include/debug/samsung.S
 delete mode 100644 arch/arm/mach-exynos/include/mach/debug-macro.S
 delete mode 100644 arch/arm/plat-samsung/include/plat/debug-macro.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..3c6851a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -330,6 +330,7 @@ choice
 
 	config DEBUG_S3C_UART0
 		depends on PLAT_SAMSUNG
+		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		bool "Use S3C UART 0 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -341,6 +342,7 @@ choice
 
 	config DEBUG_S3C_UART1
 		depends on PLAT_SAMSUNG
+		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		bool "Use S3C UART 1 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -352,6 +354,7 @@ choice
 
 	config DEBUG_S3C_UART2
 		depends on PLAT_SAMSUNG
+		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		bool "Use S3C UART 2 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -363,6 +366,7 @@ choice
 
 	config DEBUG_S3C_UART3
 		depends on PLAT_SAMSUNG && ARCH_EXYNOS
+		select DEBUG_EXYNOS_UART
 		bool "Use S3C UART 3 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -485,6 +489,9 @@ choice
 
 endchoice
 
+config DEBUG_EXYNOS_UART
+	bool
+
 config DEBUG_IMX_UART_PORT
 	int "i.MX Debug UART Port Selection" if DEBUG_IMX1_UART || \
 						DEBUG_IMX25_UART || \
@@ -579,6 +586,7 @@ endchoice
 
 config DEBUG_LL_INCLUDE
 	string
+	default "debug/exynos.S" if DEBUG_EXYNOS_UART
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/imx.S" if DEBUG_IMX1_UART || \
 				 DEBUG_IMX25_UART || \
diff --git a/arch/arm/include/debug/exynos.S b/arch/arm/include/debug/exynos.S
new file mode 100644
index 0000000..b17fdb7
--- /dev/null
+++ b/arch/arm/include/debug/exynos.S
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* pull in the relevant register and map files. */
+
+#define S3C_ADDR_BASE   0xF6000000
+#define S3C_VA_UART	S3C_ADDR_BASE + 0x01000000
+#define EXYNOS4_PA_UART	0x13800000
+#define EXYNOS5_PA_UART	0x12C00000
+
+	/* note, for the boot process to work we have to keep the UART
+	 * virtual address aligned to an 1MiB boundary for the L1
+	 * mapping the head code makes. We keep the UART virtual address
+	 * aligned and add in the offset when we load the value here.
+	 */
+
+	.macro addruart, rp, rv, tmp
+		mrc	p15, 0, \tmp, c0, c0, 0
+		and	\tmp, \tmp, #0xf0
+		teq	\tmp, #0xf0		@@ A15
+		ldreq	\rp, =EXYNOS5_PA_UART
+		movne	\rp, #EXYNOS4_PA_UART	@@ EXYNOS4
+		ldr	\rv, =S3C_VA_UART
+#if CONFIG_DEBUG_S3C_UART != 0
+		add	\rp, \rp, #(0x10000 * CONFIG_DEBUG_S3C_UART)
+		add	\rv, \rv, #(0x10000 * CONFIG_DEBUG_S3C_UART)
+#endif
+	.endm
+
+#define fifo_full fifo_full_s5pv210
+#define fifo_level fifo_level_s5pv210
+
+#include <debug/samsung.S>
diff --git a/arch/arm/include/debug/samsung.S b/arch/arm/include/debug/samsung.S
new file mode 100644
index 0000000..8d8d922
--- /dev/null
+++ b/arch/arm/include/debug/samsung.S
@@ -0,0 +1,87 @@
+/* arch/arm/plat-samsung/include/plat/debug-macro.S
+ *
+ * Copyright 2005, 2007 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/serial_s3c.h>
+
+/* The S5PV210/S5PC110 implementations are as belows. */
+
+	.macro fifo_level_s5pv210 rd, rx
+		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+		and	\rd, \rd, #S5PV210_UFSTAT_TXMASK
+	.endm
+
+	.macro  fifo_full_s5pv210 rd, rx
+		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+		tst	\rd, #S5PV210_UFSTAT_TXFULL
+	.endm
+
+/* The S3C2440 implementations are used by default as they are the
+ * most widely re-used */
+
+	.macro fifo_level_s3c2440 rd, rx
+		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+		and	\rd, \rd, #S3C2440_UFSTAT_TXMASK
+	.endm
+
+#ifndef fifo_level
+#define fifo_level fifo_level_s3c2440
+#endif
+
+	.macro  fifo_full_s3c2440 rd, rx
+		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+		tst	\rd, #S3C2440_UFSTAT_TXFULL
+	.endm
+
+#ifndef fifo_full
+#define fifo_full fifo_full_s3c2440
+#endif
+
+	.macro	senduart,rd,rx
+		strb 	\rd, [\rx, # S3C2410_UTXH]
+	.endm
+
+	.macro	busyuart, rd, rx
+		ldr	\rd, [\rx, # S3C2410_UFCON]
+		tst	\rd, #S3C2410_UFCON_FIFOMODE	@ fifo enabled?
+		beq	1001f				@
+		@ FIFO enabled...
+1003:
+		fifo_full \rd, \rx
+		bne	1003b
+		b	1002f
+
+1001:
+		@ busy waiting for non fifo
+		ldr	\rd, [\rx, # S3C2410_UTRSTAT]
+		tst	\rd, #S3C2410_UTRSTAT_TXFE
+		beq	1001b
+
+1002:		@ exit busyuart
+	.endm
+
+	.macro	waituart,rd,rx
+		ldr	\rd, [\rx, # S3C2410_UFCON]
+		tst	\rd, #S3C2410_UFCON_FIFOMODE	@ fifo enabled?
+		beq	1001f				@
+		@ FIFO enabled...
+1003:
+		fifo_level \rd, \rx
+		teq	\rd, #0
+		bne	1003b
+		b	1002f
+1001:
+		@ idle waiting for non fifo
+		ldr	\rd, [\rx, # S3C2410_UTRSTAT]
+		tst	\rd, #S3C2410_UTRSTAT_TXFE
+		beq	1001b
+
+1002:		@ exit busyuart
+	.endm
diff --git a/arch/arm/mach-exynos/include/mach/debug-macro.S b/arch/arm/mach-exynos/include/mach/debug-macro.S
deleted file mode 100644
index e0c86ea..0000000
--- a/arch/arm/mach-exynos/include/mach/debug-macro.S
+++ /dev/null
@@ -1,39 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/debug-macro.S
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Based on arch/arm/mach-s3c6400/include/mach/debug-macro.S
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* pull in the relevant register and map files. */
-
-#include <mach/map.h>
-
-	/* note, for the boot process to work we have to keep the UART
-	 * virtual address aligned to an 1MiB boundary for the L1
-	 * mapping the head code makes. We keep the UART virtual address
-	 * aligned and add in the offset when we load the value here.
-	 */
-
-	.macro addruart, rp, rv, tmp
-		mrc	p15, 0, \tmp, c0, c0, 0
-		and	\tmp, \tmp, #0xf0
-		teq	\tmp, #0xf0		@@ A15
-		ldreq	\rp, =EXYNOS5_PA_UART
-		movne	\rp, #EXYNOS4_PA_UART	@@ EXYNOS4
-		ldr	\rv, =S3C_VA_UART
-#if CONFIG_DEBUG_S3C_UART != 0
-		add	\rp, \rp, #(0x10000 * CONFIG_DEBUG_S3C_UART)
-		add	\rv, \rv, #(0x10000 * CONFIG_DEBUG_S3C_UART)
-#endif
-	.endm
-
-#define fifo_full fifo_full_s5pv210
-#define fifo_level fifo_level_s5pv210
-
-#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-s3c24xx/include/mach/debug-macro.S b/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
index 13ed33c..2558952 100644
--- a/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
@@ -98,4 +98,4 @@
 
 /* include the reset of the code which will do the work */
 
-#include <plat/debug-macro.S>
+#include <debug/samsung.S>
diff --git a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
index c0c076a..dd9ccca 100644
--- a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
@@ -35,4 +35,4 @@
  * will be fine with us.
  */
 
-#include <plat/debug-macro.S>
+#include <debug/samsung.S>
diff --git a/arch/arm/mach-s5p64x0/include/mach/debug-macro.S b/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
index e80ba3c..5e2916f 100644
--- a/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
@@ -30,4 +30,4 @@
 #endif
 	.endm
 
-#include <plat/debug-macro.S>
+#include <debug/samsung.S>
diff --git a/arch/arm/mach-s5pc100/include/mach/debug-macro.S b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
index 694f759..66cb7f1 100644
--- a/arch/arm/mach-s5pc100/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
@@ -36,4 +36,4 @@
  * will be fine with us.
  */
 
-#include <plat/debug-macro.S>
+#include <debug/samsung.S>
diff --git a/arch/arm/mach-s5pv210/include/mach/debug-macro.S b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
index 79e5559..80c2199 100644
--- a/arch/arm/mach-s5pv210/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
@@ -38,4 +38,4 @@
  * will be fine with us.
  */
 
-#include <plat/debug-macro.S>
+#include <debug/samsung.S>
diff --git a/arch/arm/plat-samsung/include/plat/debug-macro.S b/arch/arm/plat-samsung/include/plat/debug-macro.S
deleted file mode 100644
index f3a9cff..0000000
--- a/arch/arm/plat-samsung/include/plat/debug-macro.S
+++ /dev/null
@@ -1,87 +0,0 @@
-/* arch/arm/plat-samsung/include/plat/debug-macro.S
- *
- * Copyright 2005, 2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <plat/regs-serial.h>
-
-/* The S5PV210/S5PC110 implementations are as belows. */
-
-	.macro fifo_level_s5pv210 rd, rx
-		ldr	\rd, [\rx, # S3C2410_UFSTAT]
-		and	\rd, \rd, #S5PV210_UFSTAT_TXMASK
-	.endm
-
-	.macro  fifo_full_s5pv210 rd, rx
-		ldr	\rd, [\rx, # S3C2410_UFSTAT]
-		tst	\rd, #S5PV210_UFSTAT_TXFULL
-	.endm
-
-/* The S3C2440 implementations are used by default as they are the
- * most widely re-used */
-
-	.macro fifo_level_s3c2440 rd, rx
-		ldr	\rd, [\rx, # S3C2410_UFSTAT]
-		and	\rd, \rd, #S3C2440_UFSTAT_TXMASK
-	.endm
-
-#ifndef fifo_level
-#define fifo_level fifo_level_s3c2440
-#endif
-
-	.macro  fifo_full_s3c2440 rd, rx
-		ldr	\rd, [\rx, # S3C2410_UFSTAT]
-		tst	\rd, #S3C2440_UFSTAT_TXFULL
-	.endm
-
-#ifndef fifo_full
-#define fifo_full fifo_full_s3c2440
-#endif
-
-	.macro	senduart,rd,rx
-		strb 	\rd, [\rx, # S3C2410_UTXH]
-	.endm
-
-	.macro	busyuart, rd, rx
-		ldr	\rd, [\rx, # S3C2410_UFCON]
-		tst	\rd, #S3C2410_UFCON_FIFOMODE	@ fifo enabled?
-		beq	1001f				@
-		@ FIFO enabled...
-1003:
-		fifo_full \rd, \rx
-		bne	1003b
-		b	1002f
-
-1001:
-		@ busy waiting for non fifo
-		ldr	\rd, [\rx, # S3C2410_UTRSTAT]
-		tst	\rd, #S3C2410_UTRSTAT_TXFE
-		beq	1001b
-
-1002:		@ exit busyuart
-	.endm
-
-	.macro	waituart,rd,rx
-		ldr	\rd, [\rx, # S3C2410_UFCON]
-		tst	\rd, #S3C2410_UFCON_FIFOMODE	@ fifo enabled?
-		beq	1001f				@
-		@ FIFO enabled...
-1003:
-		fifo_level \rd, \rx
-		teq	\rd, #0
-		bne	1003b
-		b	1002f
-1001:
-		@ idle waiting for non fifo
-		ldr	\rd, [\rx, # S3C2410_UTRSTAT]
-		tst	\rd, #S3C2410_UTRSTAT_TXFE
-		beq	1001b
-
-1002:		@ exit busyuart
-	.endm
-- 
1.8.1.2
