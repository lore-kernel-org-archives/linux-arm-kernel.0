From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Feb 2015 15:24:39 +0100
Subject: [PATCH 2/5] serial: clps711x: fail if mctrl_gpio_init fails
In-Reply-To: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1423751082-15888-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mctrl_gpio_init is fully aware of being optional. If it returns an error
code this indicates a real error that must not be ignored.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/clps711x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 6e11c275f2ab..d5d2dd7c7917 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -501,6 +501,8 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, s);
 
 	s->gpios = mctrl_gpio_init(&pdev->dev, 0);
+	if (IS_ERR(s->gpios))
+	    return PTR_ERR(s->gpios);
 
 	ret = uart_add_one_port(&clps711x_uart, &s->port);
 	if (ret)
-- 
2.1.4
