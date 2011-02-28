From: bones@secretlab.ca (John Bonesio)
Date: Mon, 28 Feb 2011 15:33:27 -0800
Subject: [PATCH 1/4] ARM:boot:device tree: Allow the device tree binary to be
	appended to zImage
In-Reply-To: <20110228233153.24836.24176.stgit@riker>
References: <20110228233153.24836.24176.stgit@riker>
Message-ID: <20110228233327.24836.94530.stgit@riker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides the ability to boot using a device tree that is appended
to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).

Signed-off-by: John Bonesio <bones@secretlab.ca>
---

 arch/arm/Kconfig                |    7 +++
 arch/arm/boot/compressed/head.S |   93 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d8a330f..68fc640 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1593,6 +1593,13 @@ config USE_OF
 	help
 	  Include support for flattened device tree machine descriptions.
 
+config ARM_APPENDED_DTB
+       bool "Use appended device tree blob" if OF
+       default n
+       help
+         With this option, the boot code will look for a dtb bianry
+         appended to zImage.
+
 # Compressed boot loader in ROM.  Yes, we really want to ask about
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 200625c..ae9f8c6 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -210,6 +210,46 @@ restart:	adr	r0, LC0
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
+		ldr	r12, [r6, #0]
+		ldr	r1, =0xedfe0dd0		@ sig is 0xdoodfeed big endian
+		cmp	r12, r1
+		bne	dtb_check_done
+
+		/* Get the dtb's size */
+		ldr	r12, [r6, #4]		@ device tree size
+
+		/* convert r12 (dtb size) to little endian */
+		eor	r1, r12, r12, ror #16
+		bic	r1, r1, #0x00ff0000
+		mov	r12, r12, ror #8
+		eor	r12, r12, r1, lsr #8
+
+		add	r10, r10, r12
+		add	r6, r6, r12
+
+dtb_check_done:
+		adr	r1, LC0
+		ldr	r12, [r1, #28]		@ restore r12 (GOT end)
+#endif
 
 /*
  * Check to see if we will overwrite ourselves.
@@ -223,8 +263,8 @@ restart:	adr	r0, LC0
  */
 		cmp	r4, r10
 		bhs	wont_overwrite
-		add	r10, r4, r9
-		cmp	r10, r5
+		add	r1, r4, r9
+		cmp	r1, r5
 		bls	wont_overwrite
 
 /*
@@ -272,8 +312,10 @@ wont_overwrite:
  *   r12 = GOT end
  *   sp  = stack pointer
  */
-		teq	r0, #0
-		beq	not_relocated
+		adr	r1, LC0
+		ldr	r6, [r1, #16]		@ reload _edata value
+
+		add	r6, r6, r0
 		add	r11, r11, r0
 		add	r12, r12, r0
 
@@ -288,12 +330,34 @@ wont_overwrite:
 
 		/*
 		 * Relocate all entries in the GOT table.
+		 * Bump bss entries to past image end (r10)
 		 */
+		sub	r5, r10, r6		@ delta of image end and _edata
+		add	r5, r5, #7		@ ... rounded up to a multiple
+		bic	r5, r5, #7		@ ... of 8 bytes, so misaligned
+		             	 		@ ... GOT entry doesn't
+		             	 		@ ... overwrite end of image
+
 1:		ldr	r1, [r11, #0]		@ relocate entries in the GOT
 		add	r1, r1, r0		@ table.  This fixes up the
+		cmp	r1, r2
+		movcc	r9, #0			@ r9 = entry < bss_start ? 0 :
+		movcs	r9, #1			@      1;
+		cmp	r1, r3
+		movcs	r9, #0			@ r9 = entry >= end ? 0 : t1;
+		cmp	r9, #0
+		addne	r1, r5			@ entry += r9 ? bss delta : 0;
 		str	r1, [r11], #4		@ C references.
 		cmp	r11, r12
 		blo	1b
+
+		/* bump our bss registers too */
+		add	r2, r2, r5
+		add	r3, r3, r5
+
+		/* bump the stack pinter, if at or above _edata */
+		cmp	sp, r6
+		addcs	sp, sp, r5
 #else
 
 		/*
@@ -309,7 +373,7 @@ wont_overwrite:
 		blo	1b
 #endif
 
-not_relocated:	mov	r0, #0
+		mov	r0, #0
 1:		str	r0, [r2], #4		@ clear bss
 		str	r0, [r2], #4
 		str	r0, [r2], #4
@@ -317,8 +381,25 @@ not_relocated:	mov	r0, #0
 		cmp	r2, r3
 		blo	1b
 
+#ifdef CONFIG_ARM_APPENDED_DTB
+/*
+ * The C runtime environment should now be set up sufficiently.
+ *   r4  = kernel execution address
+ *   r6  = _edata
+ *   r7  = architecture ID
+ *   r8  = atags pointer
+ *
+ * if there is a device tree (dtb) appended to zImage, set up to use this dtb.
+ */
+		ldr	r0, [r6, #0]
+		ldr	r1, =0xedfe0dd0		@ sig is 0xdoodfeed big endian
+		cmp	r0, r1
+		bne	keep_atags
+
+		mov	r8, r6			@ use the appended device tree
+keep_atags:
+#endif
 /*
- * The C runtime environment should now be setup sufficiently.
  * Set up some pointers, and start decompressing.
  *   r4  = kernel execution address
  *   r7  = architecture ID
