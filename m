From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 22 Jul 2013 14:14:32 +0200
Subject: [PATCH v3 05/31] [media] fsl-viu: cleanup clock API use
In-Reply-To: <1374495298-22019-1-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
Message-ID: <1374495298-22019-6-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

prepare clocks before enabling them, check for and propagate enable
errors, balance get/put and prepare/unprepare and enable/disable,
use devm_{get,put}_clk()

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/media/platform/fsl-viu.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index 221ec42..48fced4 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1485,6 +1485,7 @@ static int viu_of_probe(struct platform_device *op)
 	struct viu_reg __iomem *viu_regs;
 	struct i2c_adapter *ad;
 	int ret, viu_irq;
+	struct clk *clk;
 
 	ret = of_address_to_resource(op->dev.of_node, 0, &r);
 	if (ret) {
@@ -1577,14 +1578,19 @@ static int viu_of_probe(struct platform_device *op)
 	}
 
 	/* enable VIU clock */
-	viu_dev->clk = clk_get(&op->dev, "viu_clk");
-	if (IS_ERR(viu_dev->clk)) {
-		dev_err(&op->dev, "failed to find the clock module!\n");
-		ret = -ENODEV;
+	clk = devm_clk_get(&op->dev, "viu_clk");
+	if (IS_ERR(clk)) {
+		dev_err(&op->dev, "failed to lookup the clock!\n");
+		ret = PTR_ERR(clk);
+		goto err_clk;
+	}
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&op->dev, "failed to enable the clock!\n");
+		devm_clk_put(&op->dev, clk);
 		goto err_clk;
-	} else {
-		clk_enable(viu_dev->clk);
 	}
+	viu_dev->clk = clk;
 
 	/* reset VIU module */
 	viu_reset(viu_dev->vr);
@@ -1602,8 +1608,8 @@ static int viu_of_probe(struct platform_device *op)
 	return ret;
 
 err_irq:
-	clk_disable(viu_dev->clk);
-	clk_put(viu_dev->clk);
+	clk_disable_unprepare(viu_dev->clk);
+	devm_clk_put(&op->dev, viu_dev->clk);
 err_clk:
 	video_unregister_device(viu_dev->vdev);
 err_vdev:
@@ -1626,8 +1632,8 @@ static int viu_of_remove(struct platform_device *op)
 	free_irq(dev->irq, (void *)dev);
 	irq_dispose_mapping(dev->irq);
 
-	clk_disable(dev->clk);
-	clk_put(dev->clk);
+	clk_disable_unprepare(dev->clk);
+	devm_clk_put(&op->dev, dev->clk);
 
 	video_unregister_device(dev->vdev);
 	i2c_put_adapter(client->adapter);
-- 
1.7.10.4
