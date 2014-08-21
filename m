From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 20 Aug 2014 18:20:35 -0700
Subject: [PATCHv3 3/7] arm64: Move cpu_resume into the text section
In-Reply-To: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1408584039-12735-4-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function cpu_resume currently lives in the .data
section. This breaks functionality to make .data no
execute. Move cpu_resume to .text which is where it
actually belongs.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/kernel/sleep.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index b192572..6ee13db 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -126,12 +126,12 @@ cpu_resume_after_mmu:
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
@@ -143,14 +143,15 @@ ENTRY(cpu_resume)
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
@@ -160,6 +161,7 @@ ENTRY(cpu_resume)
 	b	cpu_resume_mmu		// Resume MMU, never returns
 ENDPROC(cpu_resume)
 
+	.data
 	.align 3
 mpidr_hash_ptr:
 	/*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
