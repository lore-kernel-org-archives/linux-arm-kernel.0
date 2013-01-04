From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 4 Jan 2013 17:32:21 +0800
Subject: [PATCH 1/2] ARM: tegra: clean up the CPUINIT section
Message-ID: <1357291942-32433-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some redundant codes in the CPUINIT section that was caused by
some codes not be organized well in "headsmp.S". Currently all the codes
in "headsmp.S" were put into CPUINIT section. But actually it doesn't
need to be loacted in CPUINIT section. There is no fuction access them
in CPUINIT section and we will relocate them to IRAM.

These codes also caused some unnecessary functions that access these
codes been put into CPUINIT section too. This patch clean it up and put
them into normal text section.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra30.c | 6 +++---
 arch/arm/mach-tegra/headsmp.S         | 2 --
 arch/arm/mach-tegra/pm.c              | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 5e8cbf5..82530bd 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -121,9 +121,9 @@ static inline bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
 }
 #endif
 
-static int __cpuinit tegra30_idle_lp2(struct cpuidle_device *dev,
-				      struct cpuidle_driver *drv,
-				      int index)
+static int tegra30_idle_lp2(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv,
+			    int index)
 {
 	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
 	bool entered_lp2 = false;
diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index 4a317fa..23f487d 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -16,8 +16,6 @@
 #define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
 
         .section ".text.head", "ax"
-	__CPUINIT
-
 /*
  * Tegra specific entry point for secondary CPUs.
  *   The secondary kernel init calls v7_flush_dcache_all before it enables
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 1b11707..498d70b 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -148,7 +148,7 @@ static void suspend_cpu_complex(void)
 	save_cpu_arch_register();
 }
 
-void __cpuinit tegra_clear_cpu_in_lp2(int phy_cpu_id)
+void tegra_clear_cpu_in_lp2(int phy_cpu_id)
 {
 	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
 
@@ -160,7 +160,7 @@ void __cpuinit tegra_clear_cpu_in_lp2(int phy_cpu_id)
 	spin_unlock(&tegra_lp2_lock);
 }
 
-bool __cpuinit tegra_set_cpu_in_lp2(int phy_cpu_id)
+bool tegra_set_cpu_in_lp2(int phy_cpu_id)
 {
 	bool last_cpu = false;
 	cpumask_t *cpu_lp2_mask = tegra_cpu_lp2_mask;
-- 
1.8.0.3
