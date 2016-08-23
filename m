From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 23 Aug 2016 10:44:02 +0200
Subject: [PATCH v3 1/4] clocksource: timer-atmel-pit: enable mck
In-Reply-To: <1471941845-24813-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1471941845-24813-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1471941845-24813-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mck is needed to get the PIT working. Explicitly prepare_enable it instead
of assuming it is enabled.

This solves an issue where the system is freezing when the ETM/ETB drivers
are enabled.

Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-pit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 1ffac0cb0cb7..3494bc5a21d5 100644
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
2.8.1
