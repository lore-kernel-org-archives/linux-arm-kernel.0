From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu, 13 Sep 2012 17:25:34 +0530
Subject: [RFC] [PATCH 1/2] ARM: Exynos4: CPUIDLE: Add generic function for
 exynos4 cpuidle
In-Reply-To: <1347537335-26657-1-git-send-email-chander.kashyap@linaro.org>
References: <1347537335-26657-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1347537335-26657-2-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moved out the code from exynos4_enter_core0_aftr to a separate
function "exynos4_do_idle" in order to make it usable for other
idle states.

Also update the wakeup mask without touching reserved bits.

Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index cff0595..5e489a7 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -60,9 +60,11 @@ static struct cpuidle_driver exynos4_idle_driver = {
 };
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos4_set_wakeupmask(void)
+static void exynos4_set_wakeupmask(int index)
 {
-	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
+	unsigned long mask = __raw_readl(S5P_WAKEUP_MASK) & 0xFFF00000;
+	if (index == 1)
+		__raw_writel(mask | 0x0000ff3e, S5P_WAKEUP_MASK);
 }
 
 static unsigned int g_pwr_ctrl, g_diag_reg;
@@ -91,19 +93,17 @@ static int idle_finisher(unsigned long flags)
 	return 1;
 }
 
-static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
+static void exynos4_do_idle(int index, int pd_conf, int lp_mode_magic)
 {
 	unsigned long tmp;
 
-	exynos4_set_wakeupmask();
+	exynos4_set_wakeupmask(index);
 
-	/* Set value of power down register for aftr mode */
-	exynos_sys_powerdown_conf(SYS_AFTR);
+	/* Set value of power down register for requested LP mode */
+	exynos_sys_powerdown_conf(pd_conf);
 
 	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
-	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
+	__raw_writel(lp_mode_magic, REG_DIRECTGO_FLAG);
 
 	save_cpu_arch_register();
 
@@ -136,7 +136,13 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 
 	/* Clear wakeup state register */
 	__raw_writel(0x0, S5P_WAKEUP_STAT);
+}
 
+static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	exynos4_do_idle(index, SYS_AFTR, S5P_CHECK_AFTR);
 	return index;
 }
 
-- 
1.7.9.5
