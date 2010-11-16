From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Nov 2010 13:14:35 +0000
Subject: [PATCH 5/7] ARM: Thumb-2: Correct data alignment for
	CONFIG_THUMB2_KERNEL in mm/proc-v7.S
In-Reply-To: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1289913277-8822-5-git-send-email-dave.martin@linaro.org>
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

In this specific case, we can achieve the desired alignment by
forcing a 32-bit branch instruction using the W() macro,
since the assembler location counter is already 32-bit aligned in this case.

Applies cleanly on v2.6.37-rc1.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v7.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 53cbe22..9b9ff5d 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -381,7 +381,7 @@ __v7_ca9mp_proc_info:
 		PMD_SECT_XN | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__v7_ca9mp_setup
+	W(b)	__v7_ca9mp_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
@@ -413,7 +413,7 @@ __v7_proc_info:
 		PMD_SECT_XN | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__v7_setup
+	W(b)	__v7_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
-- 
1.7.1
