From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 19 Jun 2014 19:26:34 +0400
Subject: [PATCH RESEND 2/5] ARM: clps711x: Move debug include into
 arch/arm/include/debug/
In-Reply-To: <1403191597-28460-1-git-send-email-shc_work@mail.ru>
References: <1403191597-28460-1-git-send-email-shc_work@mail.ru>
Message-ID: <1403191597-28460-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more step to allowing CLPS711X to participate in the
multi-platform defconfig.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig.debug                            |  1 +
 arch/arm/include/debug/clps711x.S                 | 38 +++++++++++++++++++++++
 arch/arm/mach-clps711x/include/mach/debug-macro.S | 38 -----------------------
 arch/arm/mach-clps711x/include/mach/hardware.h    |  2 +-
 4 files changed, 40 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/include/debug/clps711x.S
 delete mode 100644 arch/arm/mach-clps711x/include/mach/debug-macro.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595..a9176b9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -991,6 +991,7 @@ config DEBUG_STI_UART
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default "debug/clps711x.S" if DEBUG_CLPS711X_UART1 || DEBUG_CLPS711X_UART2
 	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
 	default "debug/efm32.S" if DEBUG_LL_UART_EFM32
diff --git a/arch/arm/include/debug/clps711x.S b/arch/arm/include/debug/clps711x.S
new file mode 100644
index 0000000..abe2254
--- /dev/null
+++ b/arch/arm/include/debug/clps711x.S
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef CONFIG_DEBUG_CLPS711X_UART2
+#define CLPS711X_UART_PADDR	(0x80000000 + 0x0000)
+#define CLPS711X_UART_VADDR	(0xfeff0000 + 0x0000)
+#else
+#define CLPS711X_UART_PADDR	(0x80000000 + 0x1000)
+#define CLPS711X_UART_VADDR	(0xfeff0000 + 0x1000)
+#endif
+
+#define SYSFLG		(0x0140)
+#define SYSFLG_UBUSY	(1 << 11)
+#define UARTDR		(0x0480)
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rv, =CLPS711X_UART_VADDR
+	ldr	\rp, =CLPS711X_UART_PADDR
+	.endm
+
+	.macro	waituart,rd,rx
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #UARTDR]
+	.endm
+
+	.macro	busyuart,rd,rx
+1001:	ldr	\rd, [\rx, #SYSFLG]
+	tst	\rd, #SYSFLG_UBUSY
+	bne	1001b
+	.endm
diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
deleted file mode 100644
index cb3684f..0000000
--- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
+++ /dev/null
@@ -1,38 +0,0 @@
-/* arch/arm/mach-clps711x/include/mach/debug-macro.S
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
-
-#include <mach/hardware.h>
-
-		.macro	addruart, rp, rv, tmp
-#ifndef CONFIG_DEBUG_CLPS711X_UART2
-		mov	\rp, #0x0000	@ UART1
-#else
-		mov	\rp, #0x1000	@ UART2
-#endif
-		orr	\rv, \rp, #CLPS711X_VIRT_BASE
-		orr	\rp, \rp, #CLPS711X_PHYS_BASE
-		.endm
-
-		.macro	senduart,rd,rx
-		str	\rd, [\rx, #0x0480]	@ UARTDR
-		.endm
-
-		.macro	waituart,rd,rx
-		.endm
-
-		.macro	busyuart,rd,rx
-1001:		ldr	\rd, [\rx, #0x0140]	@ SYSFLGx
-		tst	\rd, #1 << 11		@ UBUSYx
-		bne	1001b
-		.endm
-
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index 292cbcb..833129c 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -24,7 +24,7 @@
 
 #include <mach/clps711x.h>
 
-#define CLPS711X_VIRT_BASE	IOMEM(0xfe000000)
+#define CLPS711X_VIRT_BASE	IOMEM(0xfeff0000)
 
 #ifndef __ASSEMBLY__
 #define clps_readb(off)		readb(CLPS711X_VIRT_BASE + (off))
-- 
1.8.5.5
