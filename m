From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri,  3 Nov 2017 13:04:51 -0400
Subject: [PATCH v16 12/13] arm,
 tile: turn off timer tick for oneshot_stopped state
In-Reply-To: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
Message-ID: <1509728692-10460-13-git-send-email-cmetcalf@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the schedule tick is disabled in tick_nohz_stop_sched_tick(),
we call hrtimer_cancel(), which eventually calls down into
__remove_hrtimer() and thus into hrtimer_force_reprogram().
That function's call to tick_program_event() detects that
we are trying to set the expiration to KTIME_MAX and calls
clockevents_switch_state() to set the state to ONESHOT_STOPPED,
and returns.  See commit 8fff52fd5093 ("clockevents: Introduce
CLOCK_EVT_STATE_ONESHOT_STOPPED state") for more background.

However, by default the internal __clockevents_switch_state() code
doesn't have a "set_state_oneshot_stopped" function pointer for
the arm_arch_timer or tile clock_event_device structures, so that
code returns -ENOSYS, and we end up not setting the state, and more
importantly, we don't actually turn off the hardware timer.
As a result, the timer tick we were waiting for before is still
queued, and fires shortly afterwards, only to discover there was
nothing for it to do, at which point it quiesces.

The fix is to provide that function pointer field, and like the
other function pointers, have it just turn off the timer interrupt.
Any call to set a new timer interval will properly re-enable it.

This fix avoids a small performance hiccup for regular applications,
but for TASK_ISOLATION code, it fixes a potentially serious
kernel timer interruption to the time-sensitive application.

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/tile/kernel/time.c              | 1 +
 drivers/clocksource/arm_arch_timer.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/tile/kernel/time.c b/arch/tile/kernel/time.c
index f74f10d827fa..afca6fe496c8 100644
--- a/arch/tile/kernel/time.c
+++ b/arch/tile/kernel/time.c
@@ -163,6 +163,7 @@ static DEFINE_PER_CPU(struct clock_event_device, tile_timer) = {
 	.set_next_event = tile_timer_set_next_event,
 	.set_state_shutdown = tile_timer_shutdown,
 	.set_state_oneshot = tile_timer_shutdown,
+	.set_state_oneshot_stopped = tile_timer_shutdown,
 	.tick_resume = tile_timer_shutdown,
 };
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fd4b7f684bd0..61ea7f907c56 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -722,6 +722,8 @@ static void __arch_timer_setup(unsigned type,
 		}
 	}
 
+	clk->set_state_oneshot_stopped = clk->set_state_shutdown;
+
 	clk->set_state_shutdown(clk);
 
 	clockevents_config_and_register(clk, arch_timer_rate, 0xf, 0x7fffffff);
-- 
2.1.2
