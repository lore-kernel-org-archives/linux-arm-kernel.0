From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 29 Jul 2016 17:33:57 -0700
Subject: [PATCH net-next 04/10] drivers: net: xgene: Fix error deconstruction
 path
In-Reply-To: <1469838843-19943-1-git-send-email-isubramanian@apm.com>
References: <1469838843-19943-1-git-send-email-isubramanian@apm.com>
Message-ID: <1469838843-19943-5-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since register_netdev() call in xgene_enet_probe() was moved down to
the end, it doesn't properly handle errors that may occur, by
deconstructing everything that was setup before the error occurred.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 27 +++++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 6fc5698..d05f999 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -1643,8 +1643,8 @@ static int xgene_enet_probe(struct platform_device *pdev)
 	}
 #endif
 	if (!pdata->enet_id) {
-		free_netdev(ndev);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err;
 	}
 
 	ret = xgene_enet_get_resources(pdata);
@@ -1667,7 +1667,7 @@ static int xgene_enet_probe(struct platform_device *pdev)
 
 	ret = xgene_enet_init_hw(pdata);
 	if (ret)
-		goto err_netdev;
+		goto err;
 
 	link_state = pdata->mac_ops->link_state;
 	if (pdata->phy_mode == PHY_INTERFACE_MODE_XGMII) {
@@ -1677,21 +1677,32 @@ static int xgene_enet_probe(struct platform_device *pdev)
 			ret = xgene_enet_mdio_config(pdata);
 		else
 			INIT_DELAYED_WORK(&pdata->link_work, link_state);
+
+		if (ret)
+			goto err1;
 	}
-	if (ret)
-		goto err;
 
 	xgene_enet_napi_add(pdata);
 	ret = register_netdev(ndev);
 	if (ret) {
 		netdev_err(ndev, "Failed to register netdev\n");
-		goto err;
+		goto err2;
 	}
 
 	return 0;
 
-err_netdev:
-	unregister_netdev(ndev);
+err2:
+	/*
+	 * If necessary, free_netdev() will call netif_napi_del() and undo
+	 * the effects of xgene_enet_napi_add()'s calls to netif_napi_add().
+	 */
+
+	if (pdata->mdio_driver)
+		xgene_enet_phy_disconnect(pdata);
+	else if (pdata->phy_mode == PHY_INTERFACE_MODE_RGMII)
+		xgene_enet_mdio_remove(pdata);
+err1:
+	xgene_enet_delete_desc_rings(pdata);
 err:
 	free_netdev(ndev);
 	return ret;
-- 
1.9.1
