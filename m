From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Mon, 15 Jan 2018 09:57:39 +0100
Subject: [PATCH] IIO:ADC: stm32-dfsdm: code optimization
Message-ID: <1516006659-15845-1-git-send-email-arnaud.pouliquen@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_device_get_match_data to optimize the source code.
No check is needed on dev_data as match table is defined in driver.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c  | 9 +--------
 drivers/iio/adc/stm32-dfsdm-core.c | 8 +-------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index e173858..f79a90f 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1087,18 +1087,11 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	struct iio_dev *iio;
-	const struct of_device_id *of_id;
 	char *name;
 	int ret, irq, val;
 
-	of_id = of_match_node(stm32_dfsdm_adc_match, np);
-	if (!of_id->data) {
-		dev_err(&pdev->dev, "Data associated to device is missing\n");
-		return -EINVAL;
-	}
-
-	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
 
+	dev_data = of_device_get_match_data(dev);
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!iio) {
 		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 6cd655f..6290332 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
 static int stm32_dfsdm_probe(struct platform_device *pdev)
 {
 	struct dfsdm_priv *priv;
-	const struct of_device_id *of_id;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	struct stm32_dfsdm *dfsdm;
 	int ret;
@@ -253,13 +252,8 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
 
 	priv->pdev = pdev;
 
-	of_id = of_match_node(stm32_dfsdm_of_match, pdev->dev.of_node);
-	if (!of_id->data) {
-		dev_err(&pdev->dev, "Data associated to device is missing\n");
-		return -EINVAL;
-	}
+	dev_data = of_device_get_match_data(&pdev->dev);
 
-	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
 	dfsdm = &priv->dfsdm;
 	dfsdm->fl_list = devm_kcalloc(&pdev->dev, dev_data->num_filters,
 				      sizeof(*dfsdm->fl_list), GFP_KERNEL);
-- 
2.7.4
