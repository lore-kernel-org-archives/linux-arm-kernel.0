From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  3 Apr 2013 14:15:20 +0200
Subject: [PATCH 7/9] intel: cpuidle: remove stop/start critical timings
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364991322-20585-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The start/stop_critical_timings are called from arch/x86/kernel/process.c
in the cpu_idle loop function.

Remove the ones in the cpuidle driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/idle/intel_idle.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5d66750..c99c31e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -339,7 +339,6 @@ static int intel_idle(struct cpuidle_device *dev,
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
 		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
 
-	stop_critical_timings();
 	if (!need_resched()) {
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
@@ -348,8 +347,6 @@ static int intel_idle(struct cpuidle_device *dev,
 			__mwait(eax, ecx);
 	}
 
-	start_critical_timings();
-
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
 		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
 
-- 
1.7.9.5
