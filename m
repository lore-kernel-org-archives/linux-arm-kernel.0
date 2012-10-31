From: js@sig21.net (Johannes Stezenbach)
Date: Wed, 31 Oct 2012 18:25:54 +0100
Subject: [PATCH v2] fix DEBUG_LL DCC race condition
In-Reply-To: <20121031170853.GA20498@sig21.net>
References: <20121029151832.GA2162@sig21.net>
 <20121031163615.GQ21164@n2100.arm.linux.org.uk>
 <20121031170853.GA20498@sig21.net>
Message-ID: <20121031172553.GA20949@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to boot a kernel with I- and D-caches disabled
sometimes hangs when DEBUG_LL output to DCC is enabled.
Apparently the JTAG debugger sometimes reads the
DCC register before the current busyuart implementation
could see the wDTRfull flag, thus busyuart spins in an endless loop.

The reason seems to be a misunderstanding of the purpose
of the busyuart macro.  For UART, waituart should wait
until flow control allows to send the character, or do
nothing.  busyuart should wait until the FIFO is empty
(all data is sent).
For DCC, busyuart should wait until the JTAG debugger has
read the DCC register (wait for wDTRfull == 0 on ARMv6), and
waituart does nothing.

Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
v2:
- update description
- waituart is empty (no flow control)

diff --git a/arch/arm/include/debug/icedcc.S b/arch/arm/include/debug/icedcc.S
index 43afcb0..30e18e5 100644
--- a/arch/arm/include/debug/icedcc.S
+++ b/arch/arm/include/debug/icedcc.S
@@ -21,13 +21,6 @@
 		.endm
 
 		.macro	busyuart, rd, rx
-1001:
-		mrc	p14, 0, \rx, c0, c1, 0
-		tst	\rx, #0x20000000
-		beq	1001b
-		.endm
-
-		.macro	waituart, rd, rx
 		mov	\rd, #0x2000000
 1001:
 		subs	\rd, \rd, #1
@@ -38,6 +31,9 @@
 1002:
 		.endm
 
+		.macro	waituart, rd, rx
+		.endm
+
 #elif defined(CONFIG_CPU_XSCALE)
 
 		.macro	senduart, rd, rx
@@ -45,13 +41,6 @@
 		.endm
 
 		.macro	busyuart, rd, rx
-1001:
-		mrc	p14, 0, \rx, c14, c0, 0
-		tst	\rx, #0x10000000
-		beq	1001b
-		.endm
-
-		.macro	waituart, rd, rx
 		mov	\rd, #0x10000000
 1001:
 		subs	\rd, \rd, #1
@@ -62,6 +51,9 @@
 1002:
 		.endm
 
+		.macro	waituart, rd, rx
+		.endm
+
 #else
 
 		.macro	senduart, rd, rx
@@ -69,14 +61,6 @@
 		.endm
 
 		.macro	busyuart, rd, rx
-1001:
-		mrc	p14, 0, \rx, c0, c0, 0
-		tst	\rx, #2
-		beq	1001b
-
-		.endm
-
-		.macro	waituart, rd, rx
 		mov	\rd, #0x2000000
 1001:
 		subs	\rd, \rd, #1
@@ -87,4 +71,7 @@
 1002:
 		.endm
 
+		.macro	waituart, rd, rx
+		.endm
+
 #endif	/* CONFIG_CPU_V6 */
