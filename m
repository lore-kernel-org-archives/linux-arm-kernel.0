From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 20:05:41 +0100
Subject: [PATCH v3] ARM: exynos: move resume code to .text section
In-Reply-To: <alpine.LFD.2.11.1503241427280.27567@knanqh.ubzr>
References: <alpine.LFD.2.11.1503241427280.27567@knanqh.ubzr>
Message-ID: <1427223941-26251-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code calls cpu_resume() using a straight branch (b), so
now that we have moved cpu_resume() back to .text, this should
be moved there as well. Any direct references to symbols that will
remain in the .data section are replaced with explicit PC-relative
references.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v3: add missing .align, regroup changes to be more logical
v2: keep cp15_save_power and cp15_save_diag in the .data section

 arch/arm/mach-exynos/sleep.S | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
index 31d25834b9c4..cf950790fbdc 100644
--- a/arch/arm/mach-exynos/sleep.S
+++ b/arch/arm/mach-exynos/sleep.S
@@ -23,14 +23,7 @@
 #define CPU_MASK	0xff0ffff0
 #define CPU_CORTEX_A9	0x410fc090
 
-	/*
-	 * The following code is located into the .data section. This is to
-	 * allow l2x0_regs_phys to be accessed with a relative load while we
-	 * can't rely on any MMU translation. We could have put l2x0_regs_phys
-	 * in the .text section as well, but some setups might insist on it to
-	 * be truly read-only. (Reference from: arch/arm/kernel/sleep.S)
-	 */
-	.data
+	.text
 	.align
 
 	/*
@@ -69,10 +62,12 @@ ENTRY(exynos_cpu_resume_ns)
 	cmp	r0, r1
 	bne	skip_cp15
 
-	adr	r0, cp15_save_power
+	adr	r0, _cp15_save_power
 	ldr	r1, [r0]
-	adr	r0, cp15_save_diag
+	ldr	r1, [r0, r1]
+	adr	r0, _cp15_save_diag
 	ldr	r2, [r0]
+	ldr	r2, [r0, r2]
 	mov	r0, #SMC_CMD_C15RESUME
 	dsb
 	smc	#0
@@ -118,14 +113,20 @@ skip_l2x0:
 skip_cp15:
 	b	cpu_resume
 ENDPROC(exynos_cpu_resume_ns)
+
+	.align
+_cp15_save_power:
+	.long	cp15_save_power - .
+_cp15_save_diag:
+	.long	cp15_save_diag - .
+#ifdef CONFIG_CACHE_L2X0
+1:	.long	l2x0_saved_regs - .
+#endif /* CONFIG_CACHE_L2X0 */
+
+	.data
 	.globl cp15_save_diag
 cp15_save_diag:
 	.long	0	@ cp15 diagnostic
 	.globl cp15_save_power
 cp15_save_power:
 	.long	0	@ cp15 power control
-
-#ifdef CONFIG_CACHE_L2X0
-	.align
-1:	.long	l2x0_saved_regs - .
-#endif /* CONFIG_CACHE_L2X0 */
-- 
1.8.3.2
