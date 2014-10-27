From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 27 Oct 2014 13:12:28 -0700
Subject: [PATCHv4 3/7] arm64: Move cpu_resume into the text section
In-Reply-To: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1414440752-9411-4-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function cpu_resume currently lives in the .data
section. There's no reason for it to be there since
we can use relative instructions without a problem.
Move it to the text section where it belongs.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/kernel/sleep.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index a564b44..5762b16 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -147,12 +147,12 @@ cpu_resume_after_mmu:
 	ret
 ENDPROC(cpu_resume_after_mmu)
 
-	.data
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 #ifdef CONFIG_SMP
 	mrs	x1, mpidr_el1
-	adr	x4, mpidr_hash_ptr
+	adrp	x4, mpidr_hash_ptr
+	add	x4, x4, #:lo12:mpidr_hash_ptr
 	ldr	x5, [x4]
 	add	x8, x4, x5		// x8 = struct mpidr_hash phys address
         /* retrieve mpidr_hash members to compute the hash */
@@ -164,14 +164,15 @@ ENTRY(cpu_resume)
 #else
 	mov	x7, xzr
 #endif
-	adr	x0, sleep_save_sp
+	adrp	x0, sleep_save_sp
+	add	x0, x0, #:lo12:sleep_save_sp
 	ldr	x0, [x0, #SLEEP_SAVE_SP_PHYS]
 	ldr	x0, [x0, x7, lsl #3]
 	/* load sp from context */
 	ldr	x2, [x0, #CPU_CTX_SP]
-	adr	x1, sleep_idmap_phys
+	adrp	x1, sleep_idmap_phys
 	/* load physical address of identity map page table in x1 */
-	ldr	x1, [x1]
+	ldr	x1, [x1, #:lo12:sleep_idmap_phys]
 	mov	sp, x2
 	/*
 	 * cpu_do_resume expects x0 to contain context physical address
@@ -181,6 +182,7 @@ ENTRY(cpu_resume)
 	b	cpu_resume_mmu		// Resume MMU, never returns
 ENDPROC(cpu_resume)
 
+	.data
 	.align 3
 mpidr_hash_ptr:
 	/*
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
