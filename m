From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 22 Nov 2010 18:04:18 +0000
Subject: [PATCH v2 2/9] ARM: vfp: Correct data alignment for
	CONFIG_THUMB2_KERNEL
In-Reply-To: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1290449065-28843-3-git-send-email-dave.martin@linaro.org>
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
 arch/arm/vfp/vfphw.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index d66cead..9897dcf 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -206,6 +206,7 @@ ENTRY(vfp_save_state)
 	mov	pc, lr
 ENDPROC(vfp_save_state)
 
+	.align
 last_VFP_context_address:
 	.word	last_VFP_context
 
-- 
1.7.1
