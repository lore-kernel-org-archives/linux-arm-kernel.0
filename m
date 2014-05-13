From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 17:28:41 +0530
Subject: [PATCH v6 2/5] ARM: EXYNOS: use generic exynos cpu power control
 functions
In-Reply-To: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
References: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1399982324-27879-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leela Krishna Amudala <leela.krishna@linaro.org>

Use generic exynos cpu power control functions to power up/down
and to know the status of the cpu in platsmp and hotplug code.

Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/hotplug.c  |    2 +-
 arch/arm/mach-exynos/platsmp.c  |    9 +++------
 arch/arm/mach-exynos/regs-pmu.h |    3 ---
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 3cab3f5..69fa483 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -44,7 +44,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 
 		/* make cpu1 to be turned off at next WFI command */
 		if (cpu == 1)
-			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
+			exynos_cpu_power_down(cpu);
 
 		/*
 		 * here's the WFI
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 51cdabe..9c16da2 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -131,15 +131,12 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(phys_cpu);
 
-	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
-		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-			     S5P_ARM_CORE1_CONFIGURATION);
-
+	if (!exynos_cpu_power_state(cpu)) {
+		exynos_cpu_power_up(cpu);
 		timeout = 10;
 
 		/* wait max 10 ms until cpu1 is on */
-		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
-			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
+		while (exynos_cpu_power_state(cpu) != S5P_CORE_LOCAL_PWR_EN) {
 			if (timeout-- == 0)
 				break;
 
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 84634ac..98fb8d8 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -111,9 +111,6 @@
 #define EXYNOS_ARM_CORE_STATUS(_nr)		\
 			(EXYNOS_ARM_CORE_CONFIGURATION(_nr) + 0x4)
 
-#define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
-#define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
-
 #define S5P_PAD_RET_MAUDIO_OPTION		S5P_PMUREG(0x3028)
 #define S5P_PAD_RET_GPIO_OPTION			S5P_PMUREG(0x3108)
 #define S5P_PAD_RET_UART_OPTION			S5P_PMUREG(0x3128)
-- 
1.7.9.5
