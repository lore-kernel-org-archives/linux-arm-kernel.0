From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 13 Mar 2013 16:27:26 +0800
Subject: [PATCH 3/3] ARM: tegra: cpuidle: remove redundant parameters for
 powered-down mode
In-Reply-To: <1363163246-26368-1-git-send-email-josephl@nvidia.com>
References: <1363163246-26368-1-git-send-email-josephl@nvidia.com>
Message-ID: <1363163246-26368-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the previous patch, tegra_idle_lp2_last() no longer uses its
parameters cpu_on_time or cpu_off_time, so remove them.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
This series was based on the patch set of suspending support.
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 6 +-----
 arch/arm/mach-tegra/cpuidle-tegra30.c | 6 +-----
 arch/arm/mach-tegra/pm.c              | 2 +-
 arch/arm/mach-tegra/pm.h              | 2 +-
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 825ced4..8bbbdeb 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -130,10 +130,6 @@ static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
 					   int index)
 {
-	struct cpuidle_state *state = &drv->states[index];
-	u32 cpu_on_time = state->exit_latency;
-	u32 cpu_off_time = state->target_residency - state->exit_latency;
-
 	while (tegra20_cpu_is_resettable_soon())
 		cpu_relax();
 
@@ -142,7 +138,7 @@ static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
 
-	tegra_idle_lp2_last(cpu_on_time, cpu_off_time);
+	tegra_idle_lp2_last();
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
 
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 80445ed..c0931c8 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -72,10 +72,6 @@ static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
 					   int index)
 {
-	struct cpuidle_state *state = &drv->states[index];
-	u32 cpu_on_time = state->exit_latency;
-	u32 cpu_off_time = state->target_residency - state->exit_latency;
-
 	/* All CPUs entering LP2 is not working.
 	 * Don't let CPU0 enter LP2 when any secondary CPU is online.
 	 */
@@ -86,7 +82,7 @@ static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
 
-	tegra_idle_lp2_last(cpu_on_time, cpu_off_time);
+	tegra_idle_lp2_last();
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
 
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 2a04dfc..90b8ddc 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -139,7 +139,7 @@ static int tegra_sleep_cpu(unsigned long v2p)
 	return 0;
 }
 
-void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time)
+void tegra_idle_lp2_last(void)
 {
 	tegra_pmc_pm_set(TEGRA_SUSPEND_LP2);
 
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index e7cbfeb..85e777a 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -29,7 +29,7 @@ void restore_cpu_arch_register(void);
 void tegra_clear_cpu_in_lp2(int phy_cpu_id);
 bool tegra_set_cpu_in_lp2(int phy_cpu_id);
 
-void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time);
+void tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.8.1.5
