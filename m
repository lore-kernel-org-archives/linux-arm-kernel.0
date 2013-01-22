From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Tue, 22 Jan 2013 13:55:09 +0530
Subject: [PATCH] arm: plat-samsung: check soc ids before l2x0 cache
 restoration in resume
Message-ID: <1358843109-11072-1-git-send-email-inderpal.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only exynos4 based platforms have l2x0 cache controller. Hence check
the same before restoring the cache in resume.

This is needed for single kernel image.

Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
---
 arch/arm/mach-exynos/common.c           |    2 ++
 arch/arm/plat-samsung/include/plat/pm.h |    1 +
 arch/arm/plat-samsung/s5p-sleep.S       |   28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index cdaa55f..ab7ca00 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -796,6 +796,8 @@ static int __init exynos4_l2x0_cache_init(void)
 	if (soc_is_exynos5250() || soc_is_exynos5440())
 		return 0;
 
+	s5p_cpu = samsung_cpu_id & EXYNOS4_CPU_MASK;
+
 	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
 	if (!ret) {
 		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 887a0c9..285c8c8 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -190,3 +190,4 @@ extern void samsung_pm_save_gpios(void);
 
 extern void s3c_pm_save_core(void);
 extern void s3c_pm_restore_core(void);
+extern unsigned long s5p_cpu;
diff --git a/arch/arm/plat-samsung/s5p-sleep.S b/arch/arm/plat-samsung/s5p-sleep.S
index bdf6dad..006d35f 100644
--- a/arch/arm/plat-samsung/s5p-sleep.S
+++ b/arch/arm/plat-samsung/s5p-sleep.S
@@ -25,6 +25,15 @@
 #include <asm/asm-offsets.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#define EXYNOS4210_CPU_ID	0x43210000
+#define EXYNOS4212_CPU_ID	0x43220000
+#define EXYNOS4412_CPU_ID	0xE4412200
+#define EXYNOS4_CPU_MASK	0xFFFE0000
+
+#define EXYNOS4210_CPU		(EXYNOS4210_CPU_ID & EXYNOS4_CPU_MASK)
+#define EXYNOS4212_CPU		(EXYNOS4212_CPU_ID & EXYNOS4_CPU_MASK)
+#define EXYNOS4412_CPU		(EXYNOS4412_CPU_ID & EXYNOS4_CPU_MASK)
+
 /*
  *	 The following code is located into the .data section. This is to
  *	 allow l2x0_regs_phys to be accessed with a relative load while we
@@ -51,6 +60,22 @@
 
 ENTRY(s3c_cpu_resume)
 #ifdef CONFIG_CACHE_L2X0
+	adr	r0, s5p_cpu
+	ldr	r1, [r0]
+
+	ldr	r0, =EXYNOS4210_CPU
+	cmp	r1, r0
+	beq	continue
+
+	ldr	r0, =EXYNOS4212_CPU
+	cmp	r1, r0
+	beq	continue
+
+	ldr	r0, =EXYNOS4412_CPU
+	cmp	r1, r0
+	bne	resume_l2on
+
+continue:
 	adr	r0, l2x0_regs_phys
 	ldr	r0, [r0]
 	ldr	r1, [r0, #L2X0_R_PHY_BASE]
@@ -77,4 +102,7 @@ ENDPROC(s3c_cpu_resume)
 	.globl l2x0_regs_phys
 l2x0_regs_phys:
 	.long	0
+	.globl s5p_cpu
+s5p_cpu:
+	.long	0
 #endif
-- 
1.7.9.5
