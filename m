From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 16:35:59 +0200
Subject: [PATCH v2 2/9] arm64: kernel: fix style issues in sleep.S
In-Reply-To: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472049366-10922-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a number of style issues in sleep.S. No functional changes are
intended:
- replace absolute literal references with relative references in
  __cpu_suspend_enter(), which executes from its virtual address
- replace explicit lr assignment plus branch with bl in cpu_resume(), which
  aligns it with stext() and secondary_startup()
- use adr_l for mpidr_hash reference, and fix the incorrect accompanying
  comment
- replace leading spaces with tabs, and add a bit of whitespace for
  readability

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/sleep.S | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 182129b60fdf..bbc63099223b 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -73,10 +73,9 @@ ENTRY(__cpu_suspend_enter)
 	str	x2, [x0, #SLEEP_STACK_DATA_SYSTEM_REGS + CPU_CTX_SP]
 
 	/* find the mpidr_hash */
-	ldr	x1, =sleep_save_stash
-	ldr	x1, [x1]
+	ldr_l	x1, sleep_save_stash
 	mrs	x7, mpidr_el1
-	ldr	x9, =mpidr_hash
+	adr_l	x9, mpidr_hash
 	ldr	x10, [x9, #MPIDR_HASH_MASK]
 	/*
 	 * Following code relies on the struct mpidr_hash
@@ -95,14 +94,13 @@ ENTRY(__cpu_suspend_enter)
 	mov	x0, #1
 	ret
 ENDPROC(__cpu_suspend_enter)
-	.ltorg
 
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
+	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
-	adr_l	lr, __enable_mmu	/* __cpu_setup will return here */
 	adr_l	x27, _resume_switched	/* __enable_mmu will branch here */
-	b	__cpu_setup
+	b	__enable_mmu
 ENDPROC(cpu_resume)
 
 	.pushsection	".idmap.text", "ax"
@@ -115,14 +113,15 @@ ENDPROC(_resume_switched)
 
 ENTRY(_cpu_resume)
 	mrs	x1, mpidr_el1
-	adrp	x8, mpidr_hash
-	add x8, x8, #:lo12:mpidr_hash // x8 = struct mpidr_hash phys address
-        /* retrieve mpidr_hash members to compute the hash */
+	adr_l	x8, mpidr_hash		// x8 = struct mpidr_hash virt address
+
+	/* retrieve mpidr_hash members to compute the hash */
 	ldr	x2, [x8, #MPIDR_HASH_MASK]
 	ldp	w3, w4, [x8, #MPIDR_HASH_SHIFTS]
 	ldp	w5, w6, [x8, #(MPIDR_HASH_SHIFTS + 8)]
 	compute_mpidr_hash x7, x3, x4, x5, x6, x1, x2
-        /* x7 contains hash index, let's use it to grab context pointer */
+
+	/* x7 contains hash index, let's use it to grab context pointer */
 	ldr_l	x0, sleep_save_stash
 	ldr	x0, [x0, x7, lsl #3]
 	add	x29, x0, #SLEEP_STACK_DATA_CALLEE_REGS
-- 
2.7.4
