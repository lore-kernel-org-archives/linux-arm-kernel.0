From: andrew.jackson@arm.com (Andrew Jackson)
Date: Tue, 30 Dec 2014 10:55:43 +0000
Subject: [PATCH v5 1/6] ASoC: dwc: Switch to managed clock resource
In-Reply-To: <cover.1419936132.git.Andrew.Jackson@arm.com>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
Message-ID: <af6e23a9f11ead4b8abd1f70dbf634964253b37f.1419936132.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

Simplify error handling during probe by using managed clock
resources.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 06d3a34..5e9d163 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -407,13 +407,13 @@ static int dw_i2s_probe(struct platform_device *pdev)
 
 	dev->capability = pdata->cap;
 	dev->i2s_clk_cfg = pdata->i2s_clk_cfg;
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return  PTR_ERR(dev->clk);
 
 	ret = clk_enable(dev->clk);
 	if (ret < 0)
-		goto err_clk_put;
+		return ret;
 
 	dev_set_drvdata(&pdev->dev, dev);
 	ret = snd_soc_register_component(&pdev->dev, &dw_i2s_component,
@@ -427,19 +427,13 @@ static int dw_i2s_probe(struct platform_device *pdev)
 
 err_clk_disable:
 	clk_disable(dev->clk);
-err_clk_put:
-	clk_put(dev->clk);
 	return ret;
 }
 
 static int dw_i2s_remove(struct platform_device *pdev)
 {
-	struct dw_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
-
 	snd_soc_unregister_component(&pdev->dev);
 
-	clk_put(dev->clk);
-
 	return 0;
 }
 
-- 
1.7.1
