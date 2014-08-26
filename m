From: kpark3469@gmail.com (kpark3469 at gmail.com)
Date: Tue, 26 Aug 2014 17:30:15 +0900
Subject: [PATCH] ARM: compressed/head.S: use addruart properly
Message-ID: <1409041815-8766-1-git-send-email-kpark3469@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sahara <keun-o.park@windriver.com>

This patch fixes compile error in compressed/head.S, when DEBUG
is defined. Since addruart macro accepts 3 params, rp, rv, and tmp,
loadsp macro also needs to be fixed. Or you will meet the following
error messages:
Error: ARM register expected -- `mov ,#(5<<1)'
Error: shift expression expected -- `add r3,r3,'

Signed-off-by: Sahara <keun-o.park@windriver.com>
---
 arch/arm/boot/compressed/head.S |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 413fd94..9f1a6cd 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -24,19 +24,19 @@
 #if defined(CONFIG_DEBUG_ICEDCC)
 
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rp, rv, tmp
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c0, c5, 0
 		.endm
 #elif defined(CONFIG_CPU_XSCALE)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rp, rv, tmp
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c8, c0, 0
 		.endm
 #else
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rp, rv, tmp
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c1, c0, 0
@@ -52,17 +52,17 @@
 		.endm
 
 #if defined(CONFIG_ARCH_SA1100)
-		.macro	loadsp, rb, tmp
-		mov	\rb, #0x80000000	@ physical base address
+		.macro	loadsp, rp, rv, tmp
+		mov	\rp, #0x80000000	@ physical base address
 #ifdef CONFIG_DEBUG_LL_SER3
-		add	\rb, \rb, #0x00050000	@ Ser3
+		add	\rp, \rp, #0x00050000	@ Ser3
 #else
-		add	\rb, \rb, #0x00010000	@ Ser1
+		add	\rp, \rp, #0x00010000	@ Ser1
 #endif
 		.endm
 #else
-		.macro	loadsp,	rb, tmp
-		addruart \rb, \tmp
+		.macro	loadsp,	rp, rv, tmp
+		addruart \rp, \rv, \tmp
 		.endm
 #endif
 #endif
@@ -1209,7 +1209,7 @@ phex:		adr	r3, phexbuf
 		b	1b
 
 @ puts corrupts {r0, r1, r2, r3}
-puts:		loadsp	r3, r1
+puts:		loadsp	r3, r2, r1
 1:		ldrb	r2, [r0], #1
 		teq	r2, #0
 		moveq	pc, lr
@@ -1225,9 +1225,9 @@ puts:		loadsp	r3, r1
 		mov	pc, lr
 @ putc corrupts {r0, r1, r2, r3}
 putc:
+		loadsp	r3, r2, r1
 		mov	r2, r0
 		mov	r0, #0
-		loadsp	r3, r1
 		b	2b
 
 @ memdump corrupts {r0, r1, r2, r3, r10, r11, r12, lr}
-- 
1.7.9.5
