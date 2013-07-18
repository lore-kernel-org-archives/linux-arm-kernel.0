From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 18 Jul 2013 14:54:29 +0200
Subject: [PATCH 3/4] ARM: exynos: cpuidle: Move exynos4_idle_driver
 declaration below in the code
In-Reply-To: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1374152070-21008-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prevent a pointless forward declaration, move the driver declation
after the idle function callback, right before the init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index d8fc1a2..8d06128 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -37,28 +37,6 @@
 
 #define S5P_CHECK_AFTR		0xFCBA0D10
 
-static int exynos4_enter_lowpower(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index);
-
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
@@ -184,6 +162,24 @@ static void __init exynos5_core_down_clk(void)
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
 static int __init exynos4_init_cpuidle(void)
 {
 	if (soc_is_exynos5250())
-- 
1.7.9.5
