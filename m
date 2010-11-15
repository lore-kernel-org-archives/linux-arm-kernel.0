From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 15 Nov 2010 22:36:31 +0800
Subject: [PATCH 07/11] ARM: imx: Add support of uncompress print for i.MX28
In-Reply-To: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1289831795-4373-8-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoC i.MX28 uses DUART IP block as the debug serial. It adds the
support in the same file used by other i.MX SoC UART, and uses
variable is_duart to distinguish.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/plat-mxc/include/mach/uncompress.h |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 9dd9c20..adb617f 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -1,8 +1,9 @@
 /*
- *  arch/arm/plat-mxc/include/mach/uncompress.h
+ *  rch/arm/plat-mxc/include/mach/uncompress.h
  *
  *  Copyright (C) 1999 ARM Limited
  *  Copyright (C) Shane Nay (shane at minirl.com)
+ *  Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -22,14 +23,16 @@
 #include <asm/mach-types.h>
 
 static unsigned long uart_base;
+static unsigned short is_duart = 0;
 
 #define UART(x) (*(volatile unsigned long *)(uart_base + (x)))
 
-#define USR2 0x98
-#define USR2_TXFE (1<<14)
-#define TXR  0x40
-#define UCR1 0x80
-#define UCR1_UARTEN 1
+#define USR2		(is_duart ? 0x18 : 0x98)
+#define USR2_TXFE	(is_duart ? 1<<7 : 1<<14)
+#define USR2_BUSY	(1 << 3)
+#define TXR		(is_duart ? 0x00 : 0x40)
+#define UCR1		(is_duart ? 0x30 : 0x80)
+#define UCR1_UARTEN	1
 
 /*
  * The following code assumes the serial port has already been
@@ -59,6 +62,7 @@ static inline void flush(void)
 
 #define MX1_UART1_BASE_ADDR	0x00206000
 #define MX25_UART1_BASE_ADDR	0x43f90000
+#define MX28_DUART_BASE_ADDR	0x80074000
 #define MX2X_UART1_BASE_ADDR	0x1000a000
 #define MX3X_UART1_BASE_ADDR	0x43F90000
 #define MX3X_UART2_BASE_ADDR	0x43F94000
@@ -83,6 +87,10 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_MXT_TD60:
 		uart_base = MX2X_UART1_BASE_ADDR;
 		break;
+	case MACH_TYPE_MX28EVK:
+		uart_base = MX28_DUART_BASE_ADDR;
+		is_duart = 1;
+		break;
 	case MACH_TYPE_MX31LITE:
 	case MACH_TYPE_ARMADILLO5X0:
 	case MACH_TYPE_MX31MOBOARD:
-- 
1.7.1
