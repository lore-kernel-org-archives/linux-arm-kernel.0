From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Apr 2016 10:24:34 +0100
Subject: [PATCH v2] drivers/perf: arm-pmu: fix RCU usage on pmu resume from
 low-power
Message-ID: <1461230674-7412-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
added code in the arm perf infrastructure that allows the kernel to
save/restore perf counters whenever the CPU enters a low-power
state. The kernel saves/restores the counters for each active event
through the armpmu_{stop/start} ARM pmu API, so that the low-power state
enter/exit cycle is emulated through pmu start/stop operations for each
event in use.

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

This patch wraps the armpmu_start() call (that indirectly calls
perf_event_update_userpage()) on CPU_PM notifier power state exit (or
failed entry) within the RCU_NONIDLE() macro so that the RCU subsystem
is made aware the calling cpu is not idle from an RCU perspective for
the armpmu_start() call duration, therefore fixing the issue.

Fixes: da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: James Morse <james.morse@arm.com>
Suggested-by: Kevin Hilman <khilman@baylibre.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
v1 -> v2

- Wrapped armpmu_start() code in CPU_PM notifier within RCU_NONIDLE
- Dropped armpmu_event_set_period() refactoring
- Updated patch subject, added required tags

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/423404.html

 drivers/perf/arm_pmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 32346b5..f700908 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -737,8 +737,19 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
 			break;
 		case CPU_PM_EXIT:
 		case CPU_PM_ENTER_FAILED:
-			 /* Restore and enable the counter */
-			armpmu_start(event, PERF_EF_RELOAD);
+			 /*
+			  * Restore and enable the counter.
+			  * armpmu_start() indirectly calls
+			  *
+			  * perf_event_update_userpage()
+			  *
+			  * that requires RCU read locking to be functional,
+			  * wrap the call within RCU_NONIDLE to make the
+			  * RCU subsystem aware this cpu is not idle from
+			  * an RCU perspective for the armpmu_start() call
+			  * duration.
+			  */
+			RCU_NONIDLE(armpmu_start(event, PERF_EF_RELOAD));
 			break;
 		default:
 			break;
-- 
2.6.4
