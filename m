From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 22 Nov 2010 18:04:23 +0000
Subject: [PATCH v2 7/9] ARM: Thumb-2: Restore sensible zImage header layout
	for CONFIG_THUMB2_KERNEL
In-Reply-To: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1290449065-28843-8-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code which makes up the zImage header intends to leave a
32-byte gap followed by a branch to the real entry point, a
magic number, and a word containing the absolute entry point
address.

This gets messed up with with CONFIG_THUMB2_KERNEL, because the
size of the initial padding NOPs changes.

Instead, the header can be made fully compatible by restoring
it to ARM.

In the Thumb-2 case, we can replace the initial NOPs with a
sequence which switches to Thumb and jumps to the real entry
point.

As a consequence, the zImage entry point is now always ARM, so
no special magic is needed any more for the uImage rules in the
Thumb-2 case.

Applies on v2.6.37-rc3.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/Makefile          |    5 -----
 arch/arm/boot/compressed/head.S |    9 +++++++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 4a590f4..4d26f2c 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -70,12 +70,7 @@ else
 $(obj)/uImage: LOADADDR=$(ZRELADDR)
 endif
 
-ifeq ($(CONFIG_THUMB2_KERNEL),y)
-# Set bit 0 to 1 so that "mov pc, rx" switches to Thumb-2 mode
-$(obj)/uImage: STARTADDR=$(shell echo $(LOADADDR) | sed -e "s/.$$/1/")
-else
 $(obj)/uImage: STARTADDR=$(LOADADDR)
-endif
 
 $(obj)/uImage:	$(obj)/zImage FORCE
 	$(call if_changed,uimage)
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 1f65080..b342670 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -125,16 +125,21 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
  * sort out different calling conventions
  */
 		.align
+		.arm				@ Always enter in ARM state
 start:
 		.type	start,#function
-		.rept	8
+ THUMB(		adr	r12, BSYM(1f)	)
+ THUMB(		bx	r12		)
+ THUMB(		.rept	6		)
+ ARM(		.rept	8		)
 		mov	r0, r0
 		.endr
 
-		b	1f
+		nop				@ Pad magic number to 0x24
 		.word	0x016f2818		@ Magic numbers to help the loader
 		.word	start			@ absolute load/run zImage address
 		.word	_edata			@ zImage end address
+ THUMB(		.thumb			)
 1:		mov	r7, r1			@ save architecture ID
 		mov	r8, r2			@ save atags pointer
 
-- 
1.7.1
