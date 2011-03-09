From: bones@secretlab.ca (John Bonesio)
Date: Wed, 09 Mar 2011 13:58:00 -0800
Subject: [PATCH] ARM:boot:device tree: Allow the device tree binary to be
	appended to zImage
Message-ID: <20110309215800.26377.43925.stgit@riker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides the ability to boot using a device tree that is appended
to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).

Signed-off-by: John Bonesio <bones@secretlab.ca>
---

 arch/arm/Kconfig                |    7 ++++
 arch/arm/boot/compressed/head.S |   75 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d8a330f..1a55e3e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1593,6 +1593,13 @@ config USE_OF
 	help
 	  Include support for flattened device tree machine descriptions.
 
+config ARM_APPENDED_DTB
+	bool "Use appended device tree blob"
+	depends on OF
+	help
+	  With this option, the boot code will look for a device tree binary
+	  (dtb) appended to zImage.
+
 # Compressed boot loader in ROM.  Yes, we really want to ask about
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 200625c..611719e 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -210,6 +210,58 @@ restart:	adr	r0, LC0
 		 */
 		mov	r10, r6
 #endif
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
 
 /*
  * Check to see if we will overwrite ourselves.
@@ -272,7 +324,8 @@ wont_overwrite:
  *   r12 = GOT end
  *   sp  = stack pointer
  */
-		teq	r0, #0
+		add	r1, r0, lr
+		teq	r1, #0
 		beq	not_relocated
 		add	r11, r11, r0
 		add	r12, r12, r0
@@ -288,12 +341,28 @@ wont_overwrite:
 
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
