From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 26 Aug 2016 16:20:43 +0200
Subject: [PATCH 1/3] clocksource/drivers/timer-atmel-pit: Enable mck clock
In-Reply-To: <57C05026.7010905@linaro.org>
References: <57C05026.7010905@linaro.org>
Message-ID: <1472221245-14265-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

mck is needed to get the PIT working. Explicitly prepare_enable it instead
of assuming it is enabled.

This solves an issue where the system is freezing when the ETM/ETB drivers
are enabled.

Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-atmel-pit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 1ffac0c..3494bc5 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -261,6 +261,12 @@ static int __init at91sam926x_pit_dt_init(struct device_node *node)
 		return PTR_ERR(data->mck);
 	}
 
+	ret = clk_prepare_enable(data->mck);
+	if (ret) {
+		pr_err("Unable to enable mck\n");
+		return ret;
+	}
+
 	/* Get the interrupts property */
 	data->irq = irq_of_parse_and_map(node, 0);
 	if (!data->irq) {
-- 
1.9.1
