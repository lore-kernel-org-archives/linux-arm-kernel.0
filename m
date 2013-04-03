From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  3 Apr 2013 14:15:17 +0200
Subject: [PATCH 4/9] ARM: tegra2: cpuidle: change driver initialization
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364991322-20585-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the idle states directly in the driver structure.

That prevents extra structure declaration and memcpy at init time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c |   40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 825ced4..1ad1a67 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -43,28 +43,32 @@ static atomic_t abort_barrier;
 static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv,
 				    int index);
+#define TEGRA20_MAX_STATES 2
+#else
+#define TEGRA20_MAX_STATES 1
 #endif
 
-static struct cpuidle_state tegra_idle_states[] = {
-	[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
-#ifdef CONFIG_PM_SLEEP
-	[1] = {
-		.enter			= tegra20_idle_lp2_coupled,
-		.exit_latency		= 5000,
-		.target_residency	= 10000,
-		.power_usage		= 0,
-		.flags			= CPUIDLE_FLAG_TIME_VALID |
-					  CPUIDLE_FLAG_COUPLED,
-		.name			= "powered-down",
-		.desc			= "CPU power gated",
-	},
-#endif
-};
-
 static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
 	.en_core_tk_irqen = 1,
+	.states = {
+		ARM_CPUIDLE_WFI_STATE_PWR(600),
+#ifdef CONFIG_PM_SLEEP
+		{
+			.enter            = tegra20_idle_lp2_coupled,
+			.exit_latency     = 5000,
+			.target_residency = 10000,
+			.power_usage      = 0,
+			.flags            = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_COUPLED,
+			.name             = "powered-down",
+			.desc             = "CPU power gated",
+		},
+#endif
+	},
+	.state_count = TEGRA20_MAX_STATES,
+	.safe_state_index = 0,
 };
 
 static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
@@ -226,10 +230,6 @@ int __init tegra20_cpuidle_init(void)
 	tegra_tear_down_cpu = tegra20_tear_down_cpu;
 #endif
 
-	drv->state_count = ARRAY_SIZE(tegra_idle_states);
-	memcpy(drv->states, tegra_idle_states,
-			drv->state_count * sizeof(drv->states[0]));
-
 	ret = cpuidle_register_driver(&tegra_idle_driver);
 	if (ret) {
 		pr_err("CPUidle driver registration failed\n");
-- 
1.7.9.5
