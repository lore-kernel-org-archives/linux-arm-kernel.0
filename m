From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon,  4 Dec 2017 23:18:18 +0530
Subject: [PATCH 2/7 v2] net: ezchip: nps_enet: Fix platform_get_irq's error
 checking
In-Reply-To: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512409703-20881-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative number if an error
occurs, Zero if No irq is found and positive number if irq gets successful.
platform_get_irq() error checking only for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             commit message was not correct.

 drivers/net/ethernet/ezchip/nps_enet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ezchip/nps_enet.c b/drivers/net/ethernet/ezchip/nps_enet.c
index 659f1ad..7d4b628 100644
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
 
-- 
2.7.4
