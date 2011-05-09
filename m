From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 May 2011 04:19:30 -0700
Subject: [PATCH] ARM: Make sure appended device tree data won't overlap
	kernel BSS
In-Reply-To: <alpine.LFD.2.00.1105040936040.24613@xanadu.home>
References: <20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com>
	<20110429102623.GX3755@atomide.com>
	<alpine.LFD.2.00.1104290909310.24613@xanadu.home>
	<20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
	<20110504072317.GU2092@atomide.com>
	<alpine.LFD.2.00.1105040936040.24613@xanadu.home>
Message-ID: <20110509111929.GA11410@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do this before relocating the compressed kernel + device tree data.
Otherwise we would have to split the copying into two parts, or copy
the device tree data twice.

As we only have one register available, pass the size of kernel BSS
via linker and do the following calculation using r1.

Signed-off-by: Tony Lindgren <tony@atomide.com>

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
@@ -273,17 +273,35 @@ dtb_check_done:
 
 /*
  * Check to see if we will overwrite ourselves.
+ *   r1  = corrupted
  *   r4  = final kernel address
+ *   r5  = start of this image
+ *   r6  = _edata
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
+		cmp	lr, #0
+		beq	no_kbss_check
+		adr	r1, kbss
+		ldr	r1, [r1, #0]		@ kernel BSS size, _kbss_sz
+		add	r1, r10, r1		@ inflated kernel end + kbss
+		sub	r1, r1, r5		@ minus start of this data
+		add	r1, r1, r6		@ plus end of this data
+		sub	r1, r1, lr		@ minus size of DT data
+		cmp	r10, r1			@ DT start < kernel BSS end?
+		movlt	r10, r1			@ yes, move past kernel BSS end
+no_kbss_check:
+#endif
 		cmp	r10, pc
 		bls	wont_overwrite
 
@@ -331,6 +349,8 @@ dtb_check_done:
 		add	r0, r0, r6
 		mov	pc, r0
 
+kbss:		.word	_kbss_sz
+
 wont_overwrite:
 /*
  * If delta is zero, we are running@the address we were linked at.
