From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:47:47 +0200
Subject: [PATCH 01/17] ARM: exynos: cpuidle: Prevent forward declaration
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the structure below the 'exynos4_enter_lowpower' function so no more
need of forward declaration.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index f57cb91..bd2142a 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -60,30 +60,8 @@
 #define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
 #define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
 
-static int exynos4_enter_lowpower(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index);
-
 static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
 
-static struct cpuidle_driver exynos4_idle_driver = {
-	.name			= "exynos4_idle",
-	.owner			= THIS_MODULE,
-	.states = {
-		[0] = ARM_CPUIDLE_WFI_STATE,
-		[1] = {
-			.enter			= exynos4_enter_lowpower,
-			.exit_latency		= 300,
-			.target_residency	= 100000,
-			.flags			= CPUIDLE_FLAG_TIME_VALID,
-			.name			= "C1",
-			.desc			= "ARM power down",
-		},
-	},
-	.state_count = 2,
-	.safe_state_index = 0,
-};
-
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
 static void exynos4_set_wakeupmask(void)
 {
@@ -214,6 +192,24 @@ static void __init exynos5_core_down_clk(void)
 	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
 }
 
+static struct cpuidle_driver exynos4_idle_driver = {
+	.name			= "exynos4_idle",
+	.owner			= THIS_MODULE,
+	.states = {
+		[0] = ARM_CPUIDLE_WFI_STATE,
+		[1] = {
+			.enter			= exynos4_enter_lowpower,
+			.exit_latency		= 300,
+			.target_residency	= 100000,
+			.flags			= CPUIDLE_FLAG_TIME_VALID,
+			.name			= "C1",
+			.desc			= "ARM power down",
+		},
+	},
+	.state_count = 2,
+	.safe_state_index = 0,
+};
+
 static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int cpu_id, ret;
-- 
1.7.9.5
