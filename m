From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Sep 2011 01:41:42 -0400
Subject: [PATCH 2/6] ARM: zImage: Allow the appending of a device tree binary
In-Reply-To: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
Message-ID: <1315978906-15829-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

This patch provides the ability to boot using a device tree that is appended
to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).

Signed-off-by: John Bonesio <bones@secretlab.ca>
[nico: adjusted to latest zImage changes plus additional cleanups]
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig                |    8 ++++
 arch/arm/boot/compressed/head.S |   70 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5ebc5d922e..83323c2b1f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1781,6 +1781,14 @@ config ZBOOT_ROM_SH_MOBILE_SDHI
 
 endchoice
 
+config ARM_APPENDED_DTB
+	bool "Use appended device tree blob to zImage"
+	depends on OF && !ZBOOT_ROM
+	help
+	  With this option, the boot code will look for a device tree binary
+	  (dtb) appended to zImage
+	  (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
+
 config CMDLINE
 	string "Default kernel command string"
 	default ""
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index e95a598960..3ce5738ddb 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -216,6 +216,59 @@ restart:	adr	r0, LC0
 		mov	r10, r6
 #endif
 
+		mov	r5, #0			@ init dtb size to 0
+#ifdef CONFIG_ARM_APPENDED_DTB
+/*
+ *   r0  = delta
+ *   r2  = BSS start
+ *   r3  = BSS end
+ *   r4  = final kernel address
+ *   r5  = appended dtb size (still unknown)
+ *   r6  = _edata
+ *   r7  = architecture ID
+ *   r8  = atags/device tree pointer
+ *   r9  = size of decompressed image
+ *   r10 = end of this image, including  bss/stack/malloc space if non XIP
+ *   r11 = GOT start
+ *   r12 = GOT end
+ *   sp  = stack pointer
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
+		bne	dtb_check_done		@ not found
+
+		mov	r8, r6			@ use the appended device tree
+
+		/* Get the dtb's size */
+		ldr	r5, [r6, #4]
+#ifndef __ARMEB__
+		/* convert r5 (dtb size) to little endian */
+		eor	r1, r5, r5, ror #16
+		bic	r1, r1, #0x00ff0000
+		mov	r5, r5, ror #8
+		eor	r5, r5, r1, lsr #8
+#endif
+
+		/* preserve 64-bit alignment */
+		add	r5, r5, #7
+		bic	r5, r5, #7
+
+		/* relocate some pointers past the appended dtb */
+		add	r6, r6, r5
+		add	r10, r10, r5
+		add	sp, sp, r5
+dtb_check_done:
+#endif
+
 /*
  * Check to see if we will overwrite ourselves.
  *   r4  = final kernel address
@@ -285,14 +338,16 @@ wont_overwrite:
  *   r2  = BSS start
  *   r3  = BSS end
  *   r4  = kernel execution address
+ *   r5  = appended dtb size (0 if not present)
  *   r7  = architecture ID
  *   r8  = atags pointer
  *   r11 = GOT start
  *   r12 = GOT end
  *   sp  = stack pointer
  */
-		teq	r0, #0
+		orrs	r1, r0, r5
 		beq	not_relocated
+
 		add	r11, r11, r0
 		add	r12, r12, r0
 
@@ -307,12 +362,21 @@ wont_overwrite:
 
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
+		addhi	r1, r1, r5		@    entry += dtb size
+		str	r1, [r11], #4		@ next entry
 		cmp	r11, r12
 		blo	1b
+
+		/* bump our bss pointers too */
+		add	r2, r2, r5
+		add	r3, r3, r5
+
 #else
 
 		/*
-- 
1.7.7-rc0
