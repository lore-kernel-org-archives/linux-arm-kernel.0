From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:18 -0400
Subject: [PATCH 3/9] ARM: zImage: make sure not to relocate on top of the
	relocation code
In-Reply-To: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
Message-ID: <1304031024-5121-4-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

If the zImage load address is slightly below the relocation address,
there is a risk for the copied data to overwrite the copy loop or
cache flush code that the relocation process requires.  Always
bump the relocation address by the size of that code to avoid this
issue.

Noticed by Tony Lindgren <tony@atomide.com>.

While at it, let's start the copy from the restart symbol which makes
the above code size computation possible by the assembler directly,
given that we don't need to preserve the code before that point anyway.
And therefore we don't need to carry the _start pointer in r5 anymore.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/head.S |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 55a5bcb..6dae179 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -187,15 +187,14 @@ not_angel:
 		bl	cache_on
 
 restart:	adr	r0, LC0
-		ldmia	r0, {r1, r2, r3, r5, r6, r9, r11, r12}
-		ldr	sp, [r0, #32]
+		ldmia	r0, {r1, r2, r3, r6, r9, r11, r12}
+		ldr	sp, [r0, #28]
 
 		/*
 		 * We might be running at a different address.  We need
 		 * to fix up various pointers.
 		 */
 		sub	r0, r0, r1		@ calculate the delta offset
-		add	r5, r5, r0		@ _start
 		add	r6, r6, r0		@ _edata
 
 #ifndef CONFIG_ZBOOT_ROM
@@ -214,31 +213,37 @@ restart:	adr	r0, LC0
 /*
  * Check to see if we will overwrite ourselves.
  *   r4  = final kernel address
- *   r5  = start of this image
  *   r9  = size of decompressed image
  *   r10 = end of this image, including  bss/stack/malloc space if non XIP
  * We basically want:
  *   r4 >= r10 -> OK
- *   r4 + image length <= r5 -> OK
+ *   r4 + image length <= current position (pc) -> OK
  */
 		cmp	r4, r10
 		bhs	wont_overwrite
 		add	r10, r4, r9
-		cmp	r10, r5
+		cmp	r10, pc
 		bls	wont_overwrite
 
 /*
  * Relocate ourselves past the end of the decompressed kernel.
- *   r5  = start of this image
  *   r6  = _edata
  *   r10 = end of the decompressed kernel
  * Because we always copy ahead, we need to do it from the end and go
  * backward in case the source and destination overlap.
  */
-		/* Round up to next 256-byte boundary. */
-		add	r10, r10, #256
+		/*
+		 * Bump to the next 256-byte boundary with the size of
+		 * the relocation code added. This avoids overwriting
+		 * ourself when the offset is small.
+		 */
+		add	r10, r10, #((reloc_code_end - restart + 256) & ~255)
 		bic	r10, r10, #255
 
+		/* Get start of code we want to copy and align it down. */
+		adr	r5, restart
+		bic	r5, r5, #31
+
 		sub	r9, r6, r5		@ size to copy
 		add	r9, r9, #31		@ rounded up to a multiple
 		bic	r9, r9, #31		@ ... of 32 bytes
@@ -346,7 +351,6 @@ not_relocated:	mov	r0, #0
 LC0:		.word	LC0			@ r1
 		.word	__bss_start		@ r2
 		.word	_end			@ r3
-		.word	_start			@ r5
 		.word	_edata			@ r6
 		.word	_image_size		@ r9
 		.word	_got_start		@ r11
@@ -1075,6 +1079,7 @@ memdump:	mov	r12, r0
 #endif
 
 		.ltorg
+reloc_code_end:
 
 		.align
 		.section ".stack", "aw", %nobits
-- 
1.7.4
