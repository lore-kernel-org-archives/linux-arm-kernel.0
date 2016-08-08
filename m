From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  8 Aug 2016 15:33:53 +0200
Subject: [PATCH v2 4/4] clocksource: timer-atmel-pit: simplify IRQ handler
In-Reply-To: <1470663233-15118-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1470663233-15118-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1470663233-15118-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the PIT is also a proper clocksource, the timekeeping code  is
already able to handle lost ticks.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-pit.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index af657fdce665..c5f3291328bd 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -152,15 +152,10 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 	/* The PIT interrupt may be disabled, and is shared */
 	if (clockevent_state_periodic(&data->clkevt) &&
 	    (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS)) {
-		unsigned nr_ticks;
-
 		/* Get number of ticks performed before irq, and ack it */
-		nr_ticks = PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
-		do {
-			data->cnt += data->cycle;
-			data->clkevt.event_handler(&data->clkevt);
-			nr_ticks--;
-		} while (nr_ticks);
+		data->cnt += data->cycle * PIT_PICNT(pit_read(data->base,
+							      AT91_PIT_PIVR));
+		data->clkevt.event_handler(&data->clkevt);
 
 		return IRQ_HANDLED;
 	}
-- 
2.8.1
