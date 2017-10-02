From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun,  1 Oct 2017 22:06:16 -0400
Subject: [PATCH 1/3] ARM: debug.S: move hexbuf to a writable section
In-Reply-To: <20171002020618.23924-1-nicolas.pitre@linaro.org>
References: <20171002020618.23924-1-nicolas.pitre@linaro.org>
Message-ID: <20171002020618.23924-2-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was located in .text which is meant to be read-only. And in the XIP
case this shortcut simply doesn't work and may trigger a Flash controller
mode switch and crash the kernel. Move it to the .bss area.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/debug.S | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index ea9646cc2a..423f443258 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -55,7 +55,9 @@ ENDPROC(printhex4)
 
 ENTRY(printhex2)
 		mov	r1, #2
-printhex:	adr	r2, hexbuf
+printhex:	adr	r2, hexbuf_rel
+		ldr	r3, [r2]
+		add	r2, r2, r3
 		add	r3, r2, r1
 		mov	r1, #0
 		strb	r1, [r3]
@@ -71,7 +73,11 @@ printhex:	adr	r2, hexbuf
 		b	printascii
 ENDPROC(printhex2)
 
-hexbuf:		.space 16
+		.pushsection .bss
+hexbuf_addr:	.space 16
+		.popsection
+		.align
+hexbuf_rel:	.long	hexbuf_addr - .
 
 		.ltorg
 
@@ -120,7 +126,9 @@ ENTRY(printascii)
 ENDPROC(printascii)
 
 ENTRY(printch)
-		adr	r1, hexbuf
+		adr	r1, hexbuf_rel
+		ldr	r2, [r1]
+		add	r1, r1, r2
 		strb	r0, [r1]
 		mov	r0, #0x03		@ SYS_WRITEC
 	ARM(	svc	#0x123456	)
-- 
2.9.5
