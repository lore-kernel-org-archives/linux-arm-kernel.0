From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 18:52:28 +0100
Subject: [PATCH v2 2/4] ARM: move cpu_resume() to .text section
In-Reply-To: <1427219550-21636-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427219550-21636-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427219550-21636-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move cpu_resume() to the .text section where it belongs. Change
the adr reference to sleep_save_sp to an explicit PC relative
reference so sleep_save_sp itself can remain in .data.

This helps prevent linker failure on large kernels, as the code
in the .data section may be too far away to be in range for normal
b/bl instructions.

Reviewed-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/sleep.S | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 0ea3813fedce..fabdb14e88b8 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -116,14 +116,7 @@ cpu_resume_after_mmu:
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_resume_after_mmu)
 
-/*
- * Note: Yes, part of the following code is located into the .data section.
- *       This is to allow sleep_save_sp to be accessed with a relative load
- *       while we can't rely on any MMU translation.  We could have put
- *       sleep_save_sp in the .text section as well, but some setups might
- *       insist on it to be truly read-only.
- */
-	.data
+	.text
 	.align
 ENTRY(cpu_resume)
 ARM_BE8(setend be)			@ ensure we are in BE mode
@@ -145,6 +138,8 @@ ARM_BE8(setend be)			@ ensure we are in BE mode
 	compute_mpidr_hash	r1, r4, r5, r6, r0, r3
 1:
 	adr	r0, _sleep_save_sp
+	ldr	r2, [r0]
+	add	r0, r0, r2
 	ldr	r0, [r0, #SLEEP_SAVE_SP_PHYS]
 	ldr	r0, [r0, r1, lsl #2]
 
@@ -156,10 +151,12 @@ THUMB(	bx	r3			)
 ENDPROC(cpu_resume)
 
 	.align 2
+_sleep_save_sp:
+	.long	sleep_save_sp - .
 mpidr_hash_ptr:
 	.long	mpidr_hash - .			@ mpidr_hash struct offset
 
+	.data
 	.type	sleep_save_sp, #object
 ENTRY(sleep_save_sp)
-_sleep_save_sp:
 	.space	SLEEP_SAVE_SP_SZ		@ struct sleep_save_sp
-- 
1.8.3.2
