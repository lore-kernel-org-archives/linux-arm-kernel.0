From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  9 Jan 2018 10:33:32 +0100
Subject: [PATCH v2 01/16] iio: adc: axp20x_adc: put ADC rate setting in a
 per-variant function
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Message-ID: <e50850aeb3a121a546c39704edceda0c052a0cb1.1515486346.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare for a new comer that set a different register with different
values, move rate setting in a function that is specific to each AXP
variant.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/iio/adc/axp20x_adc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index a30a972..3fc1b06 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -470,14 +470,18 @@ static const struct iio_info axp22x_adc_iio_info = {
 	.read_raw = axp22x_read_raw,
 };
 
-static int axp20x_adc_rate(int rate)
+static int axp20x_adc_rate(struct axp20x_adc_iio *info, int rate)
 {
-	return AXP20X_ADC_RATE_HZ(rate);
+	return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
+				  AXP20X_ADC_RATE_MASK,
+				  AXP20X_ADC_RATE_HZ(rate));
 }
 
-static int axp22x_adc_rate(int rate)
+static int axp22x_adc_rate(struct axp20x_adc_iio *info, int rate)
 {
-	return AXP22X_ADC_RATE_HZ(rate);
+	return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
+				  AXP20X_ADC_RATE_MASK,
+				  AXP22X_ADC_RATE_HZ(rate));
 }
 
 struct axp_data {
@@ -485,7 +489,8 @@ struct axp_data {
 	int				num_channels;
 	struct iio_chan_spec const	*channels;
 	unsigned long			adc_en1_mask;
-	int				(*adc_rate)(int rate);
+	int				(*adc_rate)(struct axp20x_adc_iio *info,
+						    int rate);
 	bool				adc_en2;
 	struct iio_map			*maps;
 };
@@ -554,8 +559,7 @@ static int axp20x_probe(struct platform_device *pdev)
 				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
 
 	/* Configure ADCs rate */
-	regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
-			   info->data->adc_rate(100));
+	info->data->adc_rate(info, 100);
 
 	ret = iio_map_array_register(indio_dev, info->data->maps);
 	if (ret < 0) {
-- 
git-series 0.9.1
