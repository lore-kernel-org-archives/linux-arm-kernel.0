From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 20 Sep 2017 23:18:09 +0800
Subject: [RFC PATCH 2/7] iio: adc: axp20x-adc: allow to skip ADC rate setup now
In-Reply-To: <20170920151814.22461-1-icenowy@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io>
Message-ID: <20170920151814.22461-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADC rate setup on AXP803 is more complex than AXP20x/22x.

As it's not a necessary setup, allow it to be skipped, to allow simpler
AXP803 support now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/iio/adc/axp20x_adc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 11e177180ea0..93dd6b80059e 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -556,8 +556,10 @@ static int axp20x_probe(struct platform_device *pdev)
 				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
 
 	/* Configure ADCs rate */
-	regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
-			   info->data->adc_rate(100));
+	if (info->data->adc_rate)
+		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
+				   AXP20X_ADC_RATE_MASK,
+				   info->data->adc_rate(100));
 
 	ret = iio_map_array_register(indio_dev, info->data->maps);
 	if (ret < 0) {
-- 
2.13.5
