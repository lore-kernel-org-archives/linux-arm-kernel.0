From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 16:36:03 +0200
Subject: [PATCH v2 6/9] arm64: call __enable_mmu as an ordinary function for
 secondary/resume
In-Reply-To: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472049366-10922-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the secondary and cpu_resume call sites to simply call
__enable_mmu as an ordinary function, with a bl instruction. This
requires the callers to be covered by .idmap.text.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 14 ++++++--------
 arch/arm64/kernel/sleep.S | 10 +++-------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 3e08e51578d5..c112c153821e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -634,6 +634,7 @@ ENTRY(__boot_cpu_mode)
 	 * This provides a "holding pen" for platforms to hold all secondary
 	 * cores are held until we're ready for them to initialise.
 	 */
+	.pushsection	".idmap.text", "ax"
 ENTRY(secondary_holding_pen)
 	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
@@ -663,10 +664,12 @@ secondary_startup:
 	 * Common entry point for secondary CPUs.
 	 */
 	bl	__cpu_setup			// initialise processor
-
-	adr_l	lr, __secondary_switch		// address to jump to after enabling the MMU
-	b	__enable_mmu
+	bl	__enable_mmu
+	ldr	x8, =__secondary_switched
+	br	x8
 ENDPROC(secondary_startup)
+	.ltorg
+	.popsection
 
 __secondary_switched:
 	adr_l	x5, vectors
@@ -812,8 +815,3 @@ __primary_switch:
 	ldr	x8, =__primary_switched
 	br	x8
 ENDPROC(__primary_switch)
-
-__secondary_switch:
-	ldr	x8, =__secondary_switched
-	br	x8
-ENDPROC(__secondary_switch)
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 4bce95cd656a..1d4aba6fcc7a 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -95,19 +95,15 @@ ENTRY(__cpu_suspend_enter)
 	ret
 ENDPROC(__cpu_suspend_enter)
 
+	.pushsection	".idmap.text", "ax"
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
-	adr_l	lr, _resume_switched	/* __enable_mmu will branch here */
-	b	__enable_mmu
-ENDPROC(cpu_resume)
-
-	.pushsection	".idmap.text", "ax"
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
