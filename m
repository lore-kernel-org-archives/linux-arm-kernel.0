From: amsfield22@gmail.com (Alison Schofield)
Date: Tue, 5 Apr 2016 22:15:55 -0700
Subject: [PATCH 1/9] iio: adc: exynos_adc: use regmap to retrieve struct device
In-Reply-To: <cover.1459918214.git.amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
Message-ID: <2329d20396db00b60f4e7d2e783ea46b48eea9c1.1459918214.git.amsfield22@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver includes struct regmap and struct device in its global data.
Remove the struct device and use regmap API to retrieve device info.

Patch created using Coccinelle plus manual edits.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/adc/exynos_adc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index c15756d..0313e0f 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -130,7 +130,6 @@
 
 struct exynos_adc {
 	struct exynos_adc_data	*data;
-	struct device		*dev;
 	struct input_dev	*input;
 	void __iomem		*regs;
 	struct regmap		*pmu_map;
@@ -173,11 +172,12 @@ static void exynos_adc_unprepare_clk(struct exynos_adc *info)
 
 static int exynos_adc_prepare_clk(struct exynos_adc *info)
 {
+	struct device *dev = regmap_get_device(info->pmu_map);
 	int ret;
 
 	ret = clk_prepare(info->clk);
 	if (ret) {
-		dev_err(info->dev, "failed preparing adc clock: %d\n", ret);
+		dev_err(dev, "failed preparing adc clock: %d\n", ret);
 		return ret;
 	}
 
@@ -185,7 +185,7 @@ static int exynos_adc_prepare_clk(struct exynos_adc *info)
 		ret = clk_prepare(info->sclk);
 		if (ret) {
 			clk_unprepare(info->clk);
-			dev_err(info->dev,
+			dev_err(dev,
 				"failed preparing sclk_adc clock: %d\n", ret);
 			return ret;
 		}
@@ -203,11 +203,12 @@ static void exynos_adc_disable_clk(struct exynos_adc *info)
 
 static int exynos_adc_enable_clk(struct exynos_adc *info)
 {
+	struct device *dev = regmap_get_device(info->pmu_map);
 	int ret;
 
 	ret = clk_enable(info->clk);
 	if (ret) {
-		dev_err(info->dev, "failed enabling adc clock: %d\n", ret);
+		dev_err(dev, "failed enabling adc clock: %d\n", ret);
 		return ret;
 	}
 
@@ -215,7 +216,7 @@ static int exynos_adc_enable_clk(struct exynos_adc *info)
 		ret = clk_enable(info->sclk);
 		if (ret) {
 			clk_disable(info->clk);
-			dev_err(info->dev,
+			dev_err(dev,
 				"failed enabling sclk_adc clock: %d\n", ret);
 			return ret;
 		}
@@ -610,13 +611,14 @@ static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
 static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
 {
 	struct exynos_adc *info = dev_id;
-	struct iio_dev *dev = dev_get_drvdata(info->dev);
+	struct device *dev = regmap_get_device(info->pmu_map);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	u32 x, y;
 	bool pressed;
 	int ret;
 
 	while (info->input->users) {
-		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
+		ret = exynos_read_s3c64xx_ts(indio_dev, &x, &y);
 		if (ret == -ETIMEDOUT)
 			break;
 
@@ -800,8 +802,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	info->tsirq = irq;
 
-	info->dev = &pdev->dev;
-
 	init_completion(&info->completion);
 
 	info->clk = devm_clk_get(&pdev->dev, "adc");
-- 
2.1.4
