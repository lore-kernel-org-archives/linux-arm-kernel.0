From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 23 Apr 2013 17:46:29 +0200
Subject: [PATCH v3 08/13] clocksource: samsung_pwm_timer: Correct programming
 of clock events
In-Reply-To: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
References: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
Message-ID: <1366731994-7478-9-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current code, the tick count value programmed to the hardware is
always decremented by one. This is reasonable for periodic mode, since
there is one extra tick between 0 and COUNT (after reloading), but it
makes oneshot events happen 1 tick earlier than requested, because the
interrupt is triggered on transition from 1 to 0.

This patch removes the decrementation from PWM channel setup code and
moves it instead to periodic timer setup, to make both periodic and
oneshot modes work correctly.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index cb86615..92b2f13 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -138,8 +138,6 @@ static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
 
 	tcon = __raw_readl(pwm.base + REG_TCON);
 
-	tcnt--;
-
 	tcon &= ~(TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan));
 	tcon |= TCON_MANUALUPDATE(tcon_chan);
 
@@ -187,7 +185,7 @@ static int samsung_set_next_event(unsigned long cycles,
 static void samsung_timer_resume(void)
 {
 	/* event timer restart */
-	samsung_time_setup(pwm.event_id, pwm.clock_count_per_tick);
+	samsung_time_setup(pwm.event_id, pwm.clock_count_per_tick - 1);
 	samsung_time_start(pwm.event_id, true);
 
 	/* source timer restart */
@@ -202,7 +200,7 @@ static void samsung_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		samsung_time_setup(pwm.event_id, pwm.clock_count_per_tick);
+		samsung_time_setup(pwm.event_id, pwm.clock_count_per_tick - 1);
 		samsung_time_start(pwm.event_id, true);
 		break;
 
-- 
1.8.2.1
