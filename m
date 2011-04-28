From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:20 -0400
Subject: [PATCH 5/9] ARM: zImage: no need to get the decompressed size from the
	filesystem
In-Reply-To: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
Message-ID: <1304031024-5121-6-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

In commit d239b1dc093d the hardcoded 4x estimate for the decompressed
kernel size was replaced by the exact Image file size and passed to
the linker as a symbol value.  Turns out that this is unneeded as the
size is already included at the end of the compressed piggy data.
For those compressed formats that don't include this data, the build
system already takes care of appending it using size_append in
scripts/Makefile.lib.  So let's use that instead.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/compressed/Makefile |    2 --
 arch/arm/boot/compressed/head.S   |   18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 0c6852d..79b5c62 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -98,8 +98,6 @@ endif
 ccflags-y := -fpic -fno-builtin
 asflags-y := -Wa,-march=all
 
-# Provide size of uncompressed kernel to the decompressor via a linker symbol.
-LDFLAGS_vmlinux = --defsym _image_size=$(shell stat -c "%s" $(obj)/../Image)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
 LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4c50490..b6eb643 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -187,7 +187,7 @@ not_angel:
 		bl	cache_on
 
 restart:	adr	r0, LC0
-		ldmia	r0, {r1, r2, r3, r6, r9, r11, r12}
+		ldmia	r0, {r1, r2, r3, r6, r10, r11, r12}
 		ldr	sp, [r0, #28]
 
 		/*
@@ -196,6 +196,20 @@ restart:	adr	r0, LC0
 		 */
 		sub	r0, r0, r1		@ calculate the delta offset
 		add	r6, r6, r0		@ _edata
+		add	r10, r10, r0		@ inflated kernel size location
+
+		/*
+		 * The kernel build system appends the size of the
+		 * decompressed kernel at the end of the compressed data
+		 * in little-endian form.
+		 */
+		ldrb	r9, [r10, #0]
+		ldrb	lr, [r10, #1]
+		orr	r9, r9, lr, lsl #8
+		ldrb	lr, [r10, #2]
+		ldrb	r10, [r10, #3]
+		orr	r9, r9, lr, lsl #16
+		orr	r9, r9, r10, lsl #24
 
 #ifndef CONFIG_ZBOOT_ROM
 		/* malloc space is above the relocated stack (64k max) */
@@ -353,7 +367,7 @@ LC0:		.word	LC0			@ r1
 		.word	__bss_start		@ r2
 		.word	_end			@ r3
 		.word	_edata			@ r6
-		.word	_image_size		@ r9
+		.word	input_data_end - 4	@ r10 (inflated size location)
 		.word	_got_start		@ r11
 		.word	_got_end		@ ip
 		.word	user_stack_end		@ sp
-- 
1.7.4
