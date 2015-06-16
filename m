From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jun 2015 23:06:40 +0100
Subject: [PATCH 5/9] gpio: gpio-mxc: fix race in installing chained IRQ handler
Message-ID: <E1Z4z0C-0002SX-Lj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a race where a pending interrupt could be received and the handler
called before the handler's data has been setup, by converting to
irq_set_chained_handler_and_data().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Depends on patch 1.

 drivers/gpio/gpio-mxc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 9f7446a7ac64..e4f42c95c320 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -437,14 +437,13 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		irq_set_chained_handler(port->irq, mx2_gpio_irq_handler);
 	} else {
 		/* setup one handler for each entry */
-		irq_set_chained_handler(port->irq, mx3_gpio_irq_handler);
-		irq_set_handler_data(port->irq, port);
-		if (port->irq_high > 0) {
+		irq_set_chained_handler_and_data(port->irq,
+						 mx3_gpio_irq_handler, port);
+		if (port->irq_high > 0)
 			/* setup handler for GPIO 16 to 31 */
-			irq_set_chained_handler(port->irq_high,
-						mx3_gpio_irq_handler);
-			irq_set_handler_data(port->irq_high, port);
-		}
+			irq_set_chained_handler_and_data(port->irq_high,
+							 mx3_gpio_irq_handler,
+							 port);
 	}
 
 	err = bgpio_init(&port->bgc, &pdev->dev, 4,
-- 
2.1.0
