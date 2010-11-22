From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 22 Nov 2010 18:04:19 +0000
Subject: [PATCH v2 3/9] ARM: Thumb-2: Correct data alignment for
	CONFIG_THUMB2_KERNEL in bootp/init.S
In-Reply-To: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1290449065-28843-4-git-send-email-dave.martin@linaro.org>
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
 arch/arm/boot/bootp/init.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/bootp/init.S b/arch/arm/boot/bootp/init.S
index 8b0de41..78b5080 100644
--- a/arch/arm/boot/bootp/init.S
+++ b/arch/arm/boot/bootp/init.S
@@ -73,6 +73,8 @@ move:		ldmia	r4!, {r7 - r10}		@ move 32-bytes at a time
 
 		.size	_start, . - _start
 
+		.align
+
 		.type	data,#object
 data:		.word	initrd_start		@ source initrd address
 		.word	initrd_phys		@ destination initrd address
-- 
1.7.1
