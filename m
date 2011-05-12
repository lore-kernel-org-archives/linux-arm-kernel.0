From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2011 05:59:52 -0700
Subject: [PATCH] ARM: Make sure appended device tree data won't overlap
	kernel BSS
In-Reply-To: <20110509144949.GE30958@atomide.com>
References: <alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com>
	<20110429102623.GX3755@atomide.com>
	<alpine.LFD.2.00.1104290909310.24613@xanadu.home>
	<20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
	<20110504072317.GU2092@atomide.com>
	<alpine.LFD.2.00.1105040936040.24613@xanadu.home>
	<20110509111929.GA11410@atomide.com>
	<20110509144949.GE30958@atomide.com>
Message-ID: <20110512125952.GN31483@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110509 07:47]:
> * Tony Lindgren <tony@atomide.com> [110509 14:16]:
> > Do this before relocating the compressed kernel + device tree data.
> > Otherwise we would have to split the copying into two parts, or copy
> > the device tree data twice.
> > 
> > As we only have one register available, pass the size of kernel BSS
> > via linker and do the following calculation using r1.
> 
> Blah, this still needs a bit more work.. The calculation is wrong
> and we can get multiple relocations now.

Here's a better version that also makes the stack usable early.
That might become handy for further changes.

Will still do a bit more testing on this on Friday.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 12 May 2011 05:29:49 -0700
Subject: [PATCH] ARM: Make sure appended device tree data won't overlap kernel BSS

Do this before relocating the compressed kernel + device tree data.
Otherwise we would have to split the copying into two parts, or copy
the device tree data twice.

As we only have one register available, pass the size of kernel BSS
via linker and do the calculation using r1, then save it to the stack.

Note that this patch now makes the stack also usable earlier for
CONFIG_ARM_APPENDED_DTB.

Not-Yet-Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -98,6 +98,9 @@ endif
 ccflags-y := -fpic -fno-builtin
 asflags-y := -Wa,-march=all
 
+# Supply kernel BSS size to the decompressor via a linker symbol.
+KBSS_SZ = $(shell size $(obj)/../../../../vmlinux | awk 'END{print $$3}')
+LDFLAGS_vmlinux = --defsym _kbss_sz=$(KBSS_SZ)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
 LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -266,6 +266,25 @@ restart:	adr	r0, LC0
 		add	lr, lr, #7
 		bic	lr, lr, #7
 
+		/*
+		 * Compensate for the appended device tree and make stack
+		 * usable. Note if the linker script changes so the stack is
+		 * not after the bss section, this code will be wrong.
+		 */
+		add	sp, sp, lr
+
+		/*
+		 * Calculate and save the offset between kernel BSS end and
+		 * device tree data start for later use to check they won't
+		 * overlap.
+		 */
+		adr	r1, kbss_sz
+		ldr	r1, [r1, #0]		@ kernel BSS size
+		add	r1, r1, r4		@ add inflated kernel start
+		add	r1, r1, r9		@ add inflated kernel size
+		sub	r1, r1, r6		@ kbss end - dt start
+		str	r1, [sp, #0]		@ save offset into stack
+
 		add	r10, r10, lr
 		add	r6, r6, lr
 dtb_check_done:
@@ -273,17 +292,29 @@ dtb_check_done:
 
 /*
  * Check to see if we will overwrite ourselves.
+ *   r1  = corrupted
  *   r4  = final kernel address
  *   r9  = size of decompressed image
  *   r10 = end of this image, including  bss/stack/malloc space if non XIP
  * We basically want:
  *   r4 - 16k page directory >= r10 -> OK
  *   r4 + image length <= current position (pc) -> OK
+ * For the appended device tree case, check that the device tree data does
+ * not overlap the kernel BSS area.
  */
 		add	r10, r10, #16384
 		cmp	r4, r10
 		bhs	wont_overwrite
 		add	r10, r4, r9
+#if defined(CONFIG_ARM_APPENDED_DTB)
+		cmp	lr, #0			@ device tree appended?
+		beq	no_kbss_check		@ no, skip check
+		ldr	r1, [sp, #0]		@ get kbss offset
+		add	r1, r10, r1		@ inflated end + kbss offset
+		cmp	r10, r1			@ DT start < kernel BSS end?
+		movlt	r10, r1			@ yes, move past kernel BSS end
+no_kbss_check:
+#endif
 		cmp	r10, pc
 		bls	wont_overwrite
 
@@ -331,6 +362,10 @@ dtb_check_done:
 		add	r0, r0, r6
 		mov	pc, r0
 
+#ifdef CONFIG_ARM_APPENDED_DTB
+kbss_sz:	.word	_kbss_sz		@ kernel BSS size
+#endif
+
 wont_overwrite:
 /*
  * If delta is zero, we are running@the address we were linked at.
@@ -376,13 +411,6 @@ wont_overwrite:
 		add	r2, r2, lr
 		add	r3, r3, lr
 
-		/*
-		 * bump the stack pinter
-		 *
- 		 * If the linker script changes so the stack is not after
-		 * the bss section, this code will be wrong.
-		 */
-		add	sp, sp, lr
 #else
 
 		/*
