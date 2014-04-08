From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue,  8 Apr 2014 21:45:37 +0530
Subject: [PATCH] arm: exynos: generalize power register address calculation
Message-ID: <1396973737-18693-1-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently status/configuration power register values are hard-coded for cpu1.

Make it generic so that it is useful for SoC's with more than two cpus.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/mach-exynos/hotplug.c  |   10 +++++++---
 arch/arm/mach-exynos/platsmp.c  |   13 ++++++++-----
 arch/arm/mach-exynos/regs-pmu.h |    9 +++++++--
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 5eead53..460aec0 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -92,11 +92,15 @@ static inline void cpu_leave_lowpower(void)
 
 static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 {
+	unsigned long phys_cpu = cpu_logical_map(cpu);
+	unsigned int cpunr;
+
+	cpunr = phys_cpu & 0xF00 ? (4 + phys_cpu & 0xFF) : phys_cpu & 0xFF;
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
index 8ea02f6..e694bdf 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -92,6 +92,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 	unsigned long phys_cpu = cpu_logical_map(cpu);
+	unsigned int cpunr;
 
 	/*
 	 * Set synchronisation state between this boot processor
@@ -109,14 +110,16 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(phys_cpu);
 
-	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
+	cpunr = phys_cpu & 0xF00 ? (4 + phys_cpu & 0xFF) : phys_cpu & 0xFF;
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
@@ -125,7 +128,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		}
 
 		if (timeout == 0) {
-			printk(KERN_ERR "cpu1 power enable failed");
+			pr_err("cpu%x power enable failed", cpu);
 			spin_unlock(&boot_lock);
 			return -ETIMEDOUT;
 		}
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 7c029ce..16e17e4 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -104,8 +104,13 @@
 #define S5P_GPS_LOWPWR				S5P_PMUREG(0x139C)
 #define S5P_GPS_ALIVE_LOWPWR			S5P_PMUREG(0x13A0)
 
-#define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
-#define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
+#define S5P_ARM_CORE0_CONFIGURATION		S5P_PMUREG(0x2000)
+#define S5P_ARM_CORE0_STATUS			S5P_PMUREG(0x2004)
+
+#define S5P_ARM_CORE_CONFIGURATION(_cpunr)	\
+		(S5P_ARM_CORE0_CONFIGURATION + 0x80 * _cpunr)
+#define S5P_ARM_CORE_STATUS(_cpunr)		\
+		(S5P_ARM_CORE0_STATUS + 0x80 * _cpunr)
 
 #define S5P_PAD_RET_MAUDIO_OPTION		S5P_PMUREG(0x3028)
 #define S5P_PAD_RET_GPIO_OPTION			S5P_PMUREG(0x3108)
-- 
1.7.9.5
