From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue, 15 Apr 2014 13:08:18 +0530
Subject: [PATCH] arm: exynos: generalize power register address calculation
In-Reply-To: <CANuQgHEbepUZO279+Bsx7Ynep6ZPQQJj+zCW3S2k50Cw5SLOdA@mail.gmail.com>
References: <CANuQgHEbepUZO279+Bsx7Ynep6ZPQQJj+zCW3S2k50Cw5SLOdA@mail.gmail.com>
Message-ID: <1397547498-21729-1-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently status/configuration power register values are hard-coded for cpu1.

Make it generic so that it is useful for SoC's with more than two cpus.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
changes in v3:
	1. Move cpunr calculation to a macro
	2. Changed printk format specifier from unsigned hex to unsigned decimal
Changes in v2:
	1. Used existing macros for clusterid and cpuid calculation

 arch/arm/mach-exynos/hotplug.c  |    7 ++++---
 arch/arm/mach-exynos/platsmp.c  |   13 +++++++------
 arch/arm/mach-exynos/regs-pmu.h |   15 +++++++++++++--
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 5eead53..9f74be2 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -92,11 +92,12 @@ static inline void cpu_leave_lowpower(void)
 
 static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 {
+	unsigned int cpunr = ENYNOS_PMU_CPUNR(cpu_logical_map(cpu));
 	for (;;) {
 
-		/* make cpu1 to be turned off at next WFI command */
-		if (cpu == 1)
-			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
+		/* make cpu to be turned off at next WFI command */
+		if (cpu)
+			__raw_writel(0, S5P_ARM_CORE_CONFIGURATION(cpunr));
 
 		/*
 		 * here's the WFI
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 03e5e9f..d9c182f 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -90,7 +90,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 	unsigned long phys_cpu = cpu_logical_map(cpu);
-
+	unsigned int cpunr = ENYNOS_PMU_CPUNR(cpu_logical_map(cpu));
 	/*
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
@@ -107,14 +107,15 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(phys_cpu);
 
-	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
+	if (!(__raw_readl(S5P_ARM_CORE_STATUS(cpunr))
+		& S5P_CORE_LOCAL_PWR_EN)) {
 		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-			     S5P_ARM_CORE1_CONFIGURATION);
+			     S5P_ARM_CORE_CONFIGURATION(cpunr));
 
 		timeout = 10;
 
-		/* wait max 10 ms until cpu1 is on */
-		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
+		/* wait max 10 ms until secondary cpu is on */
+		while ((__raw_readl(S5P_ARM_CORE_STATUS(cpunr))
 			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
 			if (timeout-- == 0)
 				break;
@@ -123,7 +124,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		}
 
 		if (timeout == 0) {
-			printk(KERN_ERR "cpu1 power enable failed");
+			pr_err("cpu%u power enable failed", cpu);
 			spin_unlock(&boot_lock);
 			return -ETIMEDOUT;
 		}
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 4f6a256..0de6df4 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -105,8 +105,13 @@
 #define S5P_GPS_LOWPWR				S5P_PMUREG(0x139C)
 #define S5P_GPS_ALIVE_LOWPWR			S5P_PMUREG(0x13A0)
 
-#define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
-#define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
+#define S5P_ARM_CORE0_CONFIGURATION		S5P_PMUREG(0x2000)
+#define S5P_ARM_CORE0_STATUS			S5P_PMUREG(0x2004)
+
+#define S5P_ARM_CORE_CONFIGURATION(_cpunr)	\
+		(S5P_ARM_CORE0_CONFIGURATION + 0x80 * (_cpunr))
+#define S5P_ARM_CORE_STATUS(_cpunr)		\
+		(S5P_ARM_CORE0_STATUS + 0x80 * (_cpunr))
 
 #define S5P_PAD_RET_MAUDIO_OPTION		S5P_PMUREG(0x3028)
 #define S5P_PAD_RET_GPIO_OPTION			S5P_PMUREG(0x3108)
@@ -313,4 +318,10 @@
 
 #define EXYNOS5_OPTION_USE_RETENTION				(1 << 4)
 
+#include <asm/cputype.h>
+#define MAX_CPUS_IN_CLUSTER	4
+#define ENYNOS_PMU_CPUNR(mpidr) \
+		((MPIDR_AFFINITY_LEVEL(mpidr, 1) * MAX_CPUS_IN_CLUSTER) \
+		  + MPIDR_AFFINITY_LEVEL(mpidr, 0));
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
-- 
1.7.9.5
