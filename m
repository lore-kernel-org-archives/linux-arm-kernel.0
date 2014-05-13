From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 May 2014 16:12:58 +0200
Subject: [PATCH] ARM: exynos4212: hotplug: Fix CPU idle clock down after CPU1
 off
Message-ID: <1399990378-7023-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos4212 USE_DELAYED_RESET_ASSERTION must be set in
ARM_CORE1_OPTION register during CPU power down. This is the proper way
of powering down CPU. Additionally without this the CPU clock down won't
work after powering down CPU1 and CPU will work at full frequency chosen
by CPUfreq governor.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/hotplug.c  | 28 +++++++++++++++++++++++++---
 arch/arm/mach-exynos/regs-pmu.h |  2 ++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 5eead530c6f8..59b813e74558 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -74,7 +74,7 @@ static inline void cpu_enter_lowpower_a15(void)
 	dsb();
 }
 
-static inline void cpu_leave_lowpower(void)
+static inline void cpu_leave_lowpower(unsigned int cpu)
 {
 	unsigned int v;
 
@@ -88,6 +88,14 @@ static inline void cpu_leave_lowpower(void)
 	  : "=&r" (v)
 	  : "Ir" (CR_C), "Ir" (0x40)
 	  : "cc");
+
+	if (cpu == 1 && soc_is_exynos4212()) {
+		unsigned int tmp;
+
+		tmp = __raw_readl(S5P_ARM_CORE1_OPTION);
+		tmp &= ~(S5P_USE_DELAYED_RESET_ASSERTION);
+		__raw_writel(tmp, S5P_ARM_CORE1_OPTION);
+	}
 }
 
 static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
@@ -95,8 +103,22 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	for (;;) {
 
 		/* make cpu1 to be turned off at next WFI command */
-		if (cpu == 1)
+		if (cpu == 1) {
+			if (soc_is_exynos4212()) {
+				unsigned int tmp;
+
+				/*
+				 * Exynos 4212 requires setting
+				 * USE_DELAYED_RESET_ASSERTION so the CPU idle
+				 * clock down feature could properly detect
+				 * global idle state when CPU1 is off.
+				 */
+				tmp = __raw_readl(S5P_ARM_CORE1_OPTION);
+				tmp |= S5P_USE_DELAYED_RESET_ASSERTION;
+				__raw_writel(tmp, S5P_ARM_CORE1_OPTION);
+			}
 			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
+		}
 
 		/*
 		 * here's the WFI
@@ -152,7 +174,7 @@ void __ref exynos_cpu_die(unsigned int cpu)
 	 * bring this CPU back into the world of cache
 	 * coherency, and then restore interrupts
 	 */
-	cpu_leave_lowpower();
+	cpu_leave_lowpower(cpu);
 
 	if (spurious)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 4f6a2560d022..1a3da4ef0e22 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -25,6 +25,7 @@
 
 #define S5P_USE_STANDBY_WFI0			(1 << 16)
 #define S5P_USE_STANDBY_WFE0			(1 << 24)
+#define S5P_USE_DELAYED_RESET_ASSERTION		BIT(12)
 
 #define EXYNOS_SWRESET				S5P_PMUREG(0x0400)
 #define EXYNOS5440_SWRESET			S5P_PMUREG(0x00C4)
@@ -107,6 +108,7 @@
 
 #define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
 #define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
+#define S5P_ARM_CORE1_OPTION			S5P_PMUREG(0x2088)
 
 #define S5P_PAD_RET_MAUDIO_OPTION		S5P_PMUREG(0x3028)
 #define S5P_PAD_RET_GPIO_OPTION			S5P_PMUREG(0x3108)
-- 
1.9.1
