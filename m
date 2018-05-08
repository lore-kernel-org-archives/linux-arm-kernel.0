From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  8 May 2018 12:05:42 +0200
Subject: [PATCH v3 2/3] can: simplify LED trigger handling
In-Reply-To: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20180508100543.12559-3-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new function led_trigger_register_format allows one to simplify LED
trigger handling considerably.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/net/can/led.c   | 30 +++++++-----------------------
 include/linux/can/dev.h |  3 ---
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
index 2d7d1b0d20f9..111f9769e9da 100644
--- a/drivers/net/can/led.c
+++ b/drivers/net/can/led.c
@@ -81,19 +81,9 @@ void devm_can_led_init(struct net_device *netdev)
 		return;
 	}
 
-	snprintf(priv->tx_led_trig_name, sizeof(priv->tx_led_trig_name),
-		 "%s-tx", netdev->name);
-	snprintf(priv->rx_led_trig_name, sizeof(priv->rx_led_trig_name),
-		 "%s-rx", netdev->name);
-	snprintf(priv->rxtx_led_trig_name, sizeof(priv->rxtx_led_trig_name),
-		 "%s-rxtx", netdev->name);
-
-	led_trigger_register_simple(priv->tx_led_trig_name,
-				    &priv->tx_led_trig);
-	led_trigger_register_simple(priv->rx_led_trig_name,
-				    &priv->rx_led_trig);
-	led_trigger_register_simple(priv->rxtx_led_trig_name,
-				    &priv->rxtx_led_trig);
+	led_trigger_register_format(&priv->tx_led_trig, "%s-tx", netdev->name);
+	led_trigger_register_format(&priv->rx_led_trig, "%s-rx", netdev->name);
+	led_trigger_register_format(&priv->rxtx_led_trig, "%s-rxtx", netdev->name);
 
 	devres_add(&netdev->dev, res);
 }
@@ -105,23 +95,17 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
 	struct can_priv *priv = safe_candev_priv(netdev);
-	char name[CAN_LED_NAME_SZ];
 
 	if (!priv)
 		return NOTIFY_DONE;
 
-	if (!priv->tx_led_trig || !priv->rx_led_trig || !priv->rxtx_led_trig)
-		return NOTIFY_DONE;
-
 	if (msg == NETDEV_CHANGENAME) {
-		snprintf(name, sizeof(name), "%s-tx", netdev->name);
-		led_trigger_rename(priv->tx_led_trig, name);
+		led_trigger_rename(priv->tx_led_trig, "%s-tx", netdev->name);
 
-		snprintf(name, sizeof(name), "%s-rx", netdev->name);
-		led_trigger_rename(priv->rx_led_trig, name);
+		led_trigger_rename(priv->rx_led_trig, "%s-rx", netdev->name);
 
-		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
-		led_trigger_rename(priv->rxtx_led_trig, name);
+		led_trigger_rename(priv->rxtx_led_trig,
+				   "%s-rxtx", netdev->name);
 	}
 
 	return NOTIFY_DONE;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 055aaf5ed9af..ff358269aa9c 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -73,11 +73,8 @@ struct can_priv {
 
 #ifdef CONFIG_CAN_LEDS
 	struct led_trigger *tx_led_trig;
-	char tx_led_trig_name[CAN_LED_NAME_SZ];
 	struct led_trigger *rx_led_trig;
-	char rx_led_trig_name[CAN_LED_NAME_SZ];
 	struct led_trigger *rxtx_led_trig;
-	char rxtx_led_trig_name[CAN_LED_NAME_SZ];
 #endif
 };
 
-- 
2.17.0
