From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Nov 2010 13:14:34 +0000
Subject: [PATCH 4/7] ARM: Thumb-2: Correct data alignment for
	CONFIG_THUMB2_KERNEL in kernel/head.S
In-Reply-To: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1289913277-8822-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Directives such as .long and .word do not magically cause the
assembler location counter to become aligned in gas.  As a
result, using these directives in code sections can result in
misaligned data words when building a Thumb-2 kernel
(CONFIG_THUMB2_KERNEL).

This is a Bad Thing, since the ABI permits the compiler to
assume that fundamental types of word size or above are word-
aligned when accessing them from C.  If the data is not really
word-aligned, this can cause impaired performance and stray
alignment faults in some circumstances.

In general, the following rules should be applied when using
data word declaration directives inside code sections:

    * .quad and .double:
         .align 3

    * .long, .word, .single, .float:
         .align (or .align 2)

    * .short:
        No explicit alignment required, since Thumb-2
        instructions are always 2 or 4 bytes in size.
        immediately after an instruction.

Applies cleanly on v2.6.37-rc1.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/head.S |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index dd6b369..591c097 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -262,6 +262,7 @@ __create_page_tables:
 	mov	pc, lr
 ENDPROC(__create_page_tables)
 	.ltorg
+	.align
 __enable_mmu_loc:
 	.long	.
 	.long	__enable_mmu
@@ -308,6 +309,8 @@ ENTRY(__secondary_switched)
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
 
+	.align
+
 	.type	__secondary_data, %object
 __secondary_data:
 	.long	.
@@ -413,6 +416,7 @@ __fixup_smp_on_up:
 	mov	pc, lr
 ENDPROC(__fixup_smp)
 
+	.align
 1:	.word	.
 	.word	__smpalt_begin
 	.word	__smpalt_end
-- 
1.7.1
