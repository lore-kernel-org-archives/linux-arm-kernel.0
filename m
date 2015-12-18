From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:58 +0100
Subject: [PATCH 45/69] clocksource/drivers/h8300_timer8: Remove pointless irq
 re-entrant safe code
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-45-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code assumes the interrupt function is re-entrant.

That is not correct. An interrupt handler is never invoked concurrently. The
interrupt line is masked on all processors.

Remove the chewing flags in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer8.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 3eedeff..7111b99 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -24,8 +24,6 @@
 #define TCORB	6
 #define _8TCNT	8
 
-#define FLAG_SKIPEVENT (1 << 1)
-#define FLAG_IRQCONTEXT (1 << 2)
 #define FLAG_STARTED (1 << 3)
 
 #define SCALE 64
@@ -67,14 +65,13 @@ static irqreturn_t timer8_interrupt(int irq, void *dev_id)
 
 	ctrl_outb(ctrl_inb(p->mapbase + _8TCSR) & ~0x40,
 		  p->mapbase + _8TCSR);
-	p->flags |= FLAG_IRQCONTEXT;
+
 	ctrl_outw(p->tcora, p->mapbase + TCORA);
-	if (!(p->flags & FLAG_SKIPEVENT)) {
-		if (clockevent_state_oneshot(&p->ced))
-			ctrl_outw(0x0000, p->mapbase + _8TCR);
-		p->ced.event_handler(&p->ced);
-	}
-	p->flags &= ~(FLAG_SKIPEVENT | FLAG_IRQCONTEXT);
+
+	if (clockevent_state_oneshot(&p->ced))
+		ctrl_outw(0x0000, p->mapbase + _8TCR);
+
+	p->ced.event_handler(&p->ced);
 
 	return IRQ_HANDLED;
 }
-- 
1.9.1
