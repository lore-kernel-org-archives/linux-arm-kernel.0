From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Apr 2013 22:42:45 +0200
Subject: [V2 patch 15/19] ARM: tegra: cpuidle: use init/exit common routine
 for tegra3
In-Reply-To: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1365712969-7541-16-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra30.c |   27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index f6a0c72..36dc2be 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -64,8 +64,6 @@ static struct cpuidle_driver tegra_idle_driver = {
 	},
 };
 
-static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
-
 #ifdef CONFIG_PM_SLEEP
 static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
@@ -156,31 +154,8 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 
 int __init tegra30_cpuidle_init(void)
 {
-	int ret;
-	unsigned int cpu;
-	struct cpuidle_device *dev;
-	struct cpuidle_driver *drv = &tegra_idle_driver;
-
 #ifdef CONFIG_PM_SLEEP
 	tegra_tear_down_cpu = tegra30_tear_down_cpu;
 #endif
-
-	ret = cpuidle_register_driver(&tegra_idle_driver);
-	if (ret) {
-		pr_err("CPUidle driver registration failed\n");
-		return ret;
-	}
-
-	for_each_possible_cpu(cpu) {
-		dev = &per_cpu(tegra_idle_device, cpu);
-		dev->cpu = cpu;
-
-		ret = cpuidle_register_device(dev);
-		if (ret) {
-			pr_err("CPU%u: CPUidle device registration failed\n",
-				cpu);
-			return ret;
-		}
-	}
-	return 0;
+	return cpuidle_register(&tegra_idle_driver, NULL);
 }
-- 
1.7.9.5
