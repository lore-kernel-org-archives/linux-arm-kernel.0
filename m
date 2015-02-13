From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Fri, 13 Feb 2015 13:48:49 +0100
Subject: [RFC PATCH] ARM: LL_DEBUG: Fix hang on i.MX53 when wrong port
 selected.
Message-ID: <20150213124849.22919.14204.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Attempts to access the i.MX53 UART data registers while the UART
is not enabled cause the processor to hang.

This can occur when CONFIG_LL_DEBUG is selected but
CONFIG_DEBUG_IMX_UART_PORT does not correspond to the
port enabled by the bootloader.

So, do not attempt to send any data if the port is not enabled.

Checking the enabled bit requires an extra scratch register.
For the moment I have only added this to the imx version.
Obviously, if this solution is acceptable, the register would have to be
added to all the other implementations too in order to avoid breaking
the build.

Hence RFC status for the moment to see if there are any better ideas.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 arch/arm/boot/compressed/debug.S |    2 +-
 arch/arm/boot/compressed/head.S  |   16 ++++++++--------
 arch/arm/include/debug/imx.S     |   10 ++++++++--
 arch/arm/kernel/debug.S          |    2 +-
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/compressed/debug.S b/arch/arm/boot/compressed/debug.S
index 5392ee6..1f83297 100644
--- a/arch/arm/boot/compressed/debug.S
+++ b/arch/arm/boot/compressed/debug.S
@@ -8,7 +8,7 @@
 ENTRY(putc)
 	addruart r1, r2, r3
 	waituart r3, r1
-	senduart r0, r1
+	senduart r0, r1, r3
 	busyuart r3, r1
 	mov	 pc, lr
 ENDPROC(putc)
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 132c70e..0a02301 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -26,19 +26,19 @@
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
 		.macro	loadsp, rb, tmp
 		.endm
-		.macro	writeb, ch, rb
+		.macro	writeb, ch, rb, tmp
 		mcr	p14, 0, \ch, c0, c5, 0
 		.endm
 #elif defined(CONFIG_CPU_XSCALE)
 		.macro	loadsp, rb, tmp
 		.endm
-		.macro	writeb, ch, rb
+		.macro	writeb, ch, rb, tmp
 		mcr	p14, 0, \ch, c8, c0, 0
 		.endm
 #else
 		.macro	loadsp, rb, tmp
 		.endm
-		.macro	writeb, ch, rb
+		.macro	writeb, ch, rb, tmp
 		mcr	p14, 0, \ch, c1, c0, 0
 		.endm
 #endif
@@ -47,8 +47,8 @@
 
 #include CONFIG_DEBUG_LL_INCLUDE
 
-		.macro	writeb,	ch, rb
-		senduart \ch, \rb
+		.macro	writeb,	ch, rb, tmp
+		senduart \ch, \rb, \tmp
 		.endm
 
 #if defined(CONFIG_ARCH_SA1100)
@@ -870,7 +870,7 @@ proc_types:
 		W(b)	__armv3_mpu_cache_on
 		W(b)	__armv3_mpu_cache_off
 		W(b)	__armv3_mpu_cache_flush
-		
+
 		.word	0x41009400		@ ARM94x
 		.word	0xff00ff00
 		W(b)	__armv4_mpu_cache_on
@@ -1084,7 +1084,7 @@ __armv4_mpu_cache_flush:
 		mcrne	p15, 0, ip, c7, c5, 0	@ invalidate I cache
 		mcr	p15, 0, ip, c7, c10, 4	@ drain WB
 		mov	pc, lr
-		
+
 __fa526_cache_flush:
 		tst	r4, #1
 		movne	pc, lr
@@ -1246,7 +1246,7 @@ puts:		loadsp	r3, r1
 1:		ldrb	r2, [r0], #1
 		teq	r2, #0
 		moveq	pc, lr
-2:		writeb	r2, r3
+2:		writeb	r2, r3, r1
 		mov	r1, #0x00020000
 3:		subs	r1, r1, #1
 		bne	3b
diff --git a/arch/arm/include/debug/imx.S b/arch/arm/include/debug/imx.S
index 619d8cc..a04821c 100644
--- a/arch/arm/include/debug/imx.S
+++ b/arch/arm/include/debug/imx.S
@@ -33,8 +33,14 @@
 		ldr	\rv, =UART_VADDR	@ virtual
 		.endm
 
-		.macro	senduart,rd,rx
-		str	\rd, [\rx, #0x40]	@ TXDATA
+		.macro	senduart,rd,rx, tmp
+/*
+ * Data registers only accessible if uart enabled.
+ * Check to prevent hangs if bootloader config does not match
+ */
+		ldr	\tmp, [\rx, #0x80]	@ CR1
+		tst	\tmp, #1
+		strne	\rd, [\rx, #0x40]	@ TXDATA
 		.endm
 
 		.macro	waituart,rd,rx
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index 78c91b5..5a360ab 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -81,7 +81,7 @@ ENTRY(printascii)
 		addruart_current r3, r1, r2
 		b	2f
 1:		waituart r2, r3
-		senduart r1, r3
+		senduart r1, r3, r2
 		busyuart r2, r3
 		teq	r1, #'\n'
 		moveq	r1, #'\r'
