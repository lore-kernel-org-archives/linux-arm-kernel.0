From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 23:48:45 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <alpine.LFD.2.00.1002251420160.1946@xanadu.home>
References: <20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
	<20100225122429.GA3101@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002251420160.1946@xanadu.home>
Message-ID: <20100225234845.GH24043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 02:24:01PM -0500, Nicolas Pitre wrote:
> However...
> 
> > @@ -14,6 +14,7 @@ SECTIONS
> >    /DISCARD/ : {
> >      *(.ARM.exidx*)
> >      *(.ARM.extab*)
> > +    *(.data)
> >    }
> 
> I'd put a comment there, otherwise lots of people will go WTF when 
> coming across this.

Unfortunately, the decompressor in ROM mode has been subtly broken for
a while - since 2552fc2.

This assumes 'sp' is the end of the image, which for ROM=n, is fine.
However, for ROM=y, this most definitely is wrong, so this patch is
needed.

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 99b75aa..6b7205a 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -170,8 +170,8 @@ not_angel:
 
 		.text
 		adr	r0, LC0
- ARM(		ldmia	r0, {r1, r2, r3, r4, r5, r6, ip, sp}	)
- THUMB(		ldmia	r0, {r1, r2, r3, r4, r5, r6, ip}	)
+ ARM(		ldmia	r0, {r1, r2, r3, r4, r5, r6, r11, ip, sp})
+ THUMB(		ldmia	r0, {r1, r2, r3, r4, r5, r6, r11, ip}	)
  THUMB(		ldr	sp, [r0, #28]				)
 		subs	r0, r0, r1		@ calculate the delta offset
 
@@ -182,12 +182,14 @@ not_angel:
 		/*
 		 * We're running at a different address.  We need to fix
 		 * up various pointers:
-		 *   r5 - zImage base address
-		 *   r6 - GOT start
+		 *   r5 - zImage base address (_start)
+		 *   r6 - end of zImage text (_etext)
+		 *   r11 - GOT start
 		 *   ip - GOT end
 		 */
 		add	r5, r5, r0
 		add	r6, r6, r0
+		add	r11, r11, r0
 		add	ip, ip, r0
 
 #ifndef CONFIG_ZBOOT_ROM
@@ -205,10 +207,10 @@ not_angel:
 		/*
 		 * Relocate all entries in the GOT table.
 		 */
-1:		ldr	r1, [r6, #0]		@ relocate entries in the GOT
+1:		ldr	r1, [r11, #0]		@ relocate entries in the GOT
 		add	r1, r1, r0		@ table.  This fixes up the
-		str	r1, [r6], #4		@ C references.
-		cmp	r6, ip
+		str	r1, [r11], #4		@ C references.
+		cmp	r11, ip
 		blo	1b
 #else
 
@@ -216,12 +218,12 @@ not_angel:
 		 * Relocate entries in the GOT table.  We only relocate
 		 * the entries that are outside the (relocated) BSS region.
 		 */
-1:		ldr	r1, [r6, #0]		@ relocate entries in the GOT
+1:		ldr	r1, [r11, #0]		@ relocate entries in the GOT
 		cmp	r1, r2			@ entry < bss_start ||
 		cmphs	r3, r1			@ _end < entry
 		addlo	r1, r1, r0		@ table.  This fixes up the
-		str	r1, [r6], #4		@ C references.
-		cmp	r6, ip
+		str	r1, [r11], #4		@ C references.
+		cmp	r11, ip
 		blo	1b
 #endif
 
@@ -247,6 +249,7 @@ not_relocated:	mov	r0, #0
  * Check to see if we will overwrite ourselves.
  *   r4 = final kernel address
  *   r5 = start of this image
+ *   r6 = end of this image's text segment
  *   r2 = end of malloc space (and therefore this image)
  * We basically want:
  *   r4 >= r2 -> OK
@@ -254,8 +257,8 @@ not_relocated:	mov	r0, #0
  */
 		cmp	r4, r2
 		bhs	wont_overwrite
-		sub	r3, sp, r5		@ > compressed kernel size
-		add	r0, r4, r3, lsl #2	@ allow for 4x expansion
+		sub	r3, r6, r5		@ (_etext-_start) =~ compressed
+		add	r0, r4, r3, lsl #2	@ kernel size, allow for 4x expansion
 		cmp	r0, r5
 		bls	wont_overwrite
 
@@ -271,7 +274,6 @@ not_relocated:	mov	r0, #0
  * r1-r3  = unused
  * r4     = kernel execution address
  * r5     = decompressed kernel start
- * r6     = processor ID
  * r7     = architecture ID
  * r8     = atags pointer
  * r9-r12,r14 = corrupted
@@ -312,7 +314,8 @@ LC0:		.word	LC0			@ r1
 		.word	_end			@ r3
 		.word	zreladdr		@ r4
 		.word	_start			@ r5
-		.word	_got_start		@ r6
+		.word	_end			@ r6
+		.word	_got_start		@ r11
 		.word	_got_end		@ ip
 		.word	user_stack+4096		@ sp
 LC1:		.word	reloc_end - reloc_start
@@ -336,7 +339,6 @@ params:		ldr	r0, =params_phys
  *
  * On entry,
  *  r4 = kernel execution address
- *  r6 = processor ID
  *  r7 = architecture number
  *  r8 = atags pointer
  *  r9 = run-time address of "start"  (???)
@@ -542,7 +544,6 @@ __common_mmu_cache_on:
  * r1-r3  = unused
  * r4     = kernel execution address
  * r5     = decompressed kernel start
- * r6     = processor ID
  * r7     = architecture ID
  * r8     = atags pointer
  * r9-r12,r14 = corrupted
@@ -581,19 +582,19 @@ call_kernel:	bl	cache_clean_flush
  *  r1  = corrupted
  *  r2  = corrupted
  *  r3  = block offset
- *  r6  = corrupted
+ *  r9  = corrupted
  *  r12 = corrupted
  */
 
 call_cache_fn:	adr	r12, proc_types
 #ifdef CONFIG_CPU_CP15
-		mrc	p15, 0, r6, c0, c0	@ get processor ID
+		mrc	p15, 0, r9, c0, c0	@ get processor ID
 #else
-		ldr	r6, =CONFIG_PROCESSOR_ID
+		ldr	r9, =CONFIG_PROCESSOR_ID
 #endif
 1:		ldr	r1, [r12, #0]		@ get value
 		ldr	r2, [r12, #4]		@ get mask
-		eor	r1, r1, r6		@ (real ^ match)
+		eor	r1, r1, r9		@ (real ^ match)
 		tst	r1, r2			@       & mask
  ARM(		addeq	pc, r12, r3		) @ call cache function
  THUMB(		addeq	r12, r3			)
@@ -778,8 +779,7 @@ proc_types:
  * Turn off the Cache and MMU.  ARMv3 does not support
  * reading the control register, but ARMv4 does.
  *
- * On entry,  r6 = processor ID
- * On exit,   r0, r1, r2, r3, r12 corrupted
+ * On exit, r0, r1, r2, r3, r9, r12 corrupted
  * This routine must preserve: r4, r6, r7
  */
 		.align	5
@@ -852,10 +852,8 @@ __armv3_mmu_cache_off:
 /*
  * Clean and flush the cache to maintain consistency.
  *
- * On entry,
- *  r6 = processor ID
  * On exit,
- *  r1, r2, r3, r11, r12 corrupted
+ *  r1, r2, r3, r9, r11, r12 corrupted
  * This routine must preserve:
  *  r0, r4, r5, r6, r7
  */
@@ -967,7 +965,7 @@ __armv4_mmu_cache_flush:
 		mov	r2, #64*1024		@ default: 32K dcache size (*2)
 		mov	r11, #32		@ default: 32 byte line size
 		mrc	p15, 0, r3, c0, c0, 1	@ read cache type
-		teq	r3, r6			@ cache ID register present?
+		teq	r3, r9			@ cache ID register present?
 		beq	no_cache_id
 		mov	r1, r3, lsr #18
 		and	r1, r1, #7
