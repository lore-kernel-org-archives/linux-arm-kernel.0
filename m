From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 19 Apr 2016 18:08:09 +0100
Subject: [PATCH] drivers/perf: arm-pmu: fix RCU usage on resume from idle
 states
Message-ID: <1461085689-2893-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
added code in the arm perf infrastructure that allows the kernel to
save/restore perf counters whenever the CPU enters a low-power idle
state. The kernel saves/restores the counters for each active event
through the armpmu_{stop/start} ARM pmu API, so that the idle state
enter/exit power cycle is emulated through pmu start/stop operations
for each event in use.

However, calling armpmu_start() for each active event on power up
executes code that requires RCU locking (perf_event_update_userpage())
to be functional, so, given that the core may call the CPU_PM notifiers
while running the idle thread in an quiescent RCU state this is not
allowed as detected through the following splat when kernel is run with
CONFIG_PROVE_LOCKING enabled:

[   49.293286]
[   49.294761] ===============================
[   49.298895] [ INFO: suspicious RCU usage. ]
[   49.303031] 4.6.0-rc3+ #421 Not tainted
[   49.306821] -------------------------------
[   49.310956] include/linux/rcupdate.h:872 rcu_read_lock() used
illegally while idle!
[   49.318530]
[   49.318530] other info that might help us debug this:
[   49.318530]
[   49.326451]
[   49.326451] RCU used illegally from idle CPU!
[   49.326451] rcu_scheduler_active = 1, debug_locks = 0
[   49.337209] RCU used illegally from extended quiescent state!
[   49.342892] 2 locks held by swapper/2/0:
[   49.346768]  #0:  (cpu_pm_notifier_lock){......}, at:
[<ffffff8008163c28>] cpu_pm_exit+0x18/0x80
[   49.355492]  #1:  (rcu_read_lock){......}, at: [<ffffff800816dc38>]
perf_event_update_userpage+0x0/0x260

This patch refactors the perf CPU_PM notifiers to add a boolean
flag to the function updating the counters event period, so that the
userpage update can be skipped when resuming from low-power whilst
keeping correct save/restore functionality for the running events.

As a side effect the kernel, while resuming from low-power with
perf events enabled, runs with a userspace view of active counters that
is not up-to-date with the kernel one, but since the core power down is
not really a PMU event start/stop this can be considered acceptable and
the userspace event snapshot will update the user view of counters
on subsequent perf event updates requested by either the perf API
or event counters overflow-triggered interrupts.

Fixes: da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: James Morse <james.morse@arm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 drivers/perf/arm_pmu.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 32346b5..4343984 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -101,7 +101,8 @@ armpmu_map_event(struct perf_event *event,
 	return -ENOENT;
 }
 
-int armpmu_event_set_period(struct perf_event *event)
+static int __armpmu_event_set_period(struct perf_event *event,
+				     bool update_user)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -136,11 +137,17 @@ int armpmu_event_set_period(struct perf_event *event)
 
 	armpmu->write_counter(event, (u64)(-left) & 0xffffffff);
 
-	perf_event_update_userpage(event);
+	if (update_user)
+		perf_event_update_userpage(event);
 
 	return ret;
 }
 
+int armpmu_event_set_period(struct perf_event *event)
+{
+	return __armpmu_event_set_period(event, true);
+}
+
 u64 armpmu_event_update(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
@@ -733,12 +740,21 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
 			/*
 			 * Stop and update the counter
 			 */
-			armpmu_stop(event, PERF_EF_UPDATE);
+			armpmu->disable(event);
+			armpmu_event_update(event);
 			break;
 		case CPU_PM_EXIT:
 		case CPU_PM_ENTER_FAILED:
-			 /* Restore and enable the counter */
-			armpmu_start(event, PERF_EF_RELOAD);
+			 /*
+			  * Restore and enable the counter;
+			  * user space updates require RCU locking
+			  * that is disallowed when a CPU is in an
+			  * idle quiescent state, therefore set
+			  * update_user bool flag to false so that the
+			  * user space counters update is skipped.
+			  */
+			__armpmu_event_set_period(event, false);
+			armpmu->enable(event);
 			break;
 		default:
 			break;
-- 
2.6.4
