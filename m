From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Dec 2011 20:00:38 +0800
Subject: [PATCH 07/12] net: flexcan: convert to clk_prepare/clk_unprepare
In-Reply-To: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1324382443-4439-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch converts flexcan driver to clk_prepare/clk_unprepare by
using helper functions clk_prepare_enable/clk_disable_unprepare.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David S. Miller <davem@davemloft.net>
---
 drivers/net/can/flexcan.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e023379..fdd0f3f 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -802,7 +802,7 @@ static int flexcan_open(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	clk_enable(priv->clk);
+	clk_prepare_enable(priv->clk);
 
 	err = open_candev(dev);
 	if (err)
@@ -824,7 +824,7 @@ static int flexcan_open(struct net_device *dev)
  out_close:
 	close_candev(dev);
  out:
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return err;
 }
@@ -838,7 +838,7 @@ static int flexcan_close(struct net_device *dev)
 	flexcan_chip_stop(dev);
 
 	free_irq(dev->irq, dev);
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	close_candev(dev);
 
@@ -877,7 +877,7 @@ static int __devinit register_flexcandev(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	u32 reg, err;
 
-	clk_enable(priv->clk);
+	clk_prepare_enable(priv->clk);
 
 	/* select "bus clock", chip must be disabled */
 	flexcan_chip_disable(priv);
@@ -911,7 +911,7 @@ static int __devinit register_flexcandev(struct net_device *dev)
  out:
 	/* disable core and turn off clocks */
 	flexcan_chip_disable(priv);
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return err;
 }
-- 
1.7.4.1
