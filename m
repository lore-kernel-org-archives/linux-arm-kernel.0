From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 07 Jul 2013 13:49:31 +0100
Subject: [PATCH RFC 6/9] ARM: debug: move 8250 debug include into
 arch/arm/include/debug/
In-Reply-To: <20130707124326.GP24642@n2100.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
Message-ID: <E1UvoPD-0006I1-Jc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the 8250 debug include can stand alone without requiring
platforms to provide any macros, move it into the debug directory
so it can be directly included.  This allows us to get rid of a lot
of debug-macros include files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug                             |   10 +----
 arch/arm/include/asm/hardware/debug-8250.S         |   40 --------------------
 arch/arm/include/debug/8250.S                      |   36 ++++++++++++++++++
 arch/arm/include/debug/mvebu.S                     |   13 ------
 arch/arm/include/debug/nspire.S                    |    4 --
 arch/arm/include/debug/pxa.S                       |   13 ------
 arch/arm/include/debug/rockchip.S                  |   12 ------
 arch/arm/include/debug/sunxi.S                     |   12 ------
 arch/arm/mach-dove/include/mach/debug-macro.S      |    8 ----
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |   13 ------
 .../arm/mach-footbridge/include/mach/debug-macro.S |    4 --
 arch/arm/mach-gemini/include/mach/debug-macro.S    |   12 ------
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |   13 ------
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |   13 ------
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |   13 ------
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |   12 ------
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    8 ----
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |   18 ---------
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    8 ----
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |   10 -----
 arch/arm/mach-rpc/include/mach/debug-macro.S       |   13 ------
 21 files changed, 38 insertions(+), 247 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/debug-8250.S
 create mode 100644 arch/arm/include/debug/8250.S
 delete mode 100644 arch/arm/include/debug/mvebu.S
 delete mode 100644 arch/arm/include/debug/pxa.S
 delete mode 100644 arch/arm/include/debug/rockchip.S
 delete mode 100644 arch/arm/include/debug/sunxi.S
 delete mode 100644 arch/arm/mach-dove/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-gemini/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-iop32x/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-iop33x/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-orion5x/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-rpc/include/mach/debug-macro.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 82ce0ba..defd881 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -815,6 +815,7 @@ config DEBUG_STI_UART
 
 config DEBUG_LL_INCLUDE
 	string
+	default "debug/8250.S" if DEBUG_UART_8250
 	default "debug/bcm2835.S" if DEBUG_BCM2835
 	default "debug/cns3xxx.S" if DEBUG_CNS3XXX
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
@@ -831,21 +832,14 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6SL_UART
 	default "debug/keystone.S" if DEBUG_KEYSTONE_UART0 || \
 				      DEBUG_KEYSTONE_UART1
-	default "debug/mvebu.S" if DEBUG_MVEBU_UART || \
-				   DEBUG_MVEBU_UART_ALTERNATE
 	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
 	default "debug/nomadik.S" if DEBUG_NOMADIK_UART
-	default "debug/nspire.S" if 	DEBUG_NSPIRE_CX_UART || \
-					DEBUG_NSPIRE_CLASSIC_UART
+	default "debug/nspire.S" if DEBUG_NSPIRE_CX_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
-	default "debug/pxa.S" if DEBUG_PXA_UART1 || DEBUG_MMP_UART2 || \
-				 DEBUG_MMP_UART3
-	default "debug/rockchip.S" if DEBUG_ROCKCHIP_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
 	default "debug/sti.S" if DEBUG_STI_UART
-	default "debug/sunxi.S" if DEBUG_SUNXI_UART0 || DEBUG_SUNXI_UART1
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/u300.S" if DEBUG_U300_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
diff --git a/arch/arm/include/asm/hardware/debug-8250.S b/arch/arm/include/asm/hardware/debug-8250.S
deleted file mode 100644
index 4c62f2d..0000000
--- a/arch/arm/include/asm/hardware/debug-8250.S
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * arch/arm/include/asm/hardware/debug-8250.S
- *
- *  Copyright (C) 1994-1999 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/serial_reg.h>
-
-#ifdef CONFIG_DEBUG_UART_PHYS
-		.macro	addruart, rp, rv, tmp
-		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
-		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
-		.endm
-#endif
-
-#ifndef UART_SHIFT
-#define UART_SHIFT CONFIG_DEBUG_UART_8250_SHIFT
-#endif
-
-		.macro	senduart,rd,rx
-		strb	\rd, [\rx, #UART_TX << UART_SHIFT]
-		.endm
-
-		.macro	busyuart,rd,rx
-1002:		ldrb	\rd, [\rx, #UART_LSR << UART_SHIFT]
-		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
-		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
-		bne	1002b
-		.endm
-
-		.macro	waituart,rd,rx
-#ifdef CONFIG_DEBUG_UART_8250_FLOW_CONTROL
-1001:		ldrb	\rd, [\rx, #UART_MSR << UART_SHIFT]
-		tst	\rd, #UART_MSR_CTS
-		beq	1001b
-#endif
-		.endm
diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
new file mode 100644
index 0000000..4df055b
--- /dev/null
+++ b/arch/arm/include/debug/8250.S
@@ -0,0 +1,36 @@
+/*
+ * arch/arm/include/debug/8250.S
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/serial_reg.h>
+
+		.macro	addruart, rp, rv, tmp
+		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
+		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
+		.endm
+
+#define UART_SHIFT CONFIG_DEBUG_UART_8250_SHIFT
+
+		.macro	senduart,rd,rx
+		strb	\rd, [\rx, #UART_TX << UART_SHIFT]
+		.endm
+
+		.macro	busyuart,rd,rx
+1002:		ldrb	\rd, [\rx, #UART_LSR << UART_SHIFT]
+		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
+		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
+		bne	1002b
+		.endm
+
+		.macro	waituart,rd,rx
+#ifdef CONFIG_DEBUG_UART_8250_FLOW_CONTROL
+1001:		ldrb	\rd, [\rx, #UART_MSR << UART_SHIFT]
+		tst	\rd, #UART_MSR_CTS
+		beq	1001b
+#endif
+		.endm
diff --git a/arch/arm/include/debug/mvebu.S b/arch/arm/include/debug/mvebu.S
deleted file mode 100644
index 6309be5..0000000
--- a/arch/arm/include/debug/mvebu.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * Early serial output macro for Marvell  SoC
- *
- * Copyright (C) 2012 Marvell
- *
- * Lior Amsalem <alior@marvell.com>
- * Gregory Clement <gregory.clement@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/include/debug/nspire.S b/arch/arm/include/debug/nspire.S
index 3e9329a..9c2fbec 100644
--- a/arch/arm/include/debug/nspire.S
+++ b/arch/arm/include/debug/nspire.S
@@ -19,7 +19,3 @@
 
 #include <asm/hardware/debug-pl01x.S>
 #endif
-
-#ifdef CONFIG_DEBUG_NSPIRE_CLASSIC_UART
-#include <asm/hardware/debug-8250.S>
-#endif
diff --git a/arch/arm/include/debug/pxa.S b/arch/arm/include/debug/pxa.S
deleted file mode 100644
index 09e54f3..0000000
--- a/arch/arm/include/debug/pxa.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * Early serial output macro for Marvell PXA/MMP SoC
- *
- * Copyright (C) 1994-1999 Russell King
- * Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * Copyright (C) 2013 Haojian Zhuang
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/include/debug/rockchip.S b/arch/arm/include/debug/rockchip.S
deleted file mode 100644
index 3ad0238..0000000
--- a/arch/arm/include/debug/rockchip.S
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Early serial output macro for Rockchip SoCs
- *
- * Copyright (C) 2012 Maxime Ripard
- *
- * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/include/debug/sunxi.S b/arch/arm/include/debug/sunxi.S
deleted file mode 100644
index 4c3d89c..0000000
--- a/arch/arm/include/debug/sunxi.S
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Early serial output macro for Allwinner A1X SoCs
- *
- * Copyright (C) 2012 Maxime Ripard
- *
- * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-dove/include/mach/debug-macro.S
deleted file mode 100644
index 9b85a81..0000000
--- a/arch/arm/mach-dove/include/mach/debug-macro.S
+++ /dev/null
@@ -1,8 +0,0 @@
-/*
- * arch/arm/mach-dove/include/mach/debug-macro.S
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-ebsa110/include/mach/debug-macro.S b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
deleted file mode 100644
index 0cea548..0000000
--- a/arch/arm/mach-ebsa110/include/mach/debug-macro.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/* arch/arm/mach-ebsa110/include/mach/debug-macro.S
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
-**/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index 553c47d..02247f3 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -13,9 +13,6 @@
 
 #include <asm/hardware/dec21285.h>
 
-#ifndef CONFIG_DEBUG_DC21285_PORT
-#include <asm/hardware/debug-8250.S>
-#else
 #include <mach/hardware.h>
 	/* For EBSA285 debugging */
 		.equ	dc21285_high, ARMCSR_BASE & 0xff000000
@@ -43,4 +40,3 @@
 
 		.macro	waituart,rd,rx
 		.endm
-#endif
diff --git a/arch/arm/mach-gemini/include/mach/debug-macro.S b/arch/arm/mach-gemini/include/mach/debug-macro.S
deleted file mode 100644
index 9dabd4b..0000000
--- a/arch/arm/mach-gemini/include/mach/debug-macro.S
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Copyright (C) 2001-2006 Storlink, Corp.
- *  Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-iop13xx/include/mach/debug-macro.S b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
deleted file mode 100644
index 90b5e64..0000000
--- a/arch/arm/mach-iop13xx/include/mach/debug-macro.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-iop13xx/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- * Copyright (C) 1994-1999 Russell King
- * Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-iop32x/include/mach/debug-macro.S b/arch/arm/mach-iop32x/include/mach/debug-macro.S
deleted file mode 100644
index 7ea745e..0000000
--- a/arch/arm/mach-iop32x/include/mach/debug-macro.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-iop32x/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- * Copyright (C) 1994-1999 Russell King
- * Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-iop33x/include/mach/debug-macro.S b/arch/arm/mach-iop33x/include/mach/debug-macro.S
deleted file mode 100644
index 52781ae..0000000
--- a/arch/arm/mach-iop33x/include/mach/debug-macro.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-iop33x/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- * Copyright (C) 1994-1999 Russell King
- * Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
deleted file mode 100644
index ff706fa..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
+++ /dev/null
@@ -1,12 +0,0 @@
-/* arch/arm/mach-ixp4xx/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-kirkwood/include/mach/debug-macro.S b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
deleted file mode 100644
index 011ec25..0000000
--- a/arch/arm/mach-kirkwood/include/mach/debug-macro.S
+++ /dev/null
@@ -1,8 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/include/mach/debug-macro.S
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
deleted file mode 100644
index c7bb4bc..0000000
--- a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * arch/arm/mach-lpc32xx/include/mach/debug-macro.S
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
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
- */
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
deleted file mode 100644
index c8284a2..0000000
--- a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
+++ /dev/null
@@ -1,8 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/include/mach/debug-macro.S
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-orion5x/include/mach/debug-macro.S b/arch/arm/mach-orion5x/include/mach/debug-macro.S
deleted file mode 100644
index 7489963..0000000
--- a/arch/arm/mach-orion5x/include/mach/debug-macro.S
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-rpc/include/mach/debug-macro.S b/arch/arm/mach-rpc/include/mach/debug-macro.S
deleted file mode 100644
index 88a575e..0000000
--- a/arch/arm/mach-rpc/include/mach/debug-macro.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/* arch/arm/mach-rpc/include/mach/debug-macro.S
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
-#include <asm/hardware/debug-8250.S>
-- 
1.7.4.4
