From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Apr 2014 11:55:46 +0200
Subject: [PATCH V4 15/20] ARM: exynos: cpuidle: Move the AFTR state function
 into pm.c
In-Reply-To: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397123751-1957-16-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to remove depedency on pm code, let's move the 'exynos_enter_aftr'
function into the pm.c file as well as the other helper functions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/common.h  |    1 +
 arch/arm/mach-exynos/cpuidle.c |   29 -----------------------------
 arch/arm/mach-exynos/pm.c      |   29 +++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 9ef3f83..30123a0 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -62,5 +62,6 @@ struct exynos_pmu_conf {
 };
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
+extern void exynos_enter_aftr(void);
 
 #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 0d3c839..5c5a4d1 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -30,35 +30,6 @@
 #include "common.h"
 #include "regs-pmu.h"
 
-#define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
-#define REG_DIRECTGO_FLAG	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
-
-#define S5P_CHECK_AFTR		0xFCBA0D10
-
-/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos_set_wakeupmask(long mask)
-{
-	__raw_writel(mask, S5P_WAKEUP_MASK);
-}
-
-static void exynos_cpu_set_boot_vector(long flags)
-{
-	__raw_writel(virt_to_phys(exynos_cpu_resume), REG_DIRECTGO_ADDR);
-	__raw_writel(flags, REG_DIRECTGO_FLAG);
-}
-
-static void exynos_enter_aftr(void)
-{
-	exynos_set_wakeupmask(0x0000ff3e);
-	exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
-	/* Set value of power down register for aftr mode */
-	exynos_sys_powerdown_conf(SYS_AFTR);
-}
-
 static int idle_finisher(unsigned long flags)
 {
 	exynos_enter_aftr();
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c4138bf..f75d9b9 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -101,6 +101,35 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 	return -ENOENT;
 }
 
+#define EXYNOS_BOOT_VECTOR_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
+			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
+			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
+#define EXYNOS_BOOT_VECTOR_FLAG	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
+			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
+			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
+
+#define S5P_CHECK_AFTR 0xFCBA0D10
+
+/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
+static void exynos_set_wakeupmask(long mask)
+{
+	__raw_writel(mask, S5P_WAKEUP_MASK);
+}
+
+static void exynos_cpu_set_boot_vector(long flags)
+{
+	__raw_writel(virt_to_phys(exynos_cpu_resume), EXYNOS_BOOT_VECTOR_ADDR);
+	__raw_writel(flags, EXYNOS_BOOT_VECTOR_FLAG);
+}
+
+void exynos_enter_aftr(void)
+{
+	exynos_set_wakeupmask(0x0000ff3e);
+	exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
+	/* Set value of power down register for aftr mode */
+	exynos_sys_powerdown_conf(SYS_AFTR);
+}
+
 /* For Cortex-A9 Diagnostic and Power control register */
 static unsigned int save_arm_register[2];
 
-- 
1.7.9.5
