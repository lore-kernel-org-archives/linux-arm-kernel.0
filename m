From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 16:36:02 +0200
Subject: [PATCH v2 5/9] arm64: kernel: use x30 for __enable_mmu return address
In-Reply-To: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472049366-10922-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using x27 for passing to __enable_mmu what is essentially the return
address makes the code look more complicated than it needs to be. So
in preparation of further simplifications, switch to x30/lr.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 12 +++++-------
 arch/arm64/kernel/sleep.S |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d390feb92730..3e08e51578d5 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -664,7 +664,7 @@ secondary_startup:
 	 */
 	bl	__cpu_setup			// initialise processor
 
-	adr_l	x27, __secondary_switch		// address to jump to after enabling the MMU
+	adr_l	lr, __secondary_switch		// address to jump to after enabling the MMU
 	b	__enable_mmu
 ENDPROC(secondary_startup)
 
@@ -710,9 +710,9 @@ ENTRY(__early_cpu_boot_status)
  * Enable the MMU.
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
- *  x27 = *virtual* address to jump to upon completion
  *
- * Other registers depend on the function called upon completion.
+ * Returns to the caller via x30/lr. This requires the caller to be covered
+ * by the .idmap.text section.
  *
  * Checks if the selected granule size is supported by the CPU.
  * If it isn't, park the CPU
@@ -739,7 +739,7 @@ ENTRY(__enable_mmu)
 	ic	iallu
 	dsb	nsh
 	isb
-	br	x27
+	ret
 ENDPROC(__enable_mmu)
 
 __no_granule_support:
@@ -784,9 +784,7 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
-	adr	x27, 0f
-	b	__enable_mmu
-0:
+	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
 #ifdef CONFIG_RANDOMIZE_BASE
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index bbc63099223b..4bce95cd656a 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -99,7 +99,7 @@ ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
-	adr_l	x27, _resume_switched	/* __enable_mmu will branch here */
+	adr_l	lr, _resume_switched	/* __enable_mmu will branch here */
 	b	__enable_mmu
 ENDPROC(cpu_resume)
 
-- 
2.7.4
