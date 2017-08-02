From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Wed,  2 Aug 2017 11:34:27 +0200
Subject: [PATCH 6/8] bcm63xx_enet: just use "enet" as the clock name
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Message-ID: <20170802093429.12572-7-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have the individual clocks available as "enet" we
don't need to rely on the device id for them anymore.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 61a88b64bd39..d6844923a1c0 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1718,7 +1718,6 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	struct bcm63xx_enet_platform_data *pd;
 	struct resource *res_mem, *res_irq, *res_irq_rx, *res_irq_tx;
 	struct mii_bus *bus;
-	const char *clk_name;
 	int i, ret;
 
 	/* stop if shared driver failed, assume driver->probe will be
@@ -1761,14 +1760,12 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	if (priv->mac_id == 0) {
 		priv->rx_chan = 0;
 		priv->tx_chan = 1;
-		clk_name = "enet0";
 	} else {
 		priv->rx_chan = 2;
 		priv->tx_chan = 3;
-		clk_name = "enet1";
 	}
 
-	priv->mac_clk = clk_get(&pdev->dev, clk_name);
+	priv->mac_clk = clk_get(&pdev->dev, "enet");
 	if (IS_ERR(priv->mac_clk)) {
 		ret = PTR_ERR(priv->mac_clk);
 		goto out;
-- 
2.13.2
