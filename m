From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 31 Aug 2016 12:05:14 +0100
Subject: [PATCH v3 4/7] arm64: kernel: use x30 for __enable_mmu return address
In-Reply-To: <1472641517-15362-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472641517-15362-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472641517-15362-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using x27 for passing to __enable_mmu what is essentially the return
address makes the code look more complicated than it needs to be. So
switch to x30/lr, and update the secondary and cpu_resume call sites to
simply call __enable_mmu as an ordinary function, with a bl instruction.
This requires the callers to be covered by .idmap.text.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 21 +++++++-------------
 arch/arm64/kernel/sleep.S |  8 ++------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 5543068da3ae..45b865e022cc 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -675,9 +675,9 @@ secondary_startup:
 	 * Common entry point for secondary CPUs.
 	 */
 	bl	__cpu_setup			// initialise processor
-
-	adr_l	x27, __secondary_switch		// address to jump to after enabling the MMU
-	b	__enable_mmu
+	bl	__enable_mmu
+	ldr	x8, =__secondary_switched
+	br	x8
 ENDPROC(secondary_startup)
 
 __secondary_switched:
@@ -716,9 +716,9 @@ ENDPROC(__secondary_switched)
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
@@ -744,7 +744,7 @@ ENTRY(__enable_mmu)
 	ic	iallu
 	dsb	nsh
 	isb
-	br	x27
+	ret
 ENDPROC(__enable_mmu)
 
 __no_granule_support:
@@ -789,9 +789,7 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
-	adr	x27, 0f
-	b	__enable_mmu
-0:
+	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
 #ifdef CONFIG_RANDOMIZE_BASE
@@ -822,8 +820,3 @@ __primary_switch:
 	ldr	x8, =__primary_switched
 	br	x8
 ENDPROC(__primary_switch)
-
-__secondary_switch:
-	ldr	x8, =__secondary_switched
-	br	x8
-ENDPROC(__secondary_switch)
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 6adc76bf8f91..0f7e0b2ac64c 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -100,14 +100,10 @@ ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
-	adr_l	x27, _resume_switched	/* __enable_mmu will branch here */
-	b	__enable_mmu
-ENDPROC(cpu_resume)
-
-_resume_switched:
+	bl	__enable_mmu
 	ldr	x8, =_cpu_resume
 	br	x8
-ENDPROC(_resume_switched)
+ENDPROC(cpu_resume)
 	.ltorg
 	.popsection
 
-- 
2.7.4
