From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 23:12:56 +0100
Subject: [PATCH 4/6] ARM: l7200: remove zombie file
In-Reply-To: <1363299178-8241-1-git-send-email-arnd@arndb.de>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
Message-ID: <1363299178-8241-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The l7200 platform was removed in 2.6.35, but one file came
back due to a failed merge conflict resolution. Let's kill
it again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-l7200/include/mach/debug-macro.S | 38 --------------------------
 1 file changed, 38 deletions(-)
 delete mode 100644 arch/arm/mach-l7200/include/mach/debug-macro.S

diff --git a/arch/arm/mach-l7200/include/mach/debug-macro.S b/arch/arm/mach-l7200/include/mach/debug-macro.S
deleted file mode 100644
index 0b4e760..0000000
--- a/arch/arm/mach-l7200/include/mach/debug-macro.S
+++ /dev/null
@@ -1,38 +0,0 @@
-/* arch/arm/mach-l7200/include/mach/debug-macro.S
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
-		.equ	io_virt, IO_BASE
-		.equ	io_phys, IO_START
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0x00044000	@ UART1
-@		mov	\rp, #0x00045000	@ UART2
-		add	\rv, \rp, #io_virt	@ virtual address
-		add	\rp, \rp, #io_phys	@ physical base address
-		.endm
-
-		.macro	senduart,rd,rx
-		str	\rd, [\rx, #0x0]	@ UARTDR
-		.endm
-
-		.macro	waituart,rd,rx
-1001:		ldr	\rd, [\rx, #0x18]	@ UARTFLG
-		tst	\rd, #1 << 5		@ UARTFLGUTXFF - 1 when full
-		bne	1001b
-		.endm
-
-		.macro	busyuart,rd,rx
-1001:		ldr	\rd, [\rx, #0x18]	@ UARTFLG
-		tst	\rd, #1 << 3		@ UARTFLGUBUSY - 1 when busy
-		bne	1001b
-		.endm
-- 
1.8.1.2
