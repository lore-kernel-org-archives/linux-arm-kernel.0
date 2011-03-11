From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 11 Mar 2011 14:29:19 +0000
Subject: [PATCH v2 REPOST] ARM: Thumb-2: Add local symbols to work around gas
	behaviour
Message-ID: <1299853760-3041-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All current versions of gas at the time of writing have issues
fixing up pc-relative instructions which reference global symbols,
due to the potential need to support symbol preemption.
Even though symbol preemption is not relevant to the Linux kernel,
there is no way to inform the tools of this, so we get the problem.

Most pc-relative forms in ARM, and all pc-relative forms in
Thumb, will cause the assembler to fail with various fixup error
messages when used to reference global symbols.

The legacy behaviour is for ADR and plain LDR instructions in ARM
which reference global symbols to be fixed up silently with no
relocation emitted.  This means that building the kernel in ARM
currently works without problems, but this behaviour may be a bug.

After discussion with Richard Earnshaw, it seems that there is
no single obvious remedy for this inconsistent behaviour,
so there is not likely to be a comprehensive upstream fix for
a while.

A workaround which should be valid for all past and all
foreseeable future versions of gas is to express the need for
a local fixup explicitly, by declaring a shadow local symbol
for any global symbol which needs to be addressed using ADR
or any pc-relative LDR variant.

This patch implements this workaround for the one part of the
main kernel currently known to be affected.  The resulting code
builds and works correctly in ARM and Thumb.

Similar fixes may be needed in mach-specific assembler.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
v2: Use .L* local symbols to avoid polluting the symbol table

 arch/arm/kernel/relocate_kernel.S |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index 9cf4cbf..ec0320c 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -7,8 +7,8 @@
 	.globl relocate_new_kernel
 relocate_new_kernel:
 
-	ldr	r0,kexec_indirection_page
-	ldr	r1,kexec_start_address
+	ldr	r0,.Lkexec_indirection_page
+	ldr	r1,.Lkexec_start_address
 
 	/*
 	 * If there is no indirection page (we are doing crashdumps)
@@ -55,27 +55,31 @@ relocate_new_kernel:
 	/* Jump to relocated kernel */
 	mov lr,r1
 	mov r0,#0
-	ldr r1,kexec_mach_type
-	ldr r2,kexec_boot_atags
+	ldr r1,.Lkexec_mach_type
+	ldr r2,.Lkexec_boot_atags
 	mov pc,lr
 
 	.align
 
 	.globl kexec_start_address
 kexec_start_address:
+.Lkexec_start_address:
 	.long	0x0
 
 	.globl kexec_indirection_page
 kexec_indirection_page:
+.Lkexec_indirection_page:
 	.long	0x0
 
 	.globl kexec_mach_type
 kexec_mach_type:
+.Lkexec_mach_type:
 	.long	0x0
 
 	/* phy addr of the atags for the new kernel */
 	.globl kexec_boot_atags
 kexec_boot_atags:
+.Lkexec_boot_atags:
 	.long	0x0
 
 relocate_new_kernel_end:
-- 
1.7.1
