From: bones@secretlab.ca (John Bonesio)
Date: Mon, 21 Mar 2011 15:19:45 -0700
Subject: [PATCH v2] ARM:boot:device tree: Allow the device tree binary to be
	appended to zImage
Message-ID: <20110321221930.19756.36549.stgit@riker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides the ability to boot using a device tree that is appended
to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).

Signed-off-by: John Bonesio <bones@secretlab.ca>
---

 arch/arm/Kconfig                |    7 ++++
 arch/arm/boot/compressed/head.S |   78 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92bae09..3556aea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1651,6 +1651,13 @@ config ZBOOT_ROM
 	  Say Y here if you intend to execute your compressed kernel image
 	  (zImage) directly from ROM or flash.  If unsure, say N.
 
+config ARM_APPENDED_DTB
+	bool "Use appended device tree blob"
+	depends on OF && !ZBOOT_ROM
+	help
+	  With this option, the boot code will look for a device tree binary
+	  (dtb) appended to zImage.
+
 config CMDLINE
 	string "Default kernel command string"
 	default ""
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 200625c..4f8bd65 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -211,6 +211,61 @@ restart:	adr	r0, LC0
 		mov	r10, r6
 #endif
 
+		mov	lr, #0			@ init lr (dtb size) to 0
+#ifdef CONFIG_ARM_APPENDED_DTB
+/*
+ *   r0  = delta
+ *   r2  = BSS start
+ *   r3  = BSS end
+ *   r4  = final kernel address
+ *   r5  = start of this image
+ *   r6  = _edata
+ *   r7  = architecture ID
+ *   r8  = atags/device tree pointer
+ *   r9  = size of decompressed image
+ *   r10 = end of this image, including  bss/stack/malloc space if non XIP
+ *   r11 = GOT start
+ *   r12 = GOT end
+ *
+ * if there are device trees (dtb) appended to zImage, advance r10 so that the
+ * dtb data will get relocated along with the kernel if necessary.
+ */
+
+		ldr	lr, [r6, #0]
+#ifndef __ARMEB__
+		ldr	r1, =0xedfe0dd0		@ sig is 0xd00dfeed big endian
+#else
+		ldr	r1, =0xd00dfeed
+#endif
+		cmp	lr, r1
+		mov	lr, #0			@ dtb not found, it's size is 0
+		bne	dtb_check_done
+
+		mov	r8, r6			@ use the appended device tree
+
+		/* Get the dtb's size */
+		ldr	lr, [r6, #4]
+
+#ifndef __ARMEB__
+		/* convert lr (dtb size) to little endian */
+		eor	r1, lr, lr, ror #16
+		bic	r1, r1, #0x00ff0000
+		mov	lr, lr, ror #8
+		eor	lr, lr, r1, lsr #8
+#endif
+		/*
+		 * dtb size rounded up to a multiple of 8 bytes so a
+		 * misaligned GOT entry doesn't cause the end of the
+		 * dtb binary to be overwritten.
+		 */
+		add	lr, lr, #7
+		bic	lr, lr, #7
+
+		add	r10, r10, lr
+		add	r6, r6, lr
+dtb_check_done:
+#endif
+
 /*
  * Check to see if we will overwrite ourselves.
  *   r4  = final kernel address
@@ -271,8 +326,9 @@ wont_overwrite:
  *   r11 = GOT start
  *   r12 = GOT end
  *   sp  = stack pointer
+ *   lr  = appended dtb size (0 if not present)
  */
-		teq	r0, #0
+		orrs	r1, r0, lr
 		beq	not_relocated
 		add	r11, r11, r0
 		add	r12, r12, r0
@@ -288,12 +344,28 @@ wont_overwrite:
 
 		/*
 		 * Relocate all entries in the GOT table.
+		 * Bump bss entries to _edata + dtb size
 		 */
 1:		ldr	r1, [r11, #0]		@ relocate entries in the GOT
-		add	r1, r1, r0		@ table.  This fixes up the
-		str	r1, [r11], #4		@ C references.
+		add	r1, r1, r0		@ This fixes up C references
+		cmp	r1, r2			@ if entry >= bss_start &&
+		cmphs	r3, r1			@       bss_end > entry
+		addhi	r1, lr			@    entry += dtb size
+		str	r1, [r11], #4		@ next entry
 		cmp	r11, r12
 		blo	1b
+
+		/* bump our bss registers too */
+		add	r2, r2, lr
+		add	r3, r3, lr
+
+		/*
+		 * bump the stack pinter
+		 *
+ 		 * If the linker script changes so the stack is not after
+		 * the bss section, this code will be wrong.
+		 */
+		add	sp, sp, lr
 #else
 
 		/*
