From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Sep 2011 01:41:43 -0400
Subject: [PATCH 3/6] ARM: zImage: make sure appended DTB doesn't get
	overwritten by kernel .bss
In-Reply-To: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
Message-ID: <1315978906-15829-4-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

The appended DTB gets relocated with the decompressor code to get out
of the way of the decompressed kernel.  However the kernel's .bss section
may be larger than the relocated code and data, and then the DTB gets
overwritten.  Let's make sure the relocation takes care of moving zImage
far enough so no such conflict with .bss occurs.

Thanks to Tony Lindgren <tony@atomide.com> for figuring out this issue.

While at it, let's clean up the code a bit so that the wont_overwrite
symbol is used while determining if a conflict exists, making the above
change more precise as well as eliminating some ARM/THUMB alternates.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/compressed/Makefile |    3 +++
 arch/arm/boot/compressed/head.S   |   19 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 0c74a6fab9..4867647b97 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -104,6 +104,9 @@ endif
 ccflags-y := -fpic -fno-builtin
 asflags-y := -Wa,-march=all
 
+# Supply kernel BSS size to the decompressor via a linker symbol.
+KBSS_SZ = $(shell size $(obj)/../../../../vmlinux | awk 'END{print $$3}')
+LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
 LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 3ce5738ddb..ba5c552f8c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -248,6 +248,18 @@ restart:	adr	r0, LC0
 
 		mov	r8, r6			@ use the appended device tree
 
+		/*
+		 * Make sure that the DTB doesn't end up in the final
+		 * kernel's .bss area. To do so, we adjust the decompressed
+		 * kernel size to compensate if that .bss size is larger
+		 * than the relocated code.
+		 */
+		ldr	r5, =_kernel_bss_size
+		adr	r1, wont_overwrite
+		sub	r1, r6, r1
+		subs	r1, r5, r1
+		addhi	r9, r9, r1
+
 		/* Get the dtb's size */
 		ldr	r5, [r6, #4]
 #ifndef __ARMEB__
@@ -276,15 +288,14 @@ dtb_check_done:
  *   r10 = end of this image, including  bss/stack/malloc space if non XIP
  * We basically want:
  *   r4 - 16k page directory >= r10 -> OK
- *   r4 + image length <= current position (pc) -> OK
+ *   r4 + image length <= address of wont_overwrite -> OK
  */
 		add	r10, r10, #16384
 		cmp	r4, r10
 		bhs	wont_overwrite
 		add	r10, r4, r9
-   ARM(		cmp	r10, pc		)
- THUMB(		mov	lr, pc		)
- THUMB(		cmp	r10, lr		)
+		adr	r9, wont_overwrite
+		cmp	r10, r9
 		bls	wont_overwrite
 
 /*
-- 
1.7.7-rc0
