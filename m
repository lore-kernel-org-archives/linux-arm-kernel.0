From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 18 Oct 2017 13:40:12 +0200
Subject: [PATCH] iio: adc: stm32: add check on clock rate
Message-ID: <1508326812-24297-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add check on STM32 ADC clock rate to report an explicit error.
This may avoid division by 0 later in stm32-adc driver.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 804198e..6aefef9 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -139,6 +139,11 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
 	}
 
 	rate = clk_get_rate(priv->aclk);
+	if (!rate) {
+		dev_err(&pdev->dev, "Invalid clock rate: 0\n");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
 		if ((rate / stm32f4_pclk_div[i]) <= STM32F4_ADC_MAX_CLK_RATE)
 			break;
@@ -216,6 +221,10 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 		 * From spec: PLL output musn't exceed max rate
 		 */
 		rate = clk_get_rate(priv->aclk);
+		if (!rate) {
+			dev_err(&pdev->dev, "Invalid adc clock rate: 0\n");
+			return -EINVAL;
+		}
 
 		for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
 			ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
@@ -232,6 +241,10 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 
 	/* Synchronous clock modes (e.g. ckmode is 1, 2 or 3) */
 	rate = clk_get_rate(priv->bclk);
+	if (!rate) {
+		dev_err(&pdev->dev, "Invalid bus clock rate: 0\n");
+		return -EINVAL;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
 		ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
-- 
1.9.1
