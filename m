From: js@sig21.net (Johannes Stezenbach)
Date: Mon, 29 Oct 2012 16:18:32 +0100
Subject: [PATCH] fix DEBUG_LL DCC race condition
Message-ID: <20121029151832.GA2162@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to boot a kernel with I- and D-caches disabled
sometimes hangs when DEBUG_LL output to DCC is enabled.
Apparently the JTAG debugger sometimes reads the
DCC register before busyuart could see the wDTRfull flag,
thus busyuart spins in an endless loop.

The reason seems to be a misunderstanding of the purpose
of the busyuart macro.  For UART, waituart waits until
there is space in the FIFO, and busyuart waits until
the FIFO is empty (all data is sent).
For DCC, busyuart should be identical to waituart since
there is no FIFO.

Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
Only tested on ARMv6.
e.g. arch/arm/mach-at91/include/mach/debug-macro.S has some
comments which clarify what busyuart is supposed to be doing.

diff --git a/arch/arm/include/debug/icedcc.S b/arch/arm/include/debug/icedcc.S
index 43afcb0..7204064 100644
--- a/arch/arm/include/debug/icedcc.S
+++ b/arch/arm/include/debug/icedcc.S
@@ -21,10 +21,7 @@
 		.endm
 
 		.macro	busyuart, rd, rx
-1001:
-		mrc	p14, 0, \rx, c0, c1, 0
-		tst	\rx, #0x20000000
-		beq	1001b
+		waituart \rd, \rx
 		.endm
 
 		.macro	waituart, rd, rx
@@ -45,10 +42,7 @@
 		.endm
 
 		.macro	busyuart, rd, rx
-1001:
-		mrc	p14, 0, \rx, c14, c0, 0
-		tst	\rx, #0x10000000
-		beq	1001b
+		waituart \rd, \rx
 		.endm
 
 		.macro	waituart, rd, rx
@@ -69,11 +63,7 @@
 		.endm
 
 		.macro	busyuart, rd, rx
-1001:
-		mrc	p14, 0, \rx, c0, c0, 0
-		tst	\rx, #2
-		beq	1001b
-
+		waituart \rd, \rx
 		.endm
 
 		.macro	waituart, rd, rx
