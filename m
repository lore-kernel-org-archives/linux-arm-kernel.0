From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 12:13:34 +0100
Subject: [PATCH 1/9] spi: rspi: Add missing clk_disable() calls in error and
 cleanup paths
In-Reply-To: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389525222-3482-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 04d512e1e894..5ce2127b2b43 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1066,6 +1066,7 @@ static int rspi_remove(struct platform_device *pdev)
 	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
 	rspi_release_dma(rspi);
+	clk_disable(rspi->clk);
 
 	return 0;
 }
@@ -1135,7 +1136,7 @@ static int rspi_probe(struct platform_device *pdev)
 	ret = ops->parse_platform_data(rspi, rspi_pd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "rspi invalid platform data.\n");
-		goto error1;
+		goto error2;
 	}
 
 	for (i = 0; i < MAX_NUM_IRQ; i++) {
@@ -1145,13 +1146,13 @@ static int rspi_probe(struct platform_device *pdev)
 				break;
 			dev_err(&pdev->dev, "platform_get_irq error\n");
 			ret = -ENODEV;
-			goto error1;
+			goto error2;
 		}
 		ret = devm_request_irq(&pdev->dev, irq, rspi_irq, 0,
 				       dev_name(&pdev->dev), rspi);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "request_irq %d error\n", irq);
-			goto error1;
+			goto error2;
 		}
 		rspi->irqs[i] = irq;
 		rspi->num_irqs++;
@@ -1160,21 +1161,23 @@ static int rspi_probe(struct platform_device *pdev)
 	ret = rspi_request_dma(rspi, pdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "rspi_request_dma failed.\n");
-		goto error2;
+		goto error3;
 	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master error.\n");
-		goto error2;
+		goto error3;
 	}
 
 	dev_info(&pdev->dev, "probed\n");
 
 	return 0;
 
-error2:
+error3:
 	rspi_release_dma(rspi);
+error2:
+	clk_disable(rspi->clk);
 error1:
 	spi_master_put(master);
 
-- 
1.7.9.5
