From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Nov 2010 13:14:37 +0000
Subject: [PATCH 7/7] ARM: Thumb-2: Restore sensible zImage header layout for
	CONFIG_THUMB2_KERNEL
In-Reply-To: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1289913277-8822-7-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code which makes up the zImage header clearly intends to
leave a vector-table-sized gap of 8 words (NOPs, in fact),
followed by a branch to the real entry point, a magic number,
and a word containing the absolute entry point address.

This gets messed up with with CONFIG_THUMB2_KERNEL:

    * The NOPs making up the vector table become halfword-
      sized.

    * The magic number and absolute entry point occur too early
      and become misaligned.

    * The absolute entry point fails to indicate that the entry
      point is Thumb code, which will cause incorrect execution
      if the bootloader uses this to enter the kernel.

This patch makes sure the same layout is generated in the
CONFIG_THUMB2_KERNEL case as in the traditional ARM case, and
sets the Thumb bit (bit 0) in the entry point field.  The ARM
case is unaffected.

This is my best guess as to how the zImage should be laid out
for Thumb-2.  U-Boot in particular uses its own metadata and
ignores the zImage header fields.

If someone knows of a bootloader or other utility which relies
on the strange existing Thumb-2 zImage header layout then this
may require more careful thought.

Applies cleanly on v2.6.37-rc1.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/boot/compressed/head.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 1f65080..1e36e2a 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -128,12 +128,12 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 start:
 		.type	start,#function
 		.rept	8
-		mov	r0, r0
+		W(nop)				@ use 32-bit NOPs for correct padding
 		.endr
 
-		b	1f
+		W(b)	1f
 		.word	0x016f2818		@ Magic numbers to help the loader
-		.word	start			@ absolute load/run zImage address
+		.word	BSYM(start)		@ absolute load/run zImage address
 		.word	_edata			@ zImage end address
 1:		mov	r7, r1			@ save architecture ID
 		mov	r8, r2			@ save atags pointer
-- 
1.7.1
