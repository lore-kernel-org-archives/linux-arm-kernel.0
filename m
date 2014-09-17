From: davidcdueck@googlemail.com (David Dueck)
Date: Wed, 17 Sep 2014 14:26:48 +0200
Subject: [PATCHv2] can: at91_can: prepare and unprepare the clock
Message-ID: <1410956808-1964-1-git-send-email-davidcdueck@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the driver work with the common clock framework.

Signed-off-by: David Dueck <davidcdueck@googlemail.com>
Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>
---
Changes since v1:
- improve commit message
- check return value of clk_prepare_enable

 drivers/net/can/at91_can.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index f07fa89..05e1aa0 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1123,7 +1123,9 @@ static int at91_open(struct net_device *dev)
 	struct at91_priv *priv = netdev_priv(dev);
 	int err;
 
-	clk_enable(priv->clk);
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		return err;
 
 	/* check or determine and set bittime */
 	err = open_candev(dev);
@@ -1149,7 +1151,7 @@ static int at91_open(struct net_device *dev)
  out_close:
 	close_candev(dev);
  out:
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return err;
 }
@@ -1166,7 +1168,7 @@ static int at91_close(struct net_device *dev)
 	at91_chip_stop(dev, CAN_STATE_STOPPED);
 
 	free_irq(dev->irq, dev);
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	close_candev(dev);
 
-- 
2.1.0
