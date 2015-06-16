From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jun 2015 23:06:45 +0100
Subject: [PATCH 6/9] gpio: gpio-mxs: fix race in installing chained IRQ handler
Message-ID: <E1Z4z0H-0002Sf-P9@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a race where a pending interrupt could be received and the handler
called before the handler's data has been setup, by converting to
irq_set_chained_handler_and_data().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Depends on patch 1.

 drivers/gpio/gpio-mxs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 84cbda6acdda..eac872748ee7 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -320,8 +320,8 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 	mxs_gpio_init_gc(port, irq_base);
 
 	/* setup one handler for each entry */
-	irq_set_chained_handler(port->irq, mxs_gpio_irq_handler);
-	irq_set_handler_data(port->irq, port);
+	irq_set_chained_handler_and_data(port->irq, mxs_gpio_irq_handler,
+					 port);
 
 	err = bgpio_init(&port->bgc, &pdev->dev, 4,
 			 port->base + PINCTRL_DIN(port),
-- 
2.1.0
