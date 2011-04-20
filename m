From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 20 Apr 2011 00:15:02 -0400
Subject: [PATCH 1/3] ARM: zImage: no need to get the decompressed size from the
	filesystem
In-Reply-To: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1303272904-31392-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit d239b1dc093d the hardcoded 4x estimate for the decompressed
kernel size was replaced by the exact Image file size and passed to
the linker as a symbol value.  Turns out that this is unneeded as the
size is already included at the end of the compressed piggy data.
For those compressed formats that don't include this data, the build
system already takes care of appending it using size_append in
scripts/Makefile.lib.  So let's use that instead.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/Makefile |    2 --
 arch/arm/boot/compressed/head.S   |   18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 8ebbb51..58ac434 100644
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
index adf583c..c74f048 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -179,7 +179,7 @@ not_angel:
 		bl	cache_on
 
 restart:	adr	r0, LC0
-		ldmia	r0, {r1, r2, r3, r5, r6, r9, r11, r12}
+		ldmia	r0, {r1, r2, r3, r5, r6, r10, r11, r12}
 		ldr	sp, [r0, #32]
 
 		/*
@@ -189,7 +189,21 @@ restart:	adr	r0, LC0
 		sub	r0, r0, r1		@ calculate the delta offset
 		add	r5, r5, r0		@ _start
 		add	r6, r6, r0		@ _edata
+		add	r10, r10, r0		@ inflated kernel size location
 
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
+		
 #ifndef CONFIG_ZBOOT_ROM
 		/* malloc space is above the relocated stack (64k max) */
 		add	sp, sp, r0
@@ -335,7 +349,7 @@ LC0:		.word	LC0			@ r1
 		.word	_end			@ r3
 		.word	_start			@ r5
 		.word	_edata			@ r6
-		.word	_image_size		@ r9
+		.word	input_data_end - 4	@ r9 (inflated size location)
 		.word	_got_start		@ r11
 		.word	_got_end		@ ip
 		.word	user_stack_end		@ sp
-- 
1.7.4
