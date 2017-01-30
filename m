From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 30 Jan 2017 15:34:00 +0100
Subject: [PATCH v2 5/5] iio: adc: stm32: add exti gpio trigger source
In-Reply-To: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1485786840-4557-6-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32F4 ADC can use exti11 (gpio) signal as trigger source for
conversions.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index be0e457..0118c9c 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -26,6 +26,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/timer/stm32-timer-trigger.h>
+#include <linux/iio/trigger/stm32-exti-trigger.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -240,6 +241,7 @@ struct stm32_adc_chan_spec {
 	{ TIM5_CH3, STM32_EXT12 },
 	{ TIM8_CH1, STM32_EXT13 },
 	{ TIM8_TRGO, STM32_EXT14 },
+	{ STM32_EXTI(11), STM32_EXT15 },
 	{}, /* sentinel */
 };
 
@@ -409,6 +411,11 @@ static int stm32_adc_get_trig_extsel(struct iio_trigger *trig)
 		    !strcmp(stm32f4_adc_trigs[i].name, trig->name)) {
 			return stm32f4_adc_trigs[i].extsel;
 		}
+
+		if (is_stm32_exti_trigger(trig) &&
+		    !strcmp(stm32f4_adc_trigs[i].name, trig->name)) {
+			return stm32f4_adc_trigs[i].extsel;
+		}
 	}
 
 	return -EINVAL;
-- 
1.9.1
