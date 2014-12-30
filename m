From: andrew.jackson@arm.com (Andrew Jackson)
Date: Tue, 30 Dec 2014 10:55:44 +0000
Subject: [PATCH v5 2/6] ASoC: dwc: Prepare clock before use
In-Reply-To: <cover.1419936132.git.Andrew.Jackson@arm.com>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
Message-ID: <faa0193d388fe808c2fae461954bb1730ba29244.1419936132.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

Some I2S clocks may require some time to get the clock ready
for operation and so need to be prepared before they are enabled.
So, prepare the clock as well as enabling it, but combine the
two through clk_prepare_enable.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 5e9d163..08608c1 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -411,7 +411,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->clk))
 		return  PTR_ERR(dev->clk);
 
-	ret = clk_enable(dev->clk);
+	ret = clk_prepare_enable(dev->clk);
 	if (ret < 0)
 		return ret;
 
@@ -426,13 +426,16 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_disable:
-	clk_disable(dev->clk);
+	clk_disable_unprepare(dev->clk);
 	return ret;
 }
 
 static int dw_i2s_remove(struct platform_device *pdev)
 {
+	struct dw_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
+
 	snd_soc_unregister_component(&pdev->dev);
+	clk_disable_unprepare(dev->clk);
 
 	return 0;
 }
-- 
1.7.1
