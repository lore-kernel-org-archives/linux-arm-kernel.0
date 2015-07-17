From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:40:57 +0530
Subject: [PATCH 03/18] ARM/davinci/time: Migrate to new 'set-state' interface
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <bc660a454f7899f21f2106be1a16e8d006dd2dba.1437101996.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate davinci driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in set_mode(RESUME) and so .tick_resume()
isn't implemented.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-davinci/time.c | 54 ++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 160c9602f490..6c18445a4639 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -303,36 +303,42 @@ static int davinci_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static void davinci_set_mode(enum clock_event_mode mode,
-			     struct clock_event_device *evt)
+static int davinci_shutdown(struct clock_event_device *evt)
 {
 	struct timer_s *t = &timers[TID_CLOCKEVENT];
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		t->period = davinci_clock_tick_rate / (HZ);
-		t->opts &= ~TIMER_OPTS_STATE_MASK;
-		t->opts |= TIMER_OPTS_PERIODIC;
-		timer32_config(t);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		t->opts &= ~TIMER_OPTS_STATE_MASK;
-		t->opts |= TIMER_OPTS_ONESHOT;
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		t->opts &= ~TIMER_OPTS_STATE_MASK;
-		t->opts |= TIMER_OPTS_DISABLED;
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	t->opts &= ~TIMER_OPTS_STATE_MASK;
+	t->opts |= TIMER_OPTS_DISABLED;
+	return 0;
+}
+
+static int davinci_set_oneshot(struct clock_event_device *evt)
+{
+	struct timer_s *t = &timers[TID_CLOCKEVENT];
+
+	t->opts &= ~TIMER_OPTS_STATE_MASK;
+	t->opts |= TIMER_OPTS_ONESHOT;
+	return 0;
+}
+
+static int davinci_set_periodic(struct clock_event_device *evt)
+{
+	struct timer_s *t = &timers[TID_CLOCKEVENT];
+
+	t->period = davinci_clock_tick_rate / (HZ);
+	t->opts &= ~TIMER_OPTS_STATE_MASK;
+	t->opts |= TIMER_OPTS_PERIODIC;
+	timer32_config(t);
+	return 0;
 }
 
 static struct clock_event_device clockevent_davinci = {
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event	= davinci_set_next_event,
-	.set_mode	= davinci_set_mode,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event		= davinci_set_next_event,
+	.set_state_shutdown	= davinci_shutdown,
+	.set_state_periodic	= davinci_set_periodic,
+	.set_state_oneshot	= davinci_set_oneshot,
 };
 
 
-- 
2.4.0
