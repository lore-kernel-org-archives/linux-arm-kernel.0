From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu,  4 Feb 2016 18:21:33 +0100
Subject: [PATCH v1] clocksource: atmel-pit: register as a sched_clock
Message-ID: <1454606493-15094-1-git-send-email-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the counter of the Periodic Interval Timer as a possible source
for sched_clock. This provides a better precision than the jiffies-based
default.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---

To reduce overhead and cache consumption, sched_clock_register does not
take a void* argument, as it is the case when using interrupt handlers.
As a result, the signature of the function used to read the counter is
u64 (*) (void). It is thus necessary to use a static variable inside the
driver to keep a reference to the clocksource. It is a common pattern in
other existing clocksource drivers.

All existing Atmel SoCs that rely on the PIT only have a single instance
of the controller, and future SoCs should remain this way as additional
timers are provided in 'Timer Counter' controllers. Additional code
handling the case of multiple PIT instances would thus be dead code.

 drivers/clocksource/timer-atmel-pit.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index d911c5dca8f1..744e1afc4b69 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -21,6 +21,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/slab.h>
+#include <linux/sched_clock.h>
 
 #define AT91_PIT_MR		0x00			/* Mode Register */
 #define AT91_PIT_PITIEN			BIT(25)			/* Timer Interrupt Enable */
@@ -174,6 +175,13 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static struct clocksource *pit_sched_clock;
+
+static u64 pit_sched_clock_read(void)
+{
+	return read_pit_clk(pit_sched_clock);
+}
+
 /*
  * Set up both clocksource and clockevent support.
  */
@@ -206,6 +214,9 @@ static void __init at91sam926x_pit_common_init(struct pit_data *data)
 	data->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 	clocksource_register_hz(&data->clksrc, pit_rate);
 
+	pit_sched_clock = &data->clksrc;
+	sched_clock_register(pit_sched_clock_read, bits, pit_rate);
+
 	/* Set up irq handler */
 	ret = request_irq(data->irq, at91sam926x_pit_interrupt,
 			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
-- 
2.5.0
