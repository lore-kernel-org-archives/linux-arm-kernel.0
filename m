From: bones@secretlab.ca (John Bonesio)
Date: Wed, 26 Jan 2011 13:23:14 -0800
Subject: [RFC 1/2] ARM:boot:device tree: Allow the device tree binary to be
	appended to zImage
In-Reply-To: <20110126212220.6723.28773.stgit@riker>
References: <20110126212220.6723.28773.stgit@riker>
Message-ID: <20110126212301.6723.89059.stgit@riker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides the ability to boot using a device tree that is appended
to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).

Constraints:
1) A maximum 16k device tree binary is copied to memory at 0x0. If the device
   tree is bigger than 16k, the kernel will probably fail ungracefully - unless
   there is a device tree already embedded in the zImage.

Signed-off-by: John Bonesio <bones@secretlab.ca>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/arm/Kconfig                |    7 +++++
 arch/arm/boot/compressed/head.S |   52 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d8a330f..e63a441 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1593,6 +1593,13 @@ config USE_OF
 	help
 	  Include support for flattened device tree machine descriptions.
 
+config ARM_APPENDED_DTB
+	bool "Use appended device tree blob" if OF
+	default n
+	help
+	  With this option, the boot code will look for a dtb bianry
+	  appended to zImage.
+
 # Compressed boot loader in ROM.  Yes, we really want to ask about
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 7193884..db860b3 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -138,7 +138,7 @@ start:
 		b	1f
 		.word	0x016f2818		@ Magic numbers to help the loader
 		.word	start			@ absolute load/run zImage address
-		.word	_edata			@ zImage end address
+DTB:		.word	_edata			@ zImage end address
  THUMB(		.thumb			)
 1:		mov	r7, r1			@ save architecture ID
 		mov	r8, r2			@ save atags pointer
@@ -173,6 +173,9 @@ not_angel:
 		 * by the linker here, but it should preserve r7, r8, and r9.
 		 */
 
+		/* Check if there is an appended device tree binary */
+		ldr	r10, DTB			@ get the address of _dtb
+
 		.text
 		adr	r0, LC0
 		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip}
@@ -196,10 +199,12 @@ not_angel:
 		 * up various pointers:
 		 *   r5 - zImage base address (_start)
 		 *   r6 - size of decompressed image
+		 *   r10 - zImage end
 		 *   r11 - GOT start
 		 *   ip - GOT end
 		 */
 		add	r5, r5, r0
+		add	r10, r10, r0
 		add	r11, r11, r0
 		add	ip, ip, r0
 
@@ -215,6 +220,7 @@ not_angel:
 		add	r3, r3, r0
 		add	sp, sp, r0
 
+
 		/*
 		 * Relocate all entries in the GOT table.
 		 */
@@ -238,7 +244,49 @@ not_angel:
 		blo	1b
 #endif
 
-not_relocated:	mov	r0, #0
+not_relocated:
+#ifdef CONFIG_ARM_APPENDED_DTB
+		/*
+		 * Check if there is an appended device tree binary, by testing
+		 * for the device tree magic signature
+		 *
+		 * An appended device tree will be at the end of the zImage
+		 */
+		ldr	r1, [r10, #0]
+		ldr	r9, =0xedfe0dd0	@ sig is 0xdoodfeed stored big endian
+		cmp	r1, r9
+		bne	keep_atags
+
+		/* copy the device tree binary to 0x0 */
+		ldr	r9, [r10, #4]	@ device tree size
+
+		/* convert r9 (dtb size) to little endian */
+		eor	r1, r9, r9, ror #16
+		bic	r1, r1, #0x00ff0000
+		mov	r9, r9, ror #8
+		eor	r9, r9, r1, lsr #8
+
+		/* make sure the device tree isn't too big */
+		mov	r0, #16384
+		cmp	r9, r0
+		bhi	keep_atags
+
+		mov	r0, r2
+		mov	r1, #0x0
+		add	r9, r1		@ size to address from target location
+1:
+		.rept	4
+		ldmia	r0!, {r10}	@ relocate device tree
+		stmia	r1!, {r10}
+		.endr
+		cmp	r1, r9
+		blo	1b
+		mov	r8, #0x0
+
+keep_atags:
+#endif
+
+__not_relocated:	mov	r0, #0
 1:		str	r0, [r2], #4		@ clear bss
 		str	r0, [r2], #4
 		str	r0, [r2], #4
