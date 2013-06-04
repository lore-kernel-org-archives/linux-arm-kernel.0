From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Jun 2013 18:47:33 +0800
Subject: [PATCH V2 2/4] ARM: tegra: hook tegra_tear_down_cpu function in the
 PM suspend init function
In-Reply-To: <1370342855-32705-1-git-send-email-josephl@nvidia.com>
References: <1370342855-32705-1-git-send-email-josephl@nvidia.com>
Message-ID: <1370342855-32705-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tegra_tear_down_cpu was used to cut off the CPU rail for various Tegra
SoCs. Hooking it in the PM suspend init function and making the CPUidle
driver more generic.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* fix the coding style of the runtime chip selection
---
 arch/arm/mach-tegra/cpuidle-tegra20.c |  3 ---
 arch/arm/mach-tegra/cpuidle-tegra30.c |  3 ---
 arch/arm/mach-tegra/pm.c              | 15 +++++++++++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 0cdba8d..d667513 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -214,8 +214,5 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
 int __init tegra20_cpuidle_init(void)
 {
-#ifdef CONFIG_PM_SLEEP
-	tegra_tear_down_cpu = tegra20_tear_down_cpu;
-#endif
 	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
 }
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 3cf9aca..9d9f554 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -146,8 +146,5 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 
 int __init tegra30_cpuidle_init(void)
 {
-#ifdef CONFIG_PM_SLEEP
-	tegra_tear_down_cpu = tegra30_tear_down_cpu;
-#endif
 	return cpuidle_register(&tegra_idle_driver, NULL);
 }
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 45cf52c..5e6fb31 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -44,6 +44,20 @@
 static DEFINE_SPINLOCK(tegra_lp2_lock);
 void (*tegra_tear_down_cpu)(void);
 
+static void tegra_tear_down_cpu_init(void)
+{
+	switch (tegra_chip_id) {
+	case TEGRA20:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
+			tegra_tear_down_cpu = tegra20_tear_down_cpu;
+		break;
+	case TEGRA30:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
+			tegra_tear_down_cpu = tegra30_tear_down_cpu;
+		break;
+	}
+}
+
 /*
  * restore_cpu_complex
  *
@@ -224,6 +238,7 @@ void __init tegra_init_suspend(void)
 	if (tegra_pmc_get_suspend_mode() == TEGRA_SUSPEND_NONE)
 		return;
 
+	tegra_tear_down_cpu_init();
 	tegra_pmc_suspend_init();
 
 	suspend_set_ops(&tegra_suspend_ops);
-- 
1.8.3
