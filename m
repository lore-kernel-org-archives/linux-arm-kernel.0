From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 07 Jul 2013 13:52:32 +0100
Subject: [PATCH RFC 9/9] ARM: debug: move PL01X debug include into
 arch/arm/include/debug/
In-Reply-To: <20130707124326.GP24642@n2100.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
Message-ID: <E1UvoS8-0006IF-TE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the PL01X debug include can mostly stand alone without
requiring platforms to provide any macros, move it into the debug
directory so it can be directly included.  This allows us to get rid of
a lot of debug-macros include files.

The autodetect case for Versatile Express and the ux500 are left alone;
these are more complicated implementations.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug                             |   12 +-----
 arch/arm/include/asm/hardware/debug-pl01x.S        |   36 --------------------
 arch/arm/include/debug/bcm2835.S                   |   13 -------
 arch/arm/include/debug/cns3xxx.S                   |   12 ------
 arch/arm/include/debug/highbank.S                  |   11 ------
 arch/arm/include/debug/mxs.S                       |   13 -------
 arch/arm/include/debug/nomadik.S                   |   12 ------
 arch/arm/include/debug/nspire.S                    |   11 ------
 arch/arm/include/debug/pl01x.S                     |   36 ++++++++++++++++++++
 arch/arm/include/debug/u300.S                      |    7 ----
 arch/arm/include/debug/ux500.S                     |    2 +-
 arch/arm/include/debug/vexpress.S                  |    2 +-
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |   12 ------
 .../arm/mach-integrator/include/mach/debug-macro.S |   13 -------
 arch/arm/mach-realview/include/mach/debug-macro.S  |   12 ------
 arch/arm/mach-versatile/include/mach/debug-macro.S |   13 -------
 16 files changed, 40 insertions(+), 177 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/debug-pl01x.S
 delete mode 100644 arch/arm/include/debug/bcm2835.S
 delete mode 100644 arch/arm/include/debug/cns3xxx.S
 delete mode 100644 arch/arm/include/debug/highbank.S
 delete mode 100644 arch/arm/include/debug/mxs.S
 delete mode 100644 arch/arm/include/debug/nomadik.S
 delete mode 100644 arch/arm/include/debug/nspire.S
 create mode 100644 arch/arm/include/debug/pl01x.S
 delete mode 100644 arch/arm/include/debug/u300.S
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-integrator/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-realview/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-versatile/include/mach/debug-macro.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index cd4edaf..4fff87d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -816,10 +816,8 @@ config DEBUG_STI_UART
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/8250.S" if DEBUG_UART_8250
-	default "debug/bcm2835.S" if DEBUG_BCM2835
-	default "debug/cns3xxx.S" if DEBUG_CNS3XXX
+	default "debug/pl01x.S" if DEBUG_UART_PL01X
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
-	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/imx.S" if DEBUG_IMX1_UART || \
 				 DEBUG_IMX25_UART || \
@@ -832,18 +830,12 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6SL_UART
 	default "debug/keystone.S" if DEBUG_KEYSTONE_UART0 || \
 				      DEBUG_KEYSTONE_UART1
-	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
-	default "debug/nomadik.S" if DEBUG_NOMADIK_UART
-	default "debug/nspire.S" if DEBUG_NSPIRE_CX_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
 	default "debug/sti.S" if DEBUG_STI_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
-	default "debug/u300.S" if DEBUG_U300_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
-	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
-		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1 || \
-		DEBUG_VEXPRESS_UART0_CRX
+	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT
 	default "debug/vt8500.S" if DEBUG_VT8500_UART0
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
diff --git a/arch/arm/include/asm/hardware/debug-pl01x.S b/arch/arm/include/asm/hardware/debug-pl01x.S
deleted file mode 100644
index 9d1e286..0000000
--- a/arch/arm/include/asm/hardware/debug-pl01x.S
+++ /dev/null
@@ -1,36 +0,0 @@
-/* arch/arm/include/asm/hardware/debug-pl01x.S
- *
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-#include <linux/amba/serial.h>
-
-#ifdef CONFIG_DEBUG_UART_PHYS
-		.macro	addruart, rp, rv, tmp
-		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
-		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
-		.endm
-#endif
-
-		.macro	senduart,rd,rx
-		strb	\rd, [\rx, #UART01x_DR]
-		.endm
-
-		.macro	waituart,rd,rx
-1001:		ldr	\rd, [\rx, #UART01x_FR]
-		tst	\rd, #UART01x_FR_TXFF
-		bne	1001b
-		.endm
-
-		.macro	busyuart,rd,rx
-1001:		ldr	\rd, [\rx, #UART01x_FR]
-		tst	\rd, #UART01x_FR_BUSY
-		bne	1001b
-		.endm
diff --git a/arch/arm/include/debug/bcm2835.S b/arch/arm/include/debug/bcm2835.S
deleted file mode 100644
index 726e069..0000000
--- a/arch/arm/include/debug/bcm2835.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * Debugging macro include header
- *
- * Copyright (C) 2010 Broadcom
- * Copyright (C) 1994-1999 Russell King
- * Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/cns3xxx.S b/arch/arm/include/debug/cns3xxx.S
deleted file mode 100644
index 2d5fb51..0000000
--- a/arch/arm/include/debug/cns3xxx.S
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Debugging macro include header
- *
- * Copyright 1994-1999 Russell King
- * Copyright 2008 Cavium Networks
- * Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- */
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/highbank.S b/arch/arm/include/debug/highbank.S
deleted file mode 100644
index 3c6f63f..0000000
--- a/arch/arm/include/debug/highbank.S
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/mxs.S b/arch/arm/include/debug/mxs.S
deleted file mode 100644
index 8a10ed2..0000000
--- a/arch/arm/include/debug/mxs.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/* arch/arm/mach-mxs/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/nomadik.S b/arch/arm/include/debug/nomadik.S
deleted file mode 100644
index a6d238e..0000000
--- a/arch/arm/include/debug/nomadik.S
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/nspire.S b/arch/arm/include/debug/nspire.S
deleted file mode 100644
index fc17e50..0000000
--- a/arch/arm/include/debug/nspire.S
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- *	linux/arch/arm/include/debug/nspire.S
- *
- *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2, as
- * published by the Free Software Foundation.
- *
- */
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
new file mode 100644
index 0000000..37c6895b
--- /dev/null
+++ b/arch/arm/include/debug/pl01x.S
@@ -0,0 +1,36 @@
+/* arch/arm/include/debug/pl01x.S
+ *
+ * Debugging macro include header
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+#include <linux/amba/serial.h>
+
+#ifdef CONFIG_DEBUG_UART_PHYS
+		.macro	addruart, rp, rv, tmp
+		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
+		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
+		.endm
+#endif
+
+		.macro	senduart,rd,rx
+		strb	\rd, [\rx, #UART01x_DR]
+		.endm
+
+		.macro	waituart,rd,rx
+1001:		ldr	\rd, [\rx, #UART01x_FR]
+		tst	\rd, #UART01x_FR_TXFF
+		bne	1001b
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:		ldr	\rd, [\rx, #UART01x_FR]
+		tst	\rd, #UART01x_FR_BUSY
+		bne	1001b
+		.endm
diff --git a/arch/arm/include/debug/u300.S b/arch/arm/include/debug/u300.S
deleted file mode 100644
index 58b9d62..0000000
--- a/arch/arm/include/debug/u300.S
+++ /dev/null
@@ -1,7 +0,0 @@
-/*
- * Copyright (C) 2006-2013 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Debugging macro include header.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/ux500.S b/arch/arm/include/debug/ux500.S
index fbd24be..aa7f63a 100644
--- a/arch/arm/include/debug/ux500.S
+++ b/arch/arm/include/debug/ux500.S
@@ -45,4 +45,4 @@
 	ldr	\rv, =UART_VIRT_BASE		@ yes, virtual address
 	.endm
 
-#include <asm/hardware/debug-pl01x.S>
+#include <debug/pl01x.S>
diff --git a/arch/arm/include/debug/vexpress.S b/arch/arm/include/debug/vexpress.S
index 114bf4c..524acd5 100644
--- a/arch/arm/include/debug/vexpress.S
+++ b/arch/arm/include/debug/vexpress.S
@@ -47,5 +47,5 @@
 
 		.endm
 
-#include <asm/hardware/debug-pl01x.S>
+#include <debug/pl01x.S>
 #endif
diff --git a/arch/arm/mach-ep93xx/include/mach/debug-macro.S b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
deleted file mode 100644
index a1bfe4c..0000000
--- a/arch/arm/mach-ep93xx/include/mach/debug-macro.S
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/debug-macro.S
- * Debugging macro include header
- *
- * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- */
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-integrator/include/mach/debug-macro.S b/arch/arm/mach-integrator/include/mach/debug-macro.S
deleted file mode 100644
index 03ee0fd..0000000
--- a/arch/arm/mach-integrator/include/mach/debug-macro.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/* arch/arm/mach-integrator/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-realview/include/mach/debug-macro.S b/arch/arm/mach-realview/include/mach/debug-macro.S
deleted file mode 100644
index 99488f4..0000000
--- a/arch/arm/mach-realview/include/mach/debug-macro.S
+++ /dev/null
@@ -1,12 +0,0 @@
-/* arch/arm/mach-realview/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-versatile/include/mach/debug-macro.S b/arch/arm/mach-versatile/include/mach/debug-macro.S
deleted file mode 100644
index c256977..0000000
--- a/arch/arm/mach-versatile/include/mach/debug-macro.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/* arch/arm/mach-versatile/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-#include <asm/hardware/debug-pl01x.S>
-- 
1.7.4.4
