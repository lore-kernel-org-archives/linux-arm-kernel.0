From: shengyong1@huawei.com (Sheng Yong)
Date: Sat, 29 Nov 2014 01:48:10 +0000
Subject: [PATCH] net: hisilicon: unmap IO resources when cleanup
Message-ID: <1417225690-135860-1-git-send-email-shengyong1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unmap IO resources if the driver initailization failed or the driver is
unmounted.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 0ffdcd3..3399ce6 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -917,26 +917,26 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 	priv->ctrl_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(priv->ctrl_base)) {
 		ret = PTR_ERR(priv->ctrl_base);
-		goto out_free_netdev;
+		goto out_base;
 	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		netdev_err(ndev, "failed to get clk\n");
 		ret = -ENODEV;
-		goto out_free_netdev;
+		goto out_ctrl_base;
 	}
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret < 0) {
 		netdev_err(ndev, "failed to enable clk %d\n", ret);
-		goto out_free_netdev;
+		goto out_ctrl_base;
 	}
 
 	bus = mdiobus_alloc();
 	if (bus == NULL) {
 		ret = -ENOMEM;
-		goto out_free_netdev;
+		goto out_ctrl_base;
 	}
 
 	bus->priv = priv;
@@ -1019,6 +1019,10 @@ err_mdiobus:
 	mdiobus_unregister(bus);
 err_free_mdio:
 	mdiobus_free(bus);
+out_base:
+        iounmap(priv->base);
+out_ctrl_base:
+	iounmap(priv->ctrl_base);
 out_free_netdev:
 	free_netdev(ndev);
 
@@ -1038,6 +1042,8 @@ static int hix5hd2_dev_remove(struct platform_device *pdev)
 	hix5hd2_destroy_hw_desc_queue(priv);
 	of_node_put(priv->phy_node);
 	cancel_work_sync(&priv->tx_timeout_task);
+	iounmap(priv->base);
+	iounmap(priv->ctrl_base);
 	free_netdev(ndev);
 
 	return 0;
-- 
1.8.3.4
