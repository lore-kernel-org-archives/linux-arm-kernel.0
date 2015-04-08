From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed,  8 Apr 2015 12:54:38 +0200
Subject: [PATCH] ARM: tegra: cpuidle: implement cpuidle_state.enter_freeze()
Message-ID: <1428490480-10144-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This callback is expected to do the same as enter() only that all
non-wakeup IRQs are expected to be disabled.

It will be called when the system goes to suspend-to-idle and will
reduce power usage because CPUs won't be awaken for unnecessary IRQs.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index f2b586d..ef06001 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -39,28 +39,44 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv,
 				    int index)
 {
-	local_fiq_disable();
-
 	tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
-
 	call_firmware_op(prepare_idle);
 
 	/* Do suspend by ourselves if the firmware does not implement it */
 	if (call_firmware_op(do_idle, 0) == -ENOSYS)
 		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
-
 	cpu_pm_exit();
 	tegra_clear_cpu_in_lp2();
 
+	return index;
+}
+
+static int tegra114_idle_enter(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv,
+			       int index)
+{
+	local_fiq_disable();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	index = tegra114_idle_power_down(dev, drv, index);
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
 	local_fiq_enable();
 
 	return index;
 }
+
+static void tegra114_idle_enter_freeze(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv,
+				       int index)
+{
+	tegra114_idle_power_down(dev, drv, index);
+}
 #endif
 
 static struct cpuidle_driver tegra_idle_driver = {
@@ -71,7 +87,8 @@ static struct cpuidle_driver tegra_idle_driver = {
 		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
 #ifdef CONFIG_PM_SLEEP
 		[1] = {
-			.enter			= tegra114_idle_power_down,
+			.enter			= tegra114_idle_enter,
+			.enter_freeze		= tegra114_idle_enter_freeze,
 			.exit_latency		= 500,
 			.target_residency	= 1000,
 			.power_usage		= 0,
-- 
2.3.4
