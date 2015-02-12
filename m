From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Feb 2015 15:24:40 +0100
Subject: [PATCH 3/5] serial: mxs-auart: properly handle mctrl_gpio failing
In-Reply-To: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1423751082-15888-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If mctrl_gpio_init returns an error code this value should be forwarded and
the driver must not simply ignore this failure.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/mxs-auart.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ec553f8eb218..14430394985d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1157,14 +1157,14 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	return 0;
 }
 
-static bool mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
+static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
 {
 	enum mctrl_gpio_idx i;
 	struct gpio_desc *gpiod;
 
 	s->gpios = mctrl_gpio_init(dev, 0);
-	if (IS_ERR_OR_NULL(s->gpios))
-		return false;
+	if (IS_ERR(s->gpios))
+		return PTR_ERR(s->gpios);
 
 	/* Block (enabled before) DMA option if RTS or CTS is GPIO line */
 	if (!RTS_AT_AUART() || !CTS_AT_AUART()) {
@@ -1182,7 +1182,7 @@ static bool mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
 			s->gpio_irq[i] = -EINVAL;
 	}
 
-	return true;
+	return 0;
 }
 
 static void mxs_auart_free_gpio_irq(struct mxs_auart_port *s)
@@ -1279,9 +1279,11 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, s);
 
-	if (!mxs_auart_init_gpios(s, &pdev->dev))
-		dev_err(&pdev->dev,
-			"Failed to initialize GPIOs. The serial port may not work as expected\n");
+	ret = mxs_auart_init_gpios(s, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
+		got out_free_irq;
+	}
 
 	/*
 	 * Get the GPIO lines IRQ
-- 
2.1.4
