From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  4 Jul 2016 18:00:09 +0200
Subject: [PATCH] clocksource: timer-atmel-pit: enable mck
Message-ID: <1467648009-24269-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mck is needed to get the PIT working. Explicitly prepare_enable it instead
of assuming it is enabled.

This solves an issue were the system is freezing when the ETM/ETB drivers
are enabled.

Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-pit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index d911c5dca8f1..fcc97711cd79 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -248,6 +248,9 @@ static void __init at91sam926x_pit_dt_init(struct device_node *node)
 	if (IS_ERR(data->mck))
 		panic(pr_fmt("Unable to get mck clk\n"));
 
+	if (clk_prepare_enable(data->mck))
+		panic(pr_fmt("Unable to enable mck\n"));
+
 	/* Get the interrupts property */
 	data->irq = irq_of_parse_and_map(node, 0);
 	if (!data->irq)
-- 
2.8.1
