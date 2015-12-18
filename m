From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:56 +0100
Subject: [PATCH 43/69] clocksource/drivers/h8300_timer8: Remove PERIODIC and
 ONESHOT macro
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-43-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the delta as parameter for the timer8_clock_event_start function
instead of using a macro to tell PERIODIC or ONESHOT.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer8.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 88b9b06..2433325 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -28,9 +28,6 @@
 #define FLAG_IRQCONTEXT (1 << 2)
 #define FLAG_STARTED (1 << 3)
 
-#define ONESHOT  0
-#define PERIODIC 1
-
 #define SCALE 64
 
 struct timer8_priv {
@@ -147,7 +144,7 @@ static inline struct timer8_priv *ced_to_priv(struct clock_event_device *ced)
 	return container_of(ced, struct timer8_priv, ced);
 }
 
-static void timer8_clock_event_start(struct timer8_priv *p, int periodic)
+static void timer8_clock_event_start(struct timer8_priv *p, unsigned long delta)
 {
 	struct clock_event_device *ced = &p->ced;
 
@@ -158,7 +155,7 @@ static void timer8_clock_event_start(struct timer8_priv *p, int periodic)
 	ced->max_delta_ns = clockevent_delta2ns(0xffff, ced);
 	ced->min_delta_ns = clockevent_delta2ns(0x0001, ced);
 
-	timer8_set_next(p, periodic?(p->rate + HZ/2) / HZ:0x10000);
+	timer8_set_next(p, delta);
 }
 
 static int timer8_clock_event_shutdown(struct clock_event_device *ced)
@@ -173,7 +170,7 @@ static int timer8_clock_event_periodic(struct clock_event_device *ced)
 
 	pr_info("%s: used for periodic clock events\n", ced->name);
 	timer8_stop(p);
-	timer8_clock_event_start(p, PERIODIC);
+	timer8_clock_event_start(p, (p->rate + HZ/2) / HZ);
 
 	return 0;
 }
@@ -184,7 +181,7 @@ static int timer8_clock_event_oneshot(struct clock_event_device *ced)
 
 	pr_info("%s: used for oneshot clock events\n", ced->name);
 	timer8_stop(p);
-	timer8_clock_event_start(p, ONESHOT);
+	timer8_clock_event_start(p, 0x10000);
 
 	return 0;
 }
-- 
1.9.1
