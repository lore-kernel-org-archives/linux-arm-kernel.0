From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  3 Aug 2016 17:38:46 +0200
Subject: [PATCH 4/8] ARM: head.S: use PC-relative insn sequence for
 secondary_data
In-Reply-To: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1470238730-30038-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the open coded PC relative offset calculations with adr_l
and ldr_l invocations.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/head.S | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f99360e5b004..7a14622582de 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -386,40 +386,28 @@ ENTRY(secondary_startup)
 	/*
 	 * Use the page tables supplied from  __cpu_up.
 	 */
-	adr	r4, __secondary_data
-	ldmia	r4, {r5, r7, r12}		@ address to jump to after
-	sub	lr, r4, r5			@ mmu has been enabled
-	add	r3, r7, lr
+	adr_l	r3, secondary_data
 	ldrd	r4, [r3, #0]			@ get secondary_data.pgdir
 ARM_BE8(eor	r4, r4, r5)			@ Swap r5 and r4 in BE:
 ARM_BE8(eor	r5, r4, r5)			@ it can be done in 3 steps
 ARM_BE8(eor	r4, r4, r5)			@ without using a temp reg.
 	ldr	r8, [r3, #8]			@ get secondary_data.swapper_pg_dir
 	badr	lr, __enable_mmu		@ return address
-	mov	r13, r12			@ __secondary_switched address
+	ldr	r13, =__secondary_switched	@ __secondary_switched address
 	ldr	r12, [r10, #PROCINFO_INITFUNC]
 	add	r12, r12, r10			@ initialise processor
 						@ (return control reg)
 	ret	r12
 ENDPROC(secondary_startup)
 ENDPROC(secondary_startup_arm)
+	.ltorg
 
-	/*
-	 * r6  = &secondary_data
-	 */
 ENTRY(__secondary_switched)
-	ldr	sp, [r7, #12]			@ get secondary_data.stack
+	ldr_l	sp, secondary_data + 12, ip	@ get secondary_data.stack
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
 
-	.align
-
-	.type	__secondary_data, %object
-__secondary_data:
-	.long	.
-	.long	secondary_data
-	.long	__secondary_switched
 #endif /* defined(CONFIG_SMP) */
 
 
-- 
2.7.4
