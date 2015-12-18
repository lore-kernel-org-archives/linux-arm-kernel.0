From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:20 +0100
Subject: [PATCH 67/69] clocksource/drivers/h8300: Simplify delta handling
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-67-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer8.c | 40 ++++++--------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index aa4b2a98..1ba453b 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -36,57 +36,29 @@ struct timer8_priv {
 	unsigned int tcora;
 };
 
-static unsigned long timer8_get_counter(struct timer8_priv *p)
-{
-	unsigned long v1, v2, v3;
-	int o1, o2;
-
-	o1 = readb(p->mapbase + _8TCSR) & 0x20;
-
-	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
-	do {
-		o2 = o1;
-		v1 = readw(p->mapbase + _8TCNT);
-		v2 = readw(p->mapbase + _8TCNT);
-		v3 = readw(p->mapbase + _8TCNT);
-		o1 = readb(p->mapbase + _8TCSR) & 0x20;
-	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
-			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
-
-	v2 |= o1 << 10;
-	return v2;
-}
-
 static irqreturn_t timer8_interrupt(int irq, void *dev_id)
 {
 	struct timer8_priv *p = dev_id;
 
-	writeb(readb(p->mapbase + _8TCSR) & ~0x40,
-		  p->mapbase + _8TCSR);
-
-	writew(p->tcora, p->mapbase + TCORA);
-
 	if (clockevent_state_oneshot(&p->ced))
 		writew(0x0000, p->mapbase + _8TCR);
 
 	p->ced.event_handler(&p->ced);
 
+	writeb(readb(p->mapbase + _8TCSR) & ~0x40,
+		  p->mapbase + _8TCSR);
+
 	return IRQ_HANDLED;
 }
 
 static void timer8_set_next(struct timer8_priv *p, unsigned long delta)
 {
-	unsigned long now;
-
 	if (delta >= 0x10000)
 		pr_warn("delta out of range\n");
-	now = timer8_get_counter(p);
-	p->tcora = delta;
+	writeb(readb(p->mapbase + _8TCR) & ~0x40, p->mapbase + _8TCR);
+	writew(0, p->mapbase + _8TCNT);
+	writew(delta, p->mapbase + TCORA);
 	writeb(readb(p->mapbase + _8TCR) | 0x40, p->mapbase + _8TCR);
-	if (delta > now)
-		writew(delta, p->mapbase + TCORA);
-	else
-		writew(now + 1, p->mapbase + TCORA);
 }
 
 static int timer8_enable(struct timer8_priv *p)
-- 
1.9.1
