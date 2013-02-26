From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Tue, 26 Feb 2013 15:26:53 +0530
Subject: [PATCH v2] arm: plat-samsung: check processor type before cache
 restoration in resume
Message-ID: <1361872613-12040-1-git-send-email-inderpal.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only cortex-a9 based samsung platforms have l2x0 cache controller. Hence check
the same before restoring the cache in resume.

This is needed for single kernel image.

Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
---
changes in v2:
	- check processor midr instead of checking all soc ids as 
	suggested by Kukjin

 arch/arm/mach-exynos/common.c           |    4 ++++
 arch/arm/plat-samsung/include/plat/pm.h |    1 +
 arch/arm/plat-samsung/s5p-sleep.S       |   10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index c4b2071..5585325 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -31,6 +31,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 #include <asm/cacheflush.h>
+#include <asm/cputype.h>
 
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
@@ -53,6 +54,7 @@
 #include "common.h"
 #define L2_AUX_VAL 0x7C470001
 #define L2_AUX_MASK 0xC200ffff
+#define CPU_MASK	0xff0ffff0
 
 static const char name_exynos4210[] = "EXYNOS4210";
 static const char name_exynos4212[] = "EXYNOS4212";
@@ -716,6 +718,8 @@ static int __init exynos4_l2x0_cache_init(void)
 	if (soc_is_exynos5250() || soc_is_exynos5440())
 		return 0;
 
+	cpu_midr = read_cpuid_id() & CPU_MASK;
+
 	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
 	if (!ret) {
 		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index f6fcade..532f5d7 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -184,3 +184,4 @@ extern void samsung_pm_save_gpios(void);
 
 extern void s3c_pm_save_core(void);
 extern void s3c_pm_restore_core(void);
+extern unsigned long cpu_midr;
diff --git a/arch/arm/plat-samsung/s5p-sleep.S b/arch/arm/plat-samsung/s5p-sleep.S
index bdf6dad..3b350d0 100644
--- a/arch/arm/plat-samsung/s5p-sleep.S
+++ b/arch/arm/plat-samsung/s5p-sleep.S
@@ -25,6 +25,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#define CPU_CORTEX_A9		0x410FC090
+
 /*
  *	 The following code is located into the .data section. This is to
  *	 allow l2x0_regs_phys to be accessed with a relative load while we
@@ -51,6 +53,11 @@
 
 ENTRY(s3c_cpu_resume)
 #ifdef CONFIG_CACHE_L2X0
+	adr	r0, cpu_midr
+	ldr	r1, [r0]
+	ldr	r0, =CPU_CORTEX_A9
+	cmp	r1, r0
+	bne	resume_l2on
 	adr	r0, l2x0_regs_phys
 	ldr	r0, [r0]
 	ldr	r1, [r0, #L2X0_R_PHY_BASE]
@@ -77,4 +84,7 @@ ENDPROC(s3c_cpu_resume)
 	.globl l2x0_regs_phys
 l2x0_regs_phys:
 	.long	0
+	.globl cpu_midr
+cpu_midr:
+	.long	0
 #endif
-- 
1.7.9.5
