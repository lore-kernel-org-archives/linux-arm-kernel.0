From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Feb 2011 16:39:02 -0500
Subject: [PATCH 1/2] ARM: improvements to compressed/head.S
Message-ID: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of a conflict between the memory used by the compressed
kernel with its decompressor code and the memory used for the
decompressed kernel, we currently store the later after the former and
relocate it afterwards.

This would be more efficient to do this the other way around i.e.
relocate the compressed data up front instead, resulting in a smaller
copy.  That also has the advantage of making the code smaller and more
straight forward.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/head.S |  239 ++++++++++++++++++---------------------
 1 files changed, 110 insertions(+), 129 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 7193884..200625c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -174,9 +174,7 @@ not_angel:
 		 */
 
 		.text
-		adr	r0, LC0
-		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip}
-		ldr	sp, [r0, #28]
+
 #ifdef CONFIG_AUTO_ZRELADDR
 		@ determine final kernel image address
 		mov	r4, pc
@@ -185,35 +183,108 @@ not_angel:
 #else
 		ldr	r4, =zreladdr
 #endif
-		subs	r0, r0, r1		@ calculate the delta offset
 
-						@ if delta is zero, we are
-		beq	not_relocated		@ running at the address we
-						@ were linked at.
+		bl	cache_on
+
+restart:	adr	r0, LC0
+		ldmia	r0, {r1, r2, r3, r5, r6, r9, r11, r12}
+		ldr	sp, [r0, #32]
+
+		/*
+		 * We might be running at a different address.  We need
+		 * to fix up various pointers.
+		 */
+		sub	r0, r0, r1		@ calculate the delta offset
+		add	r5, r5, r0		@ _start
+		add	r6, r6, r0		@ _edata
 
+#ifndef CONFIG_ZBOOT_ROM
+		/* malloc space is above the relocated stack (64k max) */
+		add	sp, sp, r0
+		add	r10, sp, #0x10000
+#else
 		/*
-		 * We're running at a different address.  We need to fix
-		 * up various pointers:
-		 *   r5 - zImage base address (_start)
-		 *   r6 - size of decompressed image
-		 *   r11 - GOT start
-		 *   ip - GOT end
+		 * With ZBOOT_ROM the bss/stack is non relocatable,
+		 * but someone could still run this code from RAM,
+		 * in which case our reference is _edata.
 		 */
-		add	r5, r5, r0
+		mov	r10, r6
+#endif
+
+/*
+ * Check to see if we will overwrite ourselves.
+ *   r4  = final kernel address
+ *   r5  = start of this image
+ *   r9  = size of decompressed image
+ *   r10 = end of this image, including  bss/stack/malloc space if non XIP
+ * We basically want:
+ *   r4 >= r10 -> OK
+ *   r4 + image length <= r5 -> OK
+ */
+		cmp	r4, r10
+		bhs	wont_overwrite
+		add	r10, r4, r9
+		cmp	r10, r5
+		bls	wont_overwrite
+
+/*
+ * Relocate ourselves past the end of the decompressed kernel.
+ *   r5  = start of this image
+ *   r6  = _edata 
+ *   r10 = end of the decompressed kernel
+ * Because we always copy ahead, we need to do it from the end and go
+ * backward in case the source and destination overlap.
+ */
+		/* Round up to next 256-byte boundary. */
+		add	r10, r10, #256
+		bic	r10, r10, #255
+
+		sub	r9, r6, r5		@ size to copy
+		add	r9, r9, #31		@ rounded up to a multiple
+		bic	r9, r9, #31		@ ... of 32 bytes
+		add	r6, r9, r5
+		add	r9, r9, r10
+		
+1:		ldmdb	r6!, {r0 - r3, r10 - r12, lr}
+		cmp	r6, r5
+		stmdb	r9!, {r0 - r3, r10 - r12, lr}
+		bhi	1b
+
+		/* Preserve offset to relocated code. */
+		sub	r6, r9, r6
+
+		bl	cache_clean_flush
+
+		adr	r0, BSYM(restart)
+		add	r0, r0, r6
+		mov	pc, r0
+
+wont_overwrite:
+/*
+ * If delta is zero, we are running at the address we were linked at.
+ *   r0  = delta
+ *   r2  = BSS start
+ *   r3  = BSS end
+ *   r4  = kernel execution address
+ *   r7  = architecture ID
+ *   r8  = atags pointer
+ *   r11 = GOT start
+ *   r12 = GOT end
+ *   sp  = stack pointer
+ */
+		teq	r0, #0
+		beq	not_relocated
 		add	r11, r11, r0
-		add	ip, ip, r0
+		add	r12, r12, r0
 
 #ifndef CONFIG_ZBOOT_ROM
 		/*
 		 * If we're running fully PIC === CONFIG_ZBOOT_ROM = n,
 		 * we need to fix up pointers into the BSS region.
-		 *   r2 - BSS start
-		 *   r3 - BSS end
-		 *   sp - stack pointer
+		 * Note that the stack pointer has already been fixed up.
 		 */
 		add	r2, r2, r0
 		add	r3, r3, r0
-		add	sp, sp, r0
 
 		/*
 		 * Relocate all entries in the GOT table.
@@ -221,7 +292,7 @@ not_angel:
 1:		ldr	r1, [r11, #0]		@ relocate entries in the GOT
 		add	r1, r1, r0		@ table.  This fixes up the
 		str	r1, [r11], #4		@ C references.
-		cmp	r11, ip
+		cmp	r11, r12
 		blo	1b
 #else
 
@@ -234,7 +305,7 @@ not_angel:
 		cmphs	r3, r1			@ _end < entry
 		addlo	r1, r1, r0		@ table.  This fixes up the
 		str	r1, [r11], #4		@ C references.
-		cmp	r11, ip
+		cmp	r11, r12
 		blo	1b
 #endif
 
@@ -246,76 +317,24 @@ not_relocated:	mov	r0, #0
 		cmp	r2, r3
 		blo	1b
 
-		/*
-		 * The C runtime environment should now be setup
-		 * sufficiently.  Turn the cache on, set up some
-		 * pointers, and start decompressing.
-		 */
-		bl	cache_on
-
-		mov	r1, sp			@ malloc space above stack
-		add	r2, sp, #0x10000	@ 64k max
-
 /*
- * Check to see if we will overwrite ourselves.
- *   r4 = final kernel address
- *   r5 = start of this image
- *   r6 = size of decompressed image
- *   r2 = end of malloc space (and therefore this image)
- * We basically want:
- *   r4 >= r2 -> OK
- *   r4 + image length <= r5 -> OK
+ * The C runtime environment should now be setup sufficiently.
+ * Set up some pointers, and start decompressing.
+ *   r4  = kernel execution address
+ *   r7  = architecture ID
+ *   r8  = atags pointer
  */
-		cmp	r4, r2
-		bhs	wont_overwrite
-		add	r0, r4, r6
-		cmp	r0, r5
-		bls	wont_overwrite
-
-		mov	r5, r2			@ decompress after malloc space
-		mov	r0, r5
+		mov	r0, r4
+		mov	r1, sp			@ malloc space above stack
+		add	r2, sp, #0x10000	@ 64k max
 		mov	r3, r7
 		bl	decompress_kernel
-
-		add	r0, r0, #127 + 128	@ alignment + stack
-		bic	r0, r0, #127		@ align the kernel length
-/*
- * r0     = decompressed kernel length
- * r1-r3  = unused
- * r4     = kernel execution address
- * r5     = decompressed kernel start
- * r7     = architecture ID
- * r8     = atags pointer
- * r9-r12,r14 = corrupted
- */
-		add	r1, r5, r0		@ end of decompressed kernel
-		adr	r2, reloc_start
-		ldr	r3, LC1
-		add	r3, r2, r3
-1:		ldmia	r2!, {r9 - r12, r14}	@ copy relocation code
-		stmia	r1!, {r9 - r12, r14}
-		ldmia	r2!, {r9 - r12, r14}
-		stmia	r1!, {r9 - r12, r14}
-		cmp	r2, r3
-		blo	1b
-		mov	sp, r1
-		add	sp, sp, #128		@ relocate the stack
-
 		bl	cache_clean_flush
- ARM(		add	pc, r5, r0		) @ call relocation code
- THUMB(		add	r12, r5, r0		)
- THUMB(		mov	pc, r12			) @ call relocation code
-
-/*
- * We're not in danger of overwriting ourselves.  Do this the simple way.
- *
- * r4     = kernel execution address
- * r7     = architecture ID
- */
-wont_overwrite:	mov	r0, r4
-		mov	r3, r7
-		bl	decompress_kernel
-		b	call_kernel
+		bl	cache_off
+		mov	r0, #0			@ must be zero
+		mov	r1, r7			@ restore architecture number
+		mov	r2, r8			@ restore atags pointer
+		mov	pc, r4			@ call kernel
 
 		.align	2
 		.type	LC0, #object
@@ -323,11 +342,11 @@ LC0:		.word	LC0			@ r1
 		.word	__bss_start		@ r2
 		.word	_end			@ r3
 		.word	_start			@ r5
-		.word	_image_size		@ r6
+		.word	_edata			@ r6
+		.word	_image_size		@ r9
 		.word	_got_start		@ r11
 		.word	_got_end		@ ip
 		.word	user_stack_end		@ sp
-LC1:		.word	reloc_end - reloc_start
 		.size	LC0, . - LC0
 
 #ifdef CONFIG_ARCH_RPC
@@ -353,7 +372,7 @@ params:		ldr	r0, =0x10000100		@ params_phys for RPC
  * On exit,
  *  r0, r1, r2, r3, r9, r10, r12 corrupted
  * This routine must preserve:
- *  r4, r5, r6, r7, r8
+ *  r4, r7, r8
  */
 		.align	5
 cache_on:	mov	r3, #8			@ cache_on function
@@ -551,43 +570,6 @@ __common_mmu_cache_on:
 #endif
 
 /*
- * All code following this line is relocatable.  It is relocated by
- * the above code to the end of the decompressed kernel image and
- * executed there.  During this time, we have no stacks.
- *
- * r0     = decompressed kernel length
- * r1-r3  = unused
- * r4     = kernel execution address
- * r5     = decompressed kernel start
- * r7     = architecture ID
- * r8     = atags pointer
- * r9-r12,r14 = corrupted
- */
-		.align	5
-reloc_start:	add	r9, r5, r0
-		sub	r9, r9, #128		@ do not copy the stack
-		debug_reloc_start
-		mov	r1, r4
-1:
-		.rept	4
-		ldmia	r5!, {r0, r2, r3, r10 - r12, r14}	@ relocate kernel
-		stmia	r1!, {r0, r2, r3, r10 - r12, r14}
-		.endr
-
-		cmp	r5, r9
-		blo	1b
-		mov	sp, r1
-		add	sp, sp, #128		@ relocate the stack
-		debug_reloc_end
-
-call_kernel:	bl	cache_clean_flush
-		bl	cache_off
-		mov	r0, #0			@ must be zero
-		mov	r1, r7			@ restore architecture number
-		mov	r2, r8			@ restore atags pointer
-		mov	pc, r4			@ call kernel
-
-/*
  * Here follow the relocatable cache support functions for the
  * various processors.  This is a generic hook for locating an
  * entry and jumping to an instruction at the specified offset
@@ -791,7 +773,7 @@ proc_types:
  * On exit,
  *  r0, r1, r2, r3, r9, r12 corrupted
  * This routine must preserve:
- *  r4, r6, r7
+ *  r4, r7, r8
  */
 		.align	5
 cache_off:	mov	r3, #12			@ cache_off function
@@ -866,7 +848,7 @@ __armv3_mmu_cache_off:
  * On exit,
  *  r1, r2, r3, r9, r10, r11, r12 corrupted
  * This routine must preserve:
- *  r0, r4, r5, r6, r7
+ *  r4, r6, r7, r8
  */
 		.align	5
 cache_clean_flush:
@@ -1088,7 +1070,6 @@ memdump:	mov	r12, r0
 #endif
 
 		.ltorg
-reloc_end:
 
 		.align
 		.section ".stack", "aw", %nobits
-- 
1.7.4
