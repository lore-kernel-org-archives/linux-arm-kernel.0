From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:59 +0100
Subject: [PATCH 46/69] clocksource/drivers/h8300_timer8: Remove irq and lock
 legacy code
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-46-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The time framawork takes care of disabling the interrupts and takes a lock
to prevent races.

Remove the legacy code in the driver taking care of the races.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer8.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 7111b99..24d91b1 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -31,7 +31,6 @@
 struct timer8_priv {
 	struct clock_event_device ced;
 	unsigned long mapbase;
-	raw_spinlock_t lock;
 	unsigned long flags;
 	unsigned int rate;
 	unsigned int tcora;
@@ -78,10 +77,8 @@ static irqreturn_t timer8_interrupt(int irq, void *dev_id)
 
 static void timer8_set_next(struct timer8_priv *p, unsigned long delta)
 {
-	unsigned long flags;
 	unsigned long now;
 
-	raw_spin_lock_irqsave(&p->lock, flags);
 	if (delta >= 0x10000)
 		pr_warn("delta out of range\n");
 	now = timer8_get_counter(p);
@@ -91,8 +88,6 @@ static void timer8_set_next(struct timer8_priv *p, unsigned long delta)
 		ctrl_outw(delta, p->mapbase + TCORA);
 	else
 		ctrl_outw(now + 1, p->mapbase + TCORA);
-
-	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int timer8_enable(struct timer8_priv *p)
@@ -108,9 +103,6 @@ static int timer8_enable(struct timer8_priv *p)
 static int timer8_start(struct timer8_priv *p)
 {
 	int ret = 0;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&p->lock, flags);
 
 	if (!(p->flags & FLAG_STARTED))
 		ret = timer8_enable(p);
@@ -120,20 +112,12 @@ static int timer8_start(struct timer8_priv *p)
 	p->flags |= FLAG_STARTED;
 
  out:
-	raw_spin_unlock_irqrestore(&p->lock, flags);
-
 	return ret;
 }
 
 static void timer8_stop(struct timer8_priv *p)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&p->lock, flags);
-
 	ctrl_outw(0x0000, p->mapbase + _8TCR);
-
-	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static inline struct timer8_priv *ced_to_priv(struct clock_event_device *ced)
-- 
1.9.1
