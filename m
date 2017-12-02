From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun,  3 Dec 2017 00:56:15 +0530
Subject: [PATCH 03/10] net: ezchip: nps_enet: Fix platform_get_irq's error
 checking
In-Reply-To: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512242782-7134-4-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct. And remove unnecessary check for free_netdev().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/net/ethernet/ezchip/nps_enet.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ezchip/nps_enet.c b/drivers/net/ethernet/ezchip/nps_enet.c
index 659f1ad..82dc6d0 100644
--- a/drivers/net/ethernet/ezchip/nps_enet.c
+++ b/drivers/net/ethernet/ezchip/nps_enet.c
@@ -623,9 +623,9 @@ static s32 nps_enet_probe(struct platform_device *pdev)
 
 	/* Get IRQ number */
 	priv->irq = platform_get_irq(pdev, 0);
-	if (!priv->irq) {
+	if (priv->irq <= 0) {
 		dev_err(dev, "failed to retrieve <irq Rx-Tx> value from device tree\n");
-		err = -ENODEV;
+		err = priv->irq ? priv->irq : -ENODEV;
 		goto out_netdev;
 	}
 
@@ -646,8 +646,7 @@ static s32 nps_enet_probe(struct platform_device *pdev)
 out_netif_api:
 	netif_napi_del(&priv->napi);
 out_netdev:
-	if (err)
-		free_netdev(ndev);
+	free_netdev(ndev);
 
 	return err;
 }
-- 
2.7.4
