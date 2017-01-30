From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 30 Jan 2017 14:57:40 +0100
Subject: [PATCH 2/5] iio: adc: stm32: add dt option to set default trigger
 polarity
In-Reply-To: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
References: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1485784663-19505-3-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 ADC trigger polarity can be set to either rising, falling
or both edges. Add dt option to configure it.
Note: default value may be overridden later via trigger_polarity
sysfs attribute.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 9b49a6ad..be0e457 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -997,6 +997,13 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	of_property_read_u32(pdev->dev.of_node, "st,trigger-polarity",
+			     &adc->trigger_polarity);
+	if (adc->trigger_polarity >= ARRAY_SIZE(stm32_trig_pol_items)) {
+		dev_err(&pdev->dev, "Invalid st,trigger-polarity property\n");
+		return -EINVAL;
+	}
+
 	adc->irq = platform_get_irq(pdev, 0);
 	if (adc->irq < 0) {
 		dev_err(&pdev->dev, "failed to get irq\n");
-- 
1.9.1
