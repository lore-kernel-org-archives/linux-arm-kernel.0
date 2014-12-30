From: andrew.jackson@arm.com (Andrew Jackson)
Date: Tue, 30 Dec 2014 10:55:46 +0000
Subject: [PATCH v5 4/6] ASoC: dwc: Register components with managed interface
In-Reply-To: <cover.1419936132.git.Andrew.Jackson@arm.com>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
Message-ID: <6bd7d7cfd48fedccd8730ddbbae39f92dd0069c7.1419936132.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

Register SOC component using managed interface to
simplify error handling and future introduction of
device tree.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index b3e7567..e1c0e2c 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -492,7 +492,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		return ret;
 
 	dev_set_drvdata(&pdev->dev, dev);
-	ret = snd_soc_register_component(&pdev->dev, &dw_i2s_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &dw_i2s_component,
 					 dw_i2s_dai, 1);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "not able to register dai\n");
@@ -510,7 +510,6 @@ static int dw_i2s_remove(struct platform_device *pdev)
 {
 	struct dw_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_component(&pdev->dev);
 	clk_disable_unprepare(dev->clk);
 
 	return 0;
-- 
1.7.1
