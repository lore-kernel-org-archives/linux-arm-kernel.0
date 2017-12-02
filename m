From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun,  3 Dec 2017 00:56:13 +0530
Subject: [PATCH 01/10] net: bcmgenet: Fix platform_get_irq's error checking
In-Reply-To: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512242782-7134-2-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 24b4f4c..e2f1268 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3371,7 +3371,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	priv->irq0 = platform_get_irq(pdev, 0);
 	priv->irq1 = platform_get_irq(pdev, 1);
 	priv->wol_irq = platform_get_irq(pdev, 2);
-	if (!priv->irq0 || !priv->irq1) {
+	if (priv->irq0 <= 0 || priv->irq1 <= 0 || priv->wol_irq <= 0) {
 		dev_err(&pdev->dev, "can't find IRQs\n");
 		err = -EINVAL;
 		goto err;
-- 
2.7.4
