From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Sep 2013 17:53:32 +0200
Subject: [PATCH] serial: clps711x: drop needless devm_clk_put
In-Reply-To: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1379951612-2471-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nice thing about devm_* is that the driver doesn't need to free the
resources but the driver core takes care about that.

These calls were introduced in commit c08f015 (serial: clps711x: Using
CPU clock subsystem for getting base UART speed).

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Russell King <linux@arm.linux.org.uk>
---
 drivers/tty/serial/clps711x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 7e4e408..8d0b994 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -459,7 +459,6 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	ret = uart_register_driver(&s->uart);
 	if (ret) {
 		dev_err(&pdev->dev, "Registering UART driver failed\n");
-		devm_clk_put(&pdev->dev, s->uart_clk);
 		return ret;
 	}
 
@@ -487,7 +486,6 @@ static int uart_clps711x_remove(struct platform_device *pdev)
 	for (i = 0; i < UART_CLPS711X_NR; i++)
 		uart_remove_one_port(&s->uart, &s->port[i]);
 
-	devm_clk_put(&pdev->dev, s->uart_clk);
 	uart_unregister_driver(&s->uart);
 
 	return 0;
-- 
1.8.4.rc3
