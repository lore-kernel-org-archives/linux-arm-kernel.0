From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Nov 2010 13:14:31 +0000
Subject: [PATCH 1/7] ARM: kexec: Correct data alignment for
	CONFIG_THUMB2_KERNEL
Message-ID: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
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
 arch/arm/kernel/relocate_kernel.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index fd26f8d..9cf4cbf 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -59,6 +59,8 @@ relocate_new_kernel:
 	ldr r2,kexec_boot_atags
 	mov pc,lr
 
+	.align
+
 	.globl kexec_start_address
 kexec_start_address:
 	.long	0x0
-- 
1.7.1
