From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Sat, 20 Jan 2018 00:53:15 +0300
Subject: [PATCH] crypto: picoxcell - Fix error handling in spacc_probe()
Message-ID: <1516398795-9018-1-git-send-email-khoroshilov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If clk_get() fails, device_remove_file() looks inappropriate.

The error path, where all crypto_register fail, misses resource
deallocations.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/crypto/picoxcell_crypto.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 5a6dc53b2b9d..4ef52c9d72fc 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1618,7 +1618,7 @@ MODULE_DEVICE_TABLE(of, spacc_of_id_table);
 
 static int spacc_probe(struct platform_device *pdev)
 {
-	int i, err, ret = -EINVAL;
+	int i, err, ret;
 	struct resource *mem, *irq;
 	struct device_node *np = pdev->dev.of_node;
 	struct spacc_engine *engine = devm_kzalloc(&pdev->dev, sizeof(*engine),
@@ -1679,22 +1679,18 @@ static int spacc_probe(struct platform_device *pdev)
 	engine->clk = clk_get(&pdev->dev, "ref");
 	if (IS_ERR(engine->clk)) {
 		dev_info(&pdev->dev, "clk unavailable\n");
-		device_remove_file(&pdev->dev, &dev_attr_stat_irq_thresh);
 		return PTR_ERR(engine->clk);
 	}
 
 	if (clk_prepare_enable(engine->clk)) {
 		dev_info(&pdev->dev, "unable to prepare/enable clk\n");
-		clk_put(engine->clk);
-		return -EIO;
+		ret = -EIO;
+		goto err_clk_put;
 	}
 
-	err = device_create_file(&pdev->dev, &dev_attr_stat_irq_thresh);
-	if (err) {
-		clk_disable_unprepare(engine->clk);
-		clk_put(engine->clk);
-		return err;
-	}
+	ret = device_create_file(&pdev->dev, &dev_attr_stat_irq_thresh);
+	if (ret)
+		goto err_clk_disable;
 
 
 	/*
@@ -1725,6 +1721,7 @@ static int spacc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, engine);
 
+	ret = -EINVAL;
 	INIT_LIST_HEAD(&engine->registered_algs);
 	for (i = 0; i < engine->num_algs; ++i) {
 		engine->algs[i].engine = engine;
@@ -1759,6 +1756,16 @@ static int spacc_probe(struct platform_device *pdev)
 				engine->aeads[i].alg.base.cra_name);
 	}
 
+	if (!ret)
+		return 0;
+
+	del_timer_sync(&engine->packet_timeout);
+	device_remove_file(&pdev->dev, &dev_attr_stat_irq_thresh);
+err_clk_disable:
+	clk_disable_unprepare(engine->clk);
+err_clk_put:
+	clk_put(engine->clk);
+
 	return ret;
 }
 
-- 
2.7.4
