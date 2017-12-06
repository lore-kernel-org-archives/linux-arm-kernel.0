From: Stefan.Potyra@elektrobit.com (Stefan Potyra)
Date: Wed, 6 Dec 2017 16:03:24 +0100
Subject: [PATCH] SoC: rockchip: disable clock on error
Message-ID: <20171206150324.va4ph66ohjt3v7r3@agrajag.zerfleddert.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the clocks in  rk_spdif_probe when an error occurs after one
of the clocks has been enabled previously.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: f874b80e1571 ASoC: rockchip: Add rockchip SPDIF transceiver driver
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 sound/soc/rockchip/rockchip_spdif.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index ee5055d47d13..a89fe9b6463b 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -322,26 +322,30 @@ static int rk_spdif_probe(struct platform_device *pdev)
 	spdif->mclk = devm_clk_get(&pdev->dev, "mclk");
 	if (IS_ERR(spdif->mclk)) {
 		dev_err(&pdev->dev, "Can't retrieve rk_spdif master clock\n");
-		return PTR_ERR(spdif->mclk);
+		ret = PTR_ERR(spdif->mclk);
+		goto err_disable_hclk;
 	}
 
 	ret = clk_prepare_enable(spdif->mclk);
 	if (ret) {
 		dev_err(spdif->dev, "clock enable failed %d\n", ret);
-		return ret;
+		goto err_disable_clocks;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err_disable_clocks;
+	}
 
 	spdif->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "hclk", regs,
 						  &rk_spdif_regmap_config);
 	if (IS_ERR(spdif->regmap)) {
 		dev_err(&pdev->dev,
 			"Failed to initialise managed register map\n");
-		return PTR_ERR(spdif->regmap);
+		ret = PTR_ERR(spdif->regmap);
+		goto err_disable_clocks;
 	}
 
 	spdif->playback_dma_data.addr = res->start + SPDIF_SMPDR;
@@ -373,6 +377,10 @@ static int rk_spdif_probe(struct platform_device *pdev)
 
 err_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
+err_disable_clocks:
+	clk_disable_unprepare(spdif->mclk);
+err_disable_hclk:
+	clk_disable_unprepare(spdif->hclk);
 
 	return ret;
 }
-- 
2.15.1
