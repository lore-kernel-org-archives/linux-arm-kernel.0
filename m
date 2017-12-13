From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 13 Dec 2017 17:02:05 +0000
Subject: [RFC PATCH 3/5] ARM: NOMMU: Postpone MPU activation till
 __after_proc_init
In-Reply-To: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
References: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1513184527-44120-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch postpone MPU activation till __after_proc_init (which is
placed in .text section) rather than doing it in __setup_mpu. It
allows us ignore used-only-once .head.text section while programming
PMSAv8 MPU (for PMSAv7 it stays covered anyway).

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/head-nommu.S | 45 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index aaa25a6..482936a 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -125,11 +125,24 @@ __secondary_data:
  */
 	.text
 __after_proc_init:
+#ifdef CONFIG_ARM_MPU
+M_CLASS(movw	r12, #:lower16:BASEADDR_V7M_SCB)
+M_CLASS(movt	r12, #:upper16:BASEADDR_V7M_SCB)
+M_CLASS(ldr	r3, [r12, 0x50])
+AR_CLASS(mrc	p15, 0, r3, c0, c1, 4)          @ Read ID_MMFR0
+	and	r3, r3, #(MMFR0_PMSA)           @ PMSA field
+	teq	r3, #(MMFR0_PMSAv7)             @ PMSA v7
+#endif
 #ifdef CONFIG_CPU_CP15
 	/*
 	 * CP15 system control register value returned in r0 from
 	 * the CPU init function.
 	 */
+
+#ifdef CONFIG_ARM_MPU
+	biceq	r0, r0, #CR_BR			@ Disable the 'default mem-map'
+	orreq	r0, r0, #CR_M			@ Set SCTRL.M (MPU on)
+#endif
 #if defined(CONFIG_ALIGNMENT_TRAP) && __LINUX_ARM_ARCH__ < 6
 	orr	r0, r0, #CR_A
 #else
@@ -145,7 +158,15 @@ __after_proc_init:
 	bic	r0, r0, #CR_I
 #endif
 	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
+	isb
 #elif defined (CONFIG_CPU_V7M)
+#ifdef CONFIG_ARM_MPU
+	ldreq	r3, [r12, MPU_CTRL]
+	biceq	r3, #MPU_CTRL_PRIVDEFENA
+	orreq	r3, #MPU_CTRL_ENABLE
+	streq	r3, [r12, MPU_CTRL]
+	isb
+#endif
 	/* For V7M systems we want to modify the CCR similarly to the SCTLR */
 #ifdef CONFIG_CPU_DCACHE_DISABLE
 	bic	r0, r0, #V7M_SCB_CCR_DC
@@ -156,9 +177,7 @@ __after_proc_init:
 #ifdef CONFIG_CPU_ICACHE_DISABLE
 	bic	r0, r0, #V7M_SCB_CCR_IC
 #endif
-	movw	r3, #:lower16:(BASEADDR_V7M_SCB + V7M_SCB_CCR)
-	movt	r3, #:upper16:(BASEADDR_V7M_SCB + V7M_SCB_CCR)
-	str	r0, [r3]
+	str	r0, [r12, V7M_SCB_CCR]
 #endif /* CONFIG_CPU_CP15 elif CONFIG_CPU_V7M */
 	ret	lr
 ENDPROC(__after_proc_init)
@@ -282,19 +301,6 @@ M_CLASS(ldr    r0, [r12, #MPU_TYPE])
 	setup_region r0, r5, r6, PMSAv7_INSTR_SIDE, r12	@ XIP_PHYS_ADDR, shared, enabled
 3:	isb
 #endif
-
-	/* Enable the MPU */
-AR_CLASS(mrc	p15, 0, r0, c1, c0, 0)		@ Read SCTLR
-AR_CLASS(bic	r0, r0, #CR_BR)			@ Disable the 'default mem-map'
-AR_CLASS(orr	r0, r0, #CR_M)			@ Set SCTRL.M (MPU on)
-AR_CLASS(mcr	p15, 0, r0, c1, c0, 0)		@ Enable MPU
-
-M_CLASS(ldr	r0, [r12, #MPU_CTRL])
-M_CLASS(bic	r0, #MPU_CTRL_PRIVDEFENA)
-M_CLASS(orr	r0, #MPU_CTRL_ENABLE)
-M_CLASS(str	r0, [r12, #MPU_CTRL])
-	isb
-
 	ret	lr
 ENDPROC(__setup_pmsa_v7)
 
@@ -352,13 +358,6 @@ ENTRY(__secondary_setup_pmsa_v7)
 	cmp	r4, #0
 	bgt	1b
 
-	/* Enable the MPU */
-	mrc	p15, 0, r0, c1, c0, 0		@ Read SCTLR
-	bic	r0, r0, #CR_BR			@ Disable the 'default mem-map'
-	orr	r0, r0, #CR_M			@ Set SCTRL.M (MPU on)
-	mcr	p15, 0, r0, c1, c0, 0		@ Enable MPU
-	isb
-
 	ret	lr
 ENDPROC(__secondary_setup_pmsa_v7)
 
-- 
2.0.0
