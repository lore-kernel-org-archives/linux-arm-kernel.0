From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Jun 2013 18:47:35 +0800
Subject: [PATCH V2 4/4] ARM: tegra: don't pass CPU ID to tegra_{set,
 clear}_cpu_in_lp2
In-Reply-To: <1370342855-32705-1-git-send-email-josephl@nvidia.com>
References: <1370342855-32705-1-git-send-email-josephl@nvidia.com>
Message-ID: <1370342855-32705-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra_{set,clear}_cpu_in_lp2 can easily determine which CPU ID they are
running on; there is no need to pass the CPU ID into those functions.
So, remove their CPU ID function parameter.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* fix the commit message to make it clearer to understand what had done
  in this patch
---
 arch/arm/mach-tegra/cpuidle-tegra20.c |  7 +++----
 arch/arm/mach-tegra/cpuidle-tegra30.c |  7 +++----
 arch/arm/mach-tegra/pm.c              | 10 ++++++----
 arch/arm/mach-tegra/pm.h              |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index d667513..706aa42 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -177,7 +177,6 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv,
 				    int index)
 {
-	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
 	bool entered_lp2 = false;
 
 	if (tegra_pending_sgi())
@@ -193,16 +192,16 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
 	local_fiq_disable();
 
-	tegra_set_cpu_in_lp2(cpu);
+	tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	if (cpu == 0)
+	if (dev->cpu == 0)
 		entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv, index);
 	else
 		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
 
 	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2(cpu);
+	tegra_clear_cpu_in_lp2();
 
 	local_fiq_enable();
 
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 9d9f554..ed2a2a7 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -114,16 +114,15 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv,
 			    int index)
 {
-	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
 	bool entered_lp2 = false;
 	bool last_cpu;
 
 	local_fiq_disable();
 
-	last_cpu = tegra_set_cpu_in_lp2(cpu);
+	last_cpu = tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	if (cpu == 0) {
+	if (dev->cpu == 0) {
 		if (last_cpu)
 			entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv,
 								     index);
@@ -134,7 +133,7 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 	}
 
 	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2(cpu);
+	tegra_clear_cpu_in_lp2();
 
 	local_fiq_enable();
 
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 5e6fb31..94e69be 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -105,8 +105,9 @@ static void suspend_cpu_complex(void)
 	flowctrl_cpu_suspend_enter(cpu);
 }
 
-void tegra_clear_cpu_in_lp2(int phy_cpu_id)
+void tegra_clear_cpu_in_lp2(void)
 {
+	int phy_cpu_id = cpu_logical_map(smp_processor_id());
 	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
 
 	spin_lock(&tegra_lp2_lock);
@@ -117,8 +118,9 @@ void tegra_clear_cpu_in_lp2(int phy_cpu_id)
 	spin_unlock(&tegra_lp2_lock);
 }
 
-bool tegra_set_cpu_in_lp2(int phy_cpu_id)
+bool tegra_set_cpu_in_lp2(void)
 {
+	int phy_cpu_id = cpu_logical_map(smp_processor_id());
 	bool last_cpu = false;
 	cpumask_t *cpu_lp2_mask = tegra_cpu_lp2_mask;
 	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
@@ -206,7 +208,7 @@ static int __cpuinit tegra_suspend_enter(suspend_state_t state)
 	suspend_cpu_complex();
 	switch (mode) {
 	case TEGRA_SUSPEND_LP2:
-		tegra_set_cpu_in_lp2(0);
+		tegra_set_cpu_in_lp2();
 		break;
 	default:
 		break;
@@ -216,7 +218,7 @@ static int __cpuinit tegra_suspend_enter(suspend_state_t state)
 
 	switch (mode) {
 	case TEGRA_SUSPEND_LP2:
-		tegra_clear_cpu_in_lp2(0);
+		tegra_clear_cpu_in_lp2();
 		break;
 	default:
 		break;
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 778a4aa..94c4b9d 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -28,8 +28,8 @@ extern unsigned long l2x0_saved_regs_addr;
 void save_cpu_arch_register(void);
 void restore_cpu_arch_register(void);
 
-void tegra_clear_cpu_in_lp2(int phy_cpu_id);
-bool tegra_set_cpu_in_lp2(int phy_cpu_id);
+void tegra_clear_cpu_in_lp2(void);
+bool tegra_set_cpu_in_lp2(void);
 
 void tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
-- 
1.8.3
