From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri,  2 May 2014 20:55:14 +0530
Subject: [PATCH v4 2/5] ARM: EXYNOS: use generic exynos cpu power control
 functions
In-Reply-To: <1398528348-21214-3-git-send-email-a.kesavan@samsung.com>
References: <1398528348-21214-3-git-send-email-a.kesavan@samsung.com>
Message-ID: <1399044314-15672-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leela Krishna Amudala <leela.krishna@linaro.org>

Use generic exynos cpu power control functions to power up/down
and to know the status of the cpu.

Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>
---
 arch/arm/mach-exynos/platsmp.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 0aac032..d442a66 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -130,15 +130,12 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(phys_cpu);
 
-	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
-		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-			     S5P_ARM_CORE1_CONFIGURATION);
-
+	if (!exynos_cpu_power_state(cpu)) {
+		exynos_cpu_powerup(cpu);
 		timeout = 10;
 
 		/* wait max 10 ms until cpu1 is on */
-		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
-			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
+		while (exynos_cpu_power_state(cpu) != S5P_CORE_LOCAL_PWR_EN) {
 			if (timeout-- == 0)
 				break;
 
-- 
1.7.9.5
