From: leilk.liu@mediatek.com (Leilk Liu)
Date: Wed, 25 Nov 2015 17:50:38 +0800
Subject: [PATCH v3] spi: mediatek: revise mtk_spi_probe() failure flow
Message-ID: <1448445038-10570-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtk_spi_probe() calls pm_runtime_enable(), after
pm_runtime_enable() is called, it should call
pm_runtime_disable() in the failure flow.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6c1a96e..00a36da 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -607,7 +607,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
-		goto err_disable_clk;
+		clk_disable_unprepare(mdata->spi_clk);
+		goto err_put_master;
 	}
 
 	clk_disable_unprepare(mdata->spi_clk);
@@ -617,7 +618,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
-		goto err_put_master;
+		goto err_disable_runtime_pm;
 	}
 
 	if (mdata->dev_comp->need_pad_sel) {
@@ -626,14 +627,14 @@ static int mtk_spi_probe(struct platform_device *pdev)
 				"pad_num does not match num_chipselect(%d != %d)\n",
 				mdata->pad_num, master->num_chipselect);
 			ret = -EINVAL;
-			goto err_put_master;
+			goto err_disable_runtime_pm;
 		}
 
 		if (!master->cs_gpios && master->num_chipselect > 1) {
 			dev_err(&pdev->dev,
 				"cs_gpios not specified and num_chipselect > 1\n");
 			ret = -EINVAL;
-			goto err_put_master;
+			goto err_disable_runtime_pm;
 		}
 
 		if (master->cs_gpios) {
@@ -644,7 +645,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 				if (ret) {
 					dev_err(&pdev->dev,
 						"can't get CS GPIO %i\n", i);
-					goto err_put_master;
+					goto err_disable_runtime_pm;
 				}
 			}
 		}
@@ -652,8 +653,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_disable_clk:
-	clk_disable_unprepare(mdata->spi_clk);
+err_disable_runtime_pm:
+	pm_runtime_disable(&pdev->dev);
 err_put_master:
 	spi_master_put(master);
 
-- 
1.7.9.5
