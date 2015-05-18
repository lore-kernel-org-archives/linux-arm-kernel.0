From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 18 May 2015 11:38:51 +0200
Subject: [PATCH v2] ARM: tegra: cpuidle: implement cpuidle_state.enter_freeze()
Message-ID: <1431941933-18574-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This callback is expected to do the same as enter() only that won't
re-enable interrupts on exit.

It will be called when the system goes to suspend-to-idle and will
reduce power usage because CPUs won't be awaken for unnecessary IRQs.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---

v2:	* Disable FIQs also when suspending-to-idle
---
 arch/arm/mach-tegra/cpuidle-tegra114.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index 155807f..e7c4359 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -35,32 +35,42 @@
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-static int tegra114_idle_power_down(struct cpuidle_device *dev,
-				    struct cpuidle_driver *drv,
-				    int index)
+static void tegra114_idle_power_down(void)
 {
 	local_fiq_disable();
 
 	tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	tick_broadcast_enter();
-
 	call_firmware_op(prepare_idle);
 
 	/* Do suspend by ourselves if the firmware does not implement it */
 	if (call_firmware_op(do_idle, 0) == -ENOSYS)
 		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
 
-	tick_broadcast_exit();
-
 	cpu_pm_exit();
 	tegra_clear_cpu_in_lp2();
 
 	local_fiq_enable();
+}
+
+static int tegra114_idle_enter(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv,
+			       int index)
+{
+	tick_broadcast_enter();
+	tegra114_idle_power_down();
+	tick_broadcast_exit();
 
 	return index;
 }
+
+static void tegra114_idle_enter_freeze(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv,
+				       int index)
+{
+	tegra114_idle_power_down();
+}
 #endif
 
 static struct cpuidle_driver tegra_idle_driver = {
@@ -71,7 +81,8 @@ static struct cpuidle_driver tegra_idle_driver = {
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
2.4.0
