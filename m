From: l.stelmach@samsung.com (=?UTF-8?q?=C5=81ukasz=20Stelmach?=)
Date: Fri, 23 Mar 2018 11:36:16 +0100
Subject: [PATCH] ARM: decompressor: add a missing parameter to the addruart
 macro
References: <CGME20180323103618eucas1p22b042fbfef32fb36d9723993ec749d1b@eucas1p2.samsung.com>
Message-ID: <20180323103616.24426-1-l.stelmach@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 639da5ee374b an additional temporary register was added
to the addruart macro, but the decompressor code wasn't updated.

Signed-off-by: ?ukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/head.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 45c8823c3750..182bf6add0b9 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -29,19 +29,19 @@
 #if defined(CONFIG_DEBUG_ICEDCC)
 
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c0, c5, 0
 		.endm
 #elif defined(CONFIG_CPU_XSCALE)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c8, c0, 0
 		.endm
 #else
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c1, c0, 0
@@ -57,7 +57,7 @@
 		.endm
 
 #if defined(CONFIG_ARCH_SA1100)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		mov	\rb, #0x80000000	@ physical base address
 #ifdef CONFIG_DEBUG_LL_SER3
 		add	\rb, \rb, #0x00050000	@ Ser3
@@ -66,8 +66,8 @@
 #endif
 		.endm
 #else
-		.macro	loadsp,	rb, tmp
-		addruart \rb, \tmp
+		.macro	loadsp,	rb, tmp1, tmp2
+		addruart \rb, \tmp1, \tmp2
 		.endm
 #endif
 #endif
@@ -1297,7 +1297,7 @@ phex:		adr	r3, phexbuf
 		b	1b
 
 @ puts corrupts {r0, r1, r2, r3}
-puts:		loadsp	r3, r1
+puts:		loadsp	r3, r2, r1
 1:		ldrb	r2, [r0], #1
 		teq	r2, #0
 		moveq	pc, lr
@@ -1314,8 +1314,8 @@ puts:		loadsp	r3, r1
 @ putc corrupts {r0, r1, r2, r3}
 putc:
 		mov	r2, r0
+		loadsp	r3, r1, r0
 		mov	r0, #0
-		loadsp	r3, r1
 		b	2b
 
 @ memdump corrupts {r0, r1, r2, r3, r10, r11, r12, lr}
-- 
2.11.0
