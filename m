From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 18 Apr 2014 16:42:58 +0200
Subject: [PATCH 1/4] ARM: EXYNOS: Fix definitions of S5P_ARM_CORE_* registers
In-Reply-To: <1397832181-5153-1-git-send-email-t.figa@samsung.com>
References: <1397832181-5153-1-git-send-email-t.figa@samsung.com>
Message-ID: <1397832181-5153-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SoCs with more than 2 cores there are more than 2 S5P_ARM_CORE_*
registers that can be addressed with fixed stride of 0x80. This patch
renames the definitions of S5P_ARM_CORE1_* registers to be S5P_ARM_CORE_*
and make them take physical core ID as argument to calculate register
address.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/hotplug.c  | 2 +-
 arch/arm/mach-exynos/platsmp.c  | 6 +++---
 arch/arm/mach-exynos/regs-pmu.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 5eead53..7e0f31a 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -96,7 +96,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 
 		/* make cpu1 to be turned off at next WFI command */
 		if (cpu == 1)
-			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
+			__raw_writel(0, S5P_ARM_CORE_CONFIGURATION(1));
 
 		/*
 		 * here's the WFI
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 03e5e9f..7b7de4b 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -107,14 +107,14 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(phys_cpu);
 
-	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
+	if (!(__raw_readl(S5P_ARM_CORE_STATUS(1)) & S5P_CORE_LOCAL_PWR_EN)) {
 		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-			     S5P_ARM_CORE1_CONFIGURATION);
+			     S5P_ARM_CORE_CONFIGURATION(1));
 
 		timeout = 10;
 
 		/* wait max 10 ms until cpu1 is on */
-		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
+		while ((__raw_readl(S5P_ARM_CORE_STATUS(1))
 			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
 			if (timeout-- == 0)
 				break;
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 4f6a256..d94bbc8 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -105,8 +105,8 @@
 #define S5P_GPS_LOWPWR				S5P_PMUREG(0x139C)
 #define S5P_GPS_ALIVE_LOWPWR			S5P_PMUREG(0x13A0)
 
-#define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
-#define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
+#define S5P_ARM_CORE_CONFIGURATION(n)		S5P_PMUREG(0x2000 + (n) * 0x80)
+#define S5P_ARM_CORE_STATUS(n)			S5P_PMUREG(0x2004 + (n) * 0x80)
 
 #define S5P_PAD_RET_MAUDIO_OPTION		S5P_PMUREG(0x3028)
 #define S5P_PAD_RET_GPIO_OPTION			S5P_PMUREG(0x3108)
-- 
1.9.2
